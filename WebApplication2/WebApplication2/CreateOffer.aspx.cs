using System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace dbmilestone3
{
    public partial class CreateOffer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbconn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            // (string)(Session["username"]);
            string offeramount1 = offeramount.Text;
            string expiry_date1 = expiry_date.Text;

            
            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@offeramount", offeramount1));
            cmd.Parameters.Add(new SqlParameter("@expiry_date", DateTime.Parse(expiry_date1)));
           
            //Executing the SQLCommand
            conn.Open();
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        void myConnection_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + e.Message + "');", true);
            // Response.Write(e.Message);
        }
    }
}