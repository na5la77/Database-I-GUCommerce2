<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebApplication1.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
    <body>
        <form id="form1" runat="server">
            <asp:Button ID="CustomerRegister" runat="server" Text="Customer Register" OnClick="CustomerRegister_Click" Width="148px" />
            <asp:Button ID="VendorRegister" runat="server" Text="Vendor Regsiter" OnClick="VendorRegister_Click" Width="155px" />
            <br />
            <asp:Button ID="Login" runat="server" Text="Login" OnClick="Login_Click" Width="303px" />
        </form>
    </body>
</html>
