<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DETService.aspx.cs" Inherits="FMS.Source.Details.DETService" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
        }
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="btnNewService">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="DetVHCServices" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>

        <table id="tbForms" runat="server">
            <tr>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:FormView ID="DetVHCServices" runat="server"
                        OnItemUpdating="DetVHCServices_ItemUpdating"
                        OnItemUpdated="DetVHCServices_ItemUpdated"
                        OnItemInserting="DetVHCServices_ItemInserting"
                        OnItemInserted="DetVHCServices_ItemInserted"
                        OnItemCommand="DetVHCServices_ItemCommand"
                        OnItemCreated="DetVHCServices_ItemCreated"
                        DataSourceID="linq_vhcservice" EmptyDataText="No Service Data Found"
                        DataKeyNames="vhc_srv_id" CellPadding="4" EnableModelValidation="True">
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadTextBox ReadOnly="true" Visible="false" ID="tbxVhcSrvId" runat="server" Text='<%#Bind("vhc_srv_id") %>'></telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Service Receipt No.</strong></td>
                                    <td>
                                        <asp:Label ID="tbxServiceReceiptNo" runat="server" Text='<%#Bind("service_receipt_no") %>' />                                        
                                    </td>

                                </tr>
                                <tr>
                                    <td><strong>Vehicle</strong></td>
                                    <td>
                                        <asp:Label runat="server" Text='<%#Bind("vid") %>' ID="rcmbVehicle" />
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Service Type</strong></td>
                                    <td>
                                        <asp:Label runat="server" Text='<%#Bind("service") %>' ID="rcmbServiceType" />
                                    </td>                                    
                                </tr>                                
                                <tr>
                                    <td><strong>Service Date</strong></td>
                                    <td>
                                        <asp:Label ID="rdpServiceDate" Text='<%#Bind("date_started","{0:yyyy-MM-dd}") %>' runat="server" />                                        
                                    </td>
                                </tr>

                                <tr>
                                    <td><strong>Completion Date</strong></td>
                                    <td>
                                        <asp:Label runat="server" ID="rdpCompletionDate" Text='<%#Bind("date_completed","{0:yyyy-MM-dd}") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Driver</strong></td>
                                    <td>
                                        <asp:Label ID="rcmbBroughtby" runat="server" Text='<%#Bind("driver") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Remarks</strong></td>
                                    <td>
                                        <asp:Label ID="tbxRemarks" runat="server" Text='<%#Bind("remarks") %>' TextMode="MultiLine" Height="75px" />                                        
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="insert" />
                            <table>
                                <tr>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <telerik:RadTextBox ReadOnly="true" Visible="false" ID="tbxVhcSrvId" runat="server" Text='<%#Bind("vhc_srv_id") %>'></telerik:RadTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Service Receipt No.</td>
                                    <td>
                                        <telerik:RadTextBox ID="tbxServiceReceiptNo" runat="server" Text='<%#Bind("service_receipt_no") %>'></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="tbxServiceReceiptNo" ErrorMessage="Service Receipt No. is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>Vehicle</td>
                                    <td>
                                        <telerik:RadComboBox runat="server" DataSourceID="linq_vehicle"
                                            DataValueField="vid" DataTextField="vehicle_name"
                                            SelectedValue='<%#Bind("vid") %>' ID="rcmbVehicle">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Service Type</td>
                                    <td>
                                        <telerik:RadComboBox runat="server"
                                            AppendDataBoundItems="true" DataSourceID="linq_services" DataValueField="srv_id" CausesValidation="true"
                                            DataTextField="service" SelectedValue='<%#Bind("srv_id") %>' ID="rcmbServiceType">
                                        </telerik:RadComboBox>
                                    </td>
                                    <td>
                                        <telerik:RadButton ID="btnOpenNewService" runat="server" Text="+"></telerik:RadButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>

                                    <td>
                                        <telerik:RadTextBox ID="tbxNewService" Visible="false"
                                            runat="server" Text="" ValidationGroup="srv" />

                                        <telerik:RadButton ID="btn_new_service" runat="server" Text="Add New Service" CausesValidation="true" ValidationGroup="srv" Visible="false"></telerik:RadButton>
                              
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:CustomValidator ID="srvCusValidator" runat="server"
                                            OnServerValidate="srvCusValidator_ServerValidate"
                                            ErrorMessage="Duplicate Service Name!"
                                            ControlToValidate="tbxNewService" ValidationGroup="srv" />
                                    </td>
                                </tr>

                                <tr>
                                    <td>Service Date</td>
                                    <td>
                                        <telerik:RadDatePicker MinDate="1/1/1900" runat="server" MaxDate="12/12/3000" ID="rdpServiceDate"
                                            DbSelectedDate='<%#Bind("date_started") %>' DateInput-DisplayText='<%#Bind("date_started","{0:yyyy-MM-dd}") %>'>
                                            <DateInput ID="DateInput1" runat="server" DateFormat="yyyy-MM-dd">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RangeValidator ID="DateInputRangeValidator" runat="server" ControlToValidate="rdpServiceDate"
                                            ErrorMessage="Input a proper date"
                                            Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                                        <asp:RequiredFieldValidator ID="PickerRequiredFieldValidator" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="rdpServiceDate" ErrorMessage="Service Date is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <td>Completion Date</td>
                                    <td>
                                        <telerik:RadDatePicker MinDate="1/1/1900" runat="server" ID="rdpCompletionDate" DbSelectedDate='<%#Bind("date_completed") %>'
                                            DateInput-DisplayText='<%#Bind("date_completed","{0:yyyy-MM-dd}") %>'>
                                            <DateInput ID="DateInput2" runat="server" DateFormat="yyyy-MM-dd">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="rdpCompletionDate"
                                            ErrorMessage="Input a proper date"
                                            Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="rdpCompletionDate" ErrorMessage="Completion Date is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                         <%--       <tr>
                                    <td>Serviced by</td>
                                    <td>
                                        <telerik:RadTextBox ID="tbxServicedby" runat="server" Text='<%#Bind("srv_by") %>'></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="tbxServicedby" ErrorMessage="Serviced by is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>Driver</td>
                                    <td>
                                        <telerik:RadComboBox ID="rcmbBroughtby" runat="server" DataSourceID="linq_driver" SelectedValue='<%#Bind("brought_by") %>' DataTextField="Name" DataValueField="drv_id"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Remarks</td>
                                    <td>
                                        <telerik:RadTextBox ID="tbxRemarks" runat="server" Text='<%#Bind("remarks") %>' TextMode="MultiLine" Height="75px"></telerik:RadTextBox>
                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="tbxRemarks" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>--%>
                                    </td>
                                </tr>

                                <tr>
                                    <td></td>
                                    <td>
                                        <telerik:RadButton ID="lbtnSave" runat="server" Text="Save" CommandName="Update" ValidationGroup="insert" />
                                        <telerik:RadButton ID="lbtnCancel" runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false" />
                                    </td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="insert" />
                            <table>
                                <tr>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ReadOnly="true" Visible="false" ID="tbxVhcSrvId" runat="server" Text='<%#Bind("vhc_srv_id") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Service Receipt No.</td>
                                    <td>
                                        <telerik:RadTextBox ID="tbxServiceReceiptNo" runat="server" Text='<%#Bind("service_receipt_no") %>'></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="tbxServiceReceiptNo" ErrorMessage="Service Receipt No. is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>

                                </tr>
                                <tr>
                                    <td>Vehicle</td>
                                    <td>
                                        <telerik:RadComboBox runat="server" DataSourceID="linq_vehicle" DataValueField="vid" DataTextField="vehicle_name" SelectedValue='<%#Bind("vid") %>' ID="rcmbVehicle"></telerik:RadComboBox>
                                    </td>
                                </tr>
                       <tr>
                                    <td>Service Type</td>
                                    <td>
                                        <telerik:RadComboBox runat="server"
                                            AppendDataBoundItems="true" DataSourceID="linq_services" DataValueField="srv_id" CausesValidation="true"
                                            DataTextField="service" SelectedValue='<%#Bind("srv_id") %>' ID="rcmbServiceType">
                                        </telerik:RadComboBox>
                                    </td>
                                    <td>
                                        <telerik:RadButton ID="btnOpenNewService" runat="server" Text="+"></telerik:RadButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>

                                    <td>
                                        <telerik:RadTextBox ID="tbxNewService" Visible="false"
                                            runat="server" Text="" ValidationGroup="srv" />

                                        <telerik:RadButton ID="btn_new_service" runat="server" Text="Add New Service" CausesValidation="true" ValidationGroup="srv" Visible="false"></telerik:RadButton>
                              
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:CustomValidator ID="srvCusValidator" runat="server" OnServerValidate="srvCusValidator_ServerValidate" ErrorMessage="Duplicate service name, please choose another service name." ControlToValidate="tbxNewService" ValidationGroup="srv" />
                                    </td>
                                </tr>

                                <tr>
                                    <td>Service Date</td>
                                    <td>
                                        <telerik:RadDatePicker MinDate="1/1/1900" runat="server"  MaxDate="12/12/3000" ID="rdpServiceDate"
                                            DbSelectedDate='<%#Bind("date_started") %>' DateInput-DisplayText='<%#Bind("date_started","{0:yyyy-MM-dd}") %>'>
                                            <DateInput ID="DateInput1" runat="server" DateFormat="yyyy-MM-dd">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RangeValidator ID="DateInputRangeValidator" runat="server" ControlToValidate="rdpServiceDate"
                                            ErrorMessage="Input a proper date"
                                            Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                                        <asp:RequiredFieldValidator ID="PickerRequiredFieldValidator" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="rdpServiceDate" ErrorMessage="Service Date is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>

                                <tr>
                                    <td>Completion Date</td>
                                    <td>
                                        <telerik:RadDatePicker MinDate="1/1/1900" runat="server" ID="rdpCompletionDate" DbSelectedDate='<%#Bind("date_completed") %>'
                                            DateInput-DisplayText='<%#Bind("date_completed","{0:yyyy-MM-dd}") %>'>
                                            <DateInput ID="DateInput2" runat="server" DateFormat="yyyy-MM-dd">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="rdpCompletionDate"
                                            ErrorMessage="Input a proper date"
                                            Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="rdpCompletionDate" ErrorMessage="Completion Date is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Serviced by</td>
                                    <td>
                                        <telerik:RadTextBox ID="tbxServicedby" runat="server" Text='<%#Bind("srv_by") %>'></telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="tbxServicedby" ErrorMessage="Serviced by is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Driver</td>
                                    <td>
                                        <telerik:RadComboBox ID="rcmbBroughtby" runat="server" DataSourceID="linq_driver"
                                            SelectedValue='<%#Bind("brought_by") %>' DataTextField="Name" DataValueField="drv_id">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Remarks</td>
                                    <td>
                                        <telerik:RadTextBox ID="tbxRemarks" runat="server" Text='<%#Bind("remarks") %>' TextMode="MultiLine" Height="75px"></telerik:RadTextBox>
                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="tbxRemarks" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>--%>
                                    </td>
                                </tr>

                                <tr>
                                    <td></td>
                                    <td>
                                        <telerik:RadButton ID="lbtnSave" runat="server" Text="Save" CommandName="Add" ValidationGroup="insert"
                                            OnClientClick="if(Page_ClientValidate())try { return confirm('Are you sure you want to update the data?'); } catch(e){alert(e.message);}" />
                                        <telerik:RadButton ID="lbtnCancel" runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false" />
                                    </td>
                                </tr>
                            </table>
                        </InsertItemTemplate>

                    </asp:FormView>
                </td>
            </tr>
        </table>


        <asp:LinqDataSource ID="linq_vehicle" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" Where="usr_id == @usr_id" TableName="vw_user_vehicles">
            <WhereParameters>
                <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" DefaultValue="0" />
            </WhereParameters>
        </asp:LinqDataSource>

        <asp:LinqDataSource ID="linq_vhcservice" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_vehicle_services" Where="vhc_srv_id == @vhc_srv_id">
            <WhereParameters>
                <asp:QueryStringParameter Name="vhc_srv_id" QueryStringField="id" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>

        <asp:LinqDataSource ID="linq_services" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="refServices" Where="usr_id == @usr_id">
            <WhereParameters>
                <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" DefaultValue="0" />
            </WhereParameters>
        </asp:LinqDataSource>

        <asp:LinqDataSource ID="linq_driver" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_driver_names" Where="usr_id == @usr_id">
            <WhereParameters>
                <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" DefaultValue="0" />
            </WhereParameters>
        </asp:LinqDataSource>

    </form>
</body>
</html>
