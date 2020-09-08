<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Customer_1.aspx.cs" Inherits="WebApplication2.Customer_1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
    <asp:Panel ID="Panel3" runat="server" HorizontalAlign="Center" Direction="LeftToRight" BackColor="#CCCCCC"   Visible="true" Height="100%" Width="100%">
<body>
    <form id="form1" runat="server">
        

        <div>
            <asp:Button ID="showProducts" runat="server" Text="Show all Products" OnClick="showProducts_Click" BackColor="Black" BorderStyle="Outset" BorderWidth="8px" ForeColor="#CCCCCC" Height="79px" Width="100%" style="margin-left: 0px" Font-Bold="False" Font-Italic="False" Font-Names="Niagara Solid" Font-Overline="True" Font-Size="XX-Large" Font-Underline="True" HorizontalAlign="Center"  />
          
        </div>
        
            <asp:Button ID="showCart" runat="server" Text="View my Cart" OnClick="showCart_Click" BackColor="Black" BorderStyle="Outset" BorderWidth="8px" ForeColor="#CCCCCC" Height="79px" Width="100%" style="margin-left: 0px" Font-Names="Niagara Solid" Font-Overline="True" Font-Size="XX-Large" Font-Underline="True" HorizontalAlign="Center" />
    
        
        <asp:Panel ID="wishlists" runat="server" GroupingText="Wishlists" BackColor="Black" BorderColor="#CCCCCC" BorderStyle="Inset" ForeColor="Silver" Width="100%" BorderWidth="8px" HorizontalAlign="Center">
           

                <asp:TextBox ID="newWishlistName" runat="server" OnTextChanged="TextBox1_TextChanged" placeholder="Wishlist Name" BackColor="#CCCCCC" ForeColor="Black"></asp:TextBox>
                <asp:Button ID="createWishlist" runat="server" Height="25px" OnClick="createWishlist_Click" Text="Create Wishlist" Width="130px" BackColor="Black" BorderStyle="Outset" BorderWidth="2px" ForeColor="#CCCCCC"  Font-Names="Niagara Solid" Font-Size="Large" />

         

            <div>
                <p>
                    <asp:TextBox input type ="number" ID="productSerialno" runat="server" OnTextChanged="TextBox1_TextChanged" placeholder="Serial Number of Product" BackColor="#CCCCCC" ForeColor="Black"></asp:TextBox>
                    <asp:Button ID="addToWishlist" runat="server" Text="Add To Wishlist:" OnClick="addToWishlist_Click" BackColor="Black" BorderStyle="Outset" BorderWidth="2px" ForeColor="#CCCCCC"  Font-Names="Niagara Solid" Font-Size="Large"/>
                    <asp:DropDownList ID="wishListNames" runat="server" BackColor="Black" Font-Names="Niagara Engraved" Font-Size="Large" ForeColor="#AFCCCC">
                    </asp:DropDownList>


                </p>
            </div>

            <div>
                <p>
                    <asp:TextBox input type ="number" ID="productSerialnoD" runat="server" OnTextChanged="TextBox1_TextChanged" placeholder="Serial Number of Product" BackColor="#CCCCCC" ForeColor="Black"></asp:TextBox>
                    <asp:Button ID="removeFromWishlist" runat="server" Text="Remove From Wishlist:" OnClick="removeFromWishlist_Click" BackColor="Black" BorderStyle="Outset" BorderWidth="2px" ForeColor="#CCCCCC"  Font-Names="Niagara Solid" Font-Size="Large" />
                    <asp:DropDownList ID="wishListNamesD" runat="server" BackColor="Black" Font-Names="Niagara Engraved" Font-Size="Large" ForeColor="#CCCCCC"></asp:DropDownList>
                </p>
            </div>
        </asp:Panel>
        <br/>
        
            <asp:Panel ID="Panel1" runat="server" GroupingText ="Add Credit Card" BackColor="Black" BorderColor="#CCCCCC" BorderStyle="Inset" ForeColor="Silver" Width="100%" BorderWidth="8px" HorizontalAlign="Center">
        <div>

            <br/>
                <asp:TextBox  input type ="number" ID="cc_number" runat="server" OnTextChanged="TextBox2_TextChanged" placeholder="Credit Card Number" BackColor="#CCCCCC" ForeColor="Black"></asp:TextBox>
            
            <br />
            <asp:Label ID="Label1" runat="server" Text="Expiry Date: " Font-Italic="True" Font-Size="Small"></asp:Label>
                <br />
                <asp:TextBox   ID="cc_exipry" runat="server"   input type ="date" BackColor="#CCCCCC" ForeColor="Black"></asp:TextBox>
                <br />    
            <br/>
                <asp:TextBox  input type ="number" ID="CVV" runat="server" OnTextChanged="TextBox3_TextChanged" placeholder="CVV" min ="99" max="9999" BackColor="#CCCCCC" ForeColor="Black"></asp:TextBox>
                
                <br />
            <br />
            <asp:Button ID="addCreditCard" runat="server" Text="Add Credit Card" OnClick="addCreditCard_Click1" BackColor="Black" BorderStyle="Outset" BorderWidth="2px" ForeColor="#CCCCCC"  Font-Names="Niagara Solid" Font-Size="Large" />
        <br />
        </div>
                </asp:Panel>
        <br />
        <asp:Panel ID="Cart" runat="server" GroupingText="Cart" BackColor="Black" BorderColor="#CCCCCC" BorderStyle="Inset" ForeColor="Silver" Width="100%" BorderWidth="8px" HorizontalAlign="Center">
            <div>
                <asp:TextBox input type ="number" ID="Serial_Number" runat="server" OnTextChanged="TextBox1_TextChanged" placeholder="Serial Number of Product" BackColor="#CCCCCC" ForeColor="Black" Width="220px"></asp:TextBox>
                <asp:Button ID="addToCart" runat="server" Text="Add To Cart" OnClick="addToCart_Click" BackColor="Black" BorderStyle="Outset" BorderWidth="2px" ForeColor="#CCCCCC"  Font-Names="Niagara Solid" Font-Size="Large" />
            </div>
            <br />
               <div>
                <asp:TextBox input type ="number" ID="Serial_NumberD" runat="server" OnTextChanged="TextBox4_TextChanged" placeholder="Serial Number of Product" BackColor="#CCCCCC" ForeColor="Black" Width="220px" Wrap="False"></asp:TextBox>
                <asp:Button ID="removefromCart" runat="server" Text="Remove From Cart" OnClick="removefromCart_Click" BackColor="Black" BorderStyle="Outset" BorderWidth="2px" ForeColor="#CCCCCC"  Font-Names="Niagara Solid" Font-Size="Large" />
            </div>


        </asp:Panel>
        <asp:Panel ID="Panel2" runat="server" GroupingText="Add Mobile Number" BackColor="Black" BorderColor="#CCCCCC" BorderStyle="Inset" ForeColor="Silver" Width="100%" BorderWidth="8px" HorizontalAlign="Center">
            <asp:TextBox  input type ="number" ID="mobile" runat="server" OnTextChanged="TextBox5_TextChanged" placeholder="Phone Number" BackColor="#CCCCCC" ForeColor="Black"></asp:TextBox>
            <asp:Button ID="Button2" runat="server" Text="Add" BackColor="Black" BorderStyle="Outset" BorderWidth="2px" ForeColor="#CCCCCC"  Font-Names="Niagara Solid" Font-Size="Large" OnClick="Button2_Click"  />
        </asp:Panel>
       <asp:Panel ID="Panel4" runat="server"  BackColor="#CCCCCC"  BorderStyle="None" Width="100%" BorderWidth="0px" HorizontalAlign="Right" Visible="True">
        <div>
        <asp:Button ID="Button1" runat="server" Text="Orders"  BackColor="Black" BorderStyle="Outset" BorderWidth="2px" ForeColor="#CCCCCC"  Font-Names="Niagara Solid"  Font-Size="Large" OnClick="Button1_Click" style="margin-left: 800px" Height="50px" Width="150px" />
            </div>
           </asp:Panel>
            
    </form>
</body>
    </asp:Panel>
</html>
