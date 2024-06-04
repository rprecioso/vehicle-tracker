using FMS_BusinessObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FMS.Source.Classes;

namespace FMS
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
  
        protected void Page_Load(object sender, EventArgs e)
        {
            if (((user_loginfo)Session["LoggedUser"]) == null)
            {
                Response.Redirect("/Login.aspx");
            }
            lblLogged.Text = ((user_loginfo)Session["LoggedUser"]).username;
            lblLogged.DataBind();
            

        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            Session["LoggedUser"] = null;
            Response.Redirect("/Login.aspx");
        }

        protected void Unnamed_Click1(object sender, EventArgs e)
        {
            FMS_Helper.FMS_Helper tfdb_helper = new FMS_Helper.FMS_Helper();
            List<int> groupList= tfdb_helper.get_group_code(Convert.ToInt32(Session["parent_id"])).ToList();

            Response.Redirect("http://121.96.219.159:802/bcrg/Report.aspx?gisid="+ groupList[0] +"");
        }
    }
}
