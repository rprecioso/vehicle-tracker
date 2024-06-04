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
    public class Insurance
    {
        FMS_DBDataContext datacontext = new FMS_DBDataContext();

        public void add_vehicle_insurance(refVHCInsurance _vehicle_insurance, int _vid)
        {
            using (datacontext)
            {
                datacontext.refVHCInsurances.InsertOnSubmit(_vehicle_insurance);
                datacontext.SubmitChanges();

                tblVehicle vhc_new = (from x in datacontext.tblVehicles
                                      where x.vid == _vid
                                      select x).First();
                vhc_new.ins_id = _vehicle_insurance.ins_id;
                datacontext.SubmitChanges();

            }
        }
        public void update_vehicle_insurance(refVHCInsurance _vehicle_insurance, int _ins_id, string[] ins_exception, int _vid, string[] vhc_exception)
        {
            using (datacontext)
            {
                refVHCInsurance insurance = (from i in datacontext.refVHCInsurances
                                             where i.ins_id == _ins_id
                                             select i).First();
                insurance.CopyPropertyValues(_vehicle_insurance, ins_exception);

                try
                {
                    tblVehicle vhc_old = (from x in datacontext.tblVehicles
                                          where x.ins_id == _ins_id
                                          select x).First();
                    vhc_old.ins_id = null;
                }
                catch (Exception ex)
                {
                }
                finally
                {
                    tblVehicle vhc_new = (from x in datacontext.tblVehicles
                                          where x.vid == _vid
                                          select x).First();
                    vhc_new.ins_id = _ins_id;
                }

                datacontext.SubmitChanges();
            }

        }

        //filter vehicle list
        public List<vw_vehicle_insurance> filter_insurance(string _id, string _query, string _usr_id)
        {
            using (datacontext)
            {
                var insurance_list = (from x in datacontext.vw_vehicle_insurances
                                      where x.usr_id == _usr_id.strToInt()
                                      select x);


                try
                {
                    var filtered_list = insurance_list.Where(_id + ".Value.ToString().ToLower().Contains(@0)", _query).ToList();

                    if (_id.Contains("date"))
                    {
                        DateTime _datetime;
                        if (DateTime.TryParse(_query, out _datetime) == true)
                        {
                            filtered_list = insurance_list.Where(_id + ".Value == @0", _datetime).ToList();
                        }
                    }

                    return filtered_list;
                }
                catch (Exception)
                {
                    var filtered_list = insurance_list.Where(_id + ".ToString().ToLower().Contains(@0)", _query).ToList();
                    return filtered_list;
                }
            
            }
        }

        #region Vehicle Insurance Details
        public List<refVHCInsurance> get_vehicle_insurance(int _vid)
        {
            using (datacontext)
            {
                return datacontext.refVHCInsurances.Where(x => x.ins_id == datacontext.tblVehicles.Where(y => y.vid == _vid).First().ins_id).ToList();
            }
        }
        #endregion

        public List<vw_vehicle_insurance> get_user_insurances(int _parent_id)
        {
            using (datacontext)
            {
                return datacontext.vw_vehicle_insurances.Where(x => x.usr_id == _parent_id).ToList();
            }
        }

        public void delete_vehicle_insurance(int _vhc_ins_id)
        {
            var y = datacontext.refVHCInsurances.Where(x => x.ins_id == _vhc_ins_id);
            if (y.Count() > 0)
            {
          
                var m = datacontext.tblExpenses.Where(n => n.ref_id == _vhc_ins_id && n.type == extensions.getExpType("Insurance"));
                if (m.Count() > 0)
                {
                    datacontext.tblExpenses.DeleteAllOnSubmit(m.ToList());
                }
                var b = datacontext.tblVehicles.Where(x => x.ins_id == _vhc_ins_id);
                if (b.Count() > 0)
                {
                    b.First().ins_id = null;
                }

                datacontext.refVHCInsurances.DeleteAllOnSubmit(y.ToList());
                datacontext.SubmitChanges();
            }
        }

    }
}