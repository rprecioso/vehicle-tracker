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
    public partial class DETVehicle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Permission perm = new Permission();
            if (perm.is_allowed("vehicle", "edit", Session["role_id"].ToString().strToInt()) == true)
            {
                if (string.IsNullOrEmpty(Request.QueryString["id"]))
                {
                    DETVHCDetails.DefaultMode = FormViewMode.Insert;
                    this.Page.Title = "Inserting record";
                }
                else
                {
                    var mode = Request.QueryString["mode"];
                    if (string.IsNullOrEmpty(mode))
                    {
                        DETVHCDetails.DefaultMode = FormViewMode.Edit;
                        this.Page.Title = "Editing record";
                    }
                    else
                    {
                        DETVHCDetails.DefaultMode = FormViewMode.ReadOnly;
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

        protected void DETVHCDetails_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
            }

            if (e.CommandName == "Update")
            {


                RadTextBox tbxVID = (RadTextBox)DETVHCDetails.FindControl("tbxVID");
                RadTextBox tbxVehicleName = (RadTextBox)DETVHCDetails.FindControl("tbxVehicleName");
                RadTextBox tbxModel = (RadTextBox)DETVHCDetails.FindControl("tbxModel");
                RadTextBox tbxType = (RadTextBox)DETVHCDetails.FindControl("tbxType");
                RadTextBox tbxColor = (RadTextBox)DETVHCDetails.FindControl("tbxColor");
                RadNumericTextBox tbxVolume = (RadNumericTextBox)DETVHCDetails.FindControl("tbxVolume");
                RadTextBox tbxManufacturer = (RadTextBox)DETVHCDetails.FindControl("tbxManufacturer");
                RadTextBox tbxEngineNo = (RadTextBox)DETVHCDetails.FindControl("tbxEngineNo");
                RadTextBox tbxChasisNo = (RadTextBox)DETVHCDetails.FindControl("tbxChasisNo");
                RadNumericTextBox tbxYearMake = (RadNumericTextBox)DETVHCDetails.FindControl("tbxYearMake");
                RadTextBox tbxChasisWeight = (RadTextBox)DETVHCDetails.FindControl("tbxChasisWeight");
                RadTextBox tbxBodyWeight = (RadTextBox)DETVHCDetails.FindControl("tbxBodyWeight");
                RadTextBox tbxGrossWeight = (RadTextBox)DETVHCDetails.FindControl("tbxGrossWeight");
                RadDatePicker rdpRegDate = (RadDatePicker)DETVHCDetails.FindControl("rdpRegDate");
                RadTextBox tbxRegistrationNo = (RadTextBox)DETVHCDetails.FindControl("tbxRegistrationNo");
                RadNumericTextBox tbxSeatNo = (RadNumericTextBox)DETVHCDetails.FindControl("tbxSeatNo");
                RadTextBox tbxRemarks = (RadTextBox)DETVHCDetails.FindControl("tbxRemarks");
                //RadTextBox tbxBlueCard = (RadTextBox)DETVHCDetails.FindControl("tbxBlueCard");
                //RadTextBox tbxRoadTax = (RadTextBox)DETVHCDetails.FindControl("tbxRoadTax");
                Image imgVehicle = (Image)DETVHCDetails.FindControl("imgVehicle");
                FileUpload fpFile = (FileUpload)DETVHCDetails.FindControl("fpFile");


                tblVehicle vhc = new tblVehicle()
                {
                    active = true,
                    //bluecard = tbxBlueCard.Text,
                    body_type = tbxType.Text,
                    body_wt = (tbxBodyWeight.Text.Trim() == string.Empty ? 0 : Convert.ToInt32(tbxBodyWeight.Text)),
                    cc = (tbxVolume.Text.Trim() == string.Empty ? 0.00 : Convert.ToDouble(tbxVolume.Text)),
                    chasis_no = tbxChasisNo.Text,
                    chasis_wt = (tbxChasisWeight.Text.Trim() == string.Empty ? 0 : Convert.ToInt32(tbxChasisWeight.Text)),
                    color = tbxColor.Text,
                    engine_no = tbxEngineNo.Text,
                    gross_wt = (tbxGrossWeight.Text.Trim() == string.Empty ? 0 : Convert.ToInt32(tbxGrossWeight.Text)),
                    manufacturer = tbxManufacturer.Text,
                    registration_no = tbxRegistrationNo.Text,
                    remarks = tbxRemarks.Text,
                    //road_tax = (tbxRoadTax.Text.Trim() == string.Empty ? 0.00 : Convert.ToDouble(tbxRoadTax.Text)),
                    registration_expiry_date = rdpRegDate.SelectedDate ?? DateTime.Now,
                    seating_no = (tbxSeatNo.Text.Trim() == string.Empty ? 0 : Convert.ToInt32(tbxSeatNo.Text)),
                    vehicle_name = tbxVehicleName.Text,
                    vid = (tbxVID.Text.Trim() == string.Empty ? 0 : Convert.ToInt32(tbxVID.Text)),
                    vhc_model = tbxModel.Text,
                    year_make = (tbxYearMake.Text.Trim() == string.Empty ? 0 : Convert.ToInt32(tbxYearMake.Text))
                };

                Vehicle veh = new Vehicle();
                if (fpFile.HasFile == true)
                {
                    HttpPostedFile file = (HttpPostedFile)fpFile.PostedFile;
                    if ((file != null) && (file.ContentLength > 0))
                    {
                        if (file.ContentLength <= 50000)
                        {
                            veh = new Vehicle();
                            veh.update_vehicle_image(image_to_byte_array(fpFile), DETVHCDetails.DataKey.Value.ToString().strToInt());
                            imgVehicle.ImageUrl = "~/Source/Details/ImageHandler.ashx?type=vehicle&id=" + DETVHCDetails.DataKey.Value.ToString();
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


                veh = new Vehicle();
                veh.update_user_vehicles(vhc, Convert.ToInt32(tbxVID.Text),
                    new string[] { "vid", "vehicle_name", "group_code", "image", "ins_id" });


                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Update Vehicle", "alert('Vehicle details update successful!');", true);

            }
        }


        protected void DETVHCDetails_ItemCreated(object sender, EventArgs e)
        {
            if (DETVHCDetails.CurrentMode == FormViewMode.Edit || DETVHCDetails.CurrentMode == FormViewMode.Insert)
            {

                RadButton btnSaveImage = (RadButton)DETVHCDetails.FindControl("btnSaveImage");
                //btnSaveImage.AutoPostBack = true;
                btnSaveImage.Click += btnSaveImage_Click;
            }
        }

        protected void DETVHCDetails_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            DETVHCDetails.ChangeMode(new FormViewMode());
        }

        protected void DETVHCDetails_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            e.Cancel = true;
        }

        protected void DETVHCDetails_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            DETVHCDetails.ChangeMode(new FormViewMode());
        }

        protected void DETVHCDetails_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            e.Cancel = true;
        }

        protected void btnSaveImage_Click(object sender, EventArgs e)
        {
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
            DETVHCDetails.DefaultMode = FormViewMode.Edit;
        }


    }
}