<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VendorPage0.aspx.cs" Inherits="dbmilestone3.VendorPage0" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="Button1" runat="server" Text="Post Products" OnClick="Button1_Click" Width="245px" />
        <br />
        <asp:Button ID="Button2" runat="server" Text="View Products" OnClick="Button2_Click" Width="245px" />
        <h6>Note: if a value in the products table is -1 this means that it is not assigned </h6>  
       
        <asp:Button ID="Button3" runat="server" Text="Edit Posted Products" OnClick="Button3_Click" Width="245px" />
        <br />
        <asp:Button ID="Button4" runat="server" Text="Create Offer" OnClick="Button4_Click" Width="245px" />
        <br />
        <asp:Button ID="Button5" runat="server" Text="Add Offer On Product" OnClick="Button5_Click" Width="245px" />
        <br />
        <asp:Button ID="Button6" runat="server" Text="Remove Expiered Offer" OnClick="Button6_Click" Width="245px" />
        <br />
        <asp:Button ID="Button7" runat="server" Text="Add Mobile Number" OnClick="Button7_Click" Width="245px" />
        <div>
        </div>
    </form>
</body>
</html>
