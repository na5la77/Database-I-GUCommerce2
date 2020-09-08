using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CustomerRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerRegister.aspx");
        }

        protected void VendorRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("VendorRegister.aspx");
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}