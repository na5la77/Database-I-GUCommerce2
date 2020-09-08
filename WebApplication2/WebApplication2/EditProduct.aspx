<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditProduct.aspx.cs" Inherits="dbmilestone3.EditProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label2" runat="server" Text="serial number: "></asp:Label>
        <asp:TextBox required="required" type ="number" ID="serialnumber" runat="server" Width="195px"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="product name: "></asp:Label>
        <asp:TextBox required="required" ID="product_name" runat="server" Width="195px"></asp:TextBox>
        <br />
        <asp:Label ID="Label5" runat="server" Text="category: "></asp:Label>
        <asp:TextBox required="required" ID="category" runat="server" Width="237px"></asp:TextBox>
        <br />
        <asp:Label ID="Label6" runat="server" Text="product description: "></asp:Label>
        <asp:TextBox required="required" ID="product_description" runat="server" Width="153px"></asp:TextBox>
        <br />
        <asp:Label ID="Label4" runat="server" Text="price: "></asp:Label>
        <asp:TextBox required="required" type ="number" ID="price" runat="server" Width="267px"></asp:TextBox>
        <br />
        <asp:Label ID="Label1" runat="server" Text="color: "></asp:Label>
        <asp:TextBox required="required" ID="color" runat="server" Width="268px"></asp:TextBox>
        <br />
        <asp:Button ID="Button1" runat="server" Text="Edit Product" OnClick="Button1_Click" Width="328px" />
        <br />
        <br />
        <div>
        </div>
    </form>
    <form>
         <input type="button" value="Home Page" onclick="location.href = 'VendorPage0.aspx';return true;"/>
         </form>
</body>
</html>
