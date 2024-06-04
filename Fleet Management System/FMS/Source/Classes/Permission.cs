using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using FMS_BusinessObjects;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Runtime.Serialization;
namespace FMS.Source.Classes
{
    public class Permission
    {
        public int parent_id { get; set; }
        FMS_DBDataContext dcontext = new FMS_DBDataContext();

        public List<relMODPermission> get_role_mod_perm(int _role_id)
        {
            using (dcontext)
            {

                var mod_per_list = (from x in dcontext.relMODPermissions
                                    where x.role_id == _role_id
                                    select x).ToList();


                foreach (refModule mod in dcontext.refModules)
                {
                    //check if a module permission is missing, if missing, create one
                    if (mod_per_list.Where(x => x.mod_id == mod.mod_id).Count() == 0)
                    {
                        //iterate through the list of functions
                        foreach (refFunction func in dcontext.refFunctions)
                        {
                            //create a new instance of relMODPermission
                            relMODPermission new_mod_per = new relMODPermission()
                            {
                                mod_id = mod.mod_id,
                                //create an instance of refFUNCPermission
                                refFUNCPermission = new refFUNCPermission()
                                  {
                                      func_id = func.func_id,
                                      permission = false
                                  }
                            };
                            dcontext.relMODPermissions.InsertOnSubmit(new_mod_per);
                            dcontext.SubmitChanges();
                            mod_per_list.Add(new_mod_per);
                        }
                    }
                }
                return mod_per_list;
            }
        }

        public void update_mod_perm(List<relMODPermission> _mod_per_list)
        {
            using (dcontext)
            {
                foreach (relMODPermission _mod_per in _mod_per_list)
                {
                    relMODPermission modify_mod_per = dcontext.relMODPermissions.Where(x => x.mod_per_id == _mod_per.mod_per_id).First();
                    modify_mod_per.CopyPropertyValues(_mod_per, new string[] { "mod_per_id" });
                }
            }
        }

        public void update_permission(refFUNCPermission _func_per, int _mod_per_id)
        {
            using (dcontext)
            {
                //locate the mod_per to be modified
                var old_mod_per = dcontext.relMODPermissions.Where(x => x.mod_per_id == _mod_per_id).First();

                //check if there is an existing ref_func in the database
                var check_ref_func = dcontext.refFUNCPermissions.Where(
                    x => x.func_id == _func_per.func_id && x.permission == _func_per.permission).ToList();
                refFUNCPermission new_fun_per = new refFUNCPermission();

                if (check_ref_func.Count() == 0)
                {
                    new_fun_per.CopyPropertyValues(_func_per, new string[] { "refFunction", "relMODPermission" });

                    dcontext.refFUNCPermissions.InsertOnSubmit(new_fun_per);
                    dcontext.SubmitChanges();

                    old_mod_per.func_per_id = new_fun_per.func_per_id;
                    dcontext.SubmitChanges();
                }
                else
                {
                    old_mod_per.func_per_id = check_ref_func.First().func_per_id;
                    dcontext.SubmitChanges();
                }
            }
        }

        public void update_perm_tables(int _user_id)
        {
            using (dcontext)
            {
                //iterate through every roles of the user
                var role_list = dcontext.tblRoles.Where(x => x.user_id == _user_id).ToList();
                foreach (tblRole role in role_list)
                {
                    //iterate through every modules
                    var mod_list = dcontext.refModules.ToList();
                    foreach (refModule mod in mod_list)
                    {
                        //iterate through every mod_per of the roles
                        var mod_per_list = dcontext.relMODPermissions.Where(x => x.role_id == role.role_id).ToList();

                        var func_list = dcontext.refFunctions;
                        //check if the number of modules coincides with the number of functions, if it does not, it means there's a missing module
                        if (mod_per_list.Where(x => x.mod_id == mod.mod_id).Count() != func_list.Count())
                        {
                            //check if module exist in mod_per, if the count = 0, the specific module in the iteration is missing
                            if (mod_per_list.Where(x => x.mod_id == mod.mod_id).Count() == 0)
                            {

                                //iterate through every refFunction

                                foreach (refFunction func in func_list)
                                {
                                    refFUNCPermission ref_func;

                                    //look for a func_perm that has the same func_id in the iteration and is a false
                                    var func_perm_list = dcontext.refFUNCPermissions.Where(x => x.func_id == func.func_id && x.permission == false).ToList();

                                    //if func_perm does not exist, create new 
                                    if (func_perm_list.Count == 0)
                                    {
                                        ref_func = new refFUNCPermission()
                                          {
                                              func_id = func.func_id,
                                              permission = false,
                                          };
                                        dcontext.refFUNCPermissions.InsertOnSubmit(ref_func);
                                        dcontext.SubmitChanges();
                                    }
                                    //else if the func_perm does exist, get the first instance
                                    else
                                    {
                                        ref_func = func_perm_list.First();
                                    }

                                    //create new instance of mod_perm
                                    relMODPermission new_mod_per = new relMODPermission()
                                    {
                                        mod_id = mod.mod_id,
                                        role_id = role.role_id,
                                        func_per_id = ref_func.func_per_id
                                    };

                                    //save
                                    dcontext.relMODPermissions.InsertOnSubmit(new_mod_per);
                                    dcontext.SubmitChanges();
                                }
                            }
                        }

                    }
                }
            }
        }

        public void update_role(int _role_id, tblRole _role)
        {
            using (dcontext)
            {
                var mod_role = dcontext.tblRoles.Where(x => x.role_id == _role_id).First();
                mod_role.role = _role.role;
                mod_role.description = _role.description;
                dcontext.SubmitChanges();
            }
        }

        public void add_role(tblRole _role)
        {
            using (dcontext)
            {
                tblRole new_role = new tblRole()
                {
                    description = _role.description,
                    role = _role.role,
                    user_id = _role.user_id
                };

                dcontext.tblRoles.InsertOnSubmit(new_role);
                dcontext.SubmitChanges();
            }
        }

        public object get_module_roles(int _role_id)
        {     
                return dcontext.vw_module_roles.Where(x => x.role_id == _role_id);        
        }

        //public object get_perm_functions(int _role_id, string _module_name)
        //{
        //    using (dcontext)
        //    {
        //        int _mod_id = 0;
        //        try
        //        {
        //            _mod_id = dcontext.refModules.Where(x => x.module.ToLower().Contains(_module_name.ToLower()) == true).First().mod_id;

        //            var perm_list = dcontext.vw_perm_functions.Where(x => x.role_id == _role_id && x.mod_id == _mod_id);

        //            return perm_list;
        //        }
        //        catch (Exception)
        //        {
        //            throw new Exception("module name does not exist");
        //            return null;
        //        }

        //        //var page_permission = new DynamicObject();





        //    }
        //}

        public List<vw_perm_function> get_perm_functions(int _role_id, int _mod_id)
        {
                return dcontext.vw_perm_functions.Where(x => x.role_id == _role_id && x.mod_id == _mod_id).ToList();
        
        }


        public List<vw_perm_function> get_perm_functions(int _role_id, string _module)
        {
            return dcontext.vw_perm_functions.Where(x => x.role_id == _role_id && x.module.ToLower().Contains(_module.ToLower())).ToList();
        }



        public bool is_allowed(string _module, string _function, int _role_id)
        {
            using (dcontext)
            {
                if (_role_id != 0)
                {
                    var pe = dcontext.vw_perm_functions.Where(x => x.role_id == _role_id
                        && x.module.ToLower().Contains(_module.ToLower())
                        && x.function.ToLower().Contains(_function.ToLower()));

                    return pe.First().permission ?? false;
                }
                return true;

            }
        }


        //public List<refModule> get_user_non_module(int _usr_id)
        //{
        //    using (dcontext)
        //    {

        //        var usrmodule = from prm in dcontext.relModPermissions
        //                        where prm.child_id == _usr_id
        //                        select prm;

        //        var pmodule = from pmod in dcontext.refModules
        //                      join prm in usrmodule
        //                      on pmod.mod_id equals prm.mod_id into permodules
        //                      from perms in permodules.DefaultIfEmpty()
        //                      where perms.child_id == null
        //                      select pmod;

        //        return pmodule.ToList();
        //    }
        //}

        //public void appendModulePermission(int _child_id)
        //{
        //    foreach (refModule mod in dcontext.refModules)
        //    {
        //        if (dcontext.relModPermissions.Where(x => x.child_id == _child_id && x.mod_id == mod.mod_id).Count() == 0)
        //        {
        //            insert_permission(_child_id, mod.mod_id, 3);
        //        }
        //    }
        //}

        //public void appendModulePermission()
        //{
        //    foreach (tblChildUser _child in dcontext.tblChildUsers.Where(x => x.parent_id == parent_id))
        //    {
        //        foreach (refModule mod in dcontext.refModules)
        //        {
        //            if (dcontext.relModPermissions.Where(x => x.child_id == _child.child_id && x.mod_id == mod.mod_id).Count() == 0)
        //            {
        //                insert_permission(_child.child_id, mod.mod_id, 3);
        //            }
        //        }
        //    }

        //}

        //public refPermission get_permission_status_module(string _module, int _usr_id)
        //{


        //    using (dcontext)
        //    {
        //        //admin
        //        if (_usr_id == 0)
        //        {
        //            return dcontext.refPermissions.Where(x => x.per_id == get_permission_id(true, true, true, true)).First();
        //        }
        //        else
        //        {
        //            var modu = from mod in dcontext.refModules
        //                       where mod.module.Contains(_module)
        //                       select mod.mod_id;

        //            var usrmodule = from prm in dcontext.relModPermissions
        //                            where prm.child_id == _usr_id && prm.mod_id == modu.First()
        //                            select prm.per_id;

        //            var perm = from per in dcontext.refPermissions
        //                       where per.per_id == usrmodule.First()
        //                       select per;

        //            return (refPermission)perm.First();
        //        }
        //    }
        //}

        //public void insert_permission(int _usr_id, int _mod_id, int _per_id)
        //{

        //    dcontext.sp_add_user_mod_permission(_usr_id, _mod_id, _per_id);

        //}

        //public int get_permission_id(bool _create, bool _delete, bool _modify, bool _view)
        //{
        //    var perm = from per in dcontext.refPermissions
        //               where per.create == _create &&
        //               per.delete == _delete &&
        //               per.modify == _modify &&
        //               per.view == _view
        //               select per;


        //    if (perm.Count() == 0)
        //    {
        //        refPermission newPerm = new refPermission()
        //        {
        //            create = _create,
        //            delete = _delete,
        //            modify = _modify,
        //            view = _view
        //        };

        //        dcontext.refPermissions.InsertOnSubmit(newPerm);
        //        dcontext.SubmitChanges();

        //        return newPerm.per_id;
        //    }

        //    return perm.First().per_id;
        //}

        //public void update_permission(bool _create, bool _delete, bool _modify, bool _view, int _usr_id, int _mod_id)
        //{
        //    using (dcontext)
        //    {

        //        var perm = from per in dcontext.refPermissions
        //                   where per.create == _create &&
        //                   per.delete == _delete &&
        //                   per.modify == _modify &&
        //                   per.view == _view
        //                   select per;

        //        if (perm.Count() > 0)
        //        {
        //            var modPerm = from mPerm in dcontext.relModPermissions
        //                          where mPerm.mod_id == _mod_id && mPerm.child_id == _usr_id
        //                          select mPerm;

        //            dcontext.sp_update_mod_permission(modPerm.First().child_id, modPerm.First().mod_id, perm.First().per_id);

        //        }
        //        else if (perm.Count() == 0)
        //        {
        //            refPermission newPerm = new refPermission()
        //            {
        //                create = _create,
        //                delete = _delete,
        //                modify = _modify,
        //                view = _view
        //            };

        //            dcontext.refPermissions.InsertOnSubmit(newPerm);
        //            dcontext.SubmitChanges();

        //            var modPerm = from mPerm in dcontext.relModPermissions
        //                          where mPerm.mod_id == _mod_id && mPerm.child_id == _usr_id
        //                          select mPerm;

        //            dcontext.sp_update_mod_permission(modPerm.First().child_id, modPerm.First().mod_id, perm.First().per_id);
        //        }

        //    }
        //}

        //public void delete_permission(int _usr_id, int _mod_id, int _per_id_)
        //{
        //    using (dcontext)
        //    {
        //        dcontext.relModPermissions.DeleteAllOnSubmit(dcontext.relModPermissions.Where(re => re.child_id == _usr_id).ToList());
        //        dcontext.SubmitChanges();
        //    }

        //}
    }
}