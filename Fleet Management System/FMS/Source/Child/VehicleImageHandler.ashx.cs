using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using FMS.Source.Classes;
using FMS_BusinessObjects;

namespace FMS.Source.Child
{
    /// <summary>
    /// Summary description for VehicleImageHandler
    /// </summary>
    public class VehicleImageHandler : IHttpHandler
    {

        FMS_DBDataContext datacontext = new FMS_DBDataContext();
        public void ProcessRequest(HttpContext context)
        {

            int _id = Convert.ToInt32(context.Request.QueryString["id"].ToString());

            var obj = datacontext.tblVehicles.Where(x => x.vid == _id).First().image;

            using (System.IO.MemoryStream str = new System.IO.MemoryStream(
                obj.ToArray(), true))
            {
                str.Write(obj.ToArray(), 0, obj.ToArray().Length);
                Byte[] bytes = str.ToArray();
                context.Response.BinaryWrite(bytes);
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