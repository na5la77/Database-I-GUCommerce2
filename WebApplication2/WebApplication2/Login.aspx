<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication1.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <asp:Label ID="UsernameLabel" runat="server" Text="Username: ">
            </asp:Label><asp:TextBox ID="UsernameText" runat="server" required="required" MaxLength="20"></asp:TextBox>
            <br />
            <asp:Label ID="PasswordLabel" runat="server" Text="Password: " >
            </asp:Label><asp:TextBox ID="PasswordText" runat="server" required="required" MaxLength="20" type ="password"></asp:TextBox>
            <br />
            <asp:Button ID="LoginButton" runat="server" Text="Login" OnClick="Login_Click" />
        </div>
    </form>
</body>
</html>
