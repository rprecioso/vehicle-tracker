<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Violations_Master.aspx.cs" Inherits="FMS.Source.Child.Violations" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowEditForm(id) {

                window.radopen("/Source/Details/DETViolation.aspx?id=" + id, "vioDetailDialog");
                return false;
            }
            function ShowInsertForm() {
                window.radopen("/Source/Details/DETViolation.aspx?", "vioDetailDialog");
                return false;
            }

            function ShowExpenseForm(exp_id, ref_id, type_id) {
                window.radopen("/Source/Details/DETExpense.aspx?type_id=" + type_id + "&ref_id=" + ref_id + "&exp_id=" + exp_id, "vhc_srv_dialog");
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
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDRVViolation" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadDRVViolation">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDRVViolation" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadDRVViolation">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDRVViolation" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="vioDetailDialog" runat="server" OnClientClose="refreshGrid" Title="Violation" Height="600px"
                Width="320px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="vhcDialog" runat="server" OnClientClose="refreshGrid" Title="Vehicle" Height="600px"
                Width="420px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="vhc_srv_dialog" runat="server" OnClientClose="refreshGrid" Title="Expense" Height="500px"
                Width="380px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
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

    <telerik:RadGrid ID="RadDRVViolation" Width="100%" AllowPaging="true"
        OnItemCommand="RadDRVViolation_ItemCommand"
        OnNeedDataSource="RadDRVViolation_NeedDataSource"
        OnItemDataBound="RadDRVViolation_ItemDataBound"
        OnItemCreated="RadDRVViolation_ItemCreated" runat="server" PageSize="10"  CellSpacing="0" GridLines="None">
        <MasterTableView AutoGenerateColumns="False" DataKeyNames="drv_vio_id" CommandItemDisplay="None">
            <CommandItemSettings AddNewRecordText="Add new Violation" ExportToPdfText="Export to PDF"></CommandItemSettings>
            <HeaderStyle HorizontalAlign="Center" />
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
                <telerik:GridTemplateColumn DataField="viewDetails" FilterControlAltText="" HeaderText="Ticket No." UniqueName="viewDetails" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:HyperLink ID="EditLink" runat="server" Text='<%# Eval("violation_ticket_no") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="drv_vio_id" DataType="System.Int32" Visible="false" FilterControlAltText="Filter drv_vio_id column" HeaderText="drv_vio_id" SortExpression="drv_vio_id" UniqueName="drv_vio_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="date" DataType="System.DateTime" FilterControlAltText="Filter date column" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="date" UniqueName="date">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="violation" FilterControlAltText="Filter violation column" HeaderText="Violation" SortExpression="violation" UniqueName="violation">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="location" FilterControlAltText="Filter location column" HeaderText="Location" SortExpression="location" UniqueName="location">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="Driver" FilterControlAltText="Filter Driver column" HeaderText="Driver" SortExpression="Driver" UniqueName="Driver">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="vehicle_name" FilterControlAltText="" HeaderText="Vehicle" UniqueName="vehicle_name">
                    <ItemTemplate>
                        <asp:HyperLink ID="VehicleLink" Font-Underline="true" runat="server" Text='<%# Eval("vehicle_name") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="remarks" FilterControlAltText="Filter remarks column" HeaderText="Remarks" SortExpression="remarks" UniqueName="remarks" Display="false">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn FilterControlAltText="Filter remark_elipse column" ReadOnly="true" UniqueName="remark_elipse" Reorderable="False" HeaderText="Remarks" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lbl_remarks" runat="server" Text='<%#Eval("remarks").ToString().Trim() != string.Empty ? (Eval("remarks").ToString().Length > 5 ? Eval("remarks").ToString().Substring(0, 5) + "..." : Eval("remarks")) : Eval("remarks")%>' />
                        <telerik:RadToolTip ID="tipRemarks" runat="server" TargetControlID="lbl_remarks" Skin="Metro" Text='<%#Eval("remarks")%>'>
                        </telerik:RadToolTip>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="drv_id" DataType="System.Int32" FilterControlAltText="Filter drv_id column" Visible="false" HeaderText="drv_id" SortExpression="drv_id" UniqueName="drv_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="vid" DataType="System.Int32" FilterControlAltText="Filter vid column" Visible="false" HeaderText="VID" SortExpression="vid" UniqueName="vid">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="usr_id" DataType="System.Int32" FilterControlAltText="Filter usr_id column" Visible="false" HeaderText="usr_id" SortExpression="usr_id" UniqueName="usr_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="vio_id" DataType="System.Int32" FilterControlAltText="Filter vio_id column" Visible="false" HeaderText="vio_id" SortExpression="vio_id" UniqueName="vio_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="exp_id" DataType="System.Int32" FilterControlAltText="Filter exp_id column" Visible="false" Display="false" HeaderText="exp_id" SortExpression="exp_id" UniqueName="exp_id">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="cost" FilterControlAltText="Filter cost column" HeaderText="Cost" UniqueName="cost" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <asp:HyperLink Font-Underline="true" ID="ExpenseLink" runat="server" Text='<%# Eval("cost") == null ? "No Cost": Eval("cost","{0:n0}") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ImageUrl="~/Design/icon_images/delete.png"
                    ConfirmText="Are you sure you want to delete this record?" />
            </Columns>
            <%--<CommandItemTemplate>
                            <a href="#" onclick="return ShowInsertForm();">Add New Record</a>
                        </CommandItemTemplate>--%>

            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>



</asp:Content>
