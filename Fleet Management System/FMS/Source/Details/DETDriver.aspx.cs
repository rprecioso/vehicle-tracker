using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FMS.Source.Classes;
using FMS_BusinessObjects;
using Telerik.Web.UI;

namespace FMS.Source.Details
{
    public partial class DETDriver : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            //_usr_id = ((int)Session["parent_id"]);
            //Permission perm = new Permission();
            //if (perm.is_allowed("Driver", "View", Session["role_id"].ToString().strToInt()) == false)
            //{
            //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
            //}
            Permission perm = new Permission();
            if (perm.is_allowed("driver", "edit", Session["role_id"].ToString().strToInt()) == true)
            {
                if (string.IsNullOrEmpty(Request.QueryString["id"]))
                {

                    DetDriver.DefaultMode = FormViewMode.Insert;
                    this.Page.Title = "Adding record";
                }
                else
                {
                    var mode = Request.QueryString["mode"];
                    if (string.IsNullOrEmpty(mode))
                    {
                        DetDriver.DefaultMode = FormViewMode.Edit;
                        this.Page.Title = "Editing record";
                    }
                    else
                    {
                        DetDriver.DefaultMode = FormViewMode.ReadOnly;
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


        #region window view

        protected void DetDriver_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            //Cancel autoupdate
            e.Cancel = true;
        }

        protected void DetDriver_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            //Return view to Ready Only
            DetDriver.ChangeMode(new FormViewMode());
        }

        protected void DetDriver_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            //Cancel autoupdate
            e.Cancel = true;
        }

        protected void DetDriver_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            //Return view to Ready Only
            DetDriver.ChangeMode(new FormViewMode());
        }

        #endregion

        protected void DetDriver_ItemCommand(object sender, FormViewCommandEventArgs e)
        {

            if (e.CommandName == "Cancel")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
            }

            if (e.CommandName == "Update" || e.CommandName == "Add")
            {
                RadTextBox tbx_drv_id = (RadTextBox)DetDriver.FindControl("tbx_drv_id");
                RadTextBox tbx_emp_id = (RadTextBox)DetDriver.FindControl("tbx_emp_id");
                RadTextBox tbx_first_name = (RadTextBox)DetDriver.FindControl("tbx_first_name");
                RadTextBox tbx_last_name = (RadTextBox)DetDriver.FindControl("tbx_last_name");
                RadTextBox tbx_mobile_no = (RadTextBox)DetDriver.FindControl("tbx_mobile_no");
                RadTextBox tbx_phone_no = (RadTextBox)DetDriver.FindControl("tbx_phone_no");
                RadTextBox tbx_home_address = (RadTextBox)DetDriver.FindControl("tbx_home_address");
                RadDatePicker rdp_birth_date = (RadDatePicker)DetDriver.FindControl("rdp_birth_date");
                RadTextBox tbx_gov_id = (RadTextBox)DetDriver.FindControl("tbx_gov_id");
                RadTextBox tbx_gov_id_no = (RadTextBox)DetDriver.FindControl("tbx_gov_id_no");
                RadComboBox rcmb_salary = (RadComboBox)DetDriver.FindControl("rcmb_salary");
                RadTextBox tbx_salary = (RadTextBox)DetDriver.FindControl("tbx_salary");
                RadComboBox rcmb_emp_status = (RadComboBox)DetDriver.FindControl("rcmb_emp_status");
                RadDatePicker rdp_hire_date = (RadDatePicker)DetDriver.FindControl("rdp_hire_date");
                RadTextBox tbx_license_no = (RadTextBox)DetDriver.FindControl("tbx_license_no");
                RadTextBox tbx_license_type = (RadTextBox)DetDriver.FindControl("tbx_license_type");
                RadDatePicker rdp_license_expiry_date = (RadDatePicker)DetDriver.FindControl("rdp_license_expiry_date");
                RadTextBox tbx_sal_id = (RadTextBox)DetDriver.FindControl("tbx_sal_id");
                RadTextBox tbx_emp_sta_id = (RadTextBox)DetDriver.FindControl("tbx_emp_sta_id");
                RadTextBox tbx_drv_lic_id = (RadTextBox)DetDriver.FindControl("tbx_drv_lic_id");
                //RadTextBox tbx_emp_desc = (RadTextBox)DetDriver.FindControl("tbx_emp_desc");
                //RadTextBox tbx_lic_desc = (RadTextBox)DetDriver.FindControl("tbx_lic_desc");
                //RadTextBox tbx_sal_desc = (RadTextBox)DetDriver.FindControl("tbx_sal_desc");
                Image imgVehicle = (Image)DetDriver.FindControl("imgVehicle");
                FileUpload fpFile = (FileUpload)DetDriver.FindControl("fpFile");

                int _usr_id = Convert.ToInt32(Session["parent_id"]);

                tblDriver mod_driver = new tblDriver()
                  {
                      active = true,
                      emp_id = tbx_emp_id.Text,
                      first_name = tbx_first_name.Text,
                      gov_id = tbx_gov_id.Text,
                      gov_id_no = tbx_gov_id_no.Text,
                      home_address = tbx_home_address.Text,
                      birth_date = rdp_birth_date.SelectedDate ?? DateTime.Now,
                      last_name = tbx_last_name.Text,
                      mobile_no = tbx_mobile_no.Text,
                      phone_no = tbx_phone_no.Text,
                      sal_id = rcmb_salary.SelectedValue.ToString().strToInt(),
                      salary = tbx_salary.Text.Trim() != string.Empty ? tbx_salary.Text.strToDouble() : 0.00,
                      emp_sta_id = rcmb_emp_status.SelectedValue.ToString().strToInt(),
                      hire_date = rdp_hire_date.SelectedDate ?? DateTime.Now,
                      usr_id = _usr_id
                  };

                refDRVLicense mod_drv_lic = new refDRVLicense()
                        {
                            description = tbx_license_no.Text,
                            expiry_date = rdp_license_expiry_date.SelectedDate ?? DateTime.Now,
                            license = tbx_license_no.Text,
                            type = tbx_license_type.Text
                        };
                int _drv_id = 0;

                Driver dri = new Driver();



                if (e.CommandName == "Add")
                {


                    dri = new Driver();
                    if (dri.is_empid_duplicate(tbx_emp_id.Text, _usr_id) == false)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Duplicate Employee ID!", "alert('Employee ID Already Exist!');", true);
                        return;
                    }

                    dri = new Driver();
                    mod_driver.drv_lic_id = dri.add_license(mod_drv_lic);
                    int id = dri.add_driver(mod_driver, new string[] { "drv_id", "image" });
                    dri = new Driver();


                    if (fpFile.HasFile == true)
                    {
                        HttpPostedFile file = (HttpPostedFile)fpFile.PostedFile;
                        if ((file != null) && (file.ContentLength > 0))
                        {
                            if (file.ContentLength <= 50000)
                            {
                                dri = new Driver();
                                dri.update_driver_image(image_to_byte_array(fpFile), id);

                                // imgVehicle.ImageUrl = "~/Source/Details/ImageHandler.ashx?type=driver&id=" + _drv_id;
                                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                            }
                            else
                            {
                                CustomValidator val = new CustomValidator();
                                val.ValidationGroup = "edit";
                                val.IsValid = false;
                                val.ErrorMessage = "File size must not exceed 50KB!";
                                this.Page.Validators.Add(val);
                                return;
                            }
                        }
                    }

                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Insert new Driver", "alert('Driver details insert successful!');", true);
                }


                if (e.CommandName == "Update")
                {
                    if (fpFile.HasFile == true)
                    {
                        HttpPostedFile file = (HttpPostedFile)fpFile.PostedFile;
                        if ((file != null) && (file.ContentLength > 0))
                        {
                            if (file.ContentLength <= 50000)
                            {
                                dri = new Driver();
                                dri.update_driver_image(image_to_byte_array(fpFile), DetDriver.DataKey.Value.ToString().strToInt());
                                //imgVehicle.ImageUrl = "~/Source/Details/ImageHandler.ashx?type=driver&id=" + DetDriver.DataKey.Value.ToString();
                                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                            }
                            else
                            {
                                CustomValidator val = new CustomValidator();
                                val.ValidationGroup = "edit";
                                val.IsValid = false;
                                val.ErrorMessage = "File size must not exceed 50KB!";
                                this.Page.Validators.Add(val);
                                return;
                            }
                        }
                    }

                    dri = new Driver();
                    if (dri.is_empid_duplicate(tbx_emp_id.Text, _usr_id, DetDriver.DataKey.Value.ToString().strToInt()) == false)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Duplicate Employee ID!", "alert('Employee ID Already Exist!');", true);
                        return;
                    }


                    dri = new Driver();
                    dri.update_license(mod_drv_lic, tbx_drv_lic_id.Text.strToInt(), new string[] { "drv_lic_id" });

                    dri = new Driver();
                    dri.update_driver(mod_driver, tbx_drv_id.Text.strToInt(), new string[] { "drv_id", "image", "drv_lic_id", "usr_id" });

                    _drv_id = tbx_drv_id.Text.strToInt();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Update Driver", "alert('Driver details update successful!');", true);
                }
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);

            }
        }


        private byte[] image_to_byte_array(FileUpload _file)
        {
            int fileLength = _file.PostedFile.ContentLength;
            byte[] fileArray = new byte[fileLength];
            HttpPostedFile file = _file.PostedFile;
            file.InputStream.Read(fileArray, 0, fileLength);
            return fileArray;
        }

        protected void EditButton_Click(object sender, EventArgs e)
        {
            DetDriver.DefaultMode = FormViewMode.Edit;
        }

        protected void DetDriver_ItemCreated(object sender, EventArgs e)
        {


            Permission perm = new Permission();
            if (perm.is_allowed("Driver", "View", Session["role_id"].ToString().strToInt()) == false)
            {
                LinkButton EditButton = (LinkButton)DetDriver.FindControl("EditButton");
                EditButton.Visible = false;
            }

        }
    }
}