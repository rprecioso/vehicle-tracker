using FMS_BusinessObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Linq.Dynamic;

namespace FMS.Source.Classes
{

    public class Expense
    {
        FMS_DBDataContext dcontext = new FMS_DBDataContext();
        public List<vw_user_expense> get_user_expense(int _user_id)
        {
            using (dcontext)
            {
                return dcontext.vw_user_expenses.Where(x => x.user_id == _user_id).ToList();
            }
        }

        public vw_user_expense get_expense_detail(int _exp_id)
        {
            using (dcontext)
            {
                return dcontext.vw_user_expenses.Where(x => x.exp_id == _exp_id).First();

            }
        }

        public List<vw_user_expense> get_expense_detail_ref(int _ref_id, int _type_id)
        {
            using (dcontext)
            {
                return dcontext.vw_user_expenses.Where(x => x.ref_id == _ref_id && x.type_id == _type_id).ToList();

            }
        }

        public string get_expense_type_name(int _type)
        { 
           using (dcontext)
            {
                string exp_type = dcontext.refEXPTypes.Where(x => x.exp_type_id == _type).First().type;
                return exp_type;
            }
        }

        public int get_expense_type(string _type)
        {
            using (dcontext)
            {
                int exp_type = dcontext.refEXPTypes.Where(x => x.type.ToLower().Contains(_type.ToLower())).First().exp_type_id;
                return exp_type;
            }
        }


        public int add_expense(tblExpense _exp, string[] _exception)
        {
            using (dcontext)
            {
                //tblExpense new_exp = new tblExpense();
                //new_exp.CopyPropertyValues(_exp, _exception);
                dcontext.tblExpenses.InsertOnSubmit(_exp);
                dcontext.SubmitChanges();
                return _exp.exp_id;
            }
        }

        public void update_expense(tblExpense _exp, int _exp_id, string[] _exception)
        {
            using (dcontext)
            {
                tblExpense mod_exp =
                dcontext.tblExpenses.Where(x => x.exp_id == _exp_id).FirstOrDefault();
                mod_exp.CopyPropertyValues(_exp, _exception);
                dcontext.SubmitChanges();
            }
        }

        public void delete_expense(int _exp_id)
        {
            using (dcontext)
            {
                dcontext.tblExpenses.DeleteOnSubmit(dcontext.tblExpenses.Where(x => x.exp_id == _exp_id).First());
                dcontext.SubmitChanges();
            }
        }

        public List<vw_user_expense> filter_service(string _id, string _query, string _usr_id)
        {
            using (dcontext)
            {
                try
                {
                    var filtered_list = dcontext.vw_user_expenses.Where(_id + ".Value.ToString().ToLower().Contains(@0) And user_id = (@1)", _query, _usr_id.strToInt()).ToList();
                    if (_id.Contains("date"))
                    {
                        DateTime _datetime;
                        if (DateTime.TryParse(_query, out _datetime) == true)
                        {
                            filtered_list = dcontext.vw_user_expenses.Where(_id + ".Value == @0 And user_id = (@1)", _datetime, _usr_id.strToInt()).ToList();                            
                        }                        
                    }                    
                     
                        return filtered_list;                    
                }
                catch (Exception)
                {
                    var filtered_list = dcontext.vw_user_expenses.Where(_id + ".Value.ToString().ToLower().Contains(@0) And user_id = (@1)", _query, _usr_id.strToInt()).ToList();
                    return filtered_list;
                }

                
            }
        }


    }
}