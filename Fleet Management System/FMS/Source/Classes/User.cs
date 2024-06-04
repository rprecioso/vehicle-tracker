using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using FMS.Source.Classes;
using FMS_BusinessObjects;
namespace FMS.Source.Classes
{

    public class user_loginfo
    {
        public string username { get; set; }
        public string company_name { get; set; }
        public int user_id { get; set; }
        public int role_id { get; set; }
        public int parent_id { get; set; }
    }

    public class User
    {
        FMS_DBDataContext dcontext = new FMS_DBDataContext();
        FMS_Helper.FMS_Helper tfdb_helper = new FMS_Helper.FMS_Helper();
        //FMS_Helper_PH.FMS_Helper tfdb_helper = new FMS_Helper_PH.FMS_Helper();


        public void delete_user(int _child_id)
        {
            using (dcontext)
            {
                //dcontext.relModPermissions.DeleteAllOnSubmit(dcontext.relModPermissions.Where(ch => ch.child_id == _child_id).ToList());
                dcontext.tblChildUsers.DeleteOnSubmit(dcontext.tblChildUsers.Where(ch => ch.child_id == _child_id).First());
                dcontext.SubmitChanges();
            }
        }

        public bool add_user(tblChildUser _child_user)
        {
            using (dcontext)
            {
                //should be unique from local
                if (dcontext.tblChildUsers.Where(u => u.username == _child_user.username).ToList().Count > 0)
                {
                    return false;
                }

                //should be unique from tfdb
                if (tfdb_helper.check_Username(_child_user.username).Tables[0].Rows.Count > 0)
                {
                    return false;
                }

                tblChildUser newUser = new tblChildUser()
                {
                    username = _child_user.username,
                    password = _child_user.password,
                    parent_id = _child_user.parent_id,
                    role_id = _child_user.role_id,                  
                    active = _child_user.active
                };

                dcontext.tblChildUsers.InsertOnSubmit(newUser);
                dcontext.SubmitChanges();

                return true;
            }
        }

        public bool update_user(tblChildUser _child_user,int _child_id)
        {
            using (dcontext)
            {
                //should be unique from local
                if (dcontext.tblChildUsers.Where(u => u.username == _child_user.username && u.child_id != _child_id).Count() > 0)
                {
                    return false;
                }

                //should be unique from tfdb
                if (tfdb_helper.check_Username(_child_user.username).Tables[0].Rows.Count > 0)
                {
                    return false;
                }

                var usr = from user in dcontext.tblChildUsers
                          where user.child_id == _child_id
                          select user;

                usr.First().username = _child_user.username;
                usr.First().password = _child_user.password;
                usr.First().parent_id = _child_user.parent_id;
                usr.First().active = _child_user.active;
                usr.First().role_id = _child_user.role_id;
                dcontext.SubmitChanges();
                return true;
            }
        }

        private void login_user()
        { }

        private void login_child()
        { }

        public user_loginfo user_login(string _username, string _password)
        {
            using (dcontext)
            {
                var isChildUser = dcontext.tblChildUsers.Where(x => x.username == _username && x.password == _password);

                //is not a child account
                if (isChildUser.Count() == 0)
                {
   
                    DataSet ds = tfdb_helper.check_Username(_username);
                    if (ds.Tables[0].Rows.Count > 0)
                    {

                        string _username_ds = ds.Tables[0].Rows[0][0].ToString();
                        string _password_ds = ds.Tables[0].Rows[0][1].ToString();
                        int _usr_id_ds = Convert.ToInt32(ds.Tables[0].Rows[0][2].ToString());


                        var modUser = dcontext.tblUsers.Where(us => us.usr_id == Convert.ToInt32(_usr_id_ds));

                        //account exist in local so update
                        if (modUser.Count() >= 1)
                        {
                            modUser.First().username = _username_ds;
                            modUser.First().password = _password_ds;
                            dcontext.SubmitChanges();
                        }
                        //account does not exist so create
                        if (modUser.Count() == 0)
                        {
                            tblUser newUser = new tblUser()
                            {
                                username = _username_ds,
                                password = _password_ds,
                                usr_id = Convert.ToInt32(ds.Tables[0].Rows[0][2]),
                                active = true,
                                date_registered = DateTime.Now
                            };
                            dcontext.tblUsers.InsertOnSubmit(newUser);
                            dcontext.SubmitChanges();
                        }

                        //if credentials are good
                        if (_username_ds == _username && _password_ds == _password)
                        {                 
                            return new user_loginfo()
                            {
                                username = _username_ds,
                                user_id = _usr_id_ds,
                                role_id = 0,
                                parent_id = _usr_id_ds
                            };
                        }
                        return null;
                    }
                }

                //is a child account
                if (isChildUser.Count() >= 1)
                {
                    var childUser = dcontext.tblChildUsers.Where(x => x.username == _username && x.password == _password);
                    if (childUser.Count() > 0)
                    {
                        Permission perm = new Permission();
                       // perm.appendModulePermission(childUser.First().child_id);
                        return new user_loginfo()
                        {
                            username = childUser.First().username,
                            user_id = childUser.First().child_id,
                            role_id = childUser.First().role_id ?? 0,
                            parent_id = childUser.First().parent_id ?? 0
                        };
                    }
                }
                return null;
            }
        }

        //public string user_forgotpassword(string _username)
        //{
        //    using (dcontext)
        //    {
        //        //return dcontext.sp_get_password_username(_username).First().password.ToString();
        //    }
        //}

        //public tblChildUser get_usersdas(int _user_id)
        //{
        //    using (dcontext)
        //    {
        //        var _user = from u in dcontext.sp_get_user_usrid(_user_id)
        //                    where u.child_id == _user_id
        //                    select u;
        //        return (tblChildUser)_user;
        //    }
        //}

        public List<tblChildUser> get_user_all()
        {
            using (dcontext)
            {
                var _user = from u in dcontext.tblChildUsers
                            select u;
                return _user.ToList();
            }
        }

        //private bool getExisting(string _username, string _password)
        //{
        //    DataSet ds = tfdb_helper.check_Username(_username);
        //    user_info newUser = new user_info();

        //    if (ds.Tables[0].Rows.Count > 0)
        //    {
        //        newUser.username = ds.Tables[0].Rows[0][0].ToString();
        //        newUser.password = ds.Tables[0].Rows[0][1].ToString();
        //    }

        //    if (newUser.username == _username &&
        //    newUser.password == _password)
        //    {
        //        tblUser Usr = new tblUser()
        //        {
        //            username = newUser.username,
        //            password = newUser.password
        //        };
        //        dcontext.tblUsers.InsertOnSubmit(Usr);
        //        dcontext.SubmitChanges();
        //        return true;
        //    }
        //}
    }
    public class user_info
    {
        public string username { get; set; }
        public string password { get; set; }
        public int user_id { get; set; }
    }
}