<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VendorRegister.aspx.cs" Inherits="WebApplication1.VendorRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="inputdiv">
            <asp:Label ID="UsernameLabel" runat="server" Text="Username: ">
            </asp:Label><asp:TextBox ID="UsernameText" runat="server" required="required" MaxLength="20"></asp:TextBox>
            <br />
            <asp:Label ID="FirstnameLabel" runat="server" Text="First Name:">
            </asp:Label><asp:TextBox ID="FirstnameText" runat="server" required="required" MaxLength="20"></asp:TextBox>
            <br />
            <asp:Label ID="LastnameLabel" runat="server" Text="Last Name: ">
            </asp:Label><asp:TextBox ID="LastnameText" runat="server" required="required" MaxLength="20"></asp:TextBox>
            <br />
            <asp:Label ID="PasswordLabel" runat="server" Text="Password: ">
            </asp:Label><asp:TextBox ID="PasswordText" runat="server" required="required" MaxLength="20"></asp:TextBox>
            <br />
            <asp:Label ID="EmailLabel" runat="server" Text="Email: ">
            </asp:Label><asp:TextBox ID="EmailText" runat="server" required="required" MaxLength="50"></asp:TextBox>
            <br />
            <asp:Label ID="CompanynameLabel" runat="server" Text="Company: ">
            </asp:Label><asp:TextBox ID="CompanynameText" runat="server" required="required" MaxLength="20"></asp:TextBox>
            <br />
            <asp:Label ID="BankAccountNumberLabel" runat="server" Text="Bank Account NO.: ">
            </asp:Label><asp:TextBox ID="BankAccountNumberText" runat="server" required="required" MaxLength="20"></asp:TextBox>
            <br />
            <asp:Button ID="Register" runat="server" OnClick="Register_Click" Text="Register" />
            <br />
        </div>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Login Page" />
    </form>
</body>
</html>
