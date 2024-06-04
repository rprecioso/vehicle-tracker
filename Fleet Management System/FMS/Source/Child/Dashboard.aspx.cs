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
using Microsoft.Reporting.WebForms;

namespace FMS.Source.Child
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Add Chart Title "Month of [Current Month]"
            CultureInfo ci = new CultureInfo("en-US");
            chrtVHCServices.ChartTitle.Text = "Month of " + DateTime.Now.ToString("MMMM", ci);
  
            chrtDRVViolation.ChartTitle.Text = "Month of " + DateTime.Now.ToString("MMMM", ci);
            chrt_expense.ChartTitle.Text = "Month of " + DateTime.Now.ToString("MMMM", ci) + "";

            //if (!IsPostBack)
            //{
            //    try
            //    {
            //        Service srv = new Service();
            //        ReportViewer1.LocalReport.EnableHyperlinks = true;
            //        //string url = "http://" + Request.ServerVariables["SERVER_NAME"] + "/Source/Admin/Services_Master.aspx" + "?";
            //        //ReportParameter p1 = new ReportParameter("pURL", url);
            //        //ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { p1 });
            //        ReportViewer1.LocalReport.ReportPath = "Source/Child/Report1.rdlc";
            //        ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("ds1", srv.get_user_services(Session["parent_id"].ToString().strToInt())));
            //        ReportViewer1.DataBind();
            //    }
            //    catch (Exception)
            //    {


            //    }

            //}

        }

        protected void gridExpiryFlags_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            Flagging flag = new Flagging();
            gridExpiryFlags.DataSource = flag.get_expiry_flags(Session["parent_id"].ToString().strToInt()).OrderByDescending(x => x.deadline).ThenBy(y => y.item).Take(10);
  
        }

        protected void gridExpiryFlags_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem di = (GridDataItem)e.Item;

                //TableCell cell_days_remaining = di["days_remaining"];

                //if (cell_days_remaining.Text == "Expired")
                //    di.BackColor = System.Drawing.Color.Red;
                //else
                //{
                //    int days = Convert.ToInt32(cell_days_remaining.Text);
                //    if(days <= 10)
                //        di.BackColor = System.Drawing.Color.Orange;
                //    else if(days <= 20)
                //        di.BackColor = System.Drawing.Color.Yellow;
                //    else if (days <= 30)
                //        di.BackColor = System.Drawing.Color.Green;
                //}
            }
        }

        protected void gridItemFlags_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Flag")
            {
                GridDataItem item = e.Item as GridDataItem;
                string id = item.GetDataKeyValue("id").ToString();
                string strflagged = item["flag"].Text;
                bool flagged = (strflagged == "True" || strflagged == "1") ? false : true; //intended to be interchanged because this will be the new status                
                if (item["type"].Text == "VHC")
                {
                    Vehicle vhc = new Vehicle();
                    vhc.update_vehicle_flag(flagged, "", Convert.ToInt32(id));
                }
                else if (item["type"].Text == "DRV")
                {
                    Driver drv = new Driver();
                    drv.update_driver_flag(flagged, "", Convert.ToInt32(id));
                }
                gridItemFlags.Rebind();
            }

            //if (e.CommandName == "ViewDetail")
            //{
            //    GridDataItem item = e.Item as GridDataItem;
            //    string id = item.GetDataKeyValue("id").ToString();
            //    if (item["type"].Text == "VHC")
            //    {
            //        Response.Redirect("../Child/Vehicles.aspx?vid=" + id);
            //    }
            //    else if (item["type"].Text == "DRV")
            //    {
            //        Response.Redirect("../Child/Drivers.aspx?drv_id=" + id);
            //    }
            //}

        }

        protected void gridItemFlags_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                string strflagged = item["flag"].Text;
                bool flagged = (strflagged == "True" || strflagged == "1") ? true : false;
                if (flagged)
                {
                    ImageButton img = (ImageButton)item["btn_flag"].Controls[0];
                    img.ImageUrl = "~/Design/flagging_images/flagged.png";
                    img.ToolTip = "Unflag";
                }
                if (item["type"].Text == "DRV")
                {
                    Image img = (Image)item["img_type"].Controls[0];
                    img.ImageUrl = "../../Design/flagging_images/drv.png";
                    img.ToolTip = "Driver";
                }
                else if (item["type"].Text == "VHC")
                {
                    Image img = (Image)item["img_type"].Controls[0];
                    img.ImageUrl = "../../Design/flagging_images/vhc.png";
                    img.ToolTip = "Vehicle";
                }

                Permission perm = new Permission();
                //GridDataItem item = (GridDataItem)e.Item;
                if (perm.is_allowed("vehicles", "view", Session["role_id"].ToString().strToInt()) == true)
                {
                    HyperLink lnkDetails = (HyperLink)e.Item.FindControl("lnkDetails");
                  
                    s_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString();
                    if (item["type"].Text == "VHC")
                        lnkDetails.Attributes["onclick"] = String.Format("return ShowEditFormVehicle('{0}');", s_id);
                    else if (item["type"].Text == "DRV")
                        lnkDetails.Attributes["onclick"] = String.Format("return ShowEditFormDriver('{0}');", s_id);
                }

            }
        }
        string s_id = "";

        protected void gridExpiryFlags_ItemCreated(object sender, GridItemEventArgs e)
        {
       

            GridItem item = e.Item;

            if (e.Item is  GridFooterItem)
            {

                //LinkButton AlertsLink = (LinkButton)e.Item.FindControl("AlertsLink");
                //AlertsLink.Attributes["href"] = "javascript:void(0);";

                //AlertsLink.Attributes["NavigateUrl"] = "Content1";
                //AlertsLink.Attributes["Target"] = "_self";
                ////string drv_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["drv_id"].ToString();
                //AlertsLink.Attributes["onclick"] = String.Format("return ShowAlertsForm();");

            }

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

        protected void RadChart1_Click(object sender, Telerik.Charting.ChartClickEventArgs e)
        {

        }

    }
}
