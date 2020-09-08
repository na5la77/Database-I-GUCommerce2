<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MobileNumber.aspx.cs" Inherits="dbmilestone3.MobileNumber" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <asp:Label ID="Label3" runat="server" Text="mobile number: " ></asp:Label>
        <asp:TextBox required="required" type ="number" ID="mobile_number" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="Button1" runat="server" Text="ADD MOBILE" OnClick="Button1_Click" Width="299px" />
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
