using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace WebApplication2
{
    public partial class Customer_1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string customer = (string)(Session["username"]);
            string connStr1 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn1 = new SqlConnection(connStr1);


            SqlCommand cmd1 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn1);
            cmd1.Parameters.AddWithValue("@customer", customer);
            conn1.Open();
            int k = 0;
            SqlDataReader rdr = cmd1.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
                {

                    string b = rdr.GetString(rdr.GetOrdinal("name"));

                    ListItem a = new ListItem();
                    a.Text = b;
                wishListNames.Items.Insert(k, a);
                    k++;
                }
            //////////////////////////////////////////////////////////////////////////////////////////
            string customer2 = (string)(Session["username"]);
            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);


            SqlCommand cmd2 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn2);
            cmd2.Parameters.AddWithValue("@customer", customer2);
            conn2.Open();
            int i = 0;
            SqlDataReader rdr1 = cmd2.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr1.Read())
            {

                string b = rdr1.GetString(rdr1.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNamesD.Items.Insert(i, a);
                i++;
            }

        }

        protected void showProducts_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("ShowProductsbyPrice", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            conn.Open();

            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
       
                string htmlTable = "<font face='Courier New' size='4'><table border='1' cellpadding='3' cellspacing='0'><tr>";
                htmlTable += "<th>" + "Serial Number" + "</th>";
                htmlTable += "<th>" + "Product Name" + "</th>";
                htmlTable += "<th>" + "Product Description" + "</th>";
                htmlTable += "<th>" + "Product Color" + "</th>";
                htmlTable += "<th>" + "Product Price" + "</th>";
                htmlTable += "<th>" + "Product Final Price" + "</th>";
                
                
                while (rdr.Read())
                {
                    string product_name;
                    try
                    {
                        product_name = rdr.GetString(rdr.GetOrdinal("product_name"));
                    }
                    catch (System.Data.SqlTypes.SqlNullValueException ex)
                    {
                        product_name = "";
                    }

                    string product_description;
                    try
                    {
                        product_description = rdr.GetString(rdr.GetOrdinal("product_description"));
                    }
                    catch (System.Data.SqlTypes.SqlNullValueException ex)
                    {
                        product_description = "";
                    }


                    string color;

                    try
                    {
                        color = rdr.GetString(rdr.GetOrdinal("color"));
                    }
                    catch (System.Data.SqlTypes.SqlNullValueException ex)
                    {
                        color = "";
                    }


                    decimal price;


                    try
                    {
                        price = rdr.GetDecimal(rdr.GetOrdinal("price"));

                    }
                    catch (System.Data.SqlTypes.SqlNullValueException ex)
                    {
                        price = -1;
                    }

                    decimal final_price;
                    try
                    {
                        final_price = rdr.GetDecimal(rdr.GetOrdinal("final_price"));

                    }
                    catch (System.Data.SqlTypes.SqlNullValueException ex)
                    {
                        final_price = -1;
                    }

                    int serial_no;
                    try
                    {
                        serial_no = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                    }
                    catch (System.Data.SqlTypes.SqlNullValueException ex)
                    {
                        serial_no = -1;
                    }


                htmlTable += "<tr><td>" + serial_no + "</ td><td>" + product_name + "</ td><td>" + product_description + "</ td><td>" + color + "</ td><td>" + price + "</ td><td>" + final_price + "</ td></tr>";
                 }
                
                
                

                    htmlTable += "</ table>";
                    Session["htmlTable"] = htmlTable;
                    Label lbl_table = new Label();
                    lbl_table.Text= htmlTable;
                    form1.Controls.Add(lbl_table);
                    


                

            

        }

        protected void createWishlist_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("createWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string wishlist_Name = newWishlistName.Text;


            string customer = (string)(Session["username"]);


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@name", wishlist_Name));
            cmd.Parameters.Add(new SqlParameter("@customername", customer));
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);

            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            wishListNames.Items.Clear();
            wishListNamesD.Items.Clear();

            string connStr1 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn1 = new SqlConnection(connStr1);


            SqlCommand cmd1 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn1);
            cmd1.Parameters.AddWithValue("@customer", customer);
            conn1.Open();
            int k = 0;
            SqlDataReader rdr = cmd1.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {

                string b = rdr.GetString(rdr.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNames.Items.Insert(k, a);
                k++;
            }
            //////////////////////////////////////////////////////////////////////////////////////////
            string customer2 = (string)(Session["username"]); 
            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);


            SqlCommand cmd2 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn2);
            cmd2.Parameters.AddWithValue("@customer", customer2);
            conn2.Open();
            int i = 0;
            SqlDataReader rdr1 = cmd2.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr1.Read())
            {

                string b = rdr1.GetString(rdr1.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNamesD.Items.Insert(i, a);
                i++;
            }






        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }
        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {

        }
        protected void TextBox4_TextChanged(object sender, EventArgs e)
        {

        }
        void myConnection_InfoMessage(object sender, SqlInfoMessageEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + e.Message + "');", true);
           
        }

    
      

        protected void addToWishlist_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addToWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string wishlist_Name = wishListNames.Text;
            string customer = (string)(Session["username"]);
            string serial_no = productSerialno.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@wishlistname", wishlist_Name));
            cmd.Parameters.Add(new SqlParameter("@serial", serial_no));
            cmd.Parameters.Add(new SqlParameter("@customername", customer));
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);

            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            wishListNames.Items.Clear();
            wishListNamesD.Items.Clear();

            string connStr1 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn1 = new SqlConnection(connStr1);


            SqlCommand cmd1 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn1);
            cmd1.Parameters.AddWithValue("@customer", customer);
            conn1.Open();
            int k = 0;
            SqlDataReader rdr = cmd1.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {

                string b = rdr.GetString(rdr.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNames.Items.Insert(k, a);
                k++;
            }
            //////////////////////////////////////////////////////////////////////////////////////////
            string customer2 = (string)(Session["username"]);
            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);


            SqlCommand cmd2 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn2);
            cmd2.Parameters.AddWithValue("@customer", customer2);
            conn2.Open();
            int i = 0;
            SqlDataReader rdr1 = cmd2.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr1.Read())
            {

                string b = rdr1.GetString(rdr1.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNamesD.Items.Insert(i, a);
                i++;
            }


        }

      

        protected void removeFromWishlist_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("removefromWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string wishlist_Name = wishListNamesD.Text;
            string customer = (string)(Session["username"]);
            string serial_no = productSerialnoD.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@wishlistname", wishlist_Name));
            cmd.Parameters.Add(new SqlParameter("@serial", serial_no));
            cmd.Parameters.Add(new SqlParameter("@customername", customer));
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);

            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            wishListNames.Items.Clear();
            wishListNamesD.Items.Clear();

            string connStr1 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn1 = new SqlConnection(connStr1);


            SqlCommand cmd1 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn1);
            cmd1.Parameters.AddWithValue("@customer", customer);
            conn1.Open();
            int k = 0;
            SqlDataReader rdr = cmd1.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {

                string b = rdr.GetString(rdr.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNames.Items.Insert(k, a);
                k++;
            }
            //////////////////////////////////////////////////////////////////////////////////////////
            string customer2 = (string)(Session["username"]);
            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);


            SqlCommand cmd2 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn2);
            cmd2.Parameters.AddWithValue("@customer", customer2);
            conn2.Open();
            int i = 0;
            SqlDataReader rdr1 = cmd2.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr1.Read())
            {

                string b = rdr1.GetString(rdr1.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNamesD.Items.Insert(i, a);
                i++;
            }

        }


        protected void addCreditCard_Click1(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("AddCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string cc_numbers = cc_number.Text;
            string customer = (string)(Session["username"]);
            string expiry = cc_exipry.Text;
            string CVVs = CVV.Text;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@creditcardnumber", cc_numbers));
            cmd.Parameters.Add(new SqlParameter("@cvv", CVVs));
            cmd.Parameters.Add(new SqlParameter("@expirydate", expiry));
            cmd.Parameters.Add(new SqlParameter("@customername", customer));
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);

            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            wishListNames.Items.Clear();
            wishListNamesD.Items.Clear();

            string connStr1 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn1 = new SqlConnection(connStr1);


            SqlCommand cmd1 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn1);
            cmd1.Parameters.AddWithValue("@customer", customer);
            conn1.Open();
            int k = 0;
            SqlDataReader rdr = cmd1.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {

                string b = rdr.GetString(rdr.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNames.Items.Insert(k, a);
                k++;
            }
            //////////////////////////////////////////////////////////////////////////////////////////
            string customer2 = (string)(Session["username"]);
            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);


            SqlCommand cmd2 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn2);
            cmd2.Parameters.AddWithValue("@customer", customer2);
            conn2.Open();
            int i = 0;
            SqlDataReader rdr1 = cmd2.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr1.Read())
            {

                string b = rdr1.GetString(rdr1.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNamesD.Items.Insert(i, a);
                i++;
            }

        }

        protected void showCart_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string customer = (string)(Session["username"]);


            SqlCommand cmd = new SqlCommand("viewMyCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@customer", customer));
            conn.Open();

            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);


            string htmlTable = "<font face='Courier New' size='4'><table border='1' cellpadding='3' cellspacing='0'><tr>";
            htmlTable += "<th>" + "Serial Number" + "</th>";
            htmlTable += "<th>" + "Product Name" + "</th>";
            htmlTable += "<th>" + "Product Description" + "</th>";
            htmlTable += "<th>" + "Product Color" + "</th>";
            htmlTable += "<th>" + "Product Price" + "</th>";
            htmlTable += "<th>" + "Product Final Price" + "</th>";


            while (rdr.Read())
            {
                string product_name;
                try
                {
                    product_name = rdr.GetString(rdr.GetOrdinal("product_name"));
                }
                catch (System.Data.SqlTypes.SqlNullValueException ex)
                {
                    product_name = "";
                }

                string product_description;
                try
                {
                    product_description = rdr.GetString(rdr.GetOrdinal("product_description"));
                }
                catch (System.Data.SqlTypes.SqlNullValueException ex)
                {
                    product_description = "";
                }


                string color;

                try
                {
                    color = rdr.GetString(rdr.GetOrdinal("color"));
                }
                catch (System.Data.SqlTypes.SqlNullValueException ex)
                {
                    color = "";
                }


                decimal price;


                try
                {
                    price = rdr.GetDecimal(rdr.GetOrdinal("price"));

                }
                catch (System.Data.SqlTypes.SqlNullValueException ex)
                {
                    price = -1;
                }

                decimal final_price;
                try
                {
                    final_price = rdr.GetDecimal(rdr.GetOrdinal("final_price"));

                }
                catch (System.Data.SqlTypes.SqlNullValueException ex)
                {
                    final_price = -1;
                }

                int serial_no;
                try
                {
                    serial_no = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                }
                catch (System.Data.SqlTypes.SqlNullValueException ex)
                {
                    serial_no = -1;
                }


                htmlTable += "<tr><td>" + serial_no + "</ td><td>" + product_name + "</ td><td>" + product_description + "</ td><td>" + color + "</ td><td>" + price + "</ td><td>" + final_price + "</ td></tr>";
            }




            htmlTable += "</ table>";
            Session["htmlTable"] = htmlTable;
            Label lbl_table = new Label();
            lbl_table.Text = htmlTable;
            form1.Controls.Add(lbl_table);







        }

        protected void addToCart_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addToCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string serial_no = Serial_Number.Text;
            string customer = (string)(Session["username"]);
            //pass parameters to the stored procedure

            cmd.Parameters.Add(new SqlParameter("@serial", serial_no));
            cmd.Parameters.Add(new SqlParameter("@customername", customer));
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);

            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            wishListNames.Items.Clear();
            wishListNamesD.Items.Clear();

            string connStr1 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn1 = new SqlConnection(connStr1);


            SqlCommand cmd1 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn1);
            cmd1.Parameters.AddWithValue("@customer", customer);
            conn1.Open();
            int k = 0;
            SqlDataReader rdr = cmd1.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {

                string b = rdr.GetString(rdr.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNames.Items.Insert(k, a);
                k++;
            }
            //////////////////////////////////////////////////////////////////////////////////////////
            string customer2 = (string)(Session["username"]);
            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);


            SqlCommand cmd2 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn2);
            cmd2.Parameters.AddWithValue("@customer", customer2);
            conn2.Open();
            int i = 0;
            SqlDataReader rdr1 = cmd2.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr1.Read())
            {

                string b = rdr1.GetString(rdr1.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNamesD.Items.Insert(i, a);
                i++;
            }
        }

        protected void removefromCart_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("removefromCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string serial_no = Serial_NumberD.Text;
            string customer = (string)(Session["username"]);
            //pass parameters to the stored procedure

            cmd.Parameters.Add(new SqlParameter("@serial", serial_no));
            cmd.Parameters.Add(new SqlParameter("@customername", customer));
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);

            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            wishListNames.Items.Clear();
            wishListNamesD.Items.Clear();

            string connStr1 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn1 = new SqlConnection(connStr1);


            SqlCommand cmd1 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn1);
            cmd1.Parameters.AddWithValue("@customer", customer);
            conn1.Open();
            int k = 0;
            SqlDataReader rdr = cmd1.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {

                string b = rdr.GetString(rdr.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNames.Items.Insert(k, a);
                k++;
            }
            //////////////////////////////////////////////////////////////////////////////////////////
            string customer2 = (string)(Session["username"]);
            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);


            SqlCommand cmd2 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn2);
            cmd2.Parameters.AddWithValue("@customer", customer2);
            conn2.Open();
            int i = 0;
            SqlDataReader rdr1 = cmd2.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr1.Read())
            {

                string b = rdr1.GetString(rdr1.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNamesD.Items.Insert(i, a);
                i++;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Customer2.aspx");
        }

        protected void TextBox5_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addMobile", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string number = mobile.Text;
            string customer = (string)(Session["username"]);
            //pass parameters to the stored procedure

            cmd.Parameters.Add(new SqlParameter("@mobile_number", number));
            cmd.Parameters.Add(new SqlParameter("@username", customer));
            conn.InfoMessage += new SqlInfoMessageEventHandler(myConnection_InfoMessage);

            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            wishListNames.Items.Clear();
            wishListNamesD.Items.Clear();

            string connStr1 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn1 = new SqlConnection(connStr1);


            SqlCommand cmd1 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn1);
            cmd1.Parameters.AddWithValue("@customer", customer);
            conn1.Open();
            int k = 0;
            SqlDataReader rdr = cmd1.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {

                string b = rdr.GetString(rdr.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNames.Items.Insert(k, a);
                k++;
            }
            //////////////////////////////////////////////////////////////////////////////////////////
            string customer2 = (string)(Session["username"]);
            string connStr2 = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn2 = new SqlConnection(connStr2);


            SqlCommand cmd2 = new SqlCommand("SELECT name FROM Wishlist WHERE username=@customer", conn2);
            cmd2.Parameters.AddWithValue("@customer", customer2);
            conn2.Open();
            int i = 0;
            SqlDataReader rdr1 = cmd2.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr1.Read())
            {

                string b = rdr1.GetString(rdr1.GetOrdinal("name"));

                ListItem a = new ListItem();
                a.Text = b;
                wishListNamesD.Items.Insert(i, a);
                i++;
            }
        }
    }

}