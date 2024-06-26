﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FMS.Source.Classes;
using FMS_BusinessObjects;
using Telerik.Web.UI;

namespace FMS.Source.Child
{
    public partial class Violations_Panel : System.Web.UI.Page
    {

        
        protected void Page_Load(object sender, EventArgs e)
        {
            //Redirect if session has expired
            if (((user_loginfo)Session["LoggedUser"]) == null)
            {
                Response.Redirect("/Login.aspx");
            }

            //Enable/disable pages based on user permission
            //#region user permission
            //Permission perm = new Permission();
            //refPermission modPermission = perm.get_permission_status_module("accounts", ((user_loginfo)Session["LoggedUser"]).role_id);
            //if (modPermission.create == false)
            //{

            //    RadGrid1.MasterTableView.CommandItemDisplay = GridCommandItemDisplay.None;
            //}

            //if (modPermission.delete == false)
            //{
            //    //RadGrid1.MasterTableView.GetColumn("Delete_Column").Display = false;
            //    RadGrid1.AutoGenerateDeleteColumn = false;
            //}

            //if (modPermission.modify == false)
            //{
            //    RadGrid1.AutoGenerateEditColumn = false;
            //}

            //if (modPermission.view == false)
            //{
            //    Response.Redirect("/Source/Child/Error_Page.aspx");
            //}
            //#endregion
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            FMS_DBDataContext datacontext = new FMS_DBDataContext();
            if (e.CommandName == RadGrid.UpdateCommandName)
            {
                using (datacontext)
                {
                    GridEditableItem editItem = e.Item as GridEditableItem;

                    RadTextBox violation = (RadTextBox)editItem.FindControl("tbxViolation");
                    RadTextBox vio_id = (RadTextBox)editItem.FindControl("tbxVioid");
                    refViolation vio = datacontext.refViolations.Where(x => x.vio_id == Convert.ToInt32(vio_id.Text)).First();
                    int _parent = Convert.ToInt32(Session["parent_id"].ToString());
                    string newViolation = violation.Text.Trim().ToLower();

                    if (datacontext.refViolations.Where(x => x.violation.ToLower().Contains(newViolation) && x.vio_id != Convert.ToInt32(vio_id.Text) && x.usr_id == _parent).ToList().Count() == 0)
                    {
                        vio.violation = violation.Text;
                        datacontext.SubmitChanges();
                        RadGrid1.MasterTableView.ClearEditItems();
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Duplicate", "alert('Duplicate violation name, please choose another violation name.');", true);
                    }



                }

            }

            if (e.CommandName == RadGrid.PerformInsertCommandName)
            {
                using (datacontext)
                {
                    GridEditableItem editItem = e.Item as GridEditableItem;
                    RadTextBox violation = (RadTextBox)editItem.FindControl("tbxViolation");
                    RadTextBox vio_id = (RadTextBox)editItem.FindControl("tbxVioid");


                    string newViolation = violation.Text.Trim().ToLower();
                    int _parent = Convert.ToInt32(Session["parent_id"].ToString());
                    if (datacontext.refViolations.Where(x => x.violation.ToLower().Contains(newViolation) && x.usr_id == _parent).ToList().Count() == 0)
                    {
                        refViolation vio = new refViolation()
                        {
                            usr_id = _parent,
                            violation = violation.Text,
                            active = true
                        };

                        datacontext.refViolations.InsertOnSubmit(vio);
                        datacontext.SubmitChanges();
                        RadGrid1.Rebind();
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Duplicate", "alert('Duplicate violation name, please choose another violation name.');", true);
                    }


                }
            }
        }

        protected void RadGrid1_PreRender(object sender, EventArgs e)
        {
            if (RadGrid1.EditItems.Count > 0)
            {
                foreach (GridDataItem item in RadGrid1.MasterTableView.Items)
                {
                    if (item != RadGrid1.EditItems[0])
                    {
                        item.Visible = false;
                    }
                }
            }
        }
    }
}
