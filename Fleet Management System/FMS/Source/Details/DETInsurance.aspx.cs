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
    public partial class DETInsurance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Permission perm = new Permission();
            if (perm.is_allowed("insurance", "edit", Session["role_id"].ToString().strToInt()) == true)
            {
    

                if (string.IsNullOrEmpty(Request.QueryString["id"]))
                {

                    DetVHCInsurance.DefaultMode = FormViewMode.Insert;
                    this.Page.Title = "Inserting record";
                }
                else
                {

                    var mode = Request.QueryString["mode"];
                    if (string.IsNullOrEmpty(mode))
                    {

                        DetVHCInsurance.DefaultMode = FormViewMode.Edit;
                        this.Page.Title = "Editing record";
                    }
                    else
                    {
                        DetVHCInsurance.DefaultMode = FormViewMode.ReadOnly;
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

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            if (Request.QueryString["ins_id"] == null)
            {

                DetVHCInsurance.DefaultMode = FormViewMode.Insert;
            }
            else
            {
                DetVHCInsurance.DefaultMode = FormViewMode.ReadOnly;
            }
            this.Page.Title = "Editing record";
        }

        protected void DetVHCInsurance_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            e.Cancel = true;
        }

        protected void DetVHCInsurance_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            DetVHCInsurance.ChangeMode(new FormViewMode());
        }

        protected void DetVHCInsurance_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            e.Cancel = true;
        }

        protected void DetVHCInsurance_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            DetVHCInsurance.ChangeMode(new FormViewMode());
        }

        protected void DetVHCInsurance_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
            }

            if (e.CommandName == "Update" || e.CommandName == "Add")
            {
                RadComboBox rcmbVehicle = (RadComboBox)DetVHCInsurance.FindControl("rcmbVehicle");
                RadTextBox ins_idLabel = (RadTextBox)DetVHCInsurance.FindControl("ins_idLabel");
                RadTextBox insurance_companyLabel = (RadTextBox)DetVHCInsurance.FindControl("insurance_companyLabel");
                RadTextBox cert_noLabel = (RadTextBox)DetVHCInsurance.FindControl("cert_noLabel");
                RadDatePicker rdpIssueeDate = (RadDatePicker)DetVHCInsurance.FindControl("rdpIssueeDate");
                RadDatePicker rdpExpiryDate = (RadDatePicker)DetVHCInsurance.FindControl("rdpExpiryDate");
                RadComboBox rcmbPolicyType = (RadComboBox)DetVHCInsurance.FindControl("rcmbPolicyType");
                RadNumericTextBox sum_insuredLabel = (RadNumericTextBox)DetVHCInsurance.FindControl("sum_insuredLabel");
                //RadTextBox takaful_contributionLabel = (RadTextBox)DetVHCInsurance.FindControl("takaful_contributionLabel");
                //RadTextBox ncdLabel = (RadTextBox)DetVHCInsurance.FindControl("ncdLabel");

                refVHCInsurance vhc_ins = new refVHCInsurance();
                vhc_ins.active = true;
                vhc_ins.ins_id = ins_idLabel.Text.Trim().strToInt();
                vhc_ins.insurance_company = insurance_companyLabel.Text.Trim();
                vhc_ins.cert_no = cert_noLabel.Text.Trim();
                vhc_ins.issue_date = rdpIssueeDate.SelectedDate ?? DateTime.Now;
                vhc_ins.expiry_date = rdpExpiryDate.SelectedDate ?? DateTime.Now.AddYears(1);
                vhc_ins.policy_id = rcmbPolicyType.SelectedValue.strToInt();
                vhc_ins.sum_insured = sum_insuredLabel.Text.Trim() != "" ? sum_insuredLabel.Text.Trim().strToDouble() : 0.00;
                //vhc_ins.takaful_contribution = takaful_contributionLabel.Text.Trim() != "" ? takaful_contributionLabel.Text.Trim().strToDouble() : 0.00;
                //vhc_ins.ncd = ncdLabel.Text.Trim() != "" ? ncdLabel.Text.Trim().strToDouble() : 0.00;
                              
                int _ins_id = ins_idLabel.Text.Trim().strToInt();


                if (e.CommandName == "Add")
                {
                    Insurance ins = new Insurance();
                    ins.add_vehicle_insurance(vhc_ins, rcmbVehicle.SelectedValue.ToString().strToInt());
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "New Vehicle Insurance", "alert('Vehicle insurance added successfully!');", true);


                }
                else
                {
                    Insurance ins = new Insurance();
                    ins.update_vehicle_insurance(vhc_ins, ins_idLabel.Text.Trim().strToInt(), new string[] { "ins_id" }, rcmbVehicle.SelectedValue.ToString().strToInt(), new string[] { "vid" });
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Update Vehicle Insurance", "alert('Vehicle insurance update successful!');", true);
                }

            }

        }

        #region trash codes (might be useful in the future)
        //// Add New Insurance Control Methods
        //#region add new service
        //protected void DetVHCInsurance_ItemCreated(object sender, EventArgs e)
        //{
        //    if (DetVHCInsurance.CurrentMode == FormViewMode.Edit || DetVHCInsurance.CurrentMode == FormViewMode.Insert)
        //    {

        //        RadButton btnNewService = (RadButton)DetVHCInsurance.FindControl("btnNewService");
        //        btnNewService.AutoPostBack = true;
        //        btnNewService.Click += new EventHandler(btnNewService_Click);

        //        RadButton btnOpenNewService = (RadButton)DetVHCInsurance.FindControl("btnOpenNewService");
        //        btnOpenNewService.AutoPostBack = true;
        //        btnOpenNewService.Click += new EventHandler(btnOpenService_Click);
        //    }
        //}

        //private void btnOpenService_Click(object sender, EventArgs e)
        //{
        //    RadButton btnOpenService = (RadButton)sender;
        //    RadTextBox tbxService = (RadTextBox)DetVHCInsurance.FindControl("tbxNewService");
        //    RadButton btnService = (RadButton)DetVHCInsurance.FindControl("btnNewService");
        //    if (tbxService.Visible == false)
        //    {
        //        tbxService.Visible = true;
        //        btnService.Visible = true;
        //        btnOpenService.Text = "-";
        //    }
        //    else
        //    {
        //        tbxService.Visible = false;
        //        btnService.Visible = false;
        //        btnOpenService.Text = "+";
        //    }
        //}

        //private void btnNewService_Click(object sender, EventArgs e)
        //{
        //    Validate();

        //    RadTextBox tbxService = (RadTextBox)DetVHCInsurance.FindControl("tbxNewService");
        //    RadComboBox cmbService = (RadComboBox)DetVHCInsurance.FindControl("rcmbServiceType");

        //    if (tbxService.Text.Trim() != "")
        //    {
        //        string newService = tbxService.Text.Trim().ToLower();
        //        int _parent = Convert.ToInt32(Session["parent_id"].ToString());

        //        Service srv = new Service();
        //        if (srv.is_not_duplicate_service(newService, (Session["parent_id"].ToString().strToInt())) == false)
        //        {

        //            refService new_service = new refService()
        //            {
        //                usr_id = Convert.ToInt32(Session["parent_id"]),
        //                service = tbxService.Text.Trim(),
        //                active = true
        //            };
        //            srv = new Service();
        //            srv.add_service_type(new_service);
        //            DetVHCInsurance.DataBind();
        //            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "New Service", "alert('Service " + tbxService.Text + " has been added.');", true);
        //        }
        //    }
        //}       

        //protected void srvCusValidator_ServerValidate(object source, ServerValidateEventArgs args)
        //{
        //    RadTextBox tbxService = (RadTextBox)DetVHCInsurance.FindControl("tbxNewService");
        //    string newService = tbxService.Text.Trim().ToLower();
        //    Service srv = new Service();
        //    args.IsValid = srv.is_not_duplicate_service(newService, (Session["parent_id"].ToString().strToInt()));
        //}
        // #endregion
        #endregion

        protected void EditButton_Click(object sender, EventArgs e)
        {
            DetVHCInsurance.DefaultMode = FormViewMode.Edit;
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            FMS.Source.Classes.Insurance ins = new FMS.Source.Classes.Insurance();
            ins.delete_vehicle_insurance(Request.QueryString["ins_id"].ToString().strToInt());
        }

    }
}
