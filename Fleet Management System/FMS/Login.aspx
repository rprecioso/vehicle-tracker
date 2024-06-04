<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FMS.Login.Login" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Fleet Expense</title>
    <link href="design/css/login-box.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnLogin">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="MetroTouch">
        </telerik:RadSkinManager>
        <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" DecoratedControls="Textbox,Buttons" />
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnLogin">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="btnLogin" LoadingPanelID="RadAjaxLoadingPanel1" />
                        <telerik:AjaxUpdatedControl ControlID="vs1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
        <div>
            
                <div id="pageframe">
                    <div style="text-align: center; vertical-align: middle; margin: 20px;">
                        <img alt="Fleet Expense" src="../../Design/login_images/Fleet_Expense_logo.png" width="378" height="49" />
                        <%--<br />
                                <h1 style="font-size: 40px;">Fleet Management System</h1>--%>
                    </div>
                    <div id="login-box" class="loginbox">
                        <table>
                            <tr>
                                <td style="width: 5%;"></td>
                                <td style="width: 20px;">Username: </td>
                                <td>
                                    <telerik:RadTextBox ID="txtUsername" runat="server" Width="100%"
                                        ValidationGroup="Authentication" CssClass="login-textbox">
                                    </telerik:RadTextBox>
                                </td>
                                <td style="width: 5%;">
                                    <asp:RequiredFieldValidator ID="rfv1" runat="server" ErrorMessage="Username is required!"
                                        ControlToValidate="txtUsername" Text="<img src='design/login_images/Exclamation.gif' title='Username is required!'/>"
                                        ValidationGroup="Authentication"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 5%;"></td>
                                <td>Password: 
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtPassword" TextMode="Password" runat="server" Width="100%"
                                        ValidationGroup="Authentication" CssClass="login-textbox">
                                    </telerik:RadTextBox>
                                </td>

                                <td style="width: 5%;">
                                    <asp:RequiredFieldValidator ID="rfv2" runat="server" ErrorMessage="Password is required!"
                                        ControlToValidate="txtPassword" Text="<img src='design/login_images/Exclamation.gif' title='Password is required!'/>"
                                        ValidationGroup="Authentication"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 5%;"></td>
                                <td colspan="2" style="text-align: center">
                                    <telerik:RadButton ID="btnLogin" runat="server" Text="LOGIN" Width="320px" OnClick="btnLogin_Click"
                                        ValidationGroup="Authentication" CausesValidation="true" Skin="Black" />
                                    <%--</td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 5%; height: 30px;"></td>
                                                    <td colspan="2">--%>
                                    <asp:ValidationSummary ID="vs1" runat="server" ValidationGroup="Authentication" DisplayMode="BulletList"
                                        CssClass="validationsummary" HeaderText="<div class='validationheader'>&nbsp;Please correct the following:</div>" />
                                </td>
                                <td style="width: 5%;"></td>
                            </tr>
                        </table>

                        <p>
                            Fleet Expense Version 3.9r
                    <br />
                            Last Updated: 2014-12-05
                          <br />
                            <a href="http://1drv.ms/1ku2ZYk" target="_blank">Changelogs</a>
                        </p>
                    </div>
            </div>
        </div>
    </form>
</body>
</html>
