using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using FMS.Source.Classes;
using FMS_BusinessObjects;
namespace FMS.Login
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
  
            txtUsername.Focus();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {            
            User user = new User();
            user_loginfo loggedUser = user.user_login(txtUsername.Text, txtPassword.Text);
            checkLogin(loggedUser);
        }

        private void checkLogin(user_loginfo loggedUser)
        {
            if (loggedUser == null)
            {
                CustomValidator val = new CustomValidator();
                val.ValidationGroup = "Authentication";
                val.IsValid = false;
                val.ErrorMessage = "Either Username and password does not match! or Account has been pruned or disabled.";
                this.Page.Validators.Add(val);
            }

            else
            {
                Session["loggedUser"] = loggedUser;
                Session["role_id"] = loggedUser.role_id;
                Session["parent_id"] = loggedUser.parent_id;
                Vehicle veh = new Vehicle();
                veh.fetch_vehicle_tfdb(loggedUser.parent_id);
                Permission perm = new Permission();
                perm.update_perm_tables(loggedUser.parent_id);
                Response.Redirect("/Source/Child/Dashboard.aspx");
            }
        }
    }
}