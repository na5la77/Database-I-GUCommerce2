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
    public partial class LoadOrder : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = (string)(Session["username"]);
            string htmlTable = (string)(Session["htmlTable"]);

            Label lbl_htmlTable = new Label();
            lbl_htmlTable.Text = htmlTable;
            Panel3.Controls.Add(lbl_htmlTable);

            string connStr1 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn1 = new SqlConnection(connStr1);


            SqlCommand cmd1 = new SqlCommand("SELECT * FROM Customer_CreditCard cc INNER JOIN Credit_Card c ON c.number = cc.cc_number where cc.customer_name =@username and expiry_date >= CURRENT_TIMESTAMP", conn1);
            cmd1.Parameters.AddWithValue("@username", username);
            conn1.Open();
            int i = 0;
            SqlDataReader dr = cmd1.ExecuteReader(CommandBehavior.CloseConnection);
            if (dr != null && dr.HasRows)
            {
                while(dr.Read())
              {

                    string b = dr.GetString(dr.GetOrdinal("cc_number"));

                    ListItem a = new ListItem();
                    a.Text = b;
                    CreditCardID.Items.Insert(i, a);
                    i++;
                }
                dr.Close();
            }
            conn1.Close();
            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);


            SqlCommand cmd2 = new SqlCommand("SELECT * FROM Orders WHERE customer_name=@username and total_amount IS NOT NULL and cash_amount IS NULL and credit_amount IS NULL", conn2);
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
                    OrderIdDrop.Items.Insert(j, a);
                    j++;
                }
                rdr2.Close();
            }
            conn2.Close();

            string connStr3 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn3 = new SqlConnection(connStr3);


            SqlCommand cmd3 = new SqlCommand("SELECT * FROM Orders WHERE customer_name=@username and payment_type='credit' and creditCard_number IS NULL", conn3);
            cmd3.Parameters.AddWithValue("@username", username);
            conn3.Open();
            int k = 0;
            SqlDataReader rdr3 = cmd3.ExecuteReader(CommandBehavior.CloseConnection);
            if (rdr3 != null && rdr3.HasRows)
            {
                while (rdr3.Read())
                {

                    int b = rdr3.GetInt32(rdr3.GetOrdinal("order_no"));

                    
                    ListItem c = new ListItem();
                    c.Text = Convert.ToString(b);
                    OrderIdCreditDrop.Items.Insert(k, c);
                    k++;
                }
                rdr3.Close();
            }
            conn3.Close();





        }





        protected void PayButtonID_Click(object sender, EventArgs e)
        {

        }

        protected void OrderIdDrop_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void CreditCardID_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void submitAmountButton_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();


            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("SpecifyAmount", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string username = (string)(Session["username"]);
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            string amount = AmountTEXT.Text;
            string type = DropDownList1.Text;
            string orderid = OrderIdDrop.Text;
            decimal thisiszero = (decimal)0.0;
          
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);

            if (string.Equals(type,"Cash"))
              {
                // Response.Write(Convert.ToDecimal(amount));
                if (!string.IsNullOrWhiteSpace(amount)&& !string.Equals(orderid, "")) {
                    cmd.Parameters.Add(new SqlParameter("@orderID", Convert.ToInt32(orderid)));
                    cmd.Parameters.Add(new SqlParameter("@cash", Convert.ToDecimal(amount)));
                    cmd.Parameters.Add(new SqlParameter("@credit", thisiszero));
                    //flag = false;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
                else {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Choose correct amount and Order Number" + "');", true);
                }
                  

              }
              else
              {
                if (!string.IsNullOrWhiteSpace(amount)&& !string.Equals(orderid, ""))
                {
                    cmd.Parameters.Add(new SqlParameter("@orderID", Convert.ToInt32(orderid)));
                    cmd.Parameters.Add(new SqlParameter("@credit", Convert.ToDecimal(amount)));
                    cmd.Parameters.Add(new SqlParameter("@cash", thisiszero));
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Choose correct amount and Order Number" + "');", true);
                }
                
              }

            OrderIdCreditDrop.Items.Clear();
            string connStr3 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn3 = new SqlConnection(connStr3);


            SqlCommand cmd3 = new SqlCommand("SELECT * FROM Orders WHERE customer_name=@username and payment_type='credit' and creditCard_number IS NULL", conn3);
            cmd3.Parameters.AddWithValue("@username", username);
            conn3.Open();
            int k = 0;
            SqlDataReader rdr3 = cmd3.ExecuteReader(CommandBehavior.CloseConnection);
            if (rdr3 != null && rdr3.HasRows)
            {
                while (rdr3.Read())
                {

                    int b = rdr3.GetInt32(rdr3.GetOrdinal("order_no"));


                    ListItem c = new ListItem();
                    c.Text = Convert.ToString(b);
                    OrderIdCreditDrop.Items.Insert(k, c);
                    k++;
                }
                rdr3.Close();
            }
            conn3.Close();
            CreditCardID.Items.Clear();
            string connStr1 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn1 = new SqlConnection(connStr1);


            SqlCommand cmd1 = new SqlCommand("SELECT * FROM Customer_CreditCard cc INNER JOIN Credit_Card c ON c.number = cc.cc_number where cc.customer_name =@username and expiry_date >= CURRENT_TIMESTAMP", conn1);
            cmd1.Parameters.AddWithValue("@username", username);
            conn1.Open();
            int i = 0;
            SqlDataReader dr = cmd1.ExecuteReader(CommandBehavior.CloseConnection);
            if (dr != null && dr.HasRows)
            {
                while (dr.Read())
                {

                    string b = dr.GetString(dr.GetOrdinal("cc_number"));

                    ListItem a = new ListItem();
                    a.Text = b;
                    CreditCardID.Items.Insert(i, a);
                    i++;
                }
                dr.Close();
            }
            conn1.Close();
            OrderIdDrop.Items.Clear();
            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);


            SqlCommand cmd2 = new SqlCommand("SELECT * FROM Orders WHERE customer_name=@username and total_amount IS NOT NULL and cash_amount IS NULL and credit_amount IS NULL", conn2);
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
                    OrderIdDrop.Items.Insert(j, a);
                    j++;
                }
                rdr2.Close();
            }
            conn2.Close();






        }
        void myConnection_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + e.Message + "');", true);

        }

        protected void PayButtonID_Click1(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();


            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("ChooseCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string cc = CreditCardID.Text;
            string orderid = OrderIdCreditDrop.Text;
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);
            if (!string.Equals(orderid,"")&& !string.Equals(cc, ""))

            {
                cmd.Parameters.Add(new SqlParameter("@orderid", Convert.ToInt32(orderid)));
                cmd.Parameters.Add(new SqlParameter("@creditcard", cc));
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            else if(!string.Equals(orderid, "") && string.Equals(cc, ""))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Choose correct CC Number" + "');", true);
            }
            else if (string.Equals(orderid, "") && !string.Equals(cc, ""))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Choose correct Order Number" + "');", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Choose correct CC and Order Number" + "');", true);
            }
      
          

           

            string username = (string)Session["username"];
            OrderIdCreditDrop.Items.Clear();
            string connStr3 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn3 = new SqlConnection(connStr3);


            SqlCommand cmd3 = new SqlCommand("SELECT * FROM Orders WHERE customer_name=@username and payment_type='credit' and creditCard_number IS NULL", conn3);
            cmd3.Parameters.AddWithValue("@username", username);
            conn3.Open();
            int k = 0;
            SqlDataReader rdr3 = cmd3.ExecuteReader(CommandBehavior.CloseConnection);
            if (rdr3 != null && rdr3.HasRows)
            {
                while (rdr3.Read())
                {

                    int b = rdr3.GetInt32(rdr3.GetOrdinal("order_no"));


                    ListItem c = new ListItem();
                    c.Text = Convert.ToString(b);
                    OrderIdCreditDrop.Items.Insert(k, c);
                    k++;
                }
                rdr3.Close();
            }
            conn3.Close();
            CreditCardID.Items.Clear();
            string connStr1 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn1 = new SqlConnection(connStr1);


            SqlCommand cmd1 = new SqlCommand("SELECT * FROM Customer_CreditCard cc INNER JOIN Credit_Card c ON c.number = cc.cc_number where cc.customer_name =@username and expiry_date >= CURRENT_TIMESTAMP", conn1);
            cmd1.Parameters.AddWithValue("@username", username);
            conn1.Open();
            int i = 0;
            SqlDataReader dr = cmd1.ExecuteReader(CommandBehavior.CloseConnection);
            if (dr != null && dr.HasRows)
            {
                while (dr.Read())
                {

                    string b = dr.GetString(dr.GetOrdinal("cc_number"));

                    ListItem a = new ListItem();
                    a.Text = b;
                    CreditCardID.Items.Insert(i, a);
                    i++;
                }
                dr.Close();
            }
            conn1.Close();
            OrderIdDrop.Items.Clear();
            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);


            SqlCommand cmd2 = new SqlCommand("SELECT * FROM Orders WHERE customer_name=@username and total_amount IS NOT NULL and cash_amount IS NULL and credit_amount IS NULL", conn2);
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
                    OrderIdDrop.Items.Insert(j, a);
                    j++;
                }
                rdr2.Close();
            }
            conn2.Close();
        }

        protected void OrderIdCreditDrop_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Customer1ButtonID_Click(object sender, EventArgs e)
        {
            Response.Redirect("Customer_1.aspx");
        }

        protected void Customer2ButtonID_Click(object sender, EventArgs e)
        {
            Response.Redirect("Customer2.aspx");
        }
    }
}