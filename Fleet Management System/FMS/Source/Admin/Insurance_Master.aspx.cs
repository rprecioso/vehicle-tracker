using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using FMS.Source.Classes;
using FMS_BusinessObjects;
using Telerik.Web.UI;
namespace FMS.Source.Child
{
    public partial class Insurance : System.Web.UI.Page
    {
        //Filter Menu Items
        #region Filter Menu Items

        List<filterMenu> vehicleFilterMenu = new List<filterMenu>();
        string[] filter_text = {  "VID",
                                  "Vehicle Name",
                                  "Insurance Company",
                                  "Certificate No",
                                  "Issue Date",
                                  "Expiry Date",
                                  "Policy Type"
                               };

        string[] filter_value = { "vid",
                                  "vehicle_name",
                                  "insurance_company",
                                  "cert_no",
                                  "issue_date",
                                  "expiry_date",
                                  "policy_type"
                                  };

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
        string ins_id = "";
        protected void gridIns_ItemCreated(object sender, GridItemEventArgs e)
        {

            if (e.Item is GridDataItem)
            {
                Permission perm = new Permission();
                HyperLink editLink = (HyperLink)e.Item.FindControl("lnkCertNo");
                if (perm.is_allowed("insurance", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    editLink.Attributes["href"] = "javascript:void(0);";
                    ins_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ins_id"].ToString();

                    editLink.Attributes["onclick"] = String.Format("return ShowEditForm('{0}');", ins_id);
                }

                HyperLink ExpenseLink = (HyperLink)e.Item.FindControl("lnkExpense");
                if (perm.is_allowed("Expense", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    Expense exp = new Expense();
                    ins_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ins_id"].ToString();
                    string exp_id = "M";
                    int x = exp.get_expense_detail_ref(Convert.ToInt32(ins_id), extensions.getExpType("Insurance")).Count();
                    if ( x == 0)
                    {
                        exp_id = "0";
                    }
                    ExpenseLink.Attributes["onclick"] = String.Format("return ShowExpenseForm('{0}','{1}','{2}');", ins_id, extensions.getExpType("Insurance"), exp_id);
                }                
            }
        }

        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            gridIns.Rebind();
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
            FMS.Source.Classes.Insurance ins = new FMS.Source.Classes.Insurance();
            gridIns.DataSource = ins.get_user_insurances(Convert.ToInt32(Session["parent_id"].ToString()));
            gridIns.Rebind();
        }

        private void filter()
        {
            FMS.Source.Classes.Insurance ins = new FMS.Source.Classes.Insurance(); ;
            gridIns.DataSource = ins.filter_insurance(rcmb_filter.SelectedValue, tbx_filter.Text, Session["parent_id"].ToString());
            gridIns.Rebind();
        }
        #endregion

        protected void gridIns_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            FMS.Source.Classes.Insurance ins = new FMS.Source.Classes.Insurance();
            gridIns.DataSource = ins.get_user_insurances(Convert.ToInt32(Session["parent_id"].ToString()));
        }

        protected void gridIns_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                try
                {
                    FMS.Source.Classes.Insurance ins = new FMS.Source.Classes.Insurance();
                    GridDataItem item = (GridDataItem)e.Item;
                    string str_id = item.GetDataKeyValue("ins_id").ToString();
                    ins.delete_vehicle_insurance(Convert.ToInt32(str_id));
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "alert('The record was deleted successfully!')", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "alert('An error has occured: " + ex.Message + "')", true);
                }
            }
        }

        protected void gridIns_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                Permission perm = new Permission();
                HyperLink vehLink = (HyperLink)e.Item.FindControl("lnk_veh");
                if (perm.is_allowed("insurance", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    GridDataItem item = (GridDataItem)e.Item;
                    string _vid = item["vid"].Text;
                    vehLink.Attributes["href"] = "javascript:void(0);";
                    vehLink.Attributes["onclick"] = String.Format("return ShowEditFormVehicle('{0}');", _vid);

                }
            }
        }
    }

}