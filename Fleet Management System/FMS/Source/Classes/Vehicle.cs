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

    public class Vehicle
    {

        FMS_DBDataContext datacontext = new FMS_DBDataContext();
        FMS_Helper_PH.FMS_Helper tfdb_helper = new FMS_Helper_PH.FMS_Helper();


        //General Vehicle
        #region general vehicle

        //get all vehicles under the parent_id/user_id
        public List<vw_vehicle_detail> get_user_vehicles(int _parent_id)
        {
            using (datacontext)
            {
                List<int> groupCodeList = (from x in datacontext.tblGroupCodes
                                           where x.usr_id == _parent_id
                                           select x.group_code).ToList();
                //return datacontext.tblVehicles.Where(x => groupCodeList.Contains(x.group_code ?? 0)).ToList();
                return datacontext.vw_vehicle_details.Where(x => groupCodeList.Contains(x.group_code ?? 0)).ToList();
            }
        }

        //get specific vehile via vid
        public List<tblVehicle> get_vehicle_detail(int _vid)
        {
            using (datacontext)
            {
                return datacontext.tblVehicles.Where(x => x.vid == _vid).ToList();
            }
        }

        //update specific vehicle
        public void update_user_vehicles(tblVehicle _updatedVehicle, int _vid, string[] _exceptions)
        {
            using (datacontext)
            {
                tblVehicle _vehicle = datacontext.tblVehicles.Where(x => x.vid == _vid).First();
                _vehicle.CopyPropertyValues(_updatedVehicle, _exceptions);
                datacontext.SubmitChanges();
            }
        }

        public void update_vehicle_flag(bool _flagged, string _flag_reason, int _vid)
        {
            using (datacontext)
            {
                datacontext.tblVehicles.Where(x => x.vid == _vid).First().flag = _flagged;
                datacontext.tblVehicles.Where(x => x.vid == _vid).First().flag_reason = _flag_reason;
                datacontext.SubmitChanges();
            }
        }

        public void update_vehicle_image(byte[] _image_binary, int _vid)
        {
            using (datacontext)
            {
                datacontext.tblVehicles.Where(x => x.vid == _vid).First().image = _image_binary;
                datacontext.SubmitChanges();
            }
        }

        //filter vehicle list
        public List<vw_vehicle_detail> filter_vehicle(string _id, string _query, string _usr_id)
        {
            using (datacontext)
            {
                List<int> groupCodeList = (from x in datacontext.tblGroupCodes
                                           where x.usr_id == _usr_id.strToInt()                                           
                                           select x.group_code).ToList();

                try
                {
                    var vehicle_list = datacontext.vw_vehicle_details.Where(x => groupCodeList.Contains(x.group_code ?? 0));

                    var filtered_list = vehicle_list.Where(_id + ".Value.ToString().ToLower().Contains(@0)", _query).ToList();
                    
                    if (_id.Contains("date"))
                    {
                        DateTime _datetime;
                        if (DateTime.TryParse(_query, out _datetime) == true)
                        {
                            filtered_list = vehicle_list.Where(_id + ".Value == @0", _datetime).ToList();
                        }
                    }
                        
                    return filtered_list;
                }
                catch (Exception ex)
                {

                    var vehicle_list = datacontext.vw_vehicle_details.Where(x => groupCodeList.Contains(x.group_code ?? 0));
                    var filtered_list = vehicle_list.Where(_id + ".ToString().ToLower().Contains(@0)", _query).ToList();
                    return filtered_list;
                }

            }
        }

        public bool has_vehicle_image(int _vid)
        {
            using (datacontext)
            {
                if (datacontext.tblVehicles.Where(x => x.vid == _vid).First().image != null)
                {
                    return true;
                }
                return false;
            }
        }

        //get all vehicles from tfdb
        public void fetch_vehicle_tfdb(int _user_id)
        {
            List<tblGroupCode> groupCodeList = new List<tblGroupCode>();
            List<tblVehicle> vehicleList = new List<tblVehicle>();

            foreach (int group_code in tfdb_helper.get_group_code(_user_id))
            {
                foreach (DataRow vid in tfdb_helper.get_vehicle(group_code).Tables[0].Rows)
                {
                    List<tblVehicle> vehFind = datacontext.tblVehicles.Where(x => x.vid == vid[0].ToString().strToInt()).ToList();
                    if (vehFind.Count == 0)
                    {
                        datacontext.tblVehicles.InsertOnSubmit(new tblVehicle()
                        {
                            vid = Convert.ToInt32(vid[0].ToString()),
                            vehicle_name = vid[1].ToString(), //vehicle name
                            group_code = group_code,
                            active = true
                        });
                    }
                    else
                    {
                        vehFind.First().group_code = group_code;
                        if (vid[1].ToString().Trim() == string.Empty)
                        {
                            vehFind.First().vehicle_name = vid[0].ToString();
                        }
                        else
                        {
                            vehFind.First().vehicle_name = vid[1].ToString();
                        }

                    }
                };

                List<tblGroupCode> groupCodeFin = datacontext.tblGroupCodes.Where(x => x.group_code == group_code).ToList();
                if (groupCodeFin.Count == 0)
                {
                    groupCodeList.Add(new tblGroupCode()
                    {
                        group_code = group_code,
                        usr_id = _user_id
                    });
                }
                else
                {
                    groupCodeFin.First().usr_id = _user_id;
                }
            }
            datacontext.tblGroupCodes.InsertAllOnSubmit(groupCodeList);
            datacontext.SubmitChanges();
        }

        #endregion



    }
}