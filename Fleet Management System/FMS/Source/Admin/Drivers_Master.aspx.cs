using FMS.Source.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace FMS.Source.Admin
{
    public partial class DriversMaster : System.Web.UI.Page
    {
        #region initial filter items
        List<filterMenu> vehicleFilterMenu = new List<filterMenu>();
        string[] filter_text = {
                                      "Employee ID",
                                      "First Name",
                                      "Last Name",
                                      "Mobile No.",
                                      "Phone No.",
                                      "Address",
                                      "Birth Date",
                                      "ID Type",
                                      "ID No.",
                                      "Employee Status",
                                      "Salary Type",
                                      "Salary",
                                      "License No.",
                                      "License Type",
                                      "License Expiry Date",
                                      "Hire Date"
                                   };

        string[] filter_value = {
                                      "emp_id",
                                      "first_name",
                                      "last_name",
                                      "mobile_no",
                                      "phone_no",
                                      "home_address",
                                      "birth_date",
                                      "gov_id",
                                      "gov_id_no",
                                      "emp_status",
                                      "salary_type",
                                      "status",
                                      "license_no",
                                      "license_type",
                                      "license_expiry_date",
                                      "hire_date"
                                    };
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            //Redirect page to login if session has expired
            if (((user_loginfo)Session["LoggedUser"]) == null)
            {
                Response.Redirect("/Login.aspx");
            }

            //Populate the filter
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
            if (IsPostBack == false)
            {
                rcmb_filter.DataBind();
            }
            #endregion
        }

        private void filter()
        {
            Driver drv = new Driver();
            RADDriver.DataSource = drv.filter_driver(rcmb_filter.SelectedValue, tbx_filter.Text, Session["parent_id"].ToString());
            RADDriver.Rebind();
        }

        protected void btn_filter_Click(object sender, EventArgs e)
        {
            filter();
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, Telerik.Web.UI.AjaxRequestEventArgs e)
        {
            Driver drv = new Driver();
            RADDriver.DataSource = drv.get_user_driver(Session["parent_id"].ToString().strToInt());
            RADDriver.DataBind();
        }



        protected void btnResetFilter_Click(object sender, EventArgs e)
        {
            tbx_filter.Text = "";
            Driver drv = new Driver();
            RADDriver.DataSource = drv.get_user_driver(Session["parent_id"].ToString().strToInt());
            RADDriver.DataBind();
        }

        protected void RADDriver_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                try
                {
                    Driver drv = new Driver();
                    GridDataItem item = (GridDataItem)e.Item;
                    string str_id = item.GetDataKeyValue("drv_id").ToString();
                    drv.delete_driver(Convert.ToInt32(str_id));
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "alert('The record was deleted successfully!')", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "alert('An error has occured: "+ ex.Message+"')", true);
                }
            }
        }

        protected void RADDriver_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Driver drv = new Driver();
            RADDriver.DataSource = drv.get_user_driver(Session["parent_id"].ToString().strToInt());

        }

        protected void RADDriver_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            GridItem item = e.Item;
            if (e.Item is GridDataItem)
            {
                Permission perm = new Permission();
                if (perm.is_allowed("Driver", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    HyperLink editLink = (HyperLink)e.Item.FindControl("EditLink");
                    editLink.Attributes["href"] = "javascript:void(0);";
                    string drv_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["drv_id"].ToString();
                    editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}');", drv_id);
                }


                perm = new Permission();
                if (perm.is_allowed("Expense", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    HyperLink ExpenseLink = (HyperLink)e.Item.FindControl("lnkExpense");
                    Expense exp = new Expense();
                    string drv_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["drv_id"].ToString();
                    string exp_id = "M";
                    int x = exp.get_expense_detail_ref(Convert.ToInt32(drv_id), extensions.getExpType("Driver")).Count();
                    if (x == 0)
                    {
                        exp_id = "0";
                    }
                    ExpenseLink.Attributes["onclick"] = String.Format("return ShowExpenseForm('{0}','{1}','{2}');", drv_id, extensions.getExpType("Driver"), exp_id);
                }
            }
        }
    }
}