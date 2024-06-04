using FMS.Source.Classes;
using FMS_BusinessObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace FMS.Source.Details
{
    public partial class DETViolation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Permission perm = new Permission();
            if (perm.is_allowed("violation", "edit", Session["role_id"].ToString().strToInt()) == true)
            {
                if (Request.QueryString["id"] == null)
                {
                    DETViolations.DefaultMode = FormViewMode.Insert;
                    this.Page.Title = "Adding record";
                }
                else
                {
                    var mode = Request.QueryString["mode"];
                    if (string.IsNullOrEmpty(mode))
                    {
                        DETViolations.DefaultMode = FormViewMode.Edit;
                        this.Page.Title = "Editing record";
                    }
                    else
                    {
                        DETViolations.DefaultMode = FormViewMode.ReadOnly;
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

        protected void DETViolation_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                Violation vio = new Violation();
                RadTextBox tbx_vio_id = (RadTextBox)DETViolations.FindControl("tbx_drv_vio_id");
                vio.delete_driver_violation(Convert.ToInt32(tbx_vio_id.Text));
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
            }
            if (e.CommandName == "Cancel")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
            }

            if (e.CommandName == "Update" || e.CommandName == "Add")
            {
                RadTextBox tbx_drv_vio_id = (RadTextBox)DETViolations.FindControl("tbx_drv_vio_id");
                RadTextBox tbx_violation_ticket_no = (RadTextBox)DETViolations.FindControl("tbx_violation_ticket_no");
                RadDatePicker rdp_date = (RadDatePicker)DETViolations.FindControl("rdp_date");
                RadComboBox rcmb_violation = (RadComboBox)DETViolations.FindControl("rcmb_violation");
                RadTextBox tbx_remarks = (RadTextBox)DETViolations.FindControl("tbx_remarks");
                RadTextBox tbx_location = (RadTextBox)DETViolations.FindControl("tbx_location");
                RadComboBox rcmb_driver = (RadComboBox)DETViolations.FindControl("rcmb_driver");
                RadComboBox rcmb_vehicle = (RadComboBox)DETViolations.FindControl("rcmb_vehicle");

                refDRVViolation new_drv_vio = new refDRVViolation()
                {
                    active = true,
                    date = rdp_date.SelectedDate ?? DateTime.Now,
                    drv_id = rcmb_driver.SelectedValue.ToString().strToInt(),
                    location = tbx_location.Text,
                    remarks = tbx_remarks.Text,
                    vid = rcmb_vehicle.SelectedValue.ToString().strToInt(),
                    vio_id = rcmb_violation.SelectedValue.ToString().strToInt(),
                    violation_ticket_no = tbx_violation_ticket_no.Text
                };

                Violation vio = new Violation();
                if (e.CommandName == "Add")
                {
                    vio.add_driver_violation(new_drv_vio, new string[] { "drv_vio_id" });
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Insert new Driver Violation", "alert('Driver Violation update successful!');", true);
                }

                if (e.CommandName == "Update")
                {
                    vio.update_driver_violation(new_drv_vio, tbx_drv_vio_id.Text.strToInt(), new string[] { "drv_vio_id" });
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Update Driver Violation", "alert('Driver Violation update successful!');", true);
                }
            }
        }

        protected void DETViolation_ItemCreated(object sender, EventArgs e)
        {
            if (DETViolations.CurrentMode == FormViewMode.Edit || DETViolations.CurrentMode == FormViewMode.Insert)
            {

                RadButton btn_new_violation = (RadButton)DETViolations.FindControl("btn_new_violation");
                btn_new_violation.AutoPostBack = true;
                btn_new_violation.Click += new EventHandler(btn_new_violation_Click);

                RadButton btn_open_new_violation = (RadButton)DETViolations.FindControl("btn_open_new_violation");
                btn_open_new_violation.AutoPostBack = true;
                btn_open_new_violation.Click += new EventHandler(btn_open_new_violation_Click);
            }

        }

        private void btn_open_new_violation_Click(object sender, EventArgs e)
        {
            RadButton btn_open_new_violation = (RadButton)sender;
            RadTextBox tbx_new_violation = (RadTextBox)DETViolations.FindControl("tbx_new_violation");
            RadButton btn_new_violation = (RadButton)DETViolations.FindControl("btn_new_violation");

            if (tbx_new_violation.Visible == false)
            {
                tbx_new_violation.Visible = true;
                btn_new_violation.Visible = true;
                btn_open_new_violation.Text = "-";
            }
            else
            {
                tbx_new_violation.Visible = false;
                btn_new_violation.Visible = false;
                btn_open_new_violation.Text = "+";
            }
        }

        private void btn_new_violation_Click(object sender, EventArgs e)
        {

            Validate();

            RadTextBox tbx_new_violation = (RadTextBox)DETViolations.FindControl("tbx_new_violation");
            RadComboBox rcmb_violation = (RadComboBox)DETViolations.FindControl("rcmb_violation");

            if (tbx_new_violation.Text.Trim() != "")
            {
                string new_violation = tbx_new_violation.Text.Trim().ToLower();
                int _parent = Convert.ToInt32(Session["parent_id"].ToString());
                Vehicle veh = new Vehicle();
                Violation vio = new Violation();
                if (vio.is_not_duplicate_violation(new_violation, (Session["parent_id"].ToString().strToInt())) == true)
                {
                    refViolation new_vio = new refViolation()
                    {
                        usr_id = Session["parent_id"].ToString().strToInt(),
                        violation = tbx_new_violation.Text.Trim(),
                        active = true,

                    };
                    vio = new Violation();
                    vio.add_violation(new_vio, new string[] { "vio_id" });
                    DETViolations.DataBind();

                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "New Violation", "alert('Violation " + tbx_new_violation.Text + " has been added.');", true);
                }
            }
        }

        protected void DETViolation_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            DETViolations.ChangeMode(new FormViewMode());
        }

        protected void DETViolation_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            e.Cancel = true;
        }

        protected void DETViolation_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            DETViolations.ChangeMode(new FormViewMode());
        }

        protected void DETViolation_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            e.Cancel = true;
        }

        protected void cv_violation_ServerValidate(object source, ServerValidateEventArgs args)
        {
            RadTextBox tbx_new_violation = (RadTextBox)DETViolations.FindControl("tbx_new_violation");
            string newService = tbx_new_violation.Text.Trim().ToLower();
            Violation vio = new Violation();
            args.IsValid = vio.is_not_duplicate_violation(tbx_new_violation.Text, (Session["parent_id"].ToString().strToInt()));
        }

        protected void EditButton_Click(object sender, EventArgs e)
        {
            DETViolations.DefaultMode = FormViewMode.Edit;
        }
    }
}