using FMS_BusinessObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Linq.Dynamic;

namespace FMS.Source.Classes
{
    public class Service
    {
        FMS_DBDataContext datacontext = new FMS_DBDataContext();
        //Vehicle Service
        #region Vehicle Service Methods

        //get services under user_id
        public List<vw_vehicle_service> get_user_services(int _user_id)
        {
            using (datacontext)
            {
                var b = datacontext.vw_vehicle_services.Where(x => x.usr_id == _user_id).ToList();
                return b;
            }
        }

        //get services under vid
        public List<vw_vehicle_service> get_vehicle_service(int _vid)
        {
            using (datacontext)
            {
                return datacontext.vw_vehicle_services.Where(x => x.vid == _vid).ToList();
            }
        }

        public bool isReceiptExist(string _receiptNo, int _user_id, int _srv_id)
        {
            using (datacontext)
            {
                var x = datacontext.vw_vehicle_services.Where(y => y.vhc_srv_id != _srv_id && y.usr_id == _user_id).ToList();
                if (x.Where(y => y.service_receipt_no == _receiptNo).Count() == 0)
                {
                    return false;
                }
                return true;
            }
        }

        //update vehicle services 
        public void update_vehicle_service(refVHCService _vehicle_service, int _vhc_srv_id, string[] exception)
        {
            using (datacontext)
            {
                refVHCService service = (from s in datacontext.refVHCServices
                                         where s.vhc_srv_id == _vhc_srv_id
                                         select s).First();
                service.CopyPropertyValues(_vehicle_service, exception);
                datacontext.SubmitChanges();
            }
        }

        public void add_vehicle_service(refVHCService _vehicle_service)
        {
            using (datacontext)
            {
                datacontext.refVHCServices.InsertOnSubmit(_vehicle_service);
                datacontext.SubmitChanges();
            }
        }

        public void delete_vehicle_service(int _vhc_srv_id)
        {
            using (datacontext)
            {
                datacontext.tblExpenses.DeleteAllOnSubmit(datacontext.tblExpenses.Where(x => x.ref_id == _vhc_srv_id && x.type == extensions.getExpType("Service")).ToList());
                datacontext.refVHCServices.DeleteOnSubmit(datacontext.refVHCServices.Where(x => x.vhc_srv_id == _vhc_srv_id).FirstOrDefault());
                datacontext.SubmitChanges();
            }
        }

        public bool is_not_duplicate_service(string _query, int _user_id)
        {
            using (datacontext)
            {
                if (datacontext.refServices.Where(x => x.service.ToLower().Contains(_query) && x.usr_id == _user_id).ToList().Count() == 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        public void add_service_type(refService _srv)
        {
            using (datacontext)
            {
                datacontext.refServices.InsertOnSubmit(_srv);
                datacontext.SubmitChanges();
            }
        }

        public List<vw_vehicle_service> filter_service(string _id, string _query, string _usr_id)
        {
            using (datacontext)
            {
                try
                {
                    var filtered_list = datacontext.vw_vehicle_services.Where(_id + ".Value.ToString().ToLower().Contains(@0) And usr_id = (@1)", _query, _usr_id.strToInt()).ToList();
                    if (_id.Contains("date"))
                    {
                        DateTime _datetime;
                        if (DateTime.TryParse(_query, out _datetime) == true)
                        {
                            filtered_list = datacontext.vw_vehicle_services.Where(_id + ".Value == @0 And usr_id = (@1)", _datetime, _usr_id.strToInt()).ToList();
                        }
                    }
                    return filtered_list;
                }
                catch (Exception)
                {
                    var filtered_list = datacontext.vw_vehicle_services.Where(_id + ".ToString().ToLower().Contains(@0) And usr_id = (@1)", _query, _usr_id.strToInt()).ToList();
                    return filtered_list;
                }
            
            }
        }
        #endregion
    }
}