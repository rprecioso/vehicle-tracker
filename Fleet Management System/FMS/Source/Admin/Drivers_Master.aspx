<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Drivers_Master.aspx.cs" Inherits="FMS.Source.Admin.DriversMaster" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowEditForm(id) {
                window.radopen("/Source/Details/DETDriver.aspx?id=" + id, "drvDialog");
                return false;
            }

            function ShowInsertForm(id) {
                window.radopen("/Source/Details/DETDriver.aspx", "drvDialog");
                return false;
            }

            function ShowExpenseForm(ref_id, type_id, exp_id) {
                //alert(exp_id);
                if (exp_id === "M") {
                    window.radopen("/Source/Details/DETExpenseSummary.aspx?type_id=" + type_id + "&ref_id=" + ref_id, "exp_dialog");
                }
                else {
                    window.radopen("/Source/Details/DETExpense.aspx?type_id=" + type_id + "&ref_id=" + ref_id + "&exp_id=" + exp_id, "exp_dialog");
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
        </script>

    </telerik:RadCodeBlock>
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RADDriver" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RADDriver">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RADDriver" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="drvDialog" runat="server" Title="Driver" Height="600px"
                Width="420px" ReloadOnShow="true" OnClientClose="refreshGrid" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="exp_dialog" OnClientClose="refreshGrid" runat="server" Height="500"
                Width="400" ReloadOnShow="true" ShowContentDuringLoad="false" Title="Expense"
                Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>

    </telerik:RadWindowManager>

    <%--<asp:Table ID="Table1" runat="server" HorizontalAlign="Center">
        <asp:TableHeaderRow>
            <asp:TableCell>
                </asp:TableCell>
        </asp:TableHeaderRow>
        <asp:TableRow>
            <asp:TableCell>
                </asp:TableCell>
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

    <telerik:RadGrid ID="RADDriver" runat="server" PageSize="10" 
        OnItemCommand="RADDriver_ItemCommand"
        OnNeedDataSource="RADDriver_NeedDataSource"
        OnItemCreated="RADDriver_ItemCreated" CellSpacing="0" GridLines="None" AllowPaging="true">

        <ExportSettings ExportOnlyData="true" FileName="Services List" IgnorePaging="true" OpenInNewWindow="true"
            Pdf-PageTitle="Services List" Pdf-PageHeight="210mm" Pdf-PageWidth="297mm">
            <Pdf PageTitle="Services List" PageWidth="297mm" PageHeight="210mm"></Pdf>
        </ExportSettings>

        <MasterTableView AutoGenerateColumns="False" DataKeyNames="drv_id" CommandItemDisplay="Top" InsertItemDisplay="Top">
            <HeaderStyle HorizontalAlign="Center" />
            <CommandItemSettings ExportToPdfText="Export to PDF" ShowAddNewRecordButton="false"></CommandItemSettings>

            <%--<CommandItemSettings AddNewRecordText="Add new Vehicle Service"></CommandItemSettings>
            <CommandItemSettings ShowExportToExcelButton="true" ShowExportToPdfButton="true"
                ExportToExcelText="Export to Excel" ExportToExcelImageUrl="../../Design/export_images/Excel 48.png"
                ExportToPdfText="Export to PDF" ExportToPdfImageUrl="../../Design/export_images/Acrobat 48.png" />--%>

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>

            <%--<CommandItemTemplate>
                            <a href="#" onclick="return ShowInsertForm();">Add New Driver</a>
                        </CommandItemTemplate>--%>

            <Columns>
                <telerik:GridTemplateColumn HeaderStyle-Width="50px" FilterControlAltText="Filter column column" ReadOnly="true" HeaderText="No" UniqueName="column" Reorderable="False" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Container.DataSetIndex+1 %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="50px" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="image" FilterControlAltText="Filter column column" HeaderText="Photo" UniqueName="column" Display="false">
                    <ItemTemplate>
                        <asp:Image ID="imgVehicle" ImageUrl='<%# "~/Source/Details/ImageHandler.ashx?type=driver&id=" + Eval("drv_id") %>' runat="server" Width="50" Height="50" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="emp_id" FilterControlAltText="Filter emp_id column" HeaderText="Employee ID" SortExpression="emp_id" UniqueName="emp_id"  ItemStyle-HorizontalAlign="Center">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="viewDetails" FilterControlAltText="" HeaderText="Driver" UniqueName="viewDetails">
                    <ItemTemplate>
                        <asp:HyperLink ID="EditLink" runat="server" Text='<%# Eval("first_name") + " " + Eval("last_name") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="mobile_no" FilterControlAltText="Filter mobile_no column" HeaderText="Mobile No." SortExpression="mobile_no" UniqueName="mobile_no" ItemStyle-HorizontalAlign="Center">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="phone_no" FilterControlAltText="Filter phone_no column" HeaderText="Phone No." SortExpression="phone_no" UniqueName="phone_no" ItemStyle-HorizontalAlign="Center">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="home_address" FilterControlAltText="Filter home_address column" HeaderText="Address" SortExpression="home_address" UniqueName="home_address" Display="false">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn FilterControlAltText="Filter address_elipse column" ReadOnly="true" UniqueName="address_elipse" Reorderable="False" HeaderText="Address" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lbl_address" runat="server" Text='<%# Eval("home_address").ToString().Length > 5 ? Eval("home_address").ToString().Substring(0, 5) + "..." : Eval("home_address")%>' />
                        <telerik:RadToolTip ID="tipRemarks" runat="server" TargetControlID="lbl_address" Skin="Metro" Text='<%#Eval("home_address")%>'>
                        </telerik:RadToolTip>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="birth_date" ItemStyle-HorizontalAlign="Center" DataType="System.DateTime" FilterControlAltText="Filter birth_date column" HeaderText="Birth Date" ReadOnly="True" SortExpression="birth_date" UniqueName="birth_date" DataFormatString="{0:yyyy-MM-dd}">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="gov_id" FilterControlAltText="Filter gov_id column" HeaderText="ID Type" SortExpression="gov_id" UniqueName="gov_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="gov_id_no" FilterControlAltText="Filter gov_id_no column" HeaderText="ID No." SortExpression="gov_id_no" UniqueName="gov_id_no" ItemStyle-HorizontalAlign="Center">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="emp_status" FilterControlAltText="Filter emp_status column" HeaderText="Status" SortExpression="emp_status" UniqueName="emp_status">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="emp_description" FilterControlAltText="Filter emp_description column" HeaderText="Employee description" Visible="false" SortExpression="emp_description" UniqueName="emp_description">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="license_type" FilterControlAltText="Filter license_type column" HeaderText="License Type" SortExpression="license_type" UniqueName="license_type">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="license_no" FilterControlAltText="Filter license_no column" HeaderText="License No." SortExpression="license_no" UniqueName="license_no" ItemStyle-HorizontalAlign="Center">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="license_expiry_date" ItemStyle-HorizontalAlign="Center" DataType="System.DateTime" FilterControlAltText="Filter license_expiry_date column" DataFormatString="{0:yyyy-MM-dd}" HeaderText="License Exp." SortExpression="license_expiry_date" UniqueName="license_expiry_date">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="license_description" FilterControlAltText="Filter license_description column" HeaderText="License description" Visible="false" SortExpression="license_description" UniqueName="license_description">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="salary_type" FilterControlAltText="Filter salary_type column" HeaderText="Salary type" SortExpression="salary_type" UniqueName="salary_type">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="salary" FilterControlAltText="Filter salary column" HeaderText="Salary" SortExpression="salar" UniqueName="salary" DataFormatString="{0:n2}"  ItemStyle-HorizontalAlign="Right">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="salary_description" FilterControlAltText="Filter salary_description column" HeaderText="Salary description" Visible="false" SortExpression="salary_description" UniqueName="salary_description">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="hire_date" ItemStyle-HorizontalAlign="Center" DataType="System.DateTime" FilterControlAltText="Filter hire_date column" HeaderText="Hire Date" ReadOnly="True" SortExpression="hire_date" UniqueName="hire_date" DataFormatString="{0:yyyy-MM-dd}">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="expense" FilterControlAltText="expense" HeaderText="Total Expense" UniqueName="expense" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkExpense" Font-Underline="true" runat="server" Text='<%# Eval("expense") == null ? "No Cost": Eval("expense","{0:n2}")%>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="drv_id" DataType="System.Int32" FilterControlAltText="Filter drv_id column" HeaderText="drv_id" Visible="false" SortExpression="drv_id" UniqueName="drv_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="sal_id" DataType="System.Int32" FilterControlAltText="Filter sal_id column" HeaderText="sal_id" Visible="false" SortExpression="sal_id" UniqueName="sal_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="emp_sta_id" DataType="System.Int32" FilterControlAltText="Filter emp_sta_id column" HeaderText="emp_sta_id" Visible="false" SortExpression="emp_sta_id" UniqueName="emp_sta_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="drv_lic_id" DataType="System.Int32" FilterControlAltText="Filter drv_lic_id column" HeaderText="drv_lic_id" Visible="false" SortExpression="drv_lic_id" UniqueName="drv_lic_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="usr_id" DataType="System.Int32" FilterControlAltText="Filter usr_id column" HeaderText="usr_id" Visible="false" SortExpression="usr_id" UniqueName="usr_id">
                </telerik:GridBoundColumn>
                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ImageUrl="~/Design/icon_images/delete.png" 
                    ConfirmText="Are you sure you want to delete this record?"/>
             </Columns>
            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>



</asp:Content>
