<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DETViolationList.aspx.cs" Inherits="FMS.Source.Details.DETViolationList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td>
                    <asp:ListBox ID="ListBox1" runat="server" DataSourceID="linq_vio_list" DataTextField="violation_ticket_no" DataValueField="drv_vio_id"></asp:ListBox>
                </td>
                <td>
                    <asp:FormView ID="FormView1" runat="server" DataSourceID="linq_vio_list" EnableModelValidation="True">
                        <EditItemTemplate>
                            drv_vio_id:
                            <asp:TextBox ID="drv_vio_idTextBox" runat="server" Text='<%# Bind("drv_vio_id") %>' />
                            <br />
                            date:
                            <asp:TextBox ID="dateTextBox" runat="server" Text='<%# Bind("date") %>' />
                            <br />
                            violation:
                            <asp:TextBox ID="violationTextBox" runat="server" Text='<%# Bind("violation") %>' />
                            <br />
                            location:
                            <asp:TextBox ID="locationTextBox" runat="server" Text='<%# Bind("location") %>' />
                            <br />
                            Driver:
                            <asp:TextBox ID="DriverTextBox" runat="server" Text='<%# Bind("Driver") %>' />
                            <br />
                            vehicle_name:
                            <asp:TextBox ID="vehicle_nameTextBox" runat="server" Text='<%# Bind("vehicle_name") %>' />
                            <br />
                            remarks:
                            <asp:TextBox ID="remarksTextBox" runat="server" Text='<%# Bind("remarks") %>' />
                            <br />
                            drv_id:
                            <asp:TextBox ID="drv_idTextBox" runat="server" Text='<%# Bind("drv_id") %>' />
                            <br />
                            vid:
                            <asp:TextBox ID="vidTextBox" runat="server" Text='<%# Bind("vid") %>' />
                            <br />
                            usr_id:
                            <asp:TextBox ID="usr_idTextBox" runat="server" Text='<%# Bind("usr_id") %>' />
                            <br />
                            vio_id:
                            <asp:TextBox ID="vio_idTextBox" runat="server" Text='<%# Bind("vio_id") %>' />
                            <br />
                            violation_ticket_no:
                            <asp:TextBox ID="violation_ticket_noTextBox" runat="server" Text='<%# Bind("violation_ticket_no") %>' />
                            <br />
                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            drv_vio_id:
                            <asp:TextBox ID="drv_vio_idTextBox" runat="server" Text='<%# Bind("drv_vio_id") %>' />
                            <br />
                            date:
                            <asp:TextBox ID="dateTextBox" runat="server" Text='<%# Bind("date") %>' />
                            <br />
                            violation:
                            <asp:TextBox ID="violationTextBox" runat="server" Text='<%# Bind("violation") %>' />
                            <br />
                            location:
                            <asp:TextBox ID="locationTextBox" runat="server" Text='<%# Bind("location") %>' />
                            <br />
                            Driver:
                            <asp:TextBox ID="DriverTextBox" runat="server" Text='<%# Bind("Driver") %>' />
                            <br />
                            vehicle_name:
                            <asp:TextBox ID="vehicle_nameTextBox" runat="server" Text='<%# Bind("vehicle_name") %>' />
                            <br />
                            remarks:
                            <asp:TextBox ID="remarksTextBox" runat="server" Text='<%# Bind("remarks") %>' />
                            <br />
                            drv_id:
                            <asp:TextBox ID="drv_idTextBox" runat="server" Text='<%# Bind("drv_id") %>' />
                            <br />
                            vid:
                            <asp:TextBox ID="vidTextBox" runat="server" Text='<%# Bind("vid") %>' />
                            <br />
                            usr_id:
                            <asp:TextBox ID="usr_idTextBox" runat="server" Text='<%# Bind("usr_id") %>' />
                            <br />
                            vio_id:
                            <asp:TextBox ID="vio_idTextBox" runat="server" Text='<%# Bind("vio_id") %>' />
                            <br />
                            violation_ticket_no:
                            <asp:TextBox ID="violation_ticket_noTextBox" runat="server" Text='<%# Bind("violation_ticket_no") %>' />
                            <br />
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                        </InsertItemTemplate>
                        <ItemTemplate>
                            drv_vio_id:
                            <asp:Label ID="drv_vio_idLabel" runat="server" Text='<%# Bind("drv_vio_id") %>' />
                            <br />
                            date:
                            <asp:Label ID="dateLabel" runat="server" Text='<%# Bind("date") %>' />
                            <br />
                            violation:
                            <asp:Label ID="violationLabel" runat="server" Text='<%# Bind("violation") %>' />
                            <br />
                            location:
                            <asp:Label ID="locationLabel" runat="server" Text='<%# Bind("location") %>' />
                            <br />
                            Driver:
                            <asp:Label ID="DriverLabel" runat="server" Text='<%# Bind("Driver") %>' />
                            <br />
                            vehicle_name:
                            <asp:Label ID="vehicle_nameLabel" runat="server" Text='<%# Bind("vehicle_name") %>' />
                            <br />
                            remarks:
                            <asp:Label ID="remarksLabel" runat="server" Text='<%# Bind("remarks") %>' />
                            <br />
                            drv_id:
                            <asp:Label ID="drv_idLabel" runat="server" Text='<%# Bind("drv_id") %>' />
                            <br />
                            vid:
                            <asp:Label ID="vidLabel" runat="server" Text='<%# Bind("vid") %>' />
                            <br />
                            usr_id:
                            <asp:Label ID="usr_idLabel" runat="server" Text='<%# Bind("usr_id") %>' />
                            <br />
                            vio_id:
                            <asp:Label ID="vio_idLabel" runat="server" Text='<%# Bind("vio_id") %>' />
                            <br />
                            violation_ticket_no:
                            <asp:Label ID="violation_ticket_noLabel" runat="server" Text='<%# Bind("violation_ticket_no") %>' />
                            <br />

                        </ItemTemplate>
                    </asp:FormView>
                </td>
            </tr>
        </table>
        
        <asp:LinqDataSource ID="linq_vio_list" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_driver_violations" Where="usr_id == @usr_id">
            <WhereParameters>
                <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>
    </div>
    </form>
</body>
</html>
