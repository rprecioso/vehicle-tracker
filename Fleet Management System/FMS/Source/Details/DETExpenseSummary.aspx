<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DETExpenseSummary.aspx.cs" Inherits="FMS.Source.Details.DETExpenseSummary" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowExpenseForm(exp_id) {
                window.open("/Source/Admin/Expenses_Master.aspx?exp_id=" + exp_id, "_blank");
                return false;
            }
        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
            <telerik:RadGrid ID="RADExpenseSum" runat="server" ShowFooter="true"
                 OnItemCreated="RADExpenseSum_ItemCreated"
                 DataSourceID="linq_expense">
                <MasterTableView AutoGenerateColumns="False" DataKeyNames="exp_id" DataSourceID="linq_expense">
                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>

                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>

                    <Columns>
                        <telerik:GridBoundColumn DataField="vendor" FilterControlAltText="Filter vendor column" HeaderText="Vendor" ReadOnly="True" SortExpression="vendor" UniqueName="vendor">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="type" Visible="false" FilterControlAltText="Filter type column" HeaderText="Type" ReadOnly="True" SortExpression="type" UniqueName="type">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="deep_type"  FilterControlAltText="Filter deep_type column" HeaderText="Type" ReadOnly="True" SortExpression="deep_type" UniqueName="deep_type">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="date" DataType="System.DateTime" DataFormatString="{0:yyyy/MM/dd}" FilterControlAltText="Filter date column" HeaderText="Date" ReadOnly="True" SortExpression="date" UniqueName="date">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="method" Visible="false" FilterControlAltText="Filter method column" HeaderText="method" ReadOnly="True" SortExpression="method" UniqueName="method">
                        </telerik:GridBoundColumn>               
                        <telerik:GridTemplateColumn FooterAggregateFormatString="{0:N2}" FooterStyle-ForeColor="Red" Aggregate="Sum" HeaderStyle-Width="50px" DataField="cost" FilterControlAltText="" HeaderText="Cost" UniqueName="cost">
                            <ItemTemplate>                             
                                <asp:HyperLink ID="CostLink" runat="server" Text='<%# Eval("cost","{0:N2}") %>'></asp:HyperLink>
                            </ItemTemplate>

                        </telerik:GridTemplateColumn>
                    </Columns>

                    <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                    </EditFormSettings>
                </MasterTableView>

                <FilterMenu EnableImageSprites="False"></FilterMenu>
            </telerik:RadGrid>
            <asp:LinqDataSource ID="linq_expense" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" Select="new (exp_id,vendor, type, deep_type, date, method, cost)" TableName="vw_user_expenses" Where="user_id == @user_id &amp;&amp; ref_id == @ref_id &amp;&amp; type_id == @type_id">
                <WhereParameters>
                    <asp:SessionParameter Name="user_id" SessionField="parent_id" Type="Int32" />
                    <asp:QueryStringParameter Name="ref_id" QueryStringField="ref_id" Type="Int32" />
                    <asp:QueryStringParameter Name="type_id" QueryStringField="type_id" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>
        </div>
    </form>
</body>
</html>
