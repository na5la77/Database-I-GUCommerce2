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
    public partial class VendorPage0 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("VendorPage.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbconn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("vendorviewProducts", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            //To read the input from the user
            string username = (string)(Session["username"]);                                      //(string)(Session["username"]);
            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@vendorname", username));

            conn.Open();

            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            string htmlTable = "<font face='Courier New' size='4'><table border='1' cellpadding='3' cellspacing='0'><tr>";
            htmlTable += "<th>" + "serial no." + "</th>";
            htmlTable += "<th>" + "product name" + "</th>";
            htmlTable += "<th>" + "categorey" + "</th>";
            htmlTable += "<th>" + "description" + "</th>";
            htmlTable += "<th>" + "price" + "</th>";
            htmlTable += "<th>" + "final price" + "</th>";
            htmlTable += "<th>" + "color" + "</th>";
            htmlTable += "<th>" + "availability" + "</th>";
            htmlTable += "<th>" + "rate" + "</th>";
            htmlTable += "<th>" + "vendor name" + "</th>";
            htmlTable += "<th>" + "customer name" + "</th>";
            htmlTable += "<th>" + "customer order id" + "</th>";
            while (rdr.Read())
            {

                int serial_no = rdr.GetInt32(rdr.GetOrdinal("serial_no"));

                string product_name = rdr.GetString(rdr.GetOrdinal("product_name"));

                string category = rdr.GetString(rdr.GetOrdinal("category"));

                string product_description = rdr.GetString(rdr.GetOrdinal("product_description"));

                decimal price = rdr.GetDecimal(rdr.GetOrdinal("price"));

                decimal final_price = 0;

                string color = rdr.GetString(rdr.GetOrdinal("color"));

                int rate = 0;

                bool available = true;

                string customer_username = " ";

                int customer_order_id = 0;

                try
                {
                    final_price = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                }
                catch (System.Data.SqlTypes.SqlNullValueException ex)
                {
                    final_price = price;
                }

                try
                {
                    available = rdr.GetBoolean(rdr.GetOrdinal("available"));
                }
                catch (System.Data.SqlTypes.SqlNullValueException ex)
                {
                    available = true;
                }
                try
                {
                    rate = rdr.GetInt32(rdr.GetOrdinal("rate"));
                }
                catch (System.Data.SqlTypes.SqlNullValueException ex)
                {
                    rate = -1;
                }
                string vendor_username = rdr.GetString(rdr.GetOrdinal("vendor_username"));

                try
                {
                    customer_username = rdr.GetString(rdr.GetOrdinal("customer_username"));
                }
                catch (System.Data.SqlTypes.SqlNullValueException ex)
                {
                    customer_username = "N/A";
                }

                try
                {
                    customer_order_id = rdr.GetInt32(rdr.GetOrdinal("customer_order_id"));
                }
                catch (System.Data.SqlTypes.SqlNullValueException ex)
                {
                    customer_order_id = -1;
                }

                

                htmlTable += "<tr><td>" + serial_no + "</ td><td>" + product_name + "</ td><td>" + category + "</ td><td>" + product_description + "</ td><td>" + price + "</ td><td>" + final_price + "</ td><td>" + color + "</ td><td>" + available + "</ td><td>" + rate  + "</ td><td>" + vendor_username + "</ td><td>" + customer_username + "</ td><td>" + customer_order_id + "</ td></tr>";
            }
            //Create a new label and add it to the HTML form
            /* Label lbl_CompanyName = new Label();
            lbl_CompanyName.Text ="serial no: " + serial_no + "    " + "product name: "  + product_name + "    " + "Category: " + category + "    " + "description : " + product_description + "    " +
            "price: " +price + "    " + "final price: " + final_price + "    " + "color : " + color + "    " + "availability: " + available + "    " +
           "Rate: "+ rate + "    " + "vendor name: " + vendor_username + "    " + "customer name: " + customer_username + "    " + "customer order id: " + customer_order_id + "  <br /> <br />";
            form1.Controls.Add(lbl_CompanyName);*/
            htmlTable += "</table>";
            
                Label lbl_table = new Label();
                lbl_table.Text = htmlTable;
                form1.Controls.Add(lbl_table);
            
            //this is how you retrive data from session variable.
            string field1 = (string)(Session[username]);
            Response.Write(field1);
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("EditProduct.aspx");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateOffer.aspx");
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddOfferOnProduct.aspx");
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            Response.Redirect("RemoveExpieredOffer.aspx");
        }

        protected void Button7_Click(object sender, EventArgs e)
        {
            Response.Redirect("MobileNumber.aspx");
        }
    }
}
 