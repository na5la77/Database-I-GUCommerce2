<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoveExpieredOffer.aspx.cs" Inherits="dbmilestone3.RemoveExpieredOffer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
          <asp:Label ID="Label2" runat="server" Text="offer id: "></asp:Label>
        <asp:TextBox type ="number" required="required" ID="offer_id" runat="server" Width="182px"></asp:TextBox>
        <br />
        <asp:Button ID="Button1" runat="server" Text="Remove" OnClick="Button1_Click" Width="257px" />
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
