<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateOffer.aspx.cs" Inherits="dbmilestone3.CreateOffer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label2" runat="server" Text="offer amount: "></asp:Label>
        <asp:TextBox required="required" type ="number" ID="offeramount" runat="server" Width="182px"></asp:TextBox>
        <br />
        <asp:Label ID="Label3" runat="server" Text="expiry date: "></asp:Label>
        <asp:TextBox required="required" type ="date" ID="expiry_date" runat="server" Width="194px"></asp:TextBox>
        <br />
        <asp:Button ID="Button1" runat="server" type ="number" Text="Add Offer" OnClick="Button1_Click" Width="303px" />
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
