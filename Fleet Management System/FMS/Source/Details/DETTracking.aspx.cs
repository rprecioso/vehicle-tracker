using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FMS.Source.Classes;
using FMS_BusinessObjects;

namespace FMS.Source.Details
{
    public partial class VHCTracking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (((user_loginfo)Session["LoggedUser"]) == null)
            {
                Response.Redirect("/Login.aspx");
            }
            FMS_Helper.FMS_Helper tfdb_helper = new FMS_Helper.FMS_Helper();
            string lon = "0";
            string lat = "0";
            DataSet ds = tfdb_helper.get_a_tracks(Convert.ToInt32(Request.QueryString["vid"]));

            if (ds.Tables[0].Rows.Count > 0)
            {
                lon = ds.Tables[0].Rows[0][5].ToString();
                lat = ds.Tables[0].Rows[0][6].ToString();

                string lonlat = lat + "," + lon;
                string mapURL = "http://maps.googleapis.com/maps/api/staticmap?center=" + lonlat + "&zoom=16&markers=" + lonlat + "&size=900x400&format=png&maptype=map&sensor=false";
                dvVehicle.DataSourceID = null;
                dvVehicle.DataSource = ds.Tables[0];


                imgMap.ImageUrl = mapURL;
            }

            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "No Data Found", "alert('No Data Found');", true);
            }



        }
    }
}