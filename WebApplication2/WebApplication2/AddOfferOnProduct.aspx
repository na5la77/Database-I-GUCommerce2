<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddOfferOnProduct.aspx.cs" Inherits="dbmilestone3.AddOfferOnProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label3" runat="server" Text="offer id: "></asp:Label>
        <asp:TextBox required="required" type ="number" ID="offerid" runat="server" OnTextChanged="offerid_TextChanged" Width="230px"></asp:TextBox>
        <br />
        <asp:Label ID="Label5" runat="server" Text="serial: "></asp:Label>
        <asp:TextBox required="required" type ="number" ID="serial" runat="server" Width="241px"></asp:TextBox>
        <br />
        <asp:Button ID="Button1" runat="server" Text="Apply Offer" OnClick="Button1_Click" Width="303px" />
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
