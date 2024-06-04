<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vehicles_Master.aspx.cs" Inherits="FMS.Source.Admin.VehiclesMaster" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .tooltip {
            border: none;
            vertical-align: top;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowEditForm(id) {
                window.radopen("/Source/Details/DETVehicle.aspx?id=" + id, "vhcDialog");
                return false;
            }

            function ShowTrackingForm(id) {
                window.radopen("/Source/Details/DETTracking.aspx?vid=" + id, "vhcTrackerDialog");
                return false;
            }

            function ShowExpenseForm(ref_id, type_id, exp_id) {
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
                    <telerik:AjaxUpdatedControl ControlID="RADVehicles" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RADVehicles">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RADVehicles" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="vhcDialog" OnClientClose="refreshGrid" runat="server" Title="Vehicle" Height="600px"
                Width="350px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="vhcTrackerDialog" OnClientClose="refreshGrid" runat="server" Title="Vehicle Current Position"
                Height="546"
                Width="693" ReloadOnShow="true" ShowContentDuringLoad="false"
                Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="exp_dialog" OnClientClose="refreshGrid" runat="server" Height="500"
                Width="400" ReloadOnShow="true" ShowContentDuringLoad="false" Title="Expense"
                Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>


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
            <%-- <td>
                <telerik:RadButton
                    ID="btnAdd"
                    runat="server"
                    Text="Add new record"
                    OnClientClicked="ShowEditForm"
                    AutoPostBack="false">
                </telerik:RadButton>
            </td>--%>
        </tr>
    </table>

    <telerik:RadGrid ID="RADVehicles" runat="server" PageSize="10" Width="100%"
        OnNeedDataSource="RADVehicles_NeedDataSource"
        OnItemCreated="RADVehicles_ItemCreated"
        OnPreRender="RADVehicles_PreRender"
        OnItemCommand="RADVehicles_ItemCommand"
        AllowPaging="True" CellSpacing="0" GridLines="None" MasterTableView-AllowSorting="true">
        <MasterTableView AutoGenerateColumns="False" DataKeyNames="vid" AllowSorting="True">
            <HeaderStyle HorizontalAlign="Center" />
            <%--<CommandItemSettings AddNewRecordText="Add new Vehicle Service"></CommandItemSettings>--%>
            <CommandItemSettings ShowExportToExcelButton="true" ShowExportToPdfButton="true"
                ExportToExcelText="Export to Excel" ExportToExcelImageUrl="../../Design/export_images/Excel 48.png"
                ExportToPdfText="Export to PDF" ExportToPdfImageUrl="../../Design/export_images/Acrobat 48.png" />



            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column"></RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column"></ExpandCollapseColumn>



            <Columns>
                <telerik:GridTemplateColumn HeaderStyle-Width="50px" FilterControlAltText="Filter column column" ReadOnly="true" HeaderText="No" UniqueName="column" Reorderable="False" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Container.DataSetIndex+1 %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="50px" />

                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="image" FilterControlAltText="Filter column column" HeaderText="Photo" UniqueName="column" Display="false">
                    <ItemTemplate>
                        <asp:Image ID="imgVehicle" ImageUrl='<%# "~/Source/Details/ImageHandler.ashx?type=vehicle&id=" + Eval("vid") %>' runat="server" Width="116" Height="70" />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn DataField="viewDetails" FilterControlAltText="" HeaderText="Vehicle" UniqueName="viewDetails">
                    <ItemTemplate>
                        <asp:HyperLink ID="EditLink" runat="server" Text='<%# Eval("vehicle_name") %>'></asp:HyperLink>
                        <telerik:RadToolTip ID="toolName" runat="server" AutoCloseDelay="10000000" Skin="Windows7">
                            <table class="tooltip">
                                <tr>
                                    <td>VID: 
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxVID1" runat="server"
                                                Text='<%#Bind("vid") %>'>
                                            </asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Vehicle:
                                    </td>
                                    <td>

                                        <strong>
                                            <asp:Label ID="tbxVehicleName1"
                                                runat="server" Text='<%#Bind("vehicle_name") %>'>
                                            </asp:Label>
                                        </strong></td>
                                </tr>
                                <tr>
                                    <td>Manufacturer:
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxManufacturer1" runat="server" Text='<%#Bind("manufacturer") %>'></asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Model:
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxMode1l" runat="server" Text='<%#Bind("vhc_model") %>'></asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Year:
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxYearMake1" runat="server" Type="Number" InputType="Number" Text='<%#Bind("year_make") %>' MaxLength="4">                                            
                                            </asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Type:
                                    </td>
                                    <td>

                                        <strong>
                                            <asp:Label ID="tbxType1" runat="server" Text='<%#Bind("body_type") %>'></asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Color:
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxColor1" runat="server" Text='<%#Bind("color") %>'></asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Volume (cc):
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxVolume1" runat="server" Type="Number" Text='<%#Bind("cc") %>'>                                            
                                            </asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Engine No.:
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxEngineNo1" runat="server" Text='<%#Bind("engine_no") %>'></asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Chasis No.:
                                 
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxChasisNo1" runat="server" Text='<%#Bind("chasis_no") %>'></asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Gross Weight (kg):
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxGrossWeight1" runat="server" Type="Number" Text='<%#Bind("gross_wt") %>'></asp:Label>
                                        </strong>

                                    </td>
                                </tr>
                                <tr>
                                    <td>Body Weight (kg):
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxBodyWeight1" runat="server" Type="Number" Text='<%#Bind("body_wt") %>'></asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Chasis Weight (kg):
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxChasisWeight1" runat="server" Type="Number" Text='<%#Bind("chasis_wt") %>'></asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Reg. Expiry:
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label runat="server" ID="rdpRegDate1" Text='<%#Bind("registration_expiry_date","{0:MM-dd-yyyy}") %>'>
                                            </asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Reg. No.:
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxRegistrationNo1" runat="server" Text='<%#Bind("registration_no") %>'></asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Seating Cap.:
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxSeatNo1" runat="server" Type="Number" Text='<%#Bind("seating_no") %>' MaxLength="2">                                            
                                            </asp:Label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Remarks:
                                    </td>
                                    <td>
                                        <strong>
                                            <asp:Label ID="tbxRemarks1" runat="server" Text='<%#Bind("remarks") %>' TextMode="MultiLine" Height="75px" Width="250px"></asp:Label>

                                        </strong>
                                    </td>
                                </tr>
                            </table>
                        </telerik:RadToolTip>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderStyle-Width="50px" DataField="viewMap" FilterControlAltText="" HeaderText="VID" UniqueName="viewMap" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:HyperLink ID="TrackLink" runat="server" Text='<%# Eval("vid") %>'></asp:HyperLink>
                    </ItemTemplate>

                    <HeaderStyle Width="50px"></HeaderStyle>

                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="manufacturer" FilterControlAltText="Filter manufacturer column" HeaderText="Manufacturer" SortExpression="manufacturer" UniqueName="manufacturer">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="vhc_model" FilterControlAltText="Filter vhc_model column" HeaderText="Model" SortExpression="vhc_model" UniqueName="vhc_model">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="year_make" DataType="System.Int32" FilterControlAltText="Filter year_make column" HeaderText="Year" SortExpression="year_make" UniqueName="year_make" ItemStyle-HorizontalAlign="Center">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="body_type" FilterControlAltText="Filter body_type column" HeaderText="Type" SortExpression="body_type" UniqueName="body_type">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="color" FilterControlAltText="Filter color column" HeaderText="Color" SortExpression="color" UniqueName="color">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="cc" DataType="System.Double" DataFormatString="{0:n0}" ItemStyle-HorizontalAlign="Right" FilterControlAltText="Filter cc column" HeaderText="Volume (cc)" SortExpression="cc" UniqueName="cc">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="engine_no" FilterControlAltText="Filter engine_no column" HeaderText="Engine No." SortExpression="engine_no" UniqueName="engine_no" ItemStyle-HorizontalAlign="Center">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="chasis_no" FilterControlAltText="Filter chasis_no column" HeaderText="Chasis No." SortExpression="chasis_no" UniqueName="chasis_no" ItemStyle-HorizontalAlign="Center">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="chasis_wt" DataType="System.Int32" DataFormatString="{0:n0}" ItemStyle-HorizontalAlign="Right" FilterControlAltText="Filter chasis_wt column" HeaderText="Chasis wt. (kg)" SortExpression="chasis_wt" UniqueName="chasis_wt">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="body_wt" DataType="System.Int32" DataFormatString="{0:n0}" ItemStyle-HorizontalAlign="Right" FilterControlAltText="Filter body_wt column" HeaderText="Body wt. (kg)" SortExpression="body_wt" UniqueName="body_wt">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="gross_wt" DataType="System.Int32" DataFormatString="{0:n0}" ItemStyle-HorizontalAlign="Right" FilterControlAltText="Filter gross_wt column"
                    HeaderText="Gross wt. (kg)" SortExpression="gross_wt" UniqueName="gross_wt">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="registration_expiry_date" DataFormatString="{0: yyyy-MM-dd}" DataType="System.DateTime"
                    FilterControlAltText="Filter registration_expiry_date column" HeaderText="Reg. Expiry" SortExpression="registration_expiry_date" UniqueName="registration_expiry_date">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="registration_no" FilterControlAltText="Filter registration_no column" HeaderText="Reg. No." SortExpression="registration_no" UniqueName="registration_no" ItemStyle-HorizontalAlign="Center">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="seating_no" DataType="System.Int32" FilterControlAltText="Filter seating_no column" HeaderText="Seating Cap." SortExpression="seating_no" UniqueName="seating_no" ItemStyle-HorizontalAlign="Right">
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="remarks" FilterControlAltText="Filter remarks column" HeaderText="Remarks" SortExpression="remarks" UniqueName="remarks" Display="false">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn FilterControlAltText="Filter remark_elipse column" ReadOnly="true" UniqueName="remark_elipse" Reorderable="False" HeaderText="Remarks" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lbl_remarks" runat="server" Text='<%# Eval("remarks").ToString().Trim() != string.Empty ? (Eval("remarks").ToString().Length > 5 ? Eval("remarks").ToString().Substring(0, 5) + "..." : Eval("remarks")) : Eval("remarks")%>' />
                        <telerik:RadToolTip ID="tipRemarks" runat="server" TargetControlID="lbl_remarks" Skin="Metro" Text='<%#Eval("remarks")%>'>
                        </telerik:RadToolTip>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="bluecard" FilterControlAltText="Filter bluecard column" HeaderText="Bluecard" SortExpression="bluecard" UniqueName="bluecard" Display="false">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ins_id" DataType="System.Int32" FilterControlAltText="Filter ins_id column" Visible="false" HeaderText="ins_id" SortExpression="ins_id" UniqueName="ins_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="road_tax" DataType="System.Double" DataFormatString="{0:n0}" ItemStyle-HorizontalAlign="Right" FilterControlAltText="Filter road_tax column" HeaderText="Road Tax" SortExpression="road_tax" UniqueName="road_tax" Display="false">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </telerik:GridBoundColumn>
                <telerik:GridCheckBoxColumn DataField="active" DataType="System.Boolean" FilterControlAltText="Filter active column" Visible="false" HeaderText="active" SortExpression="active" UniqueName="active">
                </telerik:GridCheckBoxColumn>
                <telerik:GridBoundColumn DataField="group_code" DataType="System.Int32" FilterControlAltText="Filter group_code column" Visible="false" HeaderText="group_code" SortExpression="group_code" UniqueName="group_code">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn DataField="expense" FilterControlAltText="expense" HeaderText="Total Expense" UniqueName="expense" ItemStyle-HorizontalAlign="Right">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkExpense" Font-Underline="true" runat="server" Text='<%# Eval("expense") == null ? "No Cost": Eval("expense","{0:n2}")%>'></asp:HyperLink>
                    </ItemTemplate>

                    <ItemStyle HorizontalAlign="Right"></ItemStyle>

                </telerik:GridTemplateColumn>
            </Columns>
            <EditFormSettings EditFormType="Template">
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                <FormTemplate>
                </FormTemplate>
            </EditFormSettings>
        </MasterTableView>
        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>
    <%--<asp:Table ID="Table1" runat="server" HorizontalAlign="Center">
        <asp:TableRow>
            <asp:TableCell>
            </asp:TableCell>

        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell></asp:TableCell>
        </asp:TableRow>

    </asp:Table>--%>
</asp:Content>
