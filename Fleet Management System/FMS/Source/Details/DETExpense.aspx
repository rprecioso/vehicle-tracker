<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DETExpense.aspx.cs" Inherits="FMS.Source.Details.DETExpense" %>

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

        function ShowFindForm() {
            window.radopen("/Source/Details/DETViolationList.aspx", "exp_dialog");
            return false;
        }
    </script>
</head>
<body>

    <form id="form1" runat="server">

        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow ID="exp_dialog" runat="server" Title="Edit Service" Height="500"
                    Width="400" ReloadOnShow="true" ShowContentDuringLoad="true"
                    Modal="true">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
        <div>

            <asp:FormView
                OnItemCommand="DETExpenses_ItemCommand"
                OnItemUpdated="DETExpenses_ItemUpdated"
                OnItemUpdating="DETExpenses_ItemUpdating"
                OnItemInserted="DETExpenses_ItemInserted"
                OnItemInserting="DETExpenses_ItemInserting"
                OnItemCreated="DETExpenses_ItemCreated"
                OnItemDeleted="DETExpenses_ItemDeleted"
                OnItemDeleting="DETExpenses_ItemDeleting"
               DataKeyNames="exp_id"
                OnDataBound="DETExpenses_DataBound" DataSourceID="linq_expense"
                runat="server" ID="DETExpenses"
                EnableModelValidation="True" Width="600px">
                <EditItemTemplate>
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 100px">Date
                            </td>
                            <td>
                                <telerik:RadDatePicker MinDate="1/1/1900" DbSelectedDate='<%# Bind("date") %>' DateInput-DisplayDateFormat="yyyy-MM-dd"
                                    ID="rdpDate" runat="server">
                                    <DateInput ID="DateInput1" runat="server" DateFormat="yyyy-MM-dd"/>
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                        <tr>
                            <td>Cost
                            </td>
                            <td>
                                <telerik:RadNumericTextBox runat="server" ID="tbxCost" Type="Number" Value='<%# Bind("cost") %>'></telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Type
                            </td>
                            <td>
                                <label id="lblType"><%# Eval("type") %></label>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_deep_type" runat="server" AutoPostBack="True" SelectedValue='<%# Bind("deep_type_id") %>' DefaultValue="0" DataSourceID="linq_deep_type" DataTextField="deep_type" DataValueField="exp_deep_type_id">
                                </telerik:RadComboBox>
                                <asp:LinqDataSource ID="linq_deep_type" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="refEXPDeepTypes" Where="exp_type_id == @exp_type_id">
                                    <WhereParameters>
                                        <asp:QueryStringParameter QueryStringField="type_id" Name="exp_type_id" DefaultValue="0" DbType="Int32" />
                                    </WhereParameters>
                                </asp:LinqDataSource>

                            </td>
                        </tr>
                        <tr>
                            <td>Vendor
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_vend" runat="server" DefaultValue="0" SelectedValue='<%# Bind("vend_id") %>' DataSourceID="linq_vendor" DataTextField="vendor" DataValueField="vend_id">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="" Value="" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Payment Method
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_pay_meth" runat="server" SelectedValue='<%# Bind("paymeth_id") %>' DefaultValue="0" DataSourceID="linq_pay_meth" DataTextField="method" DataValueField="paymeth_id">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Reference</td>
                            <td>
                                <asp:DetailsView ID="DetailsView1" Width="200px" runat="server" AutoGenerateRows="False" DataSourceID="linq_ref_table" EnableModelValidation="True" Height="50px">
                                    <Fields>
                                        <%--<asp:BoundField DataField="ref_id" HeaderText="ref_id" SortExpression="ref_id" />--%>
                                        <asp:BoundField DataField="reference" HeaderText="No." SortExpression="reference" />
                                        <asp:BoundField DataField="reference_name" HeaderText="Item" SortExpression="reference_name" />
                                        <%--<asp:BoundField DataField="type_id" HeaderText="type_id" SortExpression="type_id" />--%>
                                        <%--<asp:BoundField DataField="usr_id" HeaderText="usr_id" SortExpression="usr_id" />--%>
                                    </Fields>
                                </asp:DetailsView>
                                <asp:LinqDataSource ID="linq_ref_table" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_user_ref_tables" Where="usr_id == @usr_id &amp;&amp; type_id == @type_id &amp;&amp; ref_id == @ref_id">
                                    <WhereParameters>
                                        <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
                                        <asp:QueryStringParameter DefaultValue="0" Name="ref_id" QueryStringField="ref_id" Type="Int32" />
                                        <asp:QueryStringParameter DefaultValue="0" Name="type_id" QueryStringField="type_id" Type="Int32" />
                                    </WhereParameters>
                                </asp:LinqDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>Description
                            </td>
                            <td>
                                <telerik:RadTextBox ID="tbxDescription" Text='<%# Bind("description") %>' InputType="Text"
                                    TextMode="MultiLine" runat="server">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Remarks
                            </td>
                            <td>
                                <telerik:RadTextBox ID="tbxRemarks" Text='<%# Bind("remarks") %>' InputType="Text"
                                    TextMode="MultiLine" runat="server">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadButton ID="btnUpdate" CommandName="Update"
                                    runat="server" Text="Save">
                                </telerik:RadButton>
                               <%-- <telerik:RadButton ID="btnDelete" CommandName="Delete"
                                    runat="server" Text="Delete">
                                </telerik:RadButton>--%>
                                <telerik:RadButton ID="btnCancel" CommandName="Cancel"
                                    runat="server" Text="Cancel">
                                </telerik:RadButton>

                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadTextBox ID="tbx_ref_id" Visible="false" Text='<%# Bind("ref_id") %>' InputType="Text" runat="server" />
                                <telerik:RadTextBox ID="tbx_exp_id" Visible="false" Text='<%# Bind("exp_id") %>' InputType="Text" runat="server" />
                                <telerik:RadTextBox ID="tbx_user_id" Visible="false" Text='<%# Bind("user_id") %>' InputType="Text" runat="server" />
                                <telerik:RadTextBox ID="tbx_type_id" Visible="false" Text='<%# Bind("type_id") %>' InputType="Text" runat="server" />
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 100px">Date
                            </td>
                            <td>
                                <telerik:RadDatePicker MinDate="1/1/1900" DbSelectedDate='<%# Bind("date") %>' DateInput-DisplayDateFormat="yyyy-MM-dd"
                                    ID="rdpDate" runat="server">
                                    <DateInput ID="DateInput1" runat="server" DateFormat="yyyy-MM-dd"/>
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                        <tr>
                            <td>Cost
                            </td>
                            <td>
                                <telerik:RadNumericTextBox runat="server" ID="tbxCost" Type="Number" Value='<%# Bind("cost") %>'></telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Type
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_type" runat="server" AutoPostBack="true" DefaultValue="0" DataSourceID="linq_exp_type" DataTextField="type" DataValueField="exp_type_id">
                                </telerik:RadComboBox>

                            </td>

                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_deep_type" runat="server" AutoPostBack="True" DefaultValue="0" DataSourceID="linq_deep_type" DataTextField="deep_type" DataValueField="exp_deep_type_id">
                                </telerik:RadComboBox>
                                <asp:LinqDataSource ID="linq_deep_type" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="refEXPDeepTypes" Where="exp_type_id == @exp_type_id">
                                    <WhereParameters>
                                        <asp:ControlParameter ControlID="rcmb_type" Name="exp_type_id" DefaultValue="0" PropertyName="SelectedValue" Type="Int32" />
                                    </WhereParameters>
                                </asp:LinqDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>Reference
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_ref" runat="server" DefaultValue="0" DataSourceID="sql_ref" DataTextField="reference" DataValueField="ref_id">
                                </telerik:RadComboBox>
                                <asp:SqlDataSource ID="sql_ref" runat="server" ConnectionString="Data Source=PHILGPSITSERVER\PHILGPSITSERVER;Initial Catalog=FMS_3;User ID=app_fms;Password=pa$$fms" ProviderName="System.Data.SqlClient" SelectCommand="sp_get_exp_reference" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="user_id" SessionField="parent_id" Type="Int32" />
                                        <asp:ControlParameter ControlID="rcmb_type" Name="type_id" PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>Vendor
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_vend" runat="server" DefaultValue="0" DataSourceID="linq_vendor" DataTextField="vendor" DataValueField="vend_id">
                                    <Items>
                                        <telerik:RadComboBoxItem Text="" Value="" />
                                    </Items>
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Payment Method
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_pay_meth" runat="server" DefaultValue="0" DataSourceID="linq_pay_meth" DataTextField="method" DataValueField="paymeth_id">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Description
                            </td>
                            <td>
                                <telerik:RadTextBox ID="tbxDescription" Text='<%# Bind("description") %>' InputType="Text"
                                    TextMode="MultiLine" runat="server">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Remarks
                            </td>
                            <td>
                                <telerik:RadTextBox ID="tbxRemarks" Text='<%# Bind("remarks") %>' InputType="Text"
                                    TextMode="MultiLine" runat="server">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadButton ID="btnUpdate" CommandName="Add"
                                    runat="server" Text="Save">
                                </telerik:RadButton>
<%--                                <telerik:RadButton ID="btnDelete" CommandName="Delete"
                                    runat="server" Text="Delete">
                                </telerik:RadButton>--%>
                                <telerik:RadButton ID="btnCancel" CommandName="Cancel"
                                    runat="server" Text="Cancel">
                                </telerik:RadButton>

                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadTextBox ID="tbx_ref_id" Visible="false" Text='<%# Bind("ref_id") %>' InputType="Text" runat="server" />
                                <telerik:RadTextBox ID="tbx_exp_id" Visible="false" Text='<%# Bind("exp_id") %>' InputType="Text" runat="server" />
                                <telerik:RadTextBox ID="tbx_user_id" Visible="false" Text='<%# Bind("user_id") %>' InputType="Text" runat="server" />
                                <telerik:RadTextBox ID="tbx_type_id" Visible="false" Text='<%# Bind("type_id") %>' InputType="Text" runat="server" />
                            </td>
                        </tr>
                    </table>
                </InsertItemTemplate>
            </asp:FormView>
            <asp:LinqDataSource ID="linq_expense" runat="server" AutoPage="true" AutoSort="true" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_user_expenses" Where="ref_id == @ref_id &amp;&amp; type_id == @type_id">
                <WhereParameters>
                    <asp:QueryStringParameter DefaultValue="0" Name="ref_id" QueryStringField="ref_id" Type="Int32" />
                    <asp:QueryStringParameter Name="type_id" QueryStringField="type_id" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>
            <asp:LinqDataSource ID="linq_exp_type" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="refEXPTypes" Where="type != @type &amp;&amp; type != @type1">
                <WhereParameters>
                    <asp:Parameter DefaultValue="Service" Name="type" Type="String" />
                    <asp:Parameter DefaultValue="Violation" Name="type1" Type="String" />
                </WhereParameters>
            </asp:LinqDataSource>

            <asp:LinqDataSource ID="linq_pay_meth" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="refPaymentMethods"></asp:LinqDataSource>

            <asp:LinqDataSource ID="linq_vendor" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="tblVendors" Where="user_id == @user_id">
                <WhereParameters>
                    <asp:SessionParameter Name="user_id" SessionField="parent_id" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>

            <asp:LinqDataSource ID="linq_exp_srv" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_vehicle_services" Where="usr_id == @usr_id">
                <WhereParameters>
                    <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>

            <asp:LinqDataSource ID="linq_exp_vio" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_driver_violations" Where="user_id == @user_id">
                <WhereParameters>
                    <asp:SessionParameter Name="user_id" SessionField="parent_id" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>
            <asp:LinqDataSource ID="linq_ref_table" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_user_ref_tables" Where="usr_id == @usr_id &amp;&amp; type_id == @type_id &amp;&amp; ref_id == @ref_id">
                <WhereParameters>
                    <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
                    <asp:QueryStringParameter DefaultValue="0" Name="ref_id" QueryStringField="ref_id" Type="Int32" />
                    <asp:QueryStringParameter DefaultValue="0" Name="type_id" QueryStringField="type_id" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>
            <asp:LinqDataSource ID="linq_exp_ins" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_vehicle_insurances" Where="usr_id == @usr_id">
                <WhereParameters>
                    <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>

        </div>
    </form>
</body>
</html>
