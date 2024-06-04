<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DETFlag.aspx.cs" Inherits="FMS.Source.Details.DETFlag" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript">
        function CloseAndRebind(args) {
            GetRadWindow().BrowserWindow.refreshGrid(args);
            GetRadWindow().close();           
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)

            return oWindow;
        }
    </script>
    <title>Reason for Flagging</title>
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <div>        
        <table>
            <tr>
                <td style="vertical-align: top;">
                    Reason for Flagging
                    <br/>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter a reason for flagging." 
                        Text="Please enter a reason for flagging." ControlToValidate="txtFlagReason" ValidationGroup="flag"/>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtFlagReason" runat="server" Width="300px" Height="100px" TextMode="MultiLine"></telerik:RadTextBox>
                </td>
                </tr>
            <tr>
                <td colspan="2" style="text-align: right;">
                    <telerik:RadButton ID="btnOk" runat="server" Text="OK" OnClick="btnOk_Click" ValidationGroup="flag"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
