<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Services.aspx.cs" Inherits="FMS.Source.Child.Services" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnNewService">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGridVHCServices" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>

    <table>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Filter Result"></asp:Label></td>
            <td>
                <telerik:RadComboBox ID="rcmb_filter" runat="server" DataTextField="DataText" DataValueField="DataValue"></telerik:RadComboBox>
            </td>
            <td>
                <telerik:RadTextBox ID="tbx_filter" runat="server"></telerik:RadTextBox>
            </td>
            <td>
                <telerik:RadButton
                    ID="btn_filter"
                    runat="server"
                    Text="Filter"
                    OnClick="RadButton1_Click">
                </telerik:RadButton>
            </td>
            <td>
                <telerik:RadButton
                    ID="btnResetFilter"
                    runat="server"
                    Text="Reset"
                    OnClick="btnResetFilter_Click">
                </telerik:RadButton>
            </td>
        </tr>
    </table>

    <telerik:RadGrid ID="RadGridVHCServices" runat="server" CellSpacing="0" OnItemCommand="RadGridVHCServices_ItemCommand"
        OnNeedDataSource="RadGridVHCServices_NeedDataSource"
        OnItemCreated="RadGridVHCServices_ItemCreated" GridLines="None" AutoGenerateEditColumn="True">
        <ExportSettings ExportOnlyData="true" FileName="Services List" IgnorePaging="true" OpenInNewWindow="true"
            Pdf-PageTitle="Services List" Pdf-PageHeight="210mm" Pdf-PageWidth="297mm">
        </ExportSettings>
        <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="Top" InsertItemDisplay="Top" DataKeyNames="vhc_srv_id" AllowAutomaticUpdates="false">
            <CommandItemSettings AddNewRecordText="Add new Vehicle Service"></CommandItemSettings>
            <CommandItemSettings ShowExportToExcelButton="true" ShowExportToPdfButton="true"
                ExportToExcelText="Export to Excel" ExportToExcelImageUrl="../../Design/export_images/Excel 48.png"
                ExportToPdfText="Export to PDF" ExportToPdfImageUrl="../../Design/export_images/Acrobat 48.png" />

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>

            <Columns>
                <telerik:GridTemplateColumn FilterControlAltText="Filter column column" ReadOnly="true" HeaderText="No" UniqueName="column">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Container.DataSetIndex+1 %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="vhc_srv_id" Visible="false" DataType="System.Int32" FilterControlAltText="Filter vhc_srv_id column" HeaderText="Vehicle Service ID" SortExpression="vhc_srv_id" UniqueName="vhc_srv_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="service_receipt_no" FilterControlAltText="Filter service_receipt_no column" HeaderText="Service Receipt No." SortExpression="service_receipt_no" UniqueName="service_receipt_no">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="vehicle_name" FilterControlAltText="Filter vehicle_name column" HeaderText="Vehicle" SortExpression="vehicle_name" UniqueName="vehicle_name">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="service" FilterControlAltText="Filter service column" HeaderText="Service" SortExpression="service" UniqueName="service">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="date_started" HtmlEncode="false" DataFormatString="{0:yyyy/MM/dd}" DataType="System.DateTime" FilterControlAltText="Filter date_started column" HeaderText="Service Date" SortExpression="date_started" UniqueName="date_started">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="date_completed" HtmlEncode="false" DataFormatString="{0:yyyy/MM/dd}" DataType="System.DateTime" FilterControlAltText="Filter date_completed column" HeaderText="Completion Date" SortExpression="date_completed" UniqueName="date_completed">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="srv_by" FilterControlAltText="Filter srv_by column" HeaderText="Serviced by" SortExpression="srv_by" UniqueName="srv_by">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="brought_by" FilterControlAltText="Filter brought_by column" HeaderText="Brought by" SortExpression="brought_by" UniqueName="brought_by">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="remarks" FilterControlAltText="Filter remarks column" HeaderText="Remarks" SortExpression="remarks" UniqueName="remarks">
                </telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="vid" Visible="false" FilterControlAltText="Filter vid column" HeaderText="VID" SortExpression="vid" UniqueName="vid">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="vid" DataType="System.Int32" FilterControlAltText="Filter vid column" HeaderText="vid" SortExpression="vid" UniqueName="vid" Visible="False">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="usr_id" DataType="System.Int32" FilterControlAltText="Filter usr_id column" HeaderText="usr_id" SortExpression="usr_id" UniqueName="usr_id" Visible="False">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="srv_id" DataType="System.Int32" FilterControlAltText="Filter srv_id column" HeaderText="srv_id" SortExpression="srv_id" UniqueName="srv_id" Visible="False">
                </telerik:GridBoundColumn>
                <telerik:GridButtonColumn CommandName="Delete" ConfirmText="Are you sure you want to delete this Item ?"
                    ConfirmDialogType="RadWindow" Reorderable="False" Text="Delete" UniqueName="Delete_Column" ConfirmTitle="Delete Item" />
            </Columns>

            <EditFormSettings EditFormType="Template">
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                <FormTemplate>


                    <table width="50%" border="0" rules="none" cellpadding="1" cellspacing="0">
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
                                <telerik:RadTextBox ReadOnly="true" Visible="false" ID="tbxServiceReceiptNo" runat="server" Text='<%#Bind("service_receipt_no") %>'></telerik:RadTextBox>
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
                                <table>
                                    <tr>
                                        <td>
                                            <telerik:RadTextBox ID="tbxNewService" Visible="false" runat="server" Text="" ValidationGroup="srv"></telerik:RadTextBox>
                                        </td>
                                        <td>
                                            <telerik:RadButton ID="btnNewService" Visible="false" runat="server" Text="Add New Service" CausesValidation="true" ValidationGroup="srv"></telerik:RadButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:CustomValidator ID="srvCusValidator" runat="server" OnServerValidate="srvCusValidator_ServerValidate" ErrorMessage="Duplicate service name, please choose another service name." ControlToValidate="tbxNewService" ValidationGroup="srv" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>


                        <tr>
                            <td>Service Date</td>
                            <td>
                                <telerik:RadDatePicker runat="server" MinDate="01/01/1900" MaxDate="12/12/3000" ID="rdpServiceDate"
                                    DbSelectedDate='<%#Bind("date_started") %>' DateInput-DisplayText='<%#Bind("date_started","{0:yyyy/MM/dd}") %>'>
                                    <DateInput ID="DateInput1" runat="server" DateFormat="yyyy/MM/dd">
                                    </DateInput>
                                </telerik:RadDatePicker>
                                <asp:RangeValidator ID="DateInputRangeValidator" runat="server" ControlToValidate="rdpServiceDate"
                                    ErrorMessage="Input a proper date"
                                    Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                                <asp:RequiredFieldValidator ID="PickerRequiredFieldValidator" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="rdpServiceDate" ErrorMessage="Please select a date"></asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td>Completion Date</td>
                            <td>
                                <telerik:RadDatePicker runat="server" ID="rdpCompletionDate" DbSelectedDate='<%#Bind("date_completed") %>'
                                    DateInput-DisplayText='<%#Bind("date_completed","{0:yyyy/MM/dd}") %>'>
                                    <DateInput ID="DateInput2" runat="server" DateFormat="yyyy/MM/dd">
                                    </DateInput>
                                </telerik:RadDatePicker>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="rdpCompletionDate"
                                    ErrorMessage="Input a proper date"
                                    Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="rdpCompletionDate" ErrorMessage="Please select a date"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Serviced by</td>
                            <td>
                                <telerik:RadTextBox ID="tbxServicedby" runat="server" Text='<%#Bind("srv_by") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="tbxServicedby" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Brought by</td>
                            <td>
                                <telerik:RadComboBox ID="rcmbBroughtby" runat="server" DataSourceID="linq_driver" SelectedValue='<%#Bind("brought_by") %>' DataTextField="Name" DataValueField="drv_id"></telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Remarks</td>
                            <td>
                                <telerik:RadTextBox ID="tbxRemarks" runat="server" Text='<%#Bind("remarks") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="tbxRemarks" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td align="right">
                                <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                    runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' CausesValidation="true" ValidationGroup="insert"
                                    OnClientClick="if(Page_ClientValidate()) try { return confirm('Are you sure you want to update the data?'); } catch(e){alert(e.message);}"></asp:Button>&nbsp;                               
                                <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                    CommandName="Cancel"></asp:Button>
                            </td>
                        </tr>
                    </table>
                </FormTemplate>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>
    <asp:LinqDataSource ID="linq_ds_vhc_service" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_vehicle_services" Where="usr_id == @usr_id">
        <WhereParameters>
            <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="linq_services" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="refServices" Where="usr_id == @usr_id">
        <WhereParameters>
            <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="linq_vehicle" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="tblVehicles">
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="linq_driver" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_driver_names" Where="usr_id == @usr_id">
        <WhereParameters>
            <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" DefaultValue="0" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
