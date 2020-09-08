<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoadOrder.aspx.cs" Inherits="WebApplication1.LoadOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    
    <form id="form1" runat="server">
        <div id="tableid">
            <asp:Panel ID="Panel3" runat="server" BorderWidth="1 px">
                <div>
                    <h1> THANK YOU FOR YOUR PURCHASE!</h1>
                </div>
            </asp:Panel>
        </div>
    <div>
    <asp:Panel ID="Panel1" runat="server" BorderWidth="1 px" >
        <h2 > Please specify the amount to be paid either in cash or credit</h2>
        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            <asp:ListItem>Cash</asp:ListItem>
            <asp:ListItem>Credit</asp:ListItem>      
        </asp:DropDownList>
        <br />
        <asp:Label ID="OrderIDlabel" runat="server" Text="Order ID: "></asp:Label>
        <asp:DropDownList ID="OrderIdDrop" runat="server" OnSelectedIndexChanged="OrderIdDrop_SelectedIndexChanged"></asp:DropDownList>
        <br />
        <asp:Label runat="server" Text="Amount to pay: "></asp:Label>
         <asp:TextBox ID="AmountTEXT" runat="server"  type="number"></asp:TextBox>
        <asp:Button ID="submitAmountButton" runat="server" Text="Submit" OnClick="submitAmountButton_Click" ValidationGroup="Validate"  />
        <h6>Note: points from your giftcard might be deducted according to the amount you are gonna pay</h6>
        <h6>Note: if you choose to pay larger amount than your total we will only deduct the total amount</h6>
    </asp:Panel>
       
        <h2> Please choose a credit card if you wish!</h2>
         <asp:Panel ID="Panel2" runat="server" BorderWidth="1 px" >
             <asp:Label ID="Label1" runat="server" Text="Creditcard Number: "></asp:Label>
             <asp:DropDownList ID="CreditCardID" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"> 
                 
        </asp:DropDownList>
             <br />
             <asp:Label ID="OrderIdCreditLabel" runat="server" Text="Order ID: "></asp:Label>
             <asp:DropDownList ID="OrderIdCreditDrop" runat="server" OnSelectedIndexChanged="OrderIdCreditDrop_SelectedIndexChanged"></asp:DropDownList>
             <br />
             
             <asp:Button ID="PayButtonID" runat="server" Text="Pay" BorderStyle="Outset" OnClick="PayButtonID_Click1"  />

    </asp:Panel>
    </div>
        <asp:Panel ID="Panel4" runat="server">
            <h2> Navigation Panel</h2>
            <asp:Button ID="Customer1ButtonID" runat="server" Text="Homepage" OnClick="Customer1ButtonID_Click" />
            <br />
            <asp:Button ID="Customer2ButtonID" runat="server" Text="Orders" OnClick="Customer2ButtonID_Click" Width="115px" />
        </asp:Panel>
    </form>
    
    
</body>
</html>
