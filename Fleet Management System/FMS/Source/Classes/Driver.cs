using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FMS_BusinessObjects;
using System.Linq.Dynamic;
namespace FMS.Source.Classes
{
    public class Driver
    {
        FMS_DBDataContext dcontext = new FMS_DBDataContext();
        FMS_Helper.FMS_Helper tfdb_helper = new FMS_Helper.FMS_Helper();

        public int add_driver(tblDriver _driver, string[] _exception)
        {
            
                tblDriver newDriver = new tblDriver();
                newDriver.CopyPropertyValues(_driver, _exception);
                dcontext.tblDrivers.InsertOnSubmit(newDriver);
                dcontext.SubmitChanges();
                return newDriver.drv_id;
            
        }

        public List<vw_driver_detail> get_user_driver(int _usr_id)
        {
            
                var _driverList = from d in dcontext.vw_driver_details
                                  where d.usr_id == _usr_id
                                  select d;
                return _driverList.ToList();
            
        }

        public List<vw_driver_detail> get_driver_detail(int _drvid)
        {
           
                var _driver = from d in dcontext.vw_driver_details
                              where d.drv_id == _drvid
                              select d;
                return _driver.ToList();
            
        }

        public List<vw_driver_detail> filter_driver(string _id, string _query, string _usr_id)
        {
            try
            {
                var driver_list =
                  dcontext.vw_driver_details.
                  Where(_id + ".Value.ToString().ToLower().Contains(@0) And usr_id = (@1)", _query, _usr_id.strToInt()).ToList();
                if (_id.Contains("date"))
                {
                    DateTime _datetime;
                    if (DateTime.TryParse(_query, out _datetime) == true)
                    {
                        driver_list = dcontext.vw_driver_details.Where(_id + ".Value == @0 And usr_id = (@1)", _datetime ,_usr_id.strToInt()).ToList();
                    }
                }
                return driver_list;
            }
            catch (Exception)
            {

                var driver_list =
                    dcontext.vw_driver_details.
                    Where(_id + ".ToString().ToLower().Contains(@0) And usr_id = (@1)", _query, _usr_id.strToInt()).ToList();
                return driver_list;
            }
                
            
        }


        public int add_license(refDRVLicense _drv_lic)
        {
           
                dcontext.refDRVLicenses.InsertOnSubmit(_drv_lic);
                dcontext.SubmitChanges();
                return _drv_lic.drv_lic_id;
            
        }

        public void update_license(refDRVLicense _drv_lic, int _drv_lic_id, string[] _exception)
        {
            
                refDRVLicense newLicense = dcontext.refDRVLicenses.Where(x => x.drv_lic_id == _drv_lic_id).First();
                newLicense.CopyPropertyValues(_drv_lic, _exception);
                dcontext.SubmitChanges();
            
        }



        public void update_driver(tblDriver _driver, int _drv_id, string[] _exception)
        {
           
                tblDriver newDriver = dcontext.tblDrivers.Where(x => x.drv_id == _drv_id).First();
                newDriver.CopyPropertyValues(_driver, _exception);
                dcontext.SubmitChanges();
            
        }


        public void update_driver_flag(bool _flagged, string _flag_reason, int _drv_id)
        {
            
                dcontext.tblDrivers.Where(x => x.drv_id == _drv_id).First().flag = _flagged;
                dcontext.tblDrivers.Where(x => x.drv_id == _drv_id).First().flag_reason = _flag_reason;
                dcontext.SubmitChanges();
            
        }

        public void update_driver_image(byte[] _image_binary, int _drv_id)
        {
          
                var img = dcontext.tblDrivers.Where(x => x.drv_id == _drv_id);
                if (img.Count() > 0)
                {
                    img.First().image = _image_binary;
                    dcontext.SubmitChanges();
                }           
            
        }

        public bool has_driver_image(int _drv_id)
        {
            
                if (dcontext.tblDrivers.Where(x => x.drv_id == _drv_id).First().image != null)
                {
                    return true;
                }
                return false;
            
        }

        public void delete_driver(int _drv_id)
        {
           
                dcontext.tblExpenses.DeleteAllOnSubmit(dcontext.tblExpenses.Where(x => x.ref_id == _drv_id && x.type == extensions.getExpType("Driver")).ToList());
                dcontext.tblDrivers.DeleteOnSubmit(dcontext.tblDrivers.Where(x => x.drv_id == _drv_id).FirstOrDefault());
                dcontext.SubmitChanges();
            
        }

        public List<vw_driver_violation> get_driver_violation_drvid(int _drvid)
        {
            
                var _violation = from vw in dcontext.vw_driver_violations
                                 where vw.drv_id == _drvid
                                 select vw;
                return _violation.ToList();
            
        }

        public bool is_empid_duplicate(string _emp_id, int _usr_id, int _drv_id = 0)
        {
           
                if (_drv_id == 0)
                {
                    if (dcontext.tblDrivers.Where(x => x.emp_id == _emp_id && x.usr_id == _usr_id).ToList().Count > 0)
                    {
                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }
                else
                {
                    if (dcontext.tblDrivers.Where(x => x.emp_id == _emp_id && x.usr_id == _usr_id && x.drv_id != _drv_id).ToList().Count > 0)
                    {
                        return false;
                    }
                    else
                    {
                        return true;
                    }
                }
            
        }

        public List<refDRVViolation> get_drv_vio(int _user_id)
        {
            List<refDRVViolation> drvVioList = new List<refDRVViolation>();
            List<tblGroupCode> groupCodeList = dcontext.tblGroupCodes
                .Where(x => x.usr_id == _user_id).ToList();
            foreach (tblGroupCode groups in groupCodeList)
            {
                List<int> vehicleList = (from u in dcontext.tblVehicles
                                         where u.group_code == groups.group_code
                                         select u.vid).Distinct().ToList();
                foreach (int item in vehicleList)
                {
                    drvVioList.AddRange(dcontext.refDRVViolations.Where(x =>
                        x.vid == item).ToList());
                }
            }
            return drvVioList;
        }

    }
}