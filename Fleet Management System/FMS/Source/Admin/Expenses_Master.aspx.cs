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
    public partial class Expenses_Master : System.Web.UI.Page
    {

        #region initial filter items
        List<filterMenu> vehicleFilterMenu = new List<filterMenu>();
        string[] filter_text = {  "Type",
                                  "Vendor",
                                  "Reference No.",
                                  "Date",
                                  "Cost",
                                  "Description",
                                  "Remarks"       
                               };

        string[] filter_value = { "type",
                                  "vendor",
                                  "ref_id",
                                  "date",
                                  "cost",
                                  "description",
                                  "remarks"
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

            Expense exp = new Expense();
            RADExpense.DataSource = exp.get_user_expense(Convert.ToInt32(Session["parent_id"].ToString()));
            RADExpense.Rebind();
        }

        private void filter()
        {
            Expense exp = new Expense();

            RADExpense.DataSource = exp.filter_service(rcmb_filter.SelectedValue, tbx_filter.Text, Session["parent_id"].ToString());
            RADExpense.Rebind();
        }
        #endregion


        protected void RADExpense_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Expense exp = new Expense();
            if (string.IsNullOrEmpty(Request.QueryString["exp_id"]) == true)
            {
                RADExpense.DataSource = exp.get_user_expense(Session["parent_id"].ToString().strToInt());
            }
            else
            {
                RADExpense.DataSource = exp.get_user_expense(Session["parent_id"].ToString().strToInt()).Where(x => x.exp_id == Convert.ToInt32(Request.QueryString["exp_id"]));
            }

        }

        protected void RADExpense_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            GridItem item = e.Item;
            if (e.Item is GridDataItem)
            {
                Permission perm = new Permission();
                if (perm.is_allowed("Expense", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    HyperLink ExpenseLink = (HyperLink)e.Item.FindControl("ExpenseLink");
                    ExpenseLink.Attributes["href"] = "javascript:void(0);";
                    string exp_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["exp_id"].ToString();
                    string _ref_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ref_id"].ToString();
                    string _type_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["type_id"].ToString();
                    ExpenseLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}', '{1}','{2}');", exp_id, _ref_id, _type_id);
                }

                perm = new Permission();

                HyperLink ReferenceLink = (HyperLink)e.Item.FindControl("ReferenceLink");
                ReferenceLink.Attributes["href"] = "javascript:void(0);";
                string ref_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ref_id"].ToString();
                string url = "";
                string type_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["type_id"].ToString();
                Expense exp = new Expense();
                switch (exp.get_expense_type_name(Convert.ToInt32(type_id)).ToLower())
                {
                    case "service":
                        if (perm.is_allowed("Service", "view", Session["role_id"].ToString().strToInt()) == true)
                        {
                            url = "/Source/Details/DETService.aspx";
                            ReferenceLink.Attributes["onclick"] = String.Format("return ShowReferenceForm('{0}','{1}');", url, ref_id);
                        }
                        break;
                    case "violation":
                        if (perm.is_allowed("Violation", "view", Session["role_id"].ToString().strToInt()) == true)
                        {
                            url = "/Source/Details/DETViolation.aspx";
                            ReferenceLink.Attributes["onclick"] = String.Format("return ShowReferenceForm('{0}','{1}');", url, ref_id);
                        }
                        break;
                    case "insurance":
                        if (perm.is_allowed("Insurance", "view", Session["role_id"].ToString().strToInt()) == true)
                        {
                            url = "/Source/Details/DETInsurance.aspx";
                            ReferenceLink.Attributes["onclick"] = String.Format("return ShowReferenceForm('{0}','{1}');", url, ref_id);
                        }
                        break;
                    case "driver":
                        if (perm.is_allowed("Driver", "view", Session["role_id"].ToString().strToInt()) == true)
                        {
                            url = "/Source/Details/DETDriver.aspx";
                            ReferenceLink.Attributes["onclick"] = String.Format("return ShowReferenceForm('{0}','{1}');", url, ref_id);
                        }
                        break;
                    case "vehicle":
                        if (perm.is_allowed("Vehicle", "view", Session["role_id"].ToString().strToInt()) == true)
                        {
                            url = "/Source/Details/DETVehicle.aspx";
                            ReferenceLink.Attributes["onclick"] = String.Format("return ShowReferenceForm('{0}','{1}');", url, ref_id);
                        }
                        break;
                    default:
                        break;
                }
                perm = new Permission();

                if (perm.is_allowed("Service", "view", Session["role_id"].ToString().strToInt()) == false)
                {
                    ReferenceLink.Font.Underline = false;
                }


            }

        }

        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            Expense exp = new Expense();
            RADExpense.DataSource = exp.get_user_expense(Session["parent_id"].ToString().strToInt());
            RADExpense.DataBind();
        }

        protected void RADExpense_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                try
                {
                    Expense exp = new Expense();
                    GridDataItem item = (GridDataItem)e.Item;
                    string str_id = item.GetDataKeyValue("exp_id").ToString();
                    exp.delete_expense(Convert.ToInt32(str_id));
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "alert('The record was deleted successfully!')", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "alert('An error has occured: " + ex.Message + "')", true);
                }
            }
        }
    }
}