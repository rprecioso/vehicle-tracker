<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vehicles.aspx.cs" Inherits="FMS.Child.Vehicles" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Source/User_Control/UC_Vehicle.ascx" TagPrefix="uc1" TagName="UC_Vehicle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowFlagForm(id, type) {
                window.radopen("/Source/Details/DETFlag.aspx?id=" + id +"&type=" + type, "vhcFlagDialog");
                return false;
            }

            function ShowEditForm(id) {
                window.radopen("/Source/Details/DETService.aspx?id=" + id, "vhcServiceDialog");
                return false;
            }

            function ShowEditFormInsurance(id) {
                window.radopen("/Source/Details/DETInsurance.aspx?id=" + id, "vhcInsuranceDialog");
                return false;
            }

            function ShowEditFormTrack(id, rowIndex) {
                window.radopen("/Source/Details/DETTracking.aspx?vid=" + id, "vhcTrackerDialog");
                return false;
            }

            function ShowEditFormVehicle(id) {
                window.radopen("/Source/Details/DETVehicle.aspx?id=" + id, "vhcDetailDialog");
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
                window.radopen("/Source/Details/VHCService.aspx?vhc_srv_id=" + eventArgs.getDataKeyValue("vhc_srv_id"), "vhcServiceDialog");
            }
        </script>
    </telerik:RadCodeBlock>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadVehicle" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadServices" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="VHCDetailsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="VHCInsurancePanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadVehicle">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadVehicle" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadServices" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="VHCInsurancePanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="VHCDetailsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btn_filter">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadVehicle" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadServices">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadServices" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="VHCDetailsPanel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="VHCDetailsPanel" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>

        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="vhcFlagDialog" runat="server" Title="Reason for Flagging" Height="30px"
                Width="500px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true"  VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="vhcServiceDialog" runat="server" Title="Service Details" Height="500px"
                Width="350px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
            <telerik:RadWindow ID="vhcInsuranceDialog" runat="server" Title="Insurance Details" Height="500px"
                Width="350px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>

            <telerik:RadWindow ID="vhcDetailDialog" runat="server" Title="Vehicle Details" Height="500px"
                Width="350px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>

            <telerik:RadWindow ID="vhcTrackerDialog" runat="server" Title="Vehicle Current Position"
                Height="546"
                Width="693" ReloadOnShow="true" ShowContentDuringLoad="false"
                Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
    <table style="width: 100%; vertical-align: top;">
        <tr>
            <td style="width: 40%; vertical-align: top;">
                <%-- Filter Section--%>
                <telerik:RadDockZone ID="zoneFilter" runat="server" AllowedDocks="dockFilter">
                    <telerik:RadDock ID="dockFilter" runat="server" DockMode="Docked" DockHandle="TitleBar"
                        Title="Filter" AllowedZones="zoneFilter" Collapsed="true" EnableDrag="false" OnClientInitialize="DockInitialize" OnClientCommand="dockCommand">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                        <ContentTemplate>
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
                    <telerik:RadDock ID="dockGrid" runat="server" DockMode="Docked" DockHandle="TitleBar" Title="Vehicles"
                        EnableDrag="false" OnClientInitialize="DockInitialize" OnClientCommand="dockCommand">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                        <ContentTemplate>

                            <telerik:RadGrid CssClass="grid" Style="width: auto;" ID="RadVehicle" runat="server" AllowSorting="True" OnPreRender="RadVehicle_PreRender"
                                OnItemCommand="RadVehicle_ItemCommand" OnItemCreated="RadVehicle_ItemCreated" OnItemDataBound="RadVehicle_ItemDataBound"
                                OnNeedDataSource="RadVehicle_NeedDataSource" GridLines="None" AllowAutomaticDeletes="True" AllowAutomaticInserts="True"
                                AllowAutomaticUpdates="True" CellSpacing="0" ClientSettings-EnableRowHoverStyle="true">

                                <ClientSettings AllowColumnsReorder="True" ReorderColumnsOnClient="True">
                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                </ClientSettings>
                                <ExportSettings ExportOnlyData="true" FileName="Vehicles List" IgnorePaging="true" OpenInNewWindow="true"
                                    Pdf-PageTitle="Vehicles List" Pdf-PageHeight="210mm" Pdf-PageWidth="297mm">
                                    <Pdf PageTitle="Vehicles List" PageWidth="297mm" PageHeight="210mm"></Pdf>
                                </ExportSettings>
                                <MasterTableView AutoGenerateColumns="False" Width="100%" DataKeyNames="vid" CommandItemDisplay="Top">
                                    <CommandItemSettings ExportToPdfText="Export to PDF" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <CommandItemSettings ShowAddNewRecordButton="false" ShowRefreshButton="true" />
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>
                                    <CommandItemSettings ExportToExcelImageUrl="../../Design/export_images/Excel 48.png" ExportToExcelText="Export to Excel" ExportToPdfImageUrl="../../Design/export_images/Acrobat 48.png" ExportToPdfText="Export to PDF" ShowExportToExcelButton="false" ShowExportToPdfButton="false" />
                                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                        <HeaderStyle Width="20px" />
                                    </ExpandCollapseColumn>

                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="50px" FilterControlAltText="Filter column column" ReadOnly="true" HeaderText="No" UniqueName="column" Reorderable="False">
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Container.DataSetIndex+1 %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="50px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="50px" DataField="viewMap" FilterControlAltText="" HeaderText="VID" UniqueName="viewMap">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="TrackLink" runat="server" Text='<%# Eval("vid") %>'></asp:HyperLink>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="vid" FilterControlAltText="Filter vid column" HeaderText="VID" SortExpression="vid" UniqueName="vid" ReadOnly="True" Display="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn DataField="viewDetails" FilterControlAltText="" HeaderText="Vehicle" UniqueName="viewDetails">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkDetails" runat="server" CommandName="Select" Text='<%# Eval("vehicle_name") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn DataField="vehicle_name" FilterControlAltText="Filter vehicle_name column" HeaderText="Vehicle Name" SortExpression="vehicle_name" UniqueName="vehicle_name" Display="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="vhc_model" FilterControlAltText="Filter vhc_model column" HeaderText="Model" HeaderStyle-HorizontalAlign="Center" SortExpression="vhc_model" UniqueName="vhc_model" FilterControlWidth="35">
                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="flag" FilterControlAltText="Filter flag column" HeaderText="flag" HeaderStyle-HorizontalAlign="Center" SortExpression="flag" UniqueName="flag" FilterControlWidth="35" Display="false">
                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Flag" HeaderStyle-Width="30px" ImageUrl="~/Design/flagging_images/unflagged.png" Text="Flag" UniqueName="btn_flag">
                                            <HeaderStyle Width="40px" />
                                        </telerik:GridButtonColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="40px" DataField="lnk_flag" FilterControlAltText="" HeaderText=" " UniqueName="lnk_flag" Display="false">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgFlag" runat="server" ImageUrl="~/Design/flagging_images/unflagged.png" ToolTip="Flag"/>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>

                                </MasterTableView>

                                <FilterMenu EnableImageSprites="False"></FilterMenu>
                            </telerik:RadGrid>
                        </ContentTemplate>
                    </telerik:RadDock>
                </telerik:RadDockZone>
            </td>
            <td style="width: 30%; vertical-align: top;">
                <%-- Image and Details Section--%>
                <telerik:RadDockZone ID="zoneImageDetails" runat="server">
                    <telerik:RadDock ID="dockDetails" runat="server" DockMode="Docked" DockHandle="TitleBar"
                        Title="Details" EnableDrag="false" OnClientInitialize="DockInitialize" OnClientCommand="dockCommand">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                        <ContentTemplate>
                            <asp:Panel ID="VHCDetailsPanel" runat="server">
                                <table style="width: 100%;">
                                    <tr>
                                        <td colspan="2" style="vertical-align: top; width: 155px; text-align: center;">
                                            <asp:Image ID="imgVehicle" runat="server" Width="250" Height="150" ImageUrl="~/Design/vehicle_pg_images/VHC_unavailable.png" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:DetailsView ID="DetVehicle" runat="server" Width="100%" AutoGenerateRows="False" OnItemCreated="DetVehicle_ItemCreated"
                                                DataKeyNames="vid" EnableModelValidation="True" CellPadding="4" GridLines="None" ForeColor="#333333" EmptyDataText="No Vehicle Data Found">
                                                <AlternatingRowStyle BackColor="White" />
                                                <CommandRowStyle BackColor="#C5BBAF" Font-Bold="True" />
                                                <EditRowStyle BackColor="#7C6F57" />
                                                <FieldHeaderStyle BackColor="#D0D0D0" Font-Bold="True" />
                                                <Fields>

                                                    <asp:BoundField DataField="vehicle_name" HeaderText="Vehicle" SortExpression="vehicle_name" />
                                                    <asp:BoundField DataField="vid" HeaderText="VID" SortExpression="vid" />
                                                    <asp:BoundField DataField="vhc_model" HeaderText="Model" SortExpression="vhc_model" />
                                                    <asp:BoundField DataField="manufacturer" HeaderText="Manufacturer" SortExpression="manufacturer" />
                                                    <asp:BoundField DataField="body_type" HeaderText="Body Type" SortExpression="body_type" />
                                                    <asp:BoundField DataField="color" HeaderText="Color" SortExpression="color" />
                                                    <asp:BoundField DataField="cc" HeaderText="Volume (cc)" DataFormatString="{0:n0}" SortExpression="cc"  ItemStyle-HorizontalAlign="Left" />                                                    
                                                    <asp:BoundField DataField="engine_no" HeaderText="Engine No." SortExpression="engine_no" ItemStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="chasis_no" HeaderText="Chasis No" SortExpression="chasis_no" ItemStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="year_make" HeaderText="Year" SortExpression="year_make"  ItemStyle-HorizontalAlign="Left"/>
                                                    <asp:BoundField DataField="chasis_wt" DataFormatString="{0:n0}" HeaderText="Chasis Wt. (kg)" SortExpression="chasis_wt" ItemStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="body_wt" DataFormatString="{0:n0}" HeaderText="Body Wt. (kg)" SortExpression="body_wt" ItemStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="gross_wt" DataFormatString="{0:n0}" HeaderText="Gross Wt. (kg)" SortExpression="gross_wt"  ItemStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="registration_expiry_date" HeaderText="Reg. Expiry" DataFormatString="{0:yyyy-MM-dd}" SortExpression="registration_expiry_date" />
                                                    <asp:BoundField DataField="registration_no" HeaderText="Reg. No." SortExpression="registration_no"  ItemStyle-HorizontalAlign="Left"/>
                                                    <asp:BoundField DataField="seating_no" HeaderText="Seating Cap." SortExpression="seating_no" ItemStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="remarks" HeaderText="Remarks" SortExpression="remarks" />
                                                    <asp:BoundField DataField="bluecard" HeaderText="Bluecard" SortExpression="bluecard" Visible="false"/>
                                                    <asp:BoundField DataField="ins_id" Visible="false" HeaderText="ins_id" SortExpression="ins_id" />
                                                    <asp:BoundField DataField="road_tax" HeaderText="Road Tax" DataFormatString="{0:c}" SortExpression="road_tax" Visible="false"/>

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
                                            <asp:HyperLink ID="EditVHCLink" runat="server" Text='Edit' Visible="false"></asp:HyperLink>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </ContentTemplate>
                    </telerik:RadDock>
                </telerik:RadDockZone>
            </td>
            <td style="width: 30%; vertical-align: top;">
                <%-- Insurance Section --%>
                <telerik:RadDockZone ID="zoneInsurance" runat="server">
                    <telerik:RadDock ID="dockInsurance" runat="server" DockMode="Docked" DockHandle="TitleBar"
                        Title="Insurance" EnableDrag="false" OnClientInitialize="DockInitialize" OnClientCommand="dockCommand">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                        <ContentTemplate>
                            <asp:Panel ID="VHCInsurancePanel" runat="server">
                                <asp:DetailsView ID="DetInsurance" runat="server" EmptyDataText="No Insurance Data Found"
                                    Width="100%" AutoGenerateRows="False" DataKeyNames="ins_id" EnableModelValidation="True"
                                    CellPadding="4" GridLines="None" ForeColor="#333333" OnItemCreated="DetInsurance_ItemCreated">
                                    <AlternatingRowStyle BackColor="White" />
                                    <CommandRowStyle BackColor="#C5BBAF" Font-Bold="True" />
                                    <EditRowStyle BackColor="#7C6F57" />
                                    <FieldHeaderStyle BackColor="#D0D0D0" Font-Bold="True" />
                                    <Fields>
                                        <asp:BoundField DataField="ins_id" HeaderText="ins_id" InsertVisible="False" ReadOnly="True" SortExpression="ins_id" Visible="false" />
                                        <asp:BoundField DataField="expiry_date" HeaderText="Expiry Date" DataFormatString="{0:yyyy-MM-dd}" SortExpression="expiry_date" />
                                        <asp:BoundField DataField="cert_no" HeaderText="Certificate No." SortExpression="cert_no" />
                                        <asp:BoundField DataField="insurance_company" HeaderText="Company" SortExpression="company" />                                        
                                        <asp:BoundField DataField="sum_insured" HeaderText="Insured Amount" SortExpression="sum_insured" DataFormatString="{0:n2}" ItemStyle-HorizontalAlign="Right"/>
                                        <asp:BoundField DataField="policy_id" Visible="false" HeaderText="Policy ID" SortExpression="policy_id" />
                                        <asp:BoundField DataField="takaful_contribution" HeaderText="Takaful Contribution" DataFormatString="{0:n2}" SortExpression="takaful_contribution" Visible="false"/>
                                        <asp:BoundField DataField="ncd" HeaderText="NCD" SortExpression="ncd" DataFormatString="{0:n2}" Visible="false"/>
                                        <asp:BoundField DataField="ins_attch" Visible="false" HeaderText="Insurance attachment" SortExpression="ins_attch" />
                                    </Fields>
                                    <FooterStyle BackColor="#1C5E55" ForeColor="White" Font-Bold="True" />
                                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#E3EAEB" />
                                </asp:DetailsView>
                                <asp:HyperLink ID="EditVHCInsuranceLink" Visible="false" runat="server" Text=''></asp:HyperLink>
                            </asp:Panel>
                        </ContentTemplate>
                    </telerik:RadDock>
                </telerik:RadDockZone>
                <%-- Service History Section --%>
                <telerik:RadDockZone ID="zoneService" runat="server">
                    <telerik:RadDock ID="dockService" runat="server" DockMode="Docked" DockHandle="TitleBar"
                        Collapsed="false" Title="Service History" EnableDrag="false"
                        OnClientInitialize="DockInitialize" OnClientCommand="dockCommand" EnableViewState="true">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>


                        <ContentTemplate>
                            <asp:Panel ID="Panel2" runat="server">


                                <telerik:RadGrid ID="RadServices" runat="server" OnItemCommand="RadServices_ItemCommand" OnItemCreated="RadServices_ItemCreated">
                                    <MasterTableView AutoGenerateColumns="False" NoMasterRecordsText="No Service History Found." DataKeyNames="vhc_srv_id">
                                        <CommandItemSettings ExportToPdfText="Export to PDF" />
                                        <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                            <HeaderStyle Width="20px" />
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                            <HeaderStyle Width="20px" />
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderStyle-Width="50px" FilterControlAltText="Filter column column" ReadOnly="true" HeaderText="No" UniqueName="column" Reorderable="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Container.DataSetIndex+1 %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle Width="50px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="service" FilterControlAltText="Filter service column" HeaderText="Service" SortExpression="service" UniqueName="service">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="date_started" DataType="System.DateTime" DataFormatString="{0:yyyy-MM-dd}" FilterControlAltText="Filter date_started column" HeaderText="Date Started" SortExpression="date_started" UniqueName="date_started">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="date_completed" DataType="System.DateTime" DataFormatString="{0:yyyy-MM-dd}" FilterControlAltText="Filter date_completed column" HeaderText="Date Completed" SortExpression="date_completed" UniqueName="date_completed">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="viewDetails" FilterControlAltText="" HeaderText="Service Receipt No." UniqueName="viewDetails">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="EditLink" runat="server" Text='<%# Eval("service_receipt_no") %>'></asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn Display="false" DataField="service_receipt_no" FilterControlAltText="Filter service_receipt_no column" HeaderText="Service Receipt No." SortExpression="service_receipt_no" UniqueName="service_receipt_no">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="srv_by" FilterControlAltText="Filter srv_by column" HeaderText="srv_by" SortExpression="srv_by" UniqueName="srv_by" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="remarks" FilterControlAltText="Filter remarks column" HeaderText="remarks" SortExpression="remarks" UniqueName="remarks" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="vehicle_name" FilterControlAltText="Filter vehicle_name column" HeaderText="vehicle_name" SortExpression="vehicle_name" UniqueName="vehicle_name" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="vid" FilterControlAltText="Filter vid column" HeaderText="vid" SortExpression="vid" UniqueName="vid" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="vhc_srv_id" DataType="System.Int32" FilterControlAltText="Filter vhc_srv_id column" HeaderText="vhc_srv_id" SortExpression="vhc_srv_id" UniqueName="vhc_srv_id" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="usr_id" DataType="System.Int32" FilterControlAltText="Filter usr_id column" HeaderText="usr_id" SortExpression="usr_id" UniqueName="usr_id" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="srv_id" DataType="System.Int32" FilterControlAltText="Filter srv_id column" HeaderText="srv_id" SortExpression="srv_id" UniqueName="srv_id" Display="false">
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                        <EditFormSettings>
                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </MasterTableView>
                                    <FilterMenu EnableImageSprites="False">
                                    </FilterMenu>
                                </telerik:RadGrid>
                                <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_vehicle_services">
                                </asp:LinqDataSource>
                            </asp:Panel>
                        </ContentTemplate>

                    </telerik:RadDock>
                </telerik:RadDockZone>
            </td>
        </tr>
    </table>
</asp:Content>
