using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FMS.Source.Classes;
using FMS_BusinessObjects;
using Telerik.Web.UI;

namespace FMS.Source.Details
{
    public partial class DETService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Permission perm = new Permission();
            if (perm.is_allowed("service", "edit", Session["role_id"].ToString().strToInt()) == true)
            {

                if (string.IsNullOrEmpty(Request.QueryString["id"]))
                {

                    DetVHCServices.DefaultMode = FormViewMode.Insert;
                    this.Page.Title = "Inserting record";
                }
                else
                {
                    var mode = Request.QueryString["mode"];
                    if (string.IsNullOrEmpty(mode))
                    {
                        DetVHCServices.DefaultMode = FormViewMode.Edit;
                        this.Page.Title = "Editing record";
                    }
                    else
                    {
                        DetVHCServices.DefaultMode = FormViewMode.ReadOnly;
                        this.Page.Title = "Viewing record";
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "noauthority", "alert('You are not allowed to edit this module. Please contact your administrator for more information.');", true);
            }
        }


        protected void DetVHCServices_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            e.Cancel = true;
        }

        protected void DetVHCServices_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            DetVHCServices.ChangeMode(new FormViewMode());
        }

        protected void DetVHCServices_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            e.Cancel = true;
        }

        protected void DetVHCServices_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            DetVHCServices.ChangeMode(new FormViewMode());
        }

        protected void DetVHCServices_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
            }

            if (e.CommandName == "Update" || e.CommandName == "Add")
            {
                RadTextBox tbxServiceReceiptNo = (RadTextBox)DetVHCServices.FindControl("tbxServiceReceiptNo");
                int _parent = Convert.ToInt32(Session["parent_id"].ToString());
                Service srv = new Service();

                int key = 0;
                if (e.CommandName == "Update")
                {
                    key = DetVHCServices.DataKey.Value.ToString().strToInt();
                }

                if (srv.isReceiptExist(tbxServiceReceiptNo.Text, _parent, key) == true)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Vehicle Service", "alert('Duplicate Service Receipt No.!');", true);
                    return;
                }

                RadComboBox rcmbVehicle = (RadComboBox)DetVHCServices.FindControl("rcmbVehicle");
                RadComboBox rcmbServiceType = (RadComboBox)DetVHCServices.FindControl("rcmbServiceType");
                RadDatePicker rdpServiceDate = (RadDatePicker)DetVHCServices.FindControl("rdpServiceDate");
                RadDatePicker rdpCompletionDate = (RadDatePicker)DetVHCServices.FindControl("rdpCompletionDate");
                RadTextBox tbxServicedby = (RadTextBox)DetVHCServices.FindControl("tbxServicedby");
                RadComboBox rcmbBroughtby = (RadComboBox)DetVHCServices.FindControl("rcmbBroughtby");
                RadTextBox tbxRemarks = (RadTextBox)DetVHCServices.Row.FindControl("tbxRemarks");

                refVHCService vhc_srv = new refVHCService()
                {
                    active = true,
                    brought_by = rcmbBroughtby.SelectedValue.strToInt(),
                    date_completed = rdpCompletionDate.SelectedDate ?? DateTime.Now,
                    date_started = rdpServiceDate.SelectedDate ?? DateTime.Now,
                    remarks = tbxRemarks.Text,
                    service_receipt_no = tbxServiceReceiptNo.Text,
                    srv_by = tbxServicedby.Text,
                    srv_id = rcmbServiceType.SelectedValue.strToInt(),
                    vid = rcmbVehicle.SelectedValue.strToInt()
                };

                if (e.CommandName == "Add")
                {
                    srv = new Service();
                    srv.add_vehicle_service(vhc_srv);
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "New Vehicle Service", "alert('Vehicle service added successfully!');", true);
                }
                else
                {
                    srv = new Service();

                    srv.update_vehicle_service(vhc_srv, DetVHCServices.DataKey.Value.ToString().strToInt(), new string[] { "vhc_srv_id", "vid" });
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Update Vehicle Service", "alert('Vehicle service update successful!');", true);
                }
            }

        }

        // Add New Service Control Methods
        #region add new service
        protected void DetVHCServices_ItemCreated(object sender, EventArgs e)
        {
            if (DetVHCServices.CurrentMode == FormViewMode.Edit || DetVHCServices.CurrentMode == FormViewMode.Insert)
            {
                var x = DetVHCServices.CurrentMode;

                RadButton btnNewService = (RadButton)DetVHCServices.FindControl("btn_new_service");
                btnNewService.AutoPostBack = true;
                btnNewService.Click += new EventHandler(btnNewService_Click);

                RadButton btnOpenNewService = (RadButton)DetVHCServices.FindControl("btnOpenNewService");
                btnOpenNewService.AutoPostBack = true;
                btnOpenNewService.Click += new EventHandler(btnOpenService_Click);
            }
        }



        private void btnOpenService_Click(object sender, EventArgs e)
        {
            RadButton btnOpenService = (RadButton)sender;
            RadTextBox tbxService = (RadTextBox)DetVHCServices.FindControl("tbxNewService");
            RadButton btnService = (RadButton)DetVHCServices.FindControl("btn_new_service");
            if (tbxService.Visible == false)
            {
                tbxService.Visible = true;
                btnService.Visible = true;
                btnOpenService.Text = "-";
            }
            else
            {
                tbxService.Visible = false;
                btnService.Visible = false;
                btnOpenService.Text = "+";
            }
        }


        private void btnNewService_Click(object sender, EventArgs e)
        {
            Validate();


            RadTextBox tbxService = (RadTextBox)DetVHCServices.FindControl("tbxNewService");
            RadComboBox cmbService = (RadComboBox)DetVHCServices.FindControl("rcmbServiceType");

            if (tbxService.Text.Trim() != "")
            {
                string newService = tbxService.Text.Trim().ToLower();
                int _parent = Convert.ToInt32(Session["parent_id"].ToString());

                Service srv = new Service();
                if (srv.is_not_duplicate_service(newService, (Session["parent_id"].ToString().strToInt())) == true)
                {

                    refService new_service = new refService()
                    {
                        usr_id = Convert.ToInt32(Session["parent_id"]),
                        service = tbxService.Text.Trim(),
                        active = true
                    };
                    srv = new Service();
                    srv.add_service_type(new_service);
                    DetVHCServices.DataBind();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "New Service", "alert('Service " + tbxService.Text + " has been added.');", true);
                }
            }
        }

        protected void srvCusValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            RadTextBox tbxService = (RadTextBox)DetVHCServices.FindControl("tbxNewService");
            string newService = tbxService.Text.Trim().ToLower();
            Service srv = new Service();
            args.IsValid = srv.is_not_duplicate_service(newService, (Session["parent_id"].ToString().strToInt()));
        }

        #endregion

        protected void EditButton_Click(object sender, EventArgs e)
        {
            DetVHCServices.DefaultMode = FormViewMode.Edit;
        }

    }
}
