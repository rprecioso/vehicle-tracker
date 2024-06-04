<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Insurance_Master.aspx.cs" Inherits="FMS.Source.Child.Insurance" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function ShowEditForm(id) {
            window.radopen("/Source/Details/DETInsurance.aspx?id=" + id, "vhcInsuranceDialog");
            return false;
        }
        function ShowInsertForm() {
            window.radopen("/Source/Details/DETInsurance.aspx?", "vhcInsuranceDialog");
            return false;
        }

        function ShowEditFormVehicle(id) {
            window.radopen("/Source/Details/DETVehicle.aspx?id=" + id + "&mode=view", "vhcDetailDialog");
            return false;
        }

        function ShowExpenseForm(ref_id, type_id, exp_id) {
            //window.radopen("/Source/Details/DETExpense.aspx?type_id=" + type_id + "&ref_id=" + ref_id + "&exp_id=" + exp_id, "");
            //return false;

            if (exp_id === "M") {
                window.radopen("/Source/Details/DETExpenseSummary.aspx?type_id=" + type_id + "&ref_id=" + ref_id, "vhcInsuranceDialog");
            }
            else {
                window.radopen("/Source/Details/DETExpense.aspx?type_id=" + type_id + "&ref_id=" + ref_id + "&exp_id=" + exp_id, "vhcInsuranceDialog");
            }
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
    <style type="text/css">
        .topMidAlign {
            vertical-align: top !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridIns" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_filter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridIns" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnResetFilter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridIns" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="gridIns">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridIns" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="vhcDialog" runat="server" OnClientClose="refreshGrid" Title="Vehicle" Height="600px"
                Width="320px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="vhcTrackerDialog" runat="server" OnClientClose="refreshGrid" Title="Vehicle Current Position"
                Height="546"
                Width="693" ReloadOnShow="true" ShowContentDuringLoad="false"
                Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="vhcInsuranceDialog" runat="server" OnClientClose="refreshGrid" Title="Insurance Details" Height="500px"
                Width="350px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="vhcDetailDialog" VisibleStatusbar="false" OnClientClose="refreshGrid" runat="server" Title="Vehicle Details" Height="600px"
                Width="450px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
    <%--<asp:Table ID="Table1" runat="server" HorizontalAlign="Left">
        <asp:TableRow>
            <telerik:PivotGridTableCell ColumnSpan="2" CssClass="topMidAlign">
                <telerik:RadButton
                                ID="btnAdd"
                                runat="server"
                                Text="Add new record"
                                OnClientClicked="ShowInsertForm"
                                AutoPostBack="false">
                            </telerik:RadButton>
            </telerik:PivotGridTableCell>
        </asp:TableRow>
    </asp:Table>--%>
    <table>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Filter Result"></asp:Label></td>
            <td>
                <telerik:RadComboBox ID="rcmb_filter" runat="server" DataTextField="DataText" Width="100" DataValueField="DataValue"></telerik:RadComboBox>
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

    <telerik:RadGrid ID="gridIns" runat="server" PageSize="10" OnItemCommand="gridIns_ItemCommand" OnItemDataBound="gridIns_ItemDataBound" AllowAutomaticDeletes="true" OnItemCreated="gridIns_ItemCreated" OnNeedDataSource="gridIns_NeedDataSource" AllowPaging="true">
        <MasterTableView AutoGenerateColumns="False" CommandItemDisplay="None" DataKeyNames="ins_id">
            <HeaderStyle HorizontalAlign="Center" />
            <CommandItemSettings AddNewRecordText="Add new Vehicle Insurance"></CommandItemSettings>
            <CommandItemSettings ShowExportToExcelButton="true" ShowExportToPdfButton="true"
                ExportToExcelText="Export to Excel" ExportToExcelImageUrl="../../Design/export_images/Excel 48.png"
                ExportToPdfText="Export to PDF" ExportToPdfImageUrl="../../Design/export_images/Acrobat 48.png" />


            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>
            <%--<CommandItemTemplate>
                <a href="#" onclick="return ShowInsertForm();">Add New Vehicle Service</a>
            </CommandItemTemplate>--%>
            <Columns>

                <telerik:GridTemplateColumn HeaderStyle-Width="50px" FilterControlAltText="Filter column column" ReadOnly="true" HeaderText="No" UniqueName="column" Reorderable="False" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Container.DataSetIndex+1 %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="50px" />
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="ins_id" DataType="System.Int32" FilterControlAltText="Filter ins_id column" HeaderText="Insurance ID" ReadOnly="True" SortExpression="ins_id" UniqueName="ins_id" Display="false">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="cert_no_lnk" FilterControlAltText="" HeaderText="Certificate No." UniqueName="cert_no_lnk" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkCertNo" Font-Underline="true" runat="server" Text='<%# Eval("cert_no") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="cert_no" FilterControlAltText="Filter cert_no column" HeaderText="Certificate No." ReadOnly="True" SortExpression="cert_no" UniqueName="cert_no" Display="false">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="insurance_company" FilterControlAltText="Filter insurance_company column" HeaderText="Company" ReadOnly="True" SortExpression="insurance_company" UniqueName="insurance_company">
                </telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="vid" FilterControlAltText="Filter vid column" HeaderText="VID" ReadOnly="True" SortExpression="vid" UniqueName="vid" DataType="System.Int32" ItemStyle-HorizontalAlign="Center">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="vehicle_name" FilterControlAltText="Filter vehicle_name column" HeaderText="Vehicle Name" ReadOnly="True" SortExpression="vehicle_name" UniqueName="vehicle_name" Display="false">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="viewDetails" FilterControlAltText="" HeaderText="Vehicle" UniqueName="viewDetails">
                    <ItemTemplate>
                         <asp:HyperLink ID="lnk_veh" runat="server" Text='<%# Eval("vehicle_name") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="issue_date" ItemStyle-HorizontalAlign="Center" DataType="System.DateTime" FilterControlAltText="Filter issue_date column" HeaderText="Issue Date" ReadOnly="True" SortExpression="issue_date" UniqueName="issue_date" DataFormatString="{0:yyyy-MM-dd}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="expiry_date" ItemStyle-HorizontalAlign="Center" DataType="System.DateTime" FilterControlAltText="Filter expiry_date column" HeaderText="Expiry Date" ReadOnly="True" SortExpression="expiry_date" UniqueName="expiry_date" DataFormatString="{0:yyyy-MM-dd}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="policy_type_id" FilterControlAltText="Filter policy_type_id column" HeaderText="policy_type_id" ReadOnly="True" SortExpression="policy_type_id" UniqueName="policy_type_id" DataType="System.Int32" Display="false">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="policy_type" FilterControlAltText="Filter policy_type column" HeaderText="Policy Type" ReadOnly="True" SortExpression="policy_type" UniqueName="policy_type">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="sum_insured" FilterControlAltText="Filter sum_insured column" HeaderText="Insured Amount" ReadOnly="True" SortExpression="sum_insured" UniqueName="sum_insured" DataType="System.Double" DataFormatString="{0:n2}" ItemStyle-HorizontalAlign="Right">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="expense" FilterControlAltText="expense" HeaderText="Total Expense" UniqueName="expense" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkExpense" Font-Underline="true" runat="server" Text='<%# Eval("expense") == null ? "No Cost": Eval("expense","{0:n2}")%>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <%--    <telerik:GridBoundColumn DataField="expense" FilterControlAltText="Filter expense column" HeaderText="Total Expense" ReadOnly="True" SortExpression="expense" UniqueName="expense" DataType="System.Double"  DataFormatString="{0:n2}">
                </telerik:GridBoundColumn>--%>
                <%--           <telerik:GridBoundColumn DataField="takaful_contribution" FilterControlAltText="Filter takaful_contribution column" HeaderText="Takaful Contribution" ReadOnly="True" SortExpression="takaful_contribution" UniqueName="takaful_contribution" DataType="System.Double"  DataFormatString="{0:n2}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ncd" FilterControlAltText="Filter ncd column" HeaderText="NCD" ReadOnly="True" SortExpression="ncd" UniqueName="ncd" DataType="System.Double">
                </telerik:GridBoundColumn>--%>
                <telerik:GridBoundColumn DataField="usr_id" DataType="System.Int32" FilterControlAltText="Filter usr_id column" HeaderText="usr_id" ReadOnly="True" SortExpression="usr_id" UniqueName="usr_id" Display="false">
                </telerik:GridBoundColumn>
                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ImageUrl="~/Design/icon_images/delete.png"
                    ConfirmText="Are you sure you want to delete this record?" />
            </Columns>

            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>
    <asp:LinqDataSource ID="ling_insurance_master" runat="server" EnableDelete="true" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" Select="new (ins_id, insurance_company, cert_no, vid, vehicle_name, issue_date, expiry_date, policy_type_id, policy_type, sum_insured, takaful_contribution, ncd, usr_id)" TableName="vw_vehicle_insurances">
    </asp:LinqDataSource>

</asp:Content>
