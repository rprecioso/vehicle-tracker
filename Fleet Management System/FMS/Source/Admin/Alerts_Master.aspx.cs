using FMS.Source.Classes;
using FMS_BusinessObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Linq.Dynamic;

namespace FMS.Source.Admin
{
    public partial class Alerts_Master : System.Web.UI.Page
    {
        #region initial filter items
        List<filterMenu> vehicleFilterMenu = new List<filterMenu>();
        string[] filter_text = {
                                      "Alert Type",
                                      "Item",
                                      "Deadline",
                                      "Days Remaining"
                                   };

        string[] filter_value = {
                                      "alert_type",
                                      "item",
                                      "deadline",
                                      "days_remaining"
                                    };
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
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
            using (FMS_DBDataContext dcontext = new FMS_DBDataContext())
            {
                var driver_list =
                    dcontext.vw_db_expiry_flags.
                    Where(rcmb_filter.SelectedValue + ".ToString().ToLower().Contains(@0) And usr_id = (@1)", tbx_filter.Text, Convert.ToInt32(Session["parent_id"].ToString())).ToList();
                gridExpiryFlags.DataSource = driver_list;
                gridExpiryFlags.Rebind();
            }
        }


        protected void btnResetFilter_Click(object sender, EventArgs e)
        {
            tbx_filter.Text = "";
            using (FMS_DBDataContext dcontext = new FMS_DBDataContext())
            {
                var driver_list =
                    dcontext.vw_db_expiry_flags.Where(x => x.usr_id == Convert.ToInt32(Session["parent_id"].ToString()));

                gridExpiryFlags.DataSource = driver_list;
                gridExpiryFlags.DataBind();
            }
        }

        protected void btn_filter_Click(object sender, EventArgs e)
        {
            filter();
        }

        protected void gridExpiryFlags_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Flagging flag = new Flagging();
            gridExpiryFlags.DataSource = flag.get_expiry_flags(Session["parent_id"].ToString().strToInt());
        }

        protected void gridExpiryFlags_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {

        }

        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            Flagging flag = new Flagging();
            gridExpiryFlags.DataSource = flag.get_expiry_flags(Session["parent_id"].ToString().strToInt());
            gridExpiryFlags.DataBind();
        }

        protected void gridExpiryFlags_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            GridItem item = e.Item;
            if (e.Item is GridDataItem)
            {
                HyperLink RefLink = (HyperLink)e.Item.FindControl("RefLink");
                string type_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["type_id"].ToString();
                string ref_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ref_id"].ToString();
                if (type_id == extensions.getExpType("Vehicle").ToString())
                {
                    RefLink.Attributes["href"] = "javascript:void(0);";
                    //string drv_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["drv_id"].ToString();
                    RefLink.Attributes["onclick"] = String.Format("return ShowVehicleForm('{0}');", ref_id);
                }
                else if (type_id == extensions.getExpType("Insurance").ToString())
                {
                    RefLink.Attributes["href"] = "javascript:void(0);";
                    //string drv_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["drv_id"].ToString();
                    RefLink.Attributes["onclick"] = String.Format("return ShowInsuranceForm('{0}');", ref_id);
                }
            }
        }
    }
}