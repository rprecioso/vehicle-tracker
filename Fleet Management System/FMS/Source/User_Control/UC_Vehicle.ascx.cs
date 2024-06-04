using FMS_BusinessObjects;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;

namespace FMS.Source.User_Control
{
    public partial class UC_Vehicle : System.Web.UI.UserControl, IBindableControl
    {
 
        


        public void ExtractValues(IOrderedDictionary dictionary)
        { 
        //dictionary["vid"] = vehicleDetail.Templat
        }
  

        protected void Page_Load(object sender, EventArgs e)
        {
        //    try
        //    {
        //        lblVid.Text = source.vid.ToString();
        //        lblName.Text = source.vehicle_name;
        //        lblModel.Text = source.vhc_model;
        //        lblType.Text = source.body_type;
        //        lblColor.Text = source.color;
        //    }
        //    catch (Exception)
        //    {

        //    }
        }
    }
}