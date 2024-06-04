using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;
using FMS_BusinessObjects;
using System.Linq.Dynamic;
namespace FMS.Source.Classes
{

    public class Flagging
    {
        FMS_DBDataContext datacontext = new FMS_DBDataContext();
        FMS_Helper.FMS_Helper tfdb_helper = new FMS_Helper.FMS_Helper();

        //Flagging        
        #region Flagging
        public List<vw_db_expiry_flag> get_expiry_flags(int _parent_id)
        {
            using (datacontext)
            {
                List<int> groupCodeList = (from x in datacontext.tblGroupCodes
                                           where x.usr_id == _parent_id
                                           select x.group_code).ToList();

                return datacontext.vw_db_expiry_flags.Where(x => groupCodeList.Contains(x.group_code ?? 0)).ToList();
            }
        }
        #endregion
    }
}