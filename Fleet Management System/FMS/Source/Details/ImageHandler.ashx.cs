using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using FMS_BusinessObjects;

namespace FMS.Source.Details
{
    /// <summary>
    /// Summary description for ImageHandler
    /// </summary>
    public class ImageHandler : IHttpHandler
    {
        FMS_DBDataContext datacontext = new FMS_DBDataContext();
        public void ProcessRequest(HttpContext context)
        {
            string _type = context.Request.QueryString["type"].ToString();
            int _id = Convert.ToInt32(context.Request.QueryString["id"].ToString());
            System.Data.Linq.Binary obj = null;
            string _imagepath = "";

            switch (_type)
            {
                case "driver":
                    obj = datacontext.tblDrivers.Where(x => x.drv_id == _id).First().image;
                _imagepath = "/Design/driver_pg_images/drv_unavailable.png";
                    break;
                case "vehicle":
                    obj = datacontext.tblVehicles.Where(x => x.vid == _id).First().image;
                    _imagepath = "/Design/vehicle_pg_images/VHC_unavailable.png";
                    break;
                default:
                    break;
            }

            if (obj != null)
            {
                using (System.IO.MemoryStream str = new System.IO.MemoryStream(
                    obj.ToArray(), true))
                {
                    str.Write(obj.ToArray(), 0, obj.ToArray().Length);
                    Byte[] bytes = str.ToArray();
                    context.Response.BinaryWrite(bytes);
                }
            }
            else
            {
                using (Bitmap image = new Bitmap(context.Server.MapPath(_imagepath)))
                {
                    using (MemoryStream ms = new MemoryStream())
                    {
                        image.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                        ms.WriteTo(context.Response.OutputStream);
                    }
                }
            }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}