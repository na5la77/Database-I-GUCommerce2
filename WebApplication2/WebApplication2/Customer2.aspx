<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Customer2.aspx.cs" Inherits="WebApplication1.Customer_2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <h1>Customer 2 Homepage</h1>
    <form id="form1" runat="server">
        <asp:Panel ID="Panel2" runat="server" BorderWidth="1 px">
            <h2>To make an order press the "Make Order" button</h2>
            <asp:Button ID="MakeOrderButton" runat="server" Text="Make Order" OnClick="MakeOrderButton_Click" />
        </asp:Panel>

        <br />
        <asp:Panel ID="Panel1" runat="server" BorderWidth="1 px">
            <h2>To cancel an order press the "cancel Order" button</h2>
            <asp:Label ID="FadyOrderLabelID" runat="server" Text="Order Number: "></asp:Label> 
            <asp:DropDownList ID="FadyOrderDropId" runat="server"></asp:DropDownList>
            <asp:Button ID="CancelOrderButtonID" runat="server" Text="Cancel Order" OnClick="Button1_Click" />
            <br />
        </asp:Panel>
        <br />
        <asp:Panel ID="Panel3" runat="server" BorderWidth="1 px">
            <h2>To go to Customer Page 1 press on the button below</h2>
            <asp:Button ID="Customer1ButtonID" runat="server" Text="Homepage" OnClick="Customer1ButtonID_Click" />
            <br />
        </asp:Panel>
    </form>
</body>
</html>
