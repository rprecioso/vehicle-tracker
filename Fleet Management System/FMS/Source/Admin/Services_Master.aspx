<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Services_Master.aspx.cs" Inherits="FMS.Source.Admin.ServicesMaster" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowEditForm(id) {
                window.radopen("/Source/Details/DETService.aspx?id=" + id, "vhc_srv_dialog");
                return false;
            }

            function ShowInsertForm() {
                window.radopen("/Source/Details/DETService.aspx?", "vhc_srv_dialog");
                return false;
            }

            function ShowExpenseForm(exp_id, ref_id, type_id) {
                window.radopen("/Source/Details/DETExpense.aspx?type_id=" + type_id + "&ref_id=" + ref_id + "&exp_id=" + exp_id, "vhc_srv_dialog");
                return false;
            }

            function ShowDriverForm(id) {
                window.radopen("/Source/Details/DETDriver.aspx?id=" + id + "&mode=view", "drvDialog");
                return false;
            }

            function ShowVehicleForm(id) {
                window.radopen("/Source/Details/DETVehicle.aspx?id=" + id + "&mode=view", "vhcDialog");
                return false;
            }

            function refreshGrid(arg) {
                if (!arg) {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("Rebind");
                }
                else {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("RebindAndNavigate");
                }
            }

            function RowDblClick(sender, eventArgs) {
            }

        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RADVHCServices" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="RADVHCServices">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RADVHCServices" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="vhc_srv_dialog" runat="server" OnClientClose="refreshGrid" Title="Service" Height="500"
                Width="370" ReloadOnShow="true" ShowContentDuringLoad="false"
                Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="vhcDialog" OnClientClose="refreshGrid" runat="server" Title="Vehicle" Height="600px"
                Width="450px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="drvDialog" runat="server" Title="Driver" Height="600px"
                Width="420px" ReloadOnShow="true" OnClientClose="refreshGrid" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>


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
                    OnClick="btn_filter_Click">
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
            <td>
                <telerik:RadButton
                    ID="btnAdd"
                    runat="server"
                    Text="Add new record"
                    OnClientClicked="ShowInsertForm"
                    AutoPostBack="false">
                </telerik:RadButton>
            </td>
        </tr>
    </table>


    <telerik:RadGrid ID="RADVHCServices" runat="server" PageSize="10" CellSpacing="0" Width="100%"
        OnItemCommand="RADVHCServices_ItemCommand"
        OnNeedDataSource="RADVHCServices_NeedDataSource"
        OnItemDataBound="RADVHCServices_ItemDataBound" AllowPaging="true"
        OnItemCreated="RADVHCServices_ItemCreated" GridLines="None">

        <ExportSettings ExportOnlyData="true" FileName="Services List" IgnorePaging="true" OpenInNewWindow="true"
            Pdf-PageTitle="Services List" Pdf-PageHeight="210mm" Pdf-PageWidth="297mm">
            <Pdf PageTitle="Services List" PageWidth="297mm" PageHeight="210mm"></Pdf>
        </ExportSettings>

        <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="None" DataKeyNames="vhc_srv_id"
            InsertItemDisplay="Top" AllowAutomaticUpdates="false">
            <HeaderStyle HorizontalAlign="Center" />
            <%--<CommandItemSettings AddNewRecordText="Add new Vehicle Service"></CommandItemSettings>--%>
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
                <telerik:GridTemplateColumn HeaderStyle-Width="50px" FilterControlAltText="Filter column column" ReadOnly="true" HeaderText="No" UniqueName="column" Reorderable="False" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Container.DataSetIndex+1 %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="50px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="viewDetails" FilterControlAltText="" HeaderText="Service Receipt No." UniqueName="viewDetails" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:HyperLink ID="EditLink" runat="server" Text='<%# Eval("service_receipt_no") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="service" FilterControlAltText="Filter service column" HeaderText="Service" SortExpression="service" UniqueName="service">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="vehicle_name" FilterControlAltText="" HeaderText="Vehicle" UniqueName="vehicle_name">
                    <ItemTemplate>
                        <asp:HyperLink ID="VehicleLink" Font-Underline="true" runat="server" Text='<%# Eval("vehicle_name") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridBoundColumn DataField="date_started" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:yyyy-MM-dd}" FilterControlAltText="Filter date_started column" HeaderText="Date Started" SortExpression="date_started" UniqueName="date_started" DataType="System.DateTime">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="date_completed" ItemStyle-HorizontalAlign="Center" FilterControlAltText="Filter date_completed column" DataFormatString="{0:yyyy-MM-dd}" HeaderText="Date Completed" SortExpression="date_completed" UniqueName="date_completed" DataType="System.DateTime">
                </telerik:GridBoundColumn>
       <%--         <telerik:GridBoundColumn DataField="srv_by" HtmlEncode="false" FilterControlAltText="Filter srv_by column" HeaderText="Serviced by" SortExpression="srv_by" UniqueName="srv_by">
                </telerik:GridBoundColumn>--%>
                <telerik:GridBoundColumn DataField="remarks" HtmlEncode="false" FilterControlAltText="Filter remarks column" HeaderText="Remarks" SortExpression="remarks" UniqueName="remarks" Display="false">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn FilterControlAltText="Filter remark_elipse column" ReadOnly="true" UniqueName="remark_elipse" Reorderable="False" HeaderText="Remarks" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lbl_remarks" runat="server" Text='<%#Eval("remarks").ToString().Trim() != string.Empty ? (Eval("remarks").ToString().Length > 5 ? Eval("remarks").ToString().Substring(0, 5) + "..." : Eval("remarks")) : Eval("remarks")%>' />
                        <telerik:RadToolTip ID="tipRemarks" runat="server" TargetControlID="lbl_remarks" Skin="Metro" Text='<%#Eval("remarks")%>'>
                        </telerik:RadToolTip>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="vid" FilterControlAltText="Filter vid column" HeaderText="VID" Visible="false" SortExpression="vid" UniqueName="vid" DataType="System.Int32" ItemStyle-HorizontalAlign="Center">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="usr_id" Visible="false" FilterControlAltText="Filter usr_id column" HeaderText="usr_id" SortExpression="usr_id" UniqueName="usr_id" DataType="System.Int32">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="srv_id" Visible="false" FilterControlAltText="Filter srv_id column" HeaderText="srv_id" SortExpression="srv_id" UniqueName="srv_id" DataType="System.Int32">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="vhc_srv_id" DataType="System.Int32" FilterControlAltText="Filter vhc_srv_id column" Display="false" HeaderText="vhc_srv_id" SortExpression="vhc_srv_id" UniqueName="vhc_srv_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="brought_by" Display="false" DataType="System.Int32" FilterControlAltText="Filter brought_by column" HeaderText="brought_by" SortExpression="brought_by" UniqueName="brought_by">
                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn DataField="Driver" FilterControlAltText="" HeaderText="Driver" UniqueName="Driver">
                    <ItemTemplate>
                        <asp:HyperLink ID="DriverLink" Font-Underline="true" runat="server" Text='<%# Eval("Driver") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="exp_id" DataType="System.Int32" FilterControlAltText="Filter exp_id column" Display="false" HeaderText="exp_id" SortExpression="exp_id" UniqueName="exp_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="vendor" DataType="System.Int32" FilterControlAltText="Filter vendor column" HeaderText="Vendor" SortExpression="vendor" UniqueName="vendor">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="cost" FilterControlAltText="Filter cost column" HeaderText="Cost" UniqueName="cost" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <asp:HyperLink ID="ExpenseLink" Font-Underline="true" runat="server" Text='<%# Eval("cost") == null ? "No Cost": Eval("cost","{0:n2}") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ImageUrl="~/Design/icon_images/delete.png"
                    ConfirmText="Are you sure you want to delete this record?" />
            </Columns>
            <CommandItemTemplate>
                <a href="#" onclick="return ShowInsertForm();">Add New Vehicle Service</a>
            </CommandItemTemplate>

            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
            </EditFormSettings>
        </MasterTableView>

        <ClientSettings>
            <Selecting AllowRowSelect="true"></Selecting>
            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
        </ClientSettings>
        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>


    <asp:LinqDataSource ID="linq_vhc_service" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_vehicle_services" Where="usr_id == @usr_id">
        <WhereParameters>
            <asp:SessionParameter DefaultValue="0" Name="usr_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
