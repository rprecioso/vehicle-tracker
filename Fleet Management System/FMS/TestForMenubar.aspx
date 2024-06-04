<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestForMenubar.aspx.cs" Inherits="FMS.TestForMenubar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .ul {
            font-family: Arial, Verdana;
            font-size: 14px;
            margin: 0;
            padding: 0;
            list-style: none;
            float: right;
            margin-right: 80px;
        }

            ul li {
                display: block;
                position: relative;
                float: left;                
            }

        li ul {
            display: none;
        }

        ul li a {
            display: block;
            text-decoration: none;
            color: #ffffff;
            border: none;
            padding: 5px 15px 5px 15px;
            background: #343434;
            margin-left: 1px;
            white-space: nowrap;
        }

            ul li a:hover {
                background: #282828;
            }

        li:hover ul {
            display: block;
            position: absolute;
        }

        li:hover li {
            float: none;
            font-size: 11px;
        }

        li:hover a {
            background: #282828;
        }

        li:hover li a:hover {
            background: #4d4d4d;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="background: #343434; height: 30px;">
            <table style="width: 100%;">
                <tr>
                    <td>
                        <i>Welcome</i>
                        <strong>
                            <asp:Label ID="lblLogged"
                                runat="server" Text="User" ForeColor="#ffffff" Font-Size="12px" Font-Names="sans-serif" font-Variant="small-caps" />!
                        </strong>|
                <asp:LinkButton Text="Logout" runat="server" ID="btnLogout" ForeColor="#ffffff" />
                    </td>
                    <td>
                        <div>
                            <ul class="ul">
                                <li id="menuDashboard"><a href="/Source/Child/Dashboard.aspx">Dashboard</a></li>
                                <li id="menuVehicles">
                                    <a href="/Source/Child/Vehicles.aspx">Vehicles</a>
                                    <ul>
                                        <li><a href="/Source/Child/Vehicles.aspx">
                                            <img src="../../Design/menu_images/new/vehicles.png" />&nbsp;&nbsp;Vehicle Detail</a></li>
                                        <li><a href="/Source/Admin/Vehicles_Master.aspx">
                                            <img width="32" height="32" src="../../Design/menu_images/new/vehiclesmaster.png" />&nbsp;&nbsp;Vehicle</a></li>
                                        <li><a href="/Source/Admin/Services_Master.aspx">
                                            <img width="32" height="32" src="../../Design/menu_images/new/services.png" />&nbsp;&nbsp;Service</a></li>
                                        <li><a href="/Source/Admin/Insurance_Master.aspx">
                                            <img width="32" height="32" src="../../Design/menu_images/new/insurance.png" />&nbsp;&nbsp;Insurance</a></li>
                                    </ul>
                                </li>
                                <li id="menuDrivers">
                                    <a href="/Source/Child/Drivers.aspx">Drivers</a>
                                    <ul>
                                        <li><a href="/Source/Child/Drivers.aspx">
                                            <img width="32" height="32" src="../../Design/menu_images/new/drivers.png" />&nbsp;&nbsp; Driver Detail</a></li>
                                        <li><a href="/Source/Admin/Drivers_Master.aspx">
                                            <img src="../../Design/menu_images/new/driversmaster.png" />&nbsp;&nbsp;Driver</a></li>
                                        <li><a href="/Source/Admin/Violations_Master.aspx">
                                            <img src="../../Design/menu_images/new/violations.png" />&nbsp;&nbsp;Violation</a></li>
                                    </ul>
                                </li>
                                <li id="menuExpense">
                                    <a href="/Source/Admin/Expenses_Master.aspx">Expense</a>
                                    <ul>
                                        <li><a href="/Source/Admin/Expenses_Master.aspx">
                                            <img width="32" height="32" src="../../Design/menu_images/new/expenses.png" />&nbsp;&nbsp;Expense</a></li>
                                    </ul>
                                </li>
                                <li id="menuReports">
                                    <a href="http://121.96.219.159:802/ssrs/">Reports</a>
                                    <ul>
                                        <li><a href="http://121.96.219.159:802/ssrs/">
                                            <img src="../../Design/menu_images/new/reports.png" />FMS Report</a></li>
                                        <li><a href="http://121.96.219.159:802/ssrs/expensefms.aspx">
                                            <img src="../../Design/menu_images/new/expensereports.png" />Expense Report</a></li>
                                    </ul>
                                </li>
                                <li id="menuControl">
                                    <a href="/Source/Admin/User_Access.aspx">Settings</a>
                                    <ul>
                                        <li><a href="/Source/Admin/User_Access.aspx">
                                            <img src="../../Design/menu_images/new/accounts.png" alt="" />&nbsp;&nbsp;Accounts</a></li>
                                        <li><a href="/Source/Admin/User_Roles.aspx">
                                            <img width="32" height="32" src="../../Design/menu_images/new/roles.png" />&nbsp;&nbsp;Roles</a></li>
                                        <li><a href="/Source/Admin/Services_Panel.aspx">
                                            <img src="../../Design/menu_images/new/services.png" alt="" />&nbsp;&nbsp;Service Type</a></li>
                                        <li><a href="/Source/Admin/Violations_Panel.aspx">
                                            <img src="../../Design/menu_images/new/violations.png" alt="" />&nbsp;&nbsp;Violation Type</a></li>
                                        <li><a href="/Source/Admin/Vendors_Panel.aspx">
                                            <img src="../../Design/menu_images/new/vendors.png" alt="" />&nbsp;&nbsp;Vendors</a></li>
                                    </ul>
                                </li>
                                <li></li>
                            </ul>
                        </div>
                    </td>
                </tr>
            </table>

        </div>
    </form>
</body>
</html>
