using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Web;
using FMS_BusinessObjects;

namespace FMS.Source.Classes
{
    public class Violation
    {
        FMS_DBDataContext dcontext = new FMS_DBDataContext();

        public void add_driver_violation(refDRVViolation _drv_vio, string[] _exception)
        {
            using (dcontext)
            {
                dcontext.refDRVViolations.InsertOnSubmit(_drv_vio);
                dcontext.SubmitChanges();
            }
        }

        public void update_driver_violation(refDRVViolation _drv_vio, int _drv_vio_id, string[] _exception)
        {
            using (dcontext)
            {
                var mod_drv_vio = dcontext.refDRVViolations.Where(x => x.drv_vio_id == _drv_vio_id).First();
                mod_drv_vio.CopyPropertyValues(_drv_vio, _exception);
                dcontext.SubmitChanges();
            }
        }

        public void delete_driver_violation(int _drv_vio_id)
        {
            using (dcontext)
            {
                dcontext.tblExpenses.DeleteAllOnSubmit(dcontext.tblExpenses.Where(x => x.ref_id == _drv_vio_id && x.type == extensions.getExpType("Violation")).ToList());
                var del_drv_vio = dcontext.refDRVViolations.Where(x => x.drv_vio_id == _drv_vio_id).First();
                dcontext.refDRVViolations.DeleteOnSubmit(del_drv_vio);
                dcontext.SubmitChanges();
            }
        }


        public List<vw_driver_violation> get_driver_violation(int _drv_id)
        {
            using (dcontext)
            {
                return dcontext.vw_driver_violations.Where(x => x.drv_id == _drv_id).ToList();
            }
        }

        public List<vw_driver_violation> get_user_violation(int _user_id)
        {
            using (dcontext)
            {
                return dcontext.vw_driver_violations.Where(x => x.user_id == _user_id).ToList();
            }
        }

        public void add_violation(refViolation _vio, string[] _exception)
        {
            using (dcontext)
            {
                dcontext.refViolations.InsertOnSubmit(_vio);
                dcontext.SubmitChanges();
            }
        }

        public bool is_not_duplicate_violation(string _violation_name, int _user_id)
        {
            using (dcontext)
            {
                if (dcontext.refViolations.Where(x => x.violation.ToLower().Contains(_violation_name.ToLower()) == true && x.usr_id == _user_id).Count() == 0)
                {
                    return true;
                }
                return false;
            }
        }

        public List<vw_driver_violation> filter_violation(string _id, string _query, string _usr_id)
        {
            using (dcontext)
            {
                var violation_list = (from x in dcontext.vw_driver_violations
                                      where x.user_id == _usr_id.strToInt()
                                      select x);


                try
                {
                    var filtered_list = violation_list.Where(_id + ".Value.ToString().ToLower().Contains(@0)", _query).ToList();

                    if (_id.Contains("date"))
                    {
                        DateTime _datetime;
                        if (DateTime.TryParse(_query, out _datetime) == true)
                        {
                            filtered_list = violation_list.Where(_id + ".Value == @0", _datetime).ToList();
                        }
                    }

                    return filtered_list;
                }
                catch (Exception)
                {
                    var filtered_list = violation_list.Where(_id + ".ToString().ToLower().Contains(@0)", _query).ToList();
                    return filtered_list;
                }

            }
        }
    }
}