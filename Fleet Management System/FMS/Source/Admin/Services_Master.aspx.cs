using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FMS.Child;
using FMS.Source.Classes;
using FMS_BusinessObjects;
using Telerik.Web.UI;

namespace FMS.Source.Admin
{
    public partial class ServicesMaster : System.Web.UI.Page
    {
        #region initial filter items
        List<filterMenu> vehicleFilterMenu = new List<filterMenu>();
        string[] filter_text = {  "Service Type",
                                  "Date Started",
                                  "Date Completed",
                                  "Serviced By",
                                  "Remarks",
                                  "Vehicle",
                                  "VID",
                                  "Receipt No.",
                                  "Driver"          
                               };

        string[] filter_value = { "service",
                                  "date_started",
                                  "date_completed",
                                  "srv_by",
                                  "remarks",
                                  "vehicle_name",
                                  "vid",
                                  "service_receipt_no",
                                  "brought_by"
                                };
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            //Redirect page to login if session has expired
            if (((user_loginfo)Session["LoggedUser"]) == null)
            {
                Response.Redirect("/Login.aspx");
            }

            //Populate filter menu
            #region populate filter
            for (int i = 0; i < filter_value.Count(); i++)
            {
                vehicleFilterMenu.Add(new filterMenu
                {
                    DataText = filter_text[i],
                    DataValue = filter_value[i]
                });
            }
            rcmb_filter.DataSource = vehicleFilterMenu;
            if (!IsPostBack)
            {
                rcmb_filter.DataBind();
            }
            #endregion

        }


        #region Filter Menu Methods
        protected void btn_filter_Click(object sender, EventArgs e)
        {
            filter();
        }

        protected void btnResetFilter_Click(object sender, EventArgs e)
        {
            tbx_filter.Text = "";
            Service srv = new Service();
            RADVHCServices.DataSource = srv.get_user_services(Convert.ToInt32(Session["parent_id"].ToString()));
            RADVHCServices.Rebind();
        }

        private void filter()
        {

            Service srv = new Service();
            RADVHCServices.DataSource = srv.filter_service(rcmb_filter.SelectedValue, tbx_filter.Text, Session["parent_id"].ToString());
            RADVHCServices.Rebind();
        }
        #endregion



        //Initiate the radgrid output
        protected void RADVHCServices_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Service srv = new Service();


            var res = Request.QueryString["id"];
            if (string.IsNullOrEmpty(res) == true)
            {
                RADVHCServices.DataSource = srv.get_user_services(Convert.ToInt32(Session["parent_id"].ToString()));
            }
            else
            {
                RADVHCServices.DataSource = srv.get_user_services(Convert.ToInt32(Session["parent_id"].ToString())).Where(x => x.vhc_srv_id == res.strToInt());
            }            

        }

        string format = "";
        protected void RADVHCServices_ItemCreated(object sender, GridItemEventArgs e)
        {
            GridItem item = e.Item;
            if (e.Item is GridDataItem)
            {
                Permission perm = new Permission();
                if (perm.is_allowed("Service", "modify", Session["role_id"].ToString().strToInt()) == true)
                {
                    HyperLink editLink = (HyperLink)e.Item.FindControl("EditLink");
                    editLink.Attributes["href"] = "javascript:void(0);";
                    string vhc_srv_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["vhc_srv_id"].ToString();
                    editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}');", vhc_srv_id);
                }

            }


            #region Export Functions

            if (format == "excel")
            {
                if (item is GridHeaderItem)
                    foreach (TableCell cell in item.Cells)
                    {
                        cell.Style["font-family"] = "Verdana";
                        cell.Style["text-align"] = "center";
                        cell.Style["font-size"] = "10pt";
                        item.Style["background-color"] = "#3588be";
                    }
                else if (item is GridDataItem)
                {
                    item.Style["font-family"] = "Times New Roman";
                    item.Style["vertical-align"] = "middle";
                    item.Style["text-align"] = "center";
                    item.Style["font-size"] = "11pt";
                    item.Style["background-color"] = item.ItemType == GridItemType.AlternatingItem ? "#DDDDDD" : "#ffffff";
                }
            }
            else if (format == "pdf")
            {
                if (item is GridHeaderItem)
                    foreach (TableCell cell in item.Cells)
                    {
                        cell.Style["font-family"] = "Verdana";
                        cell.Style["text-align"] = "center";
                        cell.Style["font-size"] = "6pt";
                        item.Style["background-color"] = "#3588be";
                    }
                else if (item is GridDataItem)
                {
                    item.Style["font-family"] = "Times New Roman";
                    item.Style["vertical-align"] = "middle";
                    item.Style["text-align"] = "center";
                    item.Style["font-size"] = "8pt";
                    item.Style["background-color"] = item.ItemType == GridItemType.AlternatingItem ? "#DDDDDD" : "#ffffff";
                }
            }
            #endregion


        }

        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            Service srv = new Service();
            RADVHCServices.DataSource = srv.get_user_services(Convert.ToInt32(Session["parent_id"].ToString()));
            RADVHCServices.DataBind();
        }

        protected void RADVHCServices_ItemCommand(object sender, GridCommandEventArgs e)
        {

            Validate();

            if (e.CommandName == "InitInsert")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "ShowInsertForm();", true);
            }


            //if (e.CommandName == "Delete")
            //{
            //    GridDataItem dataItem = e.Item as GridDataItem;

            //    string vhc_srv_id = dataItem.GetDataKeyValue("vhc_srv_id").ToString();
            //    Service srv = new Service();
            //    srv.delete_vehicle_service(Convert.ToInt32(vhc_srv_id));
            //}

            if (e.CommandName == "Delete")
            {
                try
                {
                    Service srv = new Service();
                    GridDataItem item = (GridDataItem)e.Item;
                    string str_id = item.GetDataKeyValue("vhc_srv_id").ToString();
                    srv.delete_vehicle_service(Convert.ToInt32(str_id));
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "alert('The record was deleted successfully!')", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "alert('An error has occured: " + ex.Message + "')", true);
                }
            }


            if (e.CommandName == "ExportToExcel")
            {
                filter();
                format = "excel";
            }

            else if (e.CommandName == "ExportToPdf")
            {
                filter();
                format = "pdf";
            }
        }

        protected void RADVHCServices_ItemDataBound(object sender, GridItemEventArgs e)
        {
            HyperLink ExpenseLink = new HyperLink();
            HyperLink DriverLink = new HyperLink();
            HyperLink VehicleLink = new HyperLink();
            if (e.Item is GridDataItem)
            {
                ExpenseLink = (HyperLink)e.Item.FindControl("ExpenseLink");
                DriverLink = (HyperLink)e.Item.FindControl("DriverLink");
                VehicleLink = (HyperLink)e.Item.FindControl("VehicleLink");
            }

            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)e.Item;
                string vhc_srv_id = dataItem["vhc_srv_id"].Text;
                string exp_id = dataItem["exp_id"].Text;
                string vid = dataItem["vid"].Text;
                string drv_id = dataItem["brought_by"].Text;
                if (exp_id == "&nbsp;")
                {
                    exp_id = "0";
                }
                Permission perm = new Permission();
                if (perm.is_allowed("Expense", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    ExpenseLink.Attributes["onclick"] = String.Format("return ShowExpenseForm('{0}','{1}',{2});", exp_id, vhc_srv_id, extensions.getExpType("Service"));
                }
                else
                {
                    ExpenseLink.Font.Underline = false;
                }
                perm = new Permission();
                if (perm.is_allowed("Driver", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    DriverLink.Attributes["onclick"] = String.Format("return ShowDriverForm('{0}');", drv_id);
                }
                else
                {
                    DriverLink.Font.Underline = false;
                }
                perm = new Permission();
                if (perm.is_allowed("Vehicle", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    VehicleLink.Attributes["onclick"] = String.Format("return ShowVehicleForm('{0}');", vid);
                }
                else
                {
                    VehicleLink.Font.Underline = false;
                }
            }
        }


    }
}