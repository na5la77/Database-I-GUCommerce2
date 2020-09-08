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
    public partial class Customer_2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);

            string username = (string)Session["username"];
            SqlCommand cmd2 = new SqlCommand("SELECT * FROM Orders WHERE customer_name=@username and (order_status='in process' OR order_status='not processed') ", conn2);
            cmd2.Parameters.AddWithValue("@username", username);
            conn2.Open();
            int j = 0;
            SqlDataReader rdr2 = cmd2.ExecuteReader(CommandBehavior.CloseConnection);
            if (rdr2 != null && rdr2.HasRows)
            {
                while (rdr2.Read())
                {

                    int b = rdr2.GetInt32(rdr2.GetOrdinal("order_no"));

                    ListItem a = new ListItem();
                    a.Text = Convert.ToString(b);
                    FadyOrderDropId.Items.Insert(j, a);
                    j++;
                }
                rdr2.Close();
            }
            conn2.Close();
        }

        protected void MakeOrderButton_Click(object sender, EventArgs e)
        {



            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("makeOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string username = (string)(Session["username"]);
            cmd.Parameters.Add(new SqlParameter("@customername", username));




            conn.Open();
            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            decimal Total_amount = 0;
            int OrderID = -1;
            string htmlTable = "<font face='Courier New' size='4'><table border='1' cellpadding='3' cellspacing='0'><tr>";
            htmlTable += "<th>" + "Product Name" + "</th>";
            htmlTable += "<th>" + "Product Description" + "</th>";
            htmlTable += "<th>" + "Product Price" + "</th>";
            htmlTable += "<th>" + "Product Final Price" + "</th>";
            htmlTable += "<th>" + "Product Color" + "</th>";
            htmlTable += "<th>" + "Order ID" + "</th>";
            while (rdr.Read())
            {
                //Get the value of the attribute name in the Company table
                OrderID = rdr.GetInt32(rdr.GetOrdinal("customer_order_id"));

                //Get the value of the attribute field in the Company table
                decimal finalprice = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                Total_amount += finalprice;
                //Create a new label and add it to the HTML form
                string productname = rdr.GetString(rdr.GetOrdinal("product_name"));
                string productdesc = rdr.GetString(rdr.GetOrdinal("product_description"));
                decimal productprice = rdr.GetDecimal(rdr.GetOrdinal("price"));
                decimal productfinal = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                string productcolor = rdr.GetString(rdr.GetOrdinal("color"));

                htmlTable += "<tr><td>" + productname + "</ td><td>" + productdesc + "</ td><td>" + productprice + "</ td><td>" + productfinal + "</ td><td>" + productcolor + "</ td><td>" + OrderID + "</ td></tr>";

            }
            if (OrderID == -1 )
            {
                //Response.Redirect("NoItems.aspx");
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "You dont have any products in your cart!" + "');", true);
            }
            else
            {

                htmlTable += "<tr><td>" + "--" + "</ td><td>" + "--" + "</ td><td>" + "--" + "</ td><td>" + "Total: " + Total_amount + "</ td><td>" + "--" + "</ td><td>" + "--" + "</ td></tr> </ table>";

                Session["htmlTable"] = htmlTable;
                Response.Redirect("LoadOrder.aspx");
                /*Label lbl_OrderID = new Label();
                lbl_OrderID.Text = "<br />" + "Order ID" + OrderID;
                form1.Controls.Add(lbl_OrderID);
                Label lbl_Total_amount = new Label();
                lbl_Total_amount.Text = "<br />" + "Total Amount: " + Total_amount;
                form1.Controls.Add(lbl_Total_amount);
                

                Session["OrderID"] = OrderID;
                Session["Total_Amount"] = Total_amount;*/
            }
            conn.Close();
            
                
        }


        void myConnection_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + e.Message + "');", true);
            Response.Write(e.Message);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();


            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("cancelOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string username = (string)(Session["username"]);
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);
            

            string orderid = FadyOrderDropId.Text;
            if(!string.Equals(orderid, "")) { 
            cmd.Parameters.Add(new SqlParameter("@orderid", Convert.ToInt32(orderid)));
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "You need to have an Order that can be canceled" + "');", true);
            }

            FadyOrderDropId.Items.Clear();
            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);

            
            SqlCommand cmd2 = new SqlCommand("SELECT * FROM Orders WHERE customer_name=@username and (order_status='in process' OR order_status='not processed') ", conn2);
            cmd2.Parameters.AddWithValue("@username", username);
            conn2.Open();
            int j = 0;
            SqlDataReader rdr2 = cmd2.ExecuteReader(CommandBehavior.CloseConnection);
            if (rdr2 != null && rdr2.HasRows)
            {
                while (rdr2.Read())
                {

                    int b = rdr2.GetInt32(rdr2.GetOrdinal("order_no"));

                    ListItem a = new ListItem();
                    a.Text = Convert.ToString(b);
                    FadyOrderDropId.Items.Insert(j, a);
                    j++;
                }
                rdr2.Close();
            }
            conn2.Close();

        }

        protected void Customer1ButtonID_Click(object sender, EventArgs e)
        {
            Response.Redirect("Customer_1.aspx");
        }
    }
}