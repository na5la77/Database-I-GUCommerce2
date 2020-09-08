using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


namespace WebApplication1
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("userLogin", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user

            string username = UsernameText.Text;
            string password = PasswordText.Text;


            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@password", password));

            SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;
            SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
            type.Direction = ParameterDirection.Output;
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);



            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            //Response.Write((success.Value).ToString());
            if (success.Value.ToString().Equals("True"))
            {
                Session["username"] = username;
                //Response.Write(username);
                if (type.Value.ToString().Equals("0"))
                {
                    Response.Redirect("Customer_1.aspx");
                }
                else if (type.Value.ToString().Equals("1"))
                {

                    Response.Redirect("VendorPage0.aspx");
                }
                else if (type.Value.ToString().Equals("2"))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "You are an Admin" + "');", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "You a delivery personnel" + "');", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Wrong username or password" + "');", true);
            }


        }
        void myConnection_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + e.Message + "');", true);

        }
    }
        

}
