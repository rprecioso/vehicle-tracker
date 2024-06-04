using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using FMS.Source.Classes;
using FMS_BusinessObjects;
using Telerik.Web.UI;

namespace FMS.Source.Details
{
    public partial class DETFlag : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnOk_Click(object sender, EventArgs e)
        {
            //string id = item.GetDataKeyValue("id").ToString();
            string id = Request.QueryString["id"];
            string type = Request.QueryString["type"];
            string flag_reason = txtFlagReason.Text.Trim();
            //bool flagged = (strflagged == "True" || strflagged == "1") ? false : true; //intended to be interchanged because this will be the new status                
            if (type == "VHC")
            {
                Vehicle vhc = new Vehicle();
                vhc.update_vehicle_flag(true, flag_reason, Convert.ToInt32(id));
                Session["strVID"] = id;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Flag Vehicle", "alert('Vehicle is now flagged!');", true);
            }
            else if (type == "DRV")
            {
                Driver drv = new Driver();
                drv.update_driver_flag(true, flag_reason, Convert.ToInt32(id));
                Session["drv_id"] = id;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Flag Vehicle", "alert('Vehicle is now flagged!');", true);
            }
            else if (type == "VND")
            {
                FMS_DBDataContext datacontext = new FMS_DBDataContext();
                using (datacontext)
                {

                    int key = id.strToInt();
                    tblVendor vend = datacontext.tblVendors.Where(x => x.vend_id == key).First();
                    int _parent = Convert.ToInt32(Session["parent_id"].ToString());

                    vend.flag = true;
                    vend.flag_reason = flag_reason;

                    datacontext.SubmitChanges();

                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Flag Vehicle", "alert('Vehicle is now flagged!');", true);
                }
            }
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
        }
    }
}



