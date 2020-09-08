<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VendorPage.aspx.cs" Inherits="milestone3.VendorPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
        <asp:Label ID="Label2" runat="server" Text="product name:  "></asp:Label>
        <asp:TextBox required="required" ID="product_name" runat="server" Width="185px"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="category: " ></asp:Label>
        <asp:TextBox required="required" ID= "category" runat="server" Width="225px"></asp:TextBox>
        <br />
        <asp:Label ID="Label5" runat="server" Text="product description: "></asp:Label>
        <asp:TextBox required="required" ID="product_description" runat="server" Width="142px"></asp:TextBox>
        <br />
        <asp:Label ID="Label6" runat="server" Text="price: "></asp:Label>
        <asp:TextBox  type ="number" required="required" ID="price" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="Label4" runat="server" Text="color: "></asp:Label>
        <asp:TextBox required="required" ID="color" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="Button1" runat="server" Text="post products" OnClick="Button1_Click" Width="310px" />
        <br />
        <br />
        <div>
        </div>
    </form>
    <form>
        <input type="button" value="Home Page" onclick="location.href = 'VendorPage0.aspx'; return true;"/>
         </form>
</body>
</html>
