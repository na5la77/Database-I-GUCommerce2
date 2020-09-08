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
    public partial class AddOfferOnProduct : System.Web.UI.Page
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
            SqlCommand cmd = new SqlCommand("applyOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
           
            string username = (string)(Session["username"]);  // (string)(Session["username"]);
            string offerid1 = offerid.Text;
            string serial1 = serial.Text;
            
            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@vendorname", username));
            cmd.Parameters.Add(new SqlParameter("@offerid", offerid1));
            cmd.Parameters.Add(new SqlParameter("@serial", serial1));
            
            //Executing the SQLCommand
            conn.Open();
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        protected void offerid_TextChanged(object sender, EventArgs e)
        {

        }
        void myConnection_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + e.Message + "');", true);
            // Response.Write(e.Message);
        }
    }
}