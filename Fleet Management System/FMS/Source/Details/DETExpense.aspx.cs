using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FMS.Source.Classes;
using FMS_BusinessObjects;
using Telerik.Web.UI;
using System.Collections.Specialized;

namespace FMS.Source.Details
{
    public partial class DETExpense : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Permission perm = new Permission();
            if (perm.is_allowed("expense", "edit", Session["role_id"].ToString().strToInt()) == true)
            {

                if (Request.QueryString["exp_id"].ToString() == "0")
                {

                    if (string.IsNullOrEmpty(Request.QueryString["ref_id"]) == false)
                    {

                        if (!IsPostBack)
                        {
                            int _user_id = Convert.ToInt32(Session["parent_id"].ToString());
                            tblExpense newExp = new tblExpense();
                            newExp.ref_id = Convert.ToInt32(Request.QueryString["ref_id"].ToString());
                            newExp.type = Convert.ToInt32(Request.QueryString["type_id"].ToString());
                            newExp.user_id = _user_id;
                            newExp.cost = 0;
                            Expense exp = new Expense();

                            linq_expense.Where = "exp_id = " + exp.add_expense(newExp, new string[] { "exp_id" }).ToString();
                            //linq_expense.Where = "ref_id = " + Convert.ToInt32(Request.QueryString["ref_id"].ToString()) + "& type_id =" + Convert.ToInt32(Request.QueryString["type_id"].ToString());
                            //DETExpenses.DataSource = exp.get_expense_detail_ref(Convert.ToInt32(Request.QueryString["ref_id"].ToString()));
                            //DETExpenses.DataBind();
                            DETExpenses.DefaultMode = FormViewMode.Edit;
                            this.Page.Title = "Editing expense";
                        }
                    }
                    else
                    {
                        DETExpenses.DefaultMode = FormViewMode.Insert;
                        this.Page.Title = "Adding expense";
                    }
                }
                else if (Request.QueryString["exp_id"].ToString() == "M")
                {
                    //Expense exp = new Expense();
                    //var x = exp.get_expense_detail_ref(Convert.ToInt32(Request.QueryString["ref_id"].ToString()));
                    //DETExpenses.DataSource = x;
                    //DETExpenses.DataBind();

                    DETExpenses.DefaultMode = FormViewMode.Edit;
                    this.Page.Title = "Editing expense";
                }
                else
                {
                    linq_expense.Where = "exp_id = " + Convert.ToInt32(Request.QueryString["exp_id"].ToString());
                    DETExpenses.DefaultMode = FormViewMode.Edit;
                    this.Page.Title = "Editing expense";
                }

            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "noauthority", "alert('You are not allowed to edit this module. Please contact your administrator for more information.');", true);
            }
        }


        protected void rbtnFind_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Update Expense", "ShowFindForm();", true);
        }

        protected void DETExpenses_ItemCommand(object sender, FormViewCommandEventArgs e)
        {

            if (e.CommandName == "Cancel")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
            }

            if (e.CommandName == "Delete")
            {
                Expense exp = new Expense();
                RadTextBox tbx_exp_id = (RadTextBox)DETExpenses.FindControl("tbx_exp_id");
                exp.delete_expense(Convert.ToInt32(tbx_exp_id.Text));
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
            }

            if (e.CommandName == "Add")
            {
                RadDatePicker rdpDate = (RadDatePicker)DETExpenses.FindControl("rdpDate");
                RadNumericTextBox tbxCost = (RadNumericTextBox)DETExpenses.FindControl("tbxCost");
                RadComboBox rcmb_vend = (RadComboBox)DETExpenses.FindControl("rcmb_vend");
                RadTextBox tbxDescription = (RadTextBox)DETExpenses.FindControl("tbxDescription");
                RadTextBox tbxRemarks = (RadTextBox)DETExpenses.FindControl("tbxRemarks");
                RadTextBox tbx_user_id = (RadTextBox)DETExpenses.FindControl("tbx_user_id");
                RadComboBox rcmb_deep_type = (RadComboBox)DETExpenses.FindControl("rcmb_deep_type");
                RadComboBox rcmb_pay_meth = (RadComboBox)DETExpenses.FindControl("rcmb_pay_meth");
                RadComboBox rcmb_type = (RadComboBox)DETExpenses.FindControl("rcmb_type");
                RadComboBox rcmb_ref = (RadComboBox)DETExpenses.FindControl("rcmb_ref");
                int _user_id = Convert.ToInt32(Session["parent_id"].ToString());


                tblExpense new_exp = new tblExpense()
                {
                    cost = tbxCost.Value ?? 0,
                    date = DateTime.Parse((rdpDate.SelectedDate ?? DateTime.Now).ToString()),
                    vend_id = Convert.ToInt32(rcmb_vend.SelectedValue),
                    description = tbxDescription.Text,
                    paymeth_id = Convert.ToInt32(rcmb_pay_meth.SelectedValue),                  
                    deep_type_id = Convert.ToInt32(rcmb_deep_type.SelectedValue),
                    ref_id = Convert.ToInt32(rcmb_ref.SelectedValue),
                    remarks = tbxRemarks.Text,
                    type = Convert.ToInt32(rcmb_type.SelectedValue),
                    user_id = _user_id
                };
                Expense exp = new Expense();
                exp.add_expense(new_exp, new string[] { "exp_id" });
                DETExpenses.InsertItem(true);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "New Expense", "alert('Expense added successfully!');", true);
            }

            if (e.CommandName == "Update")
            {
                RadDatePicker rdpDate = (RadDatePicker)DETExpenses.FindControl("rdpDate");
                RadNumericTextBox tbxCost = (RadNumericTextBox)DETExpenses.FindControl("tbxCost");
                RadComboBox rcmb_vend = (RadComboBox)DETExpenses.FindControl("rcmb_vend");
                RadTextBox tbxDescription = (RadTextBox)DETExpenses.FindControl("tbxDescription");
                RadTextBox tbxRemarks = (RadTextBox)DETExpenses.FindControl("tbxRemarks");

                string ref_id = Request.QueryString["ref_id"].ToString();
                string type_id = Request.QueryString["type_id"].ToString();
                RadTextBox tbx_user_id = (RadTextBox)DETExpenses.FindControl("tbx_user_id");
                RadTextBox tbx_exp_id = (RadTextBox)DETExpenses.FindControl("tbx_exp_id");
                RadComboBox rcmb_deep_type = (RadComboBox)DETExpenses.FindControl("rcmb_deep_type");
                RadComboBox rcmb_pay_meth = (RadComboBox)DETExpenses.FindControl("rcmb_pay_meth");

                string exp_id = tbx_exp_id.Text;


                int _user_id = Convert.ToInt32(Session["parent_id"].ToString());

                tblExpense new_exp = new tblExpense()
                {
                    cost = tbxCost.Value ?? 0,
                    date = DateTime.Parse((rdpDate.SelectedDate ?? DateTime.Now).ToString()),
                    vend_id = Convert.ToInt32(rcmb_vend.SelectedValue),
                    description = tbxDescription.Text,
                    paymeth_id = Convert.ToInt32(rcmb_pay_meth.SelectedValue),
                    deep_type_id = Convert.ToInt32(rcmb_deep_type.SelectedValue),
                    ref_id = Convert.ToInt32(ref_id),
                    remarks = tbxRemarks.Text,
                    type = Convert.ToInt32(type_id),
                    user_id = _user_id
                };




                Expense exp = new Expense();
                exp.update_expense(new_exp, Convert.ToInt32(exp_id), new string[] { "exp_id" });
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "mykey", "CloseAndRebind();", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Update Expense", "alert('Expense updated successfully!');", true);
            }

        }



        protected void DETExpenses_ItemCreated(object sender, EventArgs e)
        {
            //if (Request.QueryString["ref_id"] != null && DETExpenses.DefaultMode == FormViewMode.Insert)
            //{
            //    RadTextBox tbxReference = (RadTextBox)DETExpenses.FindControl("tbxReference");
            //    RadTextBox tbx_type_id = (RadTextBox)DETExpenses.FindControl("tbx_type_id");
            //    RadTextBox tbx_type = (RadTextBox)DETExpenses.FindControl("tbx_type");
            //    Expense exp = new Expense();
            //    int exp_type_id = exp.get_expense_type(Request.QueryString["type"].ToString());
            //    tbx_type.Text = Request.QueryString["type"].ToString();
            //    tbx_type_id.Text = exp_type_id.ToString();
            //    tbxReference.Text = Request.QueryString["ref_id"].ToString();

            //}
        }


        protected void DETExpenses_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            DETExpenses.ChangeMode(new FormViewMode());
        }

        protected void DETExpenses_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            e.Cancel = true;
        }

        protected void DETExpenses_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            DETExpenses.ChangeMode(new FormViewMode());
        }

        protected void DETExpenses_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            e.Cancel = true;
        }

        protected void DETExpenses_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            DETExpenses.ChangeMode(new FormViewMode());
        }

        protected void DETExpenses_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            e.Cancel = true;
        }

        protected void rcmb_type_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox rcmb_type = (RadComboBox)DETExpenses.FindControl("rcmb_type");
            string typeValue = rcmb_type.SelectedValue.ToString();
            fillRefList(typeValue);

        }
        public void fillRefList(string typeValue)
        {
            RadComboBox rcmb_ref = (RadComboBox)DETExpenses.FindControl("rcmb_ref");
            if (typeValue == "1")
            {
                rcmb_ref.DataSourceID = "linq_exp_srv";
                rcmb_ref.DataValueField = "vhc_srv_id";
                rcmb_ref.DataTextField = "vhc_srv_id";
            }
            else if (typeValue == "2")
            {
                rcmb_ref.DataSourceID = "linq_exp_vio";
                rcmb_ref.DataValueField = "drv_vio_id";
                rcmb_ref.DataTextField = "drv_vio_id";
            }
            else if (typeValue == "4")
            {
                rcmb_ref.DataSourceID = "linq_exp_ins";
                rcmb_ref.DataValueField = "ins_id";
                rcmb_ref.DataTextField = "ins_id";
            }
            else
            {
                rcmb_ref.DataSource = null;
            }

        }

        protected void DETExpenses_DataBound(object sender, EventArgs e)
        {
            if (DETExpenses.CurrentMode == FormViewMode.Edit)
            {
                //RadComboBox rcmb_type = (RadComboBox)DETExpenses.FindControl("rcmb_type");
                //string typeValue = rcmb_type.SelectedValue.ToString();

                //fillRefList(typeValue);
                //RadComboBox rcmb_ref = (RadComboBox)DETExpenses.FindControl("rcmb_ref");


                //rcmb_ref.SelectedValue = Request.QueryString["ref_id"];

            }

            if (DETExpenses.CurrentMode == FormViewMode.Insert)
            {

            }

        }

        protected void rcmb_ref_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox rcmb_ref = (RadComboBox)sender;
            HiddenField hf_ref = (HiddenField)DETExpenses.FindControl("hf_ref");
            hf_ref.Value = rcmb_ref.SelectedValue.ToString();
            DetailsView det_ref_table = (DetailsView)DETExpenses.FindControl("DetailsView1");
            det_ref_table.DataBind();
        }




    }

}