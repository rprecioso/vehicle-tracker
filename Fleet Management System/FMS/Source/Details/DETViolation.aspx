<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DETViolation.aspx.cs" Inherits="FMS.Source.Details.DETViolation" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function CloseAndRebind(args) {
            GetRadWindow().close();
            GetRadWindow().BrowserWindow.refreshGrid(args);
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)

            return oWindow;
        }

        function CancelEdit() {
            GetRadWindow().close();
        } W
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
            <asp:FormView ID="DETViolations" runat="server"
                OnItemCommand="DETViolation_ItemCommand"
                OnItemCreated="DETViolation_ItemCreated"
                OnItemInserted="DETViolation_ItemInserted"
                OnItemInserting="DETViolation_ItemInserting"
                OnItemUpdated="DETViolation_ItemUpdated"
                OnItemUpdating="DETViolation_ItemUpdating"
                EmptyDataText="No Violation Data Found"
                CellPadding="4"
                EnableModelValidation="True"
                DataKeyNames="drv_vio_id" DataSourceID="linq_drv_violation">

                <EmptyDataTemplate>
                    There is nothing to see here.
                </EmptyDataTemplate>
                <EditItemTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="edit" />
                    <table>
                        <tr>
                            <td>
                                <telerik:RadTextBox Display="false" ID="tbx_drv_vio_id" Text='<%#Bind("drv_vio_id") %>' runat="server" />

                            </td>
                        </tr>
                        <tr>
                            <td>Ticket No.</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_violation_ticket_no" Text='<%#Bind("violation_ticket_no") %>' runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    Text="*" ControlToValidate="tbx_violation_ticket_no"
                                    ErrorMessage="Ticket No. is required."
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Date</td>
                            <td>
                                <telerik:RadDatePicker MinDate="1/1/1900" runat="server" DbSelectedDate='<%#Bind("date") %>'
                                    ID="rdp_date" DateInput-DisplayText='<%#Bind("date","{0:yyyy-MM-dd}") %>'>
                                    <DateInput ID="DateInput1" runat="server" DateFormat="yyyy-MM-dd"/>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                    Text="*" ControlToValidate="rdp_date"
                                    ErrorMessage="Date is required."
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Violation</td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_violation" SelectedValue='<%#Bind("vio_id") %>' runat="server" DataSourceID="linq_violation" DataTextField="violation" DataValueField="vio_id"></telerik:RadComboBox>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                    Text="*" ControlToValidate="rcmb_violation"
                                    ErrorMessage="Violation is required."
                                    ValidationGroup="edit" />--%>
                            </td>
                            <td>
                                <telerik:RadButton ID="btn_open_new_violation"
                                    runat="server" Text="+">
                                </telerik:RadButton>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="cv_vio" />
                            </td>
                            <td>
                                <telerik:RadTextBox ID="tbx_new_violation" Visible="false"
                                    ValidationGroup="cv_vio" runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                    Text="*" ControlToValidate="tbx_new_violation"
                                    ErrorMessage="Violation name is required."
                                    ValidationGroup="cv_vio" />
                            </td>
                            <td>
                                <telerik:RadButton ID="btn_new_violation" Visible="false" ValidationGroup="cv_vio"
                                    runat="server" CausesValidation="true"
                                    Text="Add New Violation" />
                                <asp:CustomValidator ID="cv_violation" runat="server"
                                    OnServerValidate="cv_violation_ServerValidate"
                                    ErrorMessage="Duplicate Violation Name!"
                                    ControlToValidate="tbx_new_violation"
                                    ValidationGroup="cv_vio" Text="*" />
                            </td>
                        </tr>

                        <tr>
                            <td>Location</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_location" Text='<%#Bind("location") %>' runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>Driver</td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_driver" SelectedValue='<%#Bind("drv_id") %>' runat="server" DataSourceID="linq_driver" DataTextField="Name" DataValueField="drv_id"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                    Text="*" ControlToValidate="rcmb_driver"
                                    ErrorMessage="Driver is required."
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Vehicle</td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_vehicle" SelectedValue='<%#Bind("vid") %>' runat="server" DataSourceID="linq_vehicle" DataTextField="vehicle_name" DataValueField="vid"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                    Text="*" ControlToValidate="rcmb_vehicle"
                                    ErrorMessage="Vehicle is required."
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        
                        <tr>
                            <td>Remarks</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_remarks" Text='<%#Bind("remarks") %>' runat="server" TextMode="MultiLine" Height="75px" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadButton ID="lbtnSave" runat="server" Text="Save" CommandName="Update"
                                    OnClientClick="if(Page_ClientValidate())try { return confirm('Are you sure you want to update the data?'); } catch(e){alert(e.message);}"
                                    CausesValidation="true" ValidationGroup="edit" />
                                <telerik:RadButton ID="lbtnCancel" runat="server" Text="Cancel" CommandName="Cancel"
                                    OnClientClick="if(Page_ClientValidate())try { return confirm('Are you sure you want to cancel the input of data?'); } catch(e){alert(e.message);}"
                                    CausesValidation="false" />
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="edit" />
                    <table>
                        <tr>
                            <td>
                                <telerik:RadTextBox Display="false" ID="tbx_drv_vio_id" Text='<%#Bind("drv_vio_id") %>' runat="server" />

                            </td>
                        </tr>
                        <tr>
                            <td>Ticket No.</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_violation_ticket_no" Text='<%#Bind("violation_ticket_no") %>' runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    Text="*" ControlToValidate="tbx_violation_ticket_no"
                                    ErrorMessage="Ticket No. is required."
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Date</td>
                            <td>
                                <telerik:RadDatePicker MinDate="1/1/1900" runat="server" DbSelectedDate='<%#Bind("date") %>'
                                    ID="rdp_date" DateInput-DisplayText='<%#Bind("date","{0:yyyy-MM-dd}") %>'>
                                    <DateInput ID="DateInput1" runat="server" DateFormat="yyyy-MM-dd"/>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                    Text="*" ControlToValidate="rdp_date"
                                    ErrorMessage="Date is required."
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Violation</td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_violation" SelectedValue='<%#Bind("vio_id") %>' runat="server" DataSourceID="linq_violation" DataTextField="violation" DataValueField="vio_id"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                    Text="*" ControlToValidate="rcmb_violation"
                                    ErrorMessage="Violation is required."
                                    ValidationGroup="edit" />
                                <telerik:RadButton ID="btn_open_new_violation"
                                    runat="server" Text="+">
                                </telerik:RadButton>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="cv_vio" />
                            </td>
                            <td>
                                <telerik:RadTextBox ID="tbx_new_violation" Visible="false"
                                    ValidationGroup="cv_vio" runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                    Text="*" ControlToValidate="tbx_new_violation"
                                    ErrorMessage="Violation name is required."
                                    ValidationGroup="cv_vio" />
                            </td>
                            <td>
                                <telerik:RadButton ID="btn_new_violation" Visible="false" ValidationGroup="cv_vio"
                                    runat="server" CausesValidation="true"
                                    Text="Add New Violation" />
                                <asp:CustomValidator ID="cv_violation" runat="server"
                                    OnServerValidate="cv_violation_ServerValidate"
                                    ErrorMessage="Duplicate Violation Name!"
                                    ControlToValidate="tbx_new_violation"
                                    ValidationGroup="cv_vio" Text="*" />
                            </td>
                        </tr>
                        <tr>
                            <td>Location</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_location" Text='<%#Bind("location") %>' runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>Driver</td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_driver" SelectedValue='<%#Bind("drv_id") %>' runat="server" DataSourceID="linq_driver" DataTextField="Name" DataValueField="drv_id"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                    Text="*" ControlToValidate="rcmb_driver"
                                    ErrorMessage="Driver is required."
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Vehicle</td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_vehicle" SelectedValue='<%#Bind("vid") %>' runat="server" DataSourceID="linq_vehicle" DataTextField="vehicle_name" DataValueField="vid"></telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                    Text="*" ControlToValidate="rcmb_vehicle"
                                    ErrorMessage="Vehicle is required."
                                    ValidationGroup="edit" />
                            </td>
                        </tr>                        
                        <tr>
                            <td>Remarks</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_remarks" Text='<%#Bind("remarks") %>' runat="server" TextMode="MultiLine" Height="75px"/>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadButton ID="lbtnSave" runat="server" Text="Save" CommandName="Add"
                                    OnClientClick="if(Page_ClientValidate())try { return confirm('Are you sure you want to update the data?'); } catch(e){alert(e.message);}"
                                    CausesValidation="true" ValidationGroup="edit" />
                                <telerik:RadButton ID="lbtnCancel" runat="server" Text="Cancel" CommandName="Cancel"
                                    OnClientClick="if(Page_ClientValidate())try { return confirm('Are you sure you want to cancel the input of data?'); } catch(e){alert(e.message);}"
                                    CausesValidation="false" />
                            </td>
                        </tr>
                    </table>
                </InsertItemTemplate>
                <ItemTemplate>
                    <table>
                        <tr>
                            <td>
                                <telerik:RadTextBox Display="false" ID="tbx_drv_vio_id" Text='<%#Bind("drv_vio_id") %>' runat="server" />

                            </td>
                        </tr>
                        <tr>
                            <td><strong>Ticket No.</strong></td>
                            <td>
                                <asp:Label ID="tbx_violation_ticket_no" Text='<%#Bind("violation_ticket_no") %>' runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Date</strong></td>
                            <td>
                                <asp:Label runat="server" ID="rdp_date" Text='<%#Bind("date","{0:yyyy-MM-dd}") %>'/>                                                                   
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Violation</strong></td>
                            <td>
                                <asp:Label ID="rcmb_violation" Text='<%#Bind("violation") %>' runat="server" />                        
                            </td>
                        </tr> 
                        <tr>
                            <td><strong>Location</strong></td>
                            <td>
                                <asp:Label ID="tbx_location" Text='<%#Bind("location") %>' runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Driver</strong></td>
                            <td>
                                <asp:Label ID="rcmb_driver" Text='<%#Bind("driver") %>' runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Vehicle</strong></td>
                            <td>
                                <asp:Label ID="rcmb_vehicle" Text='<%#Bind("vid") %>' runat="server" />                                
                            </td>
                        </tr>    
                                               
                        <tr>
                            <td><strong>Remarks</strong></td>
                            <td>
                                <asp:Label ID="tbx_remarks" Text='<%#Bind("remarks") %>' runat="server" TextMode="MultiLine" Height="75px"/>
                            </td>
                        </tr>                    
                    </table>
                </ItemTemplate>
            </asp:FormView>
            <asp:LinqDataSource ID="linq_vehicle" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_user_vehicles" Where="usr_id == @usr_id">
                <WhereParameters>
                    <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" DefaultValue="0" />
                </WhereParameters>
            </asp:LinqDataSource>
            <asp:LinqDataSource ID="linq_driver" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_driver_names" Where="usr_id == @usr_id">
                <WhereParameters>
                    <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" DefaultValue="0" />
                </WhereParameters>
            </asp:LinqDataSource>
            <asp:LinqDataSource ID="linq_violation" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="refViolations" Where="usr_id == @usr_id">
                <WhereParameters>
                    <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" DefaultValue="0" />
                </WhereParameters>
            </asp:LinqDataSource>
            <asp:LinqDataSource ID="linq_drv_violation" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext"
                TableName="vw_driver_violations" Where="drv_vio_id == @drv_vio_id" EnableDelete="True">
                <WhereParameters>
                    <asp:QueryStringParameter Name="drv_vio_id" QueryStringField="id" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>
        </div>
    </form>
</body>
</html>
