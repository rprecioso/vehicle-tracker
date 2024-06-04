using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FMS.Source.Classes;
using FMS_BusinessObjects;
using Telerik.Web.UI;

namespace FMS.Source.Admin
{
    public partial class VehiclesMaster : System.Web.UI.Page
    {
        string format = "";

        //Filter Menu Items
        #region Filter Menu Items

        List<filterMenu> vehicleFilterMenu = new List<filterMenu>();
        string[] filter_text = {  "VID",
                                  "Vehicle",
                                  "Model",
                                  "Type",
                                  "Color",
                                  "Volume",
                                  "Manufacturer",
                                  "Engine No.",
                                  "Chassis No.",
                                  "Year",
                                  "Chasis Weight",
                                  "Body Wieght",
                                  "Gross Weight",
                                  "Reg. Expiry Date",
                                  "Reg. No.",                                 
                                  "Seat Cap.",                                                                  
                                  "Remarks",                                  
                                  "Insurance Company",
                                  "Insurance Amount",
                                  "Road Tax"};

        string[] filter_value = { "vid",
                                  "vehicle",
                                  "vhc_model",
                                  "body_type",
                                  "color",
                                  "cc",
                                  "manufacturer",
                                  "engine_no",
                                  "chasis_no",
                                  "year_make",
                                  "chasis_wt",
                                  "body_wt",
                                  "gross_wt",
                                  "registration_expiry_date",
                                  "registration_no",
                                  "seating_no",
                                  "remarks",                                 
                                  "ins_co",
                                  "ins_amt",
                                  "road_tax"};

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            for (int i = 0; i < filter_value.Count(); i++)
            {
                vehicleFilterMenu.Add(new filterMenu
                {
                    DataText = filter_text[i],
                    DataValue = filter_value[i]
                });
            }

            rcmb_filter.DataSource = vehicleFilterMenu;
            if (IsPostBack == false)
            {
                rcmb_filter.DataBind();
            }

            if (((user_loginfo)Session["LoggedUser"]) == null)
            {
                Response.Redirect("/Login.aspx");
            }
        }

        //Filter Menu Methods
        #region Filter Menu Methods
        protected void btn_filter_Click(object sender, EventArgs e)
        {
            filter();
        }

        protected void btnResetFilter_Click(object sender, EventArgs e)
        {
            tbx_filter.Text = "";
            Vehicle veh = new Vehicle();
            RADVehicles.DataSource = veh.get_user_vehicles(Convert.ToInt32(Session["parent_id"].ToString()));
            RADVehicles.Rebind();
        }

        private void filter()
        {
            Vehicle veh = new Vehicle();
            RADVehicles.DataSource = veh.filter_vehicle(rcmb_filter.SelectedValue, tbx_filter.Text, Session["parent_id"].ToString());
            RADVehicles.Rebind();
        }
        #endregion

        protected void RADVehicles_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Vehicle veh = new Vehicle();
            RADVehicles.DataSource = veh.get_user_vehicles(Convert.ToInt32(Session["parent_id"].ToString()));
        }

        protected void RADVehicles_ItemCreated(object sender, GridItemEventArgs e)
        {
            GridItem item = e.Item;
            if (e.Item is GridDataItem)
            {
                Permission perm = new Permission();
                if (perm.is_allowed("Vehicle", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    HyperLink TrackLink = (HyperLink)e.Item.FindControl("EditLink");
                    TrackLink.Attributes["href"] = "javascript:void(0);";
                    string vid = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["vid"].ToString();
                    TrackLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}');", vid);
                }

                perm = new Permission();
                if (perm.is_allowed("Tracking", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    HyperLink TrackLink = (HyperLink)e.Item.FindControl("TrackLink");
                    TrackLink.Attributes["href"] = "javascript:void(0);";
                    string vid = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["vid"].ToString();

                    TrackLink.Attributes["onclick"] = String.Format("return ShowTrackingForm('{0}');", vid);
                }

               
                perm = new Permission();
                if (perm.is_allowed("Expense", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    HyperLink ExpenseLink = (HyperLink)e.Item.FindControl("lnkExpense");
                    Expense exp = new Expense();
                    string vid = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["vid"].ToString();
                    string exp_id = "M";
                    int x = exp.get_expense_detail_ref(Convert.ToInt32(vid), extensions.getExpType("Vehicle")).Count();
                    if (x == 0)
                    {
                        exp_id = "0";
                    }
                    ExpenseLink.Attributes["onclick"] = String.Format("return ShowExpenseForm('{0}','{1}','{2}');", vid, extensions.getExpType("Vehicle"), exp_id);
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

        protected void RADVehicles_PreRender(object sender, EventArgs e)
        {
            if (RADVehicles.EditItems.Count > 0)
            {
                foreach (GridDataItem item in RADVehicles.MasterTableView.Items)
                {
                    if (item != RADVehicles.EditItems[0])
                    {
                        item.Visible = false;
                    }
                }
            }
        }

        protected void RADVehicles_ItemCommand(object sender, GridCommandEventArgs e)
        {

            if (e.CommandName == "ExportToExcel")
            {
                format = "excel";
            }

            else if (e.CommandName == "ExportToPdf")
            {
                format = "pdf";
            }

        }

        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            Vehicle veh = new Vehicle();
            RADVehicles.DataSource = veh.get_user_vehicles(Convert.ToInt32(Session["parent_id"].ToString()));
            RADVehicles.DataBind();
        }
    }
}