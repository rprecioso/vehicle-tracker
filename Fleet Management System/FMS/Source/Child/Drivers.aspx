<%@ Page Title="" Language="C#" MasterPageFile="/Site.Master" AutoEventWireup="true" CodeBehind="Drivers.aspx.cs" Inherits="FMS.Source.Child.Drivers" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowFlagForm(id, type) {
                window.radopen("/Source/Details/DETFlag.aspx?id=" + id + "&type=" + type, "drvFlagDialog");
                return false;
            }

            function ShowEditFormDriver(id) {
                window.radopen("/Source/Details/DETDriver.aspx?drv_id=" + id, "drvDetailDialog");
                return false;
            }

            function ShowEditFormViolation(id) {
                window.radopen("/Source/Details/DETViolation.aspx?id=" + id, "drvDetailDialog");
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
        <script type="text/javascript">
            //Add a flag which will indicates if the click comes from the ExpandCollapseCommand 
            var ExpandCollapseCommandClicked = false;
            function DockInitialize(dock, args) {
                var titlebarId = dock.get_id() + "_T";
                var titlebar = $get(titlebarId);
                titlebar.onclick = function () {
                    if (ExpandCollapseCommandClicked == false) {
                        dock.set_collapsed(!dock.get_collapsed());
                    }
                    else {
                        ExpandCollapseCommandClicked = false;
                    }
                    return false;
                }
            }
            function dockCommand(dock, args) {
                var commandName = args.Command.get_name();
                if (commandName == "ExpandCollapse") {
                    ExpandCollapseCommandClicked = true;
                }
            }
        </script>

        <script type="text/javascript">
            //function OnKeyPress(sender, args) {
            //    var alpha = /[aábcdeéfghijklmnñoópqrstuúüvwxyzAÁBCDEÉFGHIJKLMNÑOÓPQRSTUÚÜVWXYZ ]/gi;
            //    var c = args.get_keyCode();
            //    var res = String.fromCharCode(c).match(alpha);
            //    if (res === undefined || res === null) {
            //        args.set_cancel(true);
            //    }
            //}
            //Add a flag which will indicates if the click comes from the ExpandCollapseCommand 
        </script>
    </telerik:RadCodeBlock>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDriver" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="DRVDetailsPanel" LoadingPanelID="RadAjaxLoadingPanel1"/>
                    <telerik:AjaxUpdatedControl ControlID="RadViolation" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadDriver">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDriver" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadViolation" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="DRVDetailsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_filter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadDriver" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="DRVDetailsPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="DRVDetailsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadViolation">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadViolation" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
             <telerik:RadWindow ID="drvFlagDialog" runat="server" Title="Reason for Flagging" Height="30px"
                Width="500px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true"  VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="drvDetailDialog" runat="server" Title="Edit Driver" Height="600px"
                Width="320px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
    <table style="width: 100%; vertical-align: top;">
        <tr>
            <td style="width: 40%; vertical-align: top;">
                <%-- Filter Section--%>
                <telerik:RadDockZone ID="zoneFilter" runat="server" AllowedDocks="dockFilter">
                    <telerik:RadDock ID="dockFilter" runat="server" DockMode="Docked" DockHandle="TitleBar" Title="Filter" AllowedZones="zoneFilter" Collapsed="true" EnableDrag="false" OnClientInitialize="DockInitialize" OnClientCommand="dockCommand">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                        <ContentTemplate>
                            <table style="vertical-align: middle">

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
                        </ContentTemplate>
                    </telerik:RadDock>
                </telerik:RadDockZone>

                <%-- Grid Section--%>
                <telerik:RadDockZone ID="zoneGrid" runat="server" AllowedDocks="dockGrid">
                    <telerik:RadDock ID="dockGrid" runat="server" DockMode="Docked" DockHandle="TitleBar" Title="Vehicles" EnableDrag="false" OnClientInitialize="DockInitialize" OnClientCommand="dockCommand">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                        <ContentTemplate>
                            <telerik:RadGrid ID="RadDriver" runat="server" OnNeedDataSource="RadDriver_NeedDataSource" OnItemDataBound="RadDriver_ItemDataBound"
                                OnItemCommand="RadDriver_ItemCommand" AllowAutomaticInserts="True" AllowAutomaticUpdates="True" AllowAutomaticDeletes="True"
                                AutoGenerateEditColumn="false" CellSpacing="0" GridLines="None" AllowSorting="True" AllowPaging="True">
                                <%--<ExportSettings ExportOnlyData="true" FileName="Drivers List" IgnorePaging="true" OpenInNewWindow="true"
                                    Pdf-PageTitle="Drivers List" Pdf-PageHeight="210mm" Pdf-PageWidth="297mm">
                                    <Pdf PageHeight="210mm" PageTitle="Drivers List" PageWidth="297mm" />
                                </ExportSettings>--%>

                                <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True">
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                </ClientSettings>

                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="drv_id" CommandItemDisplay="Top" InsertItemDisplay="Top">
                                    <CommandItemSettings AddNewRecordText="Add New Driver" ShowAddNewRecordButton="false"></CommandItemSettings>
                                    <CommandItemSettings ShowExportToExcelButton="false" ShowExportToPdfButton="false"
                                        ExportToExcelText="Export to Excel" ExportToExcelImageUrl="../../Design/export_images/Excel 48.png"
                                        ExportToPdfText="Export to PDF" ExportToPdfImageUrl="../../Design/export_images/Acrobat 48.png" />
                                    <HeaderStyle HorizontalAlign="Center" />
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
                                        <telerik:GridBoundColumn HeaderStyle-Width="50px" DataField="drv_id" DataType="System.Int32" FilterControlAltText="Filter drv_id column" HeaderText="No." ReadOnly="True" SortExpression="drv_id" UniqueName="drv_id" Visible="False">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="viewDetails" FilterControlAltText="" HeaderText="Driver Name" UniqueName="viewDetails">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkDetails" runat="server" CommandName="Select" Text='<%# Eval("first_name") + " " + Eval("last_name") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="emp_id" FilterControlAltText="Filter emp_id column" ReadOnly="true" HeaderText="Employee ID" SortExpression="emp_id" UniqueName="emp_id">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="license_no" FilterControlAltText="Filter license_no column" HeaderText="License No." SortExpression="license_no" UniqueName="license_no">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="flag" FilterControlAltText="Filter flag column" HeaderText="flag" HeaderStyle-HorizontalAlign="Center" SortExpression="flag" UniqueName="flag" FilterControlWidth="35" Display="false">
                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        </telerik:GridBoundColumn>                                               
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Flag" HeaderStyle-Width="30px" ImageUrl="~/Design/flagging_images/unflagged.png" Text="Flag" UniqueName="btn_flag">
                                            <HeaderStyle Width="40px" />
                                        </telerik:GridButtonColumn>
                                    </Columns>
                                </MasterTableView>
                                <FilterMenu EnableImageSprites="False"></FilterMenu>
                            </telerik:RadGrid>
                            <asp:LinqDataSource ID="linq_ds_driver" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="tblDrivers" Where="usr_id == @usr_id">
                                <WhereParameters>
                                    <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
                                </WhereParameters>
                            </asp:LinqDataSource>
                        </ContentTemplate>
                    </telerik:RadDock>
                </telerik:RadDockZone>
            </td>
            <td style="width: 30%; vertical-align: top;">
                <%-- Image and Details Section--%>
                <telerik:RadDockZone ID="zoneImageDetails" runat="server">
                    <telerik:RadDock ID="dockDetails" runat="server" DockMode="Docked" DockHandle="TitleBar" Title="Details" EnableDrag="false" OnClientInitialize="DockInitialize" OnClientCommand="dockCommand">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                        <ContentTemplate>

                            <asp:Panel ID="DRVDetailsPanel" runat="server">
                                <table style="width: 100%;">
                                    <tr>
                                        <td colspan="2" style="vertical-align: top; width: 155px; text-align: center;">
                                            <asp:Image ID="imgDriver" runat="server" ImageUrl="~/Design/driver_pg_images/drv_unavailable.png" Width="150" Height="150" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:DetailsView ID="DetDriver" runat="server" Width="100%" AutoGenerateRows="False"
                                                OnItemCreated="DetDriver_ItemCreated" EnableModelValidation="True" CellPadding="4"
                                                GridLines="None" ForeColor="#333333" CssClass="No Driver Data Found" DataKeyNames="drv_id">
                                                <AlternatingRowStyle BackColor="White" />
                                                <CommandRowStyle BackColor="#C5BBAF" Font-Bold="True" />
                                                <EditRowStyle BackColor="#7C6F57" />
                                                <FieldHeaderStyle BackColor="#D0D0D0" Font-Bold="True" />
                                                <Fields>
                                                    <asp:BoundField DataField="emp_id" HeaderText="Employee ID" SortExpression="emp_id" ItemStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="first_name" HeaderText="First Name" SortExpression="first_name" />
                                                    <asp:BoundField DataField="last_name" HeaderText="Last Name" SortExpression="last_name" />
                                                    <asp:BoundField DataField="mobile_no" HeaderText="Mobile No." SortExpression="mobile_no" />
                                                    <asp:BoundField DataField="phone_no" HeaderText="Phone No." SortExpression="phone_no" />
                                                    <asp:BoundField DataField="home_address" HeaderText="Home Address" SortExpression="home_address" />
                                                    <asp:BoundField DataField="birth_date" DataFormatString="{0:yyyy-MM-dd}" HeaderText="Birth Date" SortExpression="birth_date" />
                                                    <asp:BoundField DataField="gov_id" HeaderText="ID Type" SortExpression="gov_id" />
                                                    <asp:BoundField DataField="gov_id_no" HeaderText="ID No." SortExpression="gov_id_no" ItemStyle-HorizontalAlign="Center"  />
                                                    <asp:BoundField DataField="emp_status" HeaderText="Employee Status" SortExpression="emp_status" />
                                                    <asp:BoundField DataField="emp_description" HeaderText="emp_description" Visible="false" SortExpression="emp_description" />
                                                    <asp:BoundField DataField="license_type" HeaderText="License Type" SortExpression="license_type" />
                                                    <asp:BoundField DataField="license_no" HeaderText="License No." SortExpression="license_no" ItemStyle-HorizontalAlign="Center"  />
                                                    <asp:BoundField DataField="license_expiry_date" DataFormatString="{0:yyyy-MM-dd}" HeaderText="License Expiry Date" SortExpression="license_expiry_date" />
                                                    <asp:BoundField DataField="license_description" HeaderText="license_description" Visible="false" SortExpression="license_description" />
                                                    <asp:BoundField DataField="salary_type" HeaderText="Salary Type" SortExpression="salary_type" />
                                                    <asp:BoundField DataField="salary" HeaderText="Salary Type" SortExpression="salary" DataFormatString="{0:n2}" ItemStyle-HorizontalAlign="Right" />
                                                    <asp:BoundField DataField="hire_date" DataFormatString="{0:yyyy-MM-dd}" HeaderText="Hire Date" SortExpression="hire_date" />
                                                    <asp:BoundField DataField="salary_description" HeaderText="Salary Description" SortExpression="salary_description" Visible="false" />
                                                    <asp:BoundField DataField="drv_id" Visible="false" HeaderText="drv_id" SortExpression="drv_id" />
                                                    <asp:BoundField DataField="sal_id" Visible="false" HeaderText="sal_id" SortExpression="sal_id" />
                                                    <asp:BoundField DataField="emp_sta_id" Visible="false" HeaderText="emp_sta_id" SortExpression="emp_sta_id" />
                                                    <asp:BoundField DataField="drv_lic_id" Visible="false" HeaderText="drv_lic_id" SortExpression="drv_lic_id" />
                                                    <asp:BoundField DataField="usr_id" Visible="false" HeaderText="usr_id" SortExpression="usr_id" />
                                                </Fields>
                                                <FooterStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" />
                                                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                                                <RowStyle BackColor="#E3EAEB" />
                                            </asp:DetailsView>


                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:HyperLink ID="EditDRVLink" runat="server" Text='Edit' Visible="false"></asp:HyperLink>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>


                        </ContentTemplate>
                    </telerik:RadDock>
                </telerik:RadDockZone>
            </td>
            <td style="width: 30%; vertical-align: top;">
                <%-- Violations History Section --%>
                <telerik:RadDockZone ID="zoneViolations" runat="server">
                    <telerik:RadDock ID="dockViolations" runat="server" DockMode="Docked" DockHandle="TitleBar" Title="Violations History" EnableDrag="false" OnClientInitialize="DockInitialize" OnClientCommand="dockCommand">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                        <ContentTemplate>
                            <telerik:RadGrid ID="RadViolation" OnItemCreated="RadViolation_ItemCreated"
                                runat="server" CellSpacing="0" GridLines="None" MasterTableView-NoMasterRecordsText="No Violation History Found">
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="drv_vio_id">
                                    <CommandItemSettings ExportToPdfText="Export to PDF" />
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridTemplateColumn ItemStyle-Width="50px" FilterControlAltText="Filter column column" ReadOnly="true" HeaderText="No" UniqueName="column" Reorderable="False"  ItemStyle-HorizontalAlign="Center"  >
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Container.DataSetIndex+1 %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="50px" />
                                        </telerik:GridTemplateColumn>
                                        <%--<telerik:GridBoundColumn DataField="drv_vio_id" DataType="System.Int32" FilterControlAltText="Filter drv_vio_id column" HeaderText="drv_vio_id" SortExpression="drv_vio_id" UniqueName="drv_vio_id">
                                        </telerik:GridBoundColumn>     --%>
                                        <telerik:GridBoundColumn DataField="violation" FilterControlAltText="Filter violation column" HeaderText="Violation" SortExpression="violation" UniqueName="violation">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="date" DataType="System.DateTime" DataFormatString="{0:yyyy-MM-dd}" FilterControlAltText="Filter date column" HeaderText="Date" SortExpression="date" UniqueName="date">
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridBoundColumn DataField="location" FilterControlAltText="Filter location column" HeaderText="location" SortExpression="location" UniqueName="location">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="cost" DataType="System.Double" FilterControlAltText="Filter cost column" HeaderText="cost" SortExpression="cost" UniqueName="cost">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Driver" FilterControlAltText="Filter Driver column" HeaderText="Driver" SortExpression="Driver" UniqueName="Driver">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="vehicle_name" FilterControlAltText="Filter vehicle_name column" HeaderText="vehicle_name" SortExpression="vehicle_name" UniqueName="vehicle_name">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="remarks" FilterControlAltText="Filter remarks column" HeaderText="remarks" SortExpression="remarks" UniqueName="remarks">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="drv_id" DataType="System.Int32" FilterControlAltText="Filter drv_id column" HeaderText="drv_id" SortExpression="drv_id" UniqueName="drv_id">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="vid" DataType="System.Int32" FilterControlAltText="Filter vid column" HeaderText="vid" SortExpression="vid" UniqueName="vid">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="usr_id" DataType="System.Int32" FilterControlAltText="Filter usr_id column" HeaderText="usr_id" SortExpression="usr_id" UniqueName="usr_id">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="vio_id" DataType="System.Int32" FilterControlAltText="Filter vio_id column" HeaderText="vio_id" SortExpression="vio_id" UniqueName="vio_id">
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridTemplateColumn DataField="viewDetails" FilterControlAltText="" HeaderText="Violation Ticket No." UniqueName="viewDetails" ItemStyle-HorizontalAlign="Center"  >
                                            <ItemTemplate>
                                                <asp:HyperLink ID="EditLink" runat="server" Text='<%# Eval("violation_ticket_no") %>'></asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </MasterTableView>
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                            </telerik:RadGrid>
                        </ContentTemplate>
                    </telerik:RadDock>
                </telerik:RadDockZone>
            </td>
        </tr>
    </table>
</asp:Content>
