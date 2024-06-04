using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FMS.Source.Classes;
using Telerik.Web.UI;
using FMS_BusinessObjects;
using FMS.Child;
using System.Runtime.CompilerServices;
namespace FMS.Source.Child
{
    public partial class Violations : System.Web.UI.Page
    {
        #region initial filter items
        List<filterMenu> vehicleFilterMenu = new List<filterMenu>();
        string[] filter_text = {  "Ticket No.",
                                  "Date",
                                  "Violation",
                                  "Location",
                                  "Driver",
                                  "Vehicle"                                           
                               };

        string[] filter_value = { "violation_ticket_no",
                                  "date",
                                  "violation",
                                  "location",
                                  "driver",
                                  "vehicle_name"                                           
                               };
        #endregion

        #region Filter Menu Methods
        protected void btn_filter_Click(object sender, EventArgs e)
        {
            filter();
        }

        protected void btnResetFilter_Click(object sender, EventArgs e)
        {
            tbx_filter.Text = "";
            Violation vio = new Violation();
            RadDRVViolation.DataSource = vio.get_user_violation(Convert.ToInt32(Session["parent_id"].ToString()));
            RadDRVViolation.Rebind();
        }

        private void filter()
        {

            Violation vio = new Violation();
            RadDRVViolation.DataSource = vio.filter_violation(rcmb_filter.SelectedValue, tbx_filter.Text, Session["parent_id"].ToString());
            RadDRVViolation.Rebind();
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            //Redirect if session is expired
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

        protected void RadDRVViolation_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                try
                {
                    GridDataItem dataItem = e.Item as GridDataItem;
                    int _drv_vio_id = dataItem.GetDataKeyValue("drv_vio_id").ToString().strToInt();
                    Violation vio = new Violation();
                    vio.delete_driver_violation(_drv_vio_id);
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "alert('The record was deleted successfully!')", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "alert('An error has occured: " + ex.Message + "')", true);
                }
            }
        }

        protected void RadDRVViolation_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            Violation vio = new Violation();
            RadDRVViolation.DataSource = vio.get_user_violation(Session["parent_id"].ToString().strToInt());
        }

        protected void RadDRVViolation_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                Permission perm = new Permission();
                if (perm.is_allowed("Violation", "modify", Session["role_id"].ToString().strToInt()) == true)
                {
                    HyperLink TrackLink = (HyperLink)e.Item.FindControl("EditLink");
                    TrackLink.Attributes["href"] = "javascript:void(0);";
                    string drv_vio_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["drv_vio_id"].ToString();

                    TrackLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}');", drv_vio_id);
                }
            }
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            Violation vio = new Violation();
            RadDRVViolation.DataSource = vio.get_user_violation(Session["parent_id"].ToString().strToInt());
            RadDRVViolation.DataBind();
        }       

        protected void RadDRVViolation_ItemDataBound(object sender, GridItemEventArgs e)
        {
            HyperLink ExpenseLink = new HyperLink();
            HyperLink VehicleLink = new HyperLink();
            if (e.Item is GridDataItem)
            {
                ExpenseLink = (HyperLink)e.Item.FindControl("ExpenseLink");
                VehicleLink = (HyperLink)e.Item.FindControl("VehicleLink");

                GridDataItem dataItem = (GridDataItem)e.Item;
                string drv_vio_id = dataItem["drv_vio_id"].Text;
                string vid = dataItem["vid"].Text;
                string exp_id = dataItem["exp_id"].Text;
                if (exp_id == "&nbsp;")
                {
                    exp_id = "0";
                    //tblExpense newExp = new tblExpense();
                    //newExp.type = extensions.getExpType("Violation");
                    //newExp.ref_id = Convert.ToInt32(drv_vio_id);
                    //Expense exp = new Expense();
                    //exp_id = exp.add_expense(newExp, new[] { "exp_id" }).ToString();
                }
                Permission perm = new Permission();
                if (perm.is_allowed("Expense", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    ExpenseLink.Attributes["onclick"] = String.Format("return ShowExpenseForm('{0}','{1}','{2}');", exp_id, drv_vio_id, extensions.getExpType("Violation"));
                }
                perm = new Permission();
                if (perm.is_allowed("Vehicle", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    VehicleLink.Attributes["onclick"] = String.Format("return ShowVehicleForm('{0}');", vid);
                }


            }
        }
    }
}