<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Expenses_Master.aspx.cs" Inherits="FMS.Source.Admin.Expenses_Master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowEditForm(id, ref_id, type_id) {
                window.radopen("/Source/Details/DETExpense.aspx?exp_id=" + id + "&ref_id=" + ref_id + "&type_id=" + type_id, "exp_dialog");
                return false;
            }

            function ShowInsertForm() {
                window.radopen("/Source/Details/DETExpense.aspx?exp_id=0", "exp_dialog");
                return false;
            }

            function ShowReferenceForm(url, id) {
                window.radopen(url + "?id=" + id + "&mode=view", "exp_dialog");
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
                    <telerik:AjaxUpdatedControl ControlID="RADExpense" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="RADExpense">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RADExpense" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="exp_dialog" runat="server" OnClientClose="refreshGrid" Height="600px"
                Width="450px" ReloadOnShow="true" ShowContentDuringLoad="false" Title="Expense"
                Modal="true" VisibleStatusbar="false">
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



    <telerik:RadGrid
        OnNeedDataSource="RADExpense_NeedDataSource" OnItemCommand="RADExpense_ItemCommand"
        OnItemCreated="RADExpense_ItemCreated" Width="100%" AllowPaging="true"
        ID="RADExpense" runat="server" PageSize="10" >
        <MasterTableView AutoGenerateColumns="False" DataKeyNames="exp_id,ref_id,type_id" CommandItemDisplay="None" InsertItemDisplay="Top">
            <HeaderStyle HorizontalAlign="Center" />
            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

            <%--<CommandItemTemplate>
                <a href="#" onclick="return ShowInsertForm();">Add New Expense</a>
            </CommandItemTemplate>--%>
            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>

            <Columns>
                <telerik:GridTemplateColumn HeaderStyle-Width="50px" FilterControlAltText="Filter column column" ReadOnly="true" HeaderText="No" UniqueName="column" Reorderable="False">
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Container.DataSetIndex+1 %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="50px" />
                                        </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="exp_id" FilterControlAltText="" HeaderText="ID" UniqueName="exp_id">
                    <ItemTemplate>
                        <asp:HyperLink ID="ExpenseLink" runat="server" Text='<%# Eval("exp_id") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="type" DataType="System.DateTime" FilterControlAltText="Filter date column" HeaderText="Type" SortExpression="date" UniqueName="date">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="deep_type" FilterControlAltText="Filter deep_type column" HeaderText="Sub type" SortExpression="deep_type" UniqueName="deep_type">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="vendor" FilterControlAltText="Filter vendor column" HeaderText="Vendor" SortExpression="vendor" UniqueName="vendor">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="ref_id" FilterControlAltText="" HeaderText="Reference Name" UniqueName="ref_id" Display="false">
                    <ItemTemplate>
                        <asp:HyperLink ID="ReferenceLink1" runat="server" Text='<%# Eval("ref_id") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="item" FilterControlAltText="" HeaderText="Item Name" UniqueName="item">
                    <ItemTemplate>
                        <asp:HyperLink ID="ReferenceLink" runat="server" Text='<%# Eval("item") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="date" DataType="System.DateTime" FilterControlAltText="Filter date column" DataFormatString="{0:yyyy-MM-dd}" HeaderText="Date" SortExpression="date" UniqueName="date">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="cost" DataType="System.Double" FilterControlAltText="Filter cost column" HeaderText="Cost" SortExpression="cost" DataFormatString="{0:n2}" UniqueName="cost">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="method" FilterControlAltText="Filter method column" HeaderText="Payment method" SortExpression="method" UniqueName="method">
                </telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="type_id" DataType="System.Int32" FilterControlAltText="Filter type column" Visible="false" HeaderText="type" SortExpression="type" UniqueName="type">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="description" FilterControlAltText="Filter description column" HeaderText="Description" SortExpression="description" UniqueName="description">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="remarks" FilterControlAltText="Filter remarks column" HeaderText="Remarks" SortExpression="remarks" UniqueName="remarks">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="user_id" DataType="System.Int32" FilterControlAltText="Filter user_id column" Display="false" HeaderText="user_id" SortExpression="user_id" UniqueName="user_id">
                </telerik:GridBoundColumn>
                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ImageUrl="~/Design/icon_images/delete.png" 
                    ConfirmText="Are you sure you want to delete this record?" HeaderStyle-Width="50px"/>
            </Columns>

            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>


    <asp:LinqDataSource ID="linq_expense" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_user_expenses" Where="user_id == @user_id &amp;&amp; exp_id == @exp_id">
        <WhereParameters>
            <asp:SessionParameter Name="user_id" SessionField="parent_id" Type="Int32" />
            <asp:QueryStringParameter Name="exp_id" QueryStringField="exp_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="linq_exp_type" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="refEXPTypes"></asp:LinqDataSource>

</asp:Content>
