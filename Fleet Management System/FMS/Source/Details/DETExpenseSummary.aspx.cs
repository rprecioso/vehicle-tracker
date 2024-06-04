using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace FMS.Source.Details
{
    public partial class DETExpenseSummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RADExpenseSum_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            GridItem item = e.Item;
            if (e.Item is GridDataItem)
            {
                //Permission perm = new Permission();
                //if (perm.is_allowed("Vehicle", "view", Session["role_id"].ToString().strToInt()) == true)
                //{
                HyperLink CostLink = (HyperLink)e.Item.FindControl("CostLink");
                CostLink.Attributes["href"] = "javascript:void(0);";
                string exp_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["exp_id"].ToString();
                CostLink.Attributes["onclick"] = String.Format("return ShowExpenseForm('{0}');", exp_id);
                //}
            }
        }
    }
}