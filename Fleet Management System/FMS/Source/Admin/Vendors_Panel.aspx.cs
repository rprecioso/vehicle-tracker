using FMS.Source.Classes;
using FMS_BusinessObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace FMS.Source.Admin
{
    public partial class Vendors_Panel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (((user_loginfo)Session["LoggedUser"]) == null)
            {
                Response.Redirect("/Login.aspx");
            }
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            FMS_DBDataContext datacontext = new FMS_DBDataContext();
            if (e.CommandName == RadGrid.UpdateCommandName)
            {
                using (datacontext)
                {
                    GridEditableItem editItem = e.Item as GridEditableItem;

                    RadTextBox tbxVendor = (RadTextBox)editItem.FindControl("tbxVendor");
                    RadTextBox tbxAddress = (RadTextBox)editItem.FindControl("tbxAddress");
                    RadTextBox tbxContact = (RadTextBox)editItem.FindControl("tbxContact");
                    RadNumericTextBox tbxPhoneNo = (RadNumericTextBox)editItem.FindControl("tbxPhoneNo");
                    RadNumericTextBox tbxTIN = (RadNumericTextBox)editItem.FindControl("tbxTIN");
                    RadTextBox tbxEmail = (RadTextBox)editItem.FindControl("tbxEmail");
                    RadTextBox tbxWebsite = (RadTextBox)editItem.FindControl("tbxWebsite");
                    //RadTextBox tbxVendID = (RadTextBox)editItem.FindControl("tbxVendID");

                    int key = editItem.GetDataKeyValue("vend_id").ToString().strToInt();
                    tblVendor vend = datacontext.tblVendors.Where(x => x.vend_id == key).First();
                    int _parent = Convert.ToInt32(Session["parent_id"].ToString());
                    string newVendor = tbxVendor.Text.Trim().ToLower();

                    if (datacontext.tblVendors.Where(x => x.vendor.ToLower().Contains(newVendor) && x.vend_id != key && x.user_id == _parent).ToList().Count() == 0)
                    {
                        vend.vendor = tbxVendor.Text;
                        vend.address = tbxAddress.Text;
                        vend.contact = tbxContact.Text;
                        vend.contact_phone = tbxPhoneNo.Text;
                        vend.tin_no = tbxTIN.Text;
                        vend.contact_email = tbxEmail.Text;
                        vend.website = tbxWebsite.Text;
                        datacontext.SubmitChanges();
                        RadGrid1.MasterTableView.ClearEditItems();
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Duplicate", "alert('Duplicate vendor name, please choose another violation name.');", true);
                    }



                }

            }

            if (e.CommandName == RadGrid.PerformInsertCommandName)
            {
                using (datacontext)
                {
                    GridEditableItem editItem = e.Item as GridEditableItem;
                    RadTextBox tbxVendor = (RadTextBox)editItem.FindControl("tbxVendor");
                    RadTextBox tbxAddress = (RadTextBox)editItem.FindControl("tbxAddress");
                    RadTextBox tbxContact = (RadTextBox)editItem.FindControl("tbxContact");
                    RadNumericTextBox tbxPhoneNo = (RadNumericTextBox)editItem.FindControl("tbxPhoneNo");
                    RadNumericTextBox tbxTIN = (RadNumericTextBox)editItem.FindControl("tbxTIN");
                    RadTextBox tbxEmail = (RadTextBox)editItem.FindControl("tbxEmail");
                    RadTextBox tbxWebsite = (RadTextBox)editItem.FindControl("tbxWebsite");


                    string newVendor = tbxVendor.Text.Trim().ToLower();
                    int _parent = Convert.ToInt32(Session["parent_id"].ToString());
                    if (datacontext.tblVendors.Where(x => x.vendor.ToLower().Contains(newVendor) && x.user_id == _parent).ToList().Count() == 0)
                    {
                        tblVendor ven = new tblVendor()
                        {
                            user_id = _parent,
                            vendor = tbxVendor.Text,
                            address = tbxAddress.Text,
                            contact = tbxContact.Text,
                            contact_phone = tbxPhoneNo.Text,
                            tin_no = tbxTIN.Text,
                            contact_email = tbxEmail.Text,
                            website = tbxWebsite.Text
                        };

                        datacontext.tblVendors.InsertOnSubmit(ven);
                        datacontext.SubmitChanges();
                        RadGrid1.Rebind();
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Duplicate", "alert('Duplicate vendor name, please choose another violation name.');", true);
                    }


                }
            }

            if (e.CommandName == "Flag")
            {
                using (datacontext)
                {
                    GridEditableItem editItem = e.Item as GridEditableItem;
                    int key = editItem.GetDataKeyValue("vend_id").ToString().strToInt();
                    tblVendor vend = datacontext.tblVendors.Where(x => x.vend_id == key).First();
                    int _parent = Convert.ToInt32(Session["parent_id"].ToString());
                    vend.flag = false;
                    vend.flag_reason = string.Empty;

                    datacontext.SubmitChanges();
                    RadGrid1.Rebind();
                }
            }
        }

        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            //if (RadGrid1.EditItems.Count > 0)
            //{
            //    foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
            //    {
            //        if (item != RadGrid1.EditItems[0])
            //        {
            //            item.Visible = false;
            //        }
            //    }
            //}
        }

        string vendFlag = "";
        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                string strflagged = item["flag"].Text;
                bool flagged = (strflagged == "True" || strflagged == "1") ? true : false;
                if (flagged)
                {
                    ImageButton img = (ImageButton)item["btn_flag"].Controls[0];
                    //ImageButton imgFlag = (ImageButton)item["lnk_flag"].Controls[0];
                    img.ImageUrl = "~/Design/flagging_images/flagged.png";
                    img.ToolTip = "Unflag";
                    //imgFlag.ImageUrl = "~/Design/flagging_images/flagged.png";
                    //imgFlag.ToolTip = "Unflag";
                }
                Permission perm = new Permission();
                if (perm.is_allowed("vehicle", "modify", Session["role_id"].ToString().strToInt()) == true)
                {
                    if (!flagged)
                    {
                        ImageButton imgFlag = (ImageButton)item["btn_flag"].Controls[0];
                        imgFlag.Attributes["href"] = "javascript:void(0);";
                        imgFlag.CommandName = string.Empty;
                        vendFlag = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["vend_id"].ToString();
                        imgFlag.Attributes["onclick"] = String.Format("return ShowFlagForm('{0}','VND');", vendFlag);
                    }
                    else
                    {
                        ImageButton imgFlag = (ImageButton)item["btn_flag"].Controls[0];
                        imgFlag.Attributes["href"] = "return true;";
                        imgFlag.CommandName = "Flag";
                    }
                }
            }
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            RadGrid1.Rebind();
        }

    }
}