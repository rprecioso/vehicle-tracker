<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="FMS.Source.Child.Dashboard" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .topMidAlign
        {
            vertical-align: top !important;
        }

        .SeeAll
        {
            text-align: right;
        }

        .links
        {
            text-decoration: underline !important;
        }
    </style>

    <script type="text/javascript">
        function OnVehicleSeriesClicked(sender, eventArgs) {
            var res = $.grep(eventArgs.get_seriesData(), function (n, i) {
                return (n.vehicle_name === eventArgs.get_category());
            });
            ShowEditFormVehicle(res[0].vid);
        }

        function OnDriverSeriesClicked(sender, eventArgs) {
            var res = $.grep(eventArgs.get_seriesData(), function (n, i) {
                return (n.driver === eventArgs.get_category());
            });
            ShowEditFormDriver(res[0].drv_id);
        }

        function ShowAlertsForm() {
            window.open("/Source/Admin/Alerts_Master.aspx");
            return false;
        }

        function ShowEditFormDriver(id) {
            window.radopen("/Source/Details/DETDriver.aspx?id=" + id + "&mode=view", "drvDetailDialog");
            return false;
        }
        function ShowEditFormVehicle(id) {
            window.radopen("/Source/Details/DETVehicle.aspx?id=" + id + "&mode=view", "vhcDetailDialog");
            return false;
        }

        function ShowVehicleForm(id) {
            window.radopen("/Source/Details/DETVehicle.aspx?id=" + id + "&mode=view", "vhcDetailDialog");
            return false;
        }

        function ShowInsuranceForm(id) {
            window.radopen("/Source/Details/DETInsurance.aspx?id=" + id + "&mode=view", "vhcDetailDialog");
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gridItemFlags">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridItemFlags" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <%--<telerik:RadWindow ID="vhcServiceDialog" runat="server" Title="Service Details" Height="500px"
                Width="350px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
            <telerik:RadWindow ID="vhcInsuranceDialog" runat="server" Title="Insurance Details" Height="500px"
                Width="350px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>--%>
            <telerik:RadWindow ID="vhcDetailDialog" VisibleStatusbar="false" OnClientClose="refreshGrid" runat="server" Title="Vehicle Details" Height="600px"
                Width="450px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
            <%--<telerik:RadWindow ID="vhcTrackerDialog" runat="server" Title="Vehicle Current Position"
                Height="546"
                Width="693" ReloadOnShow="true" ShowContentDuringLoad="false"
                Modal="true">
            </telerik:RadWindow>--%>
            <telerik:RadWindow ID="drvDetailDialog" VisibleStatusbar="false" OnClientClose="refreshGrid" runat="server" Title="Edit Driver" Height="630px"
                Width="390px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="get_user_services" TypeName="FMS.Source.Classes.Service, FMS, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="_user_id" Type="Int32"></asp:Parameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="get_vehicle_service" TypeName="FMS.Source.Classes.Service, FMS, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="_vid" Type="Int32"></asp:Parameter>
        </SelectParameters>
    </asp:ObjectDataSource>




    <asp:Table runat="server" HorizontalAlign="Center">
        <%-- Expiry Alerts and Reminders Section --%>
        <asp:TableRow>
            <telerik:PivotGridTableCell ColumnSpan="2" CssClass="topMidAlign">                
                    <telerik:RadDockZone ID="zoneAlert" runat="server" Width="916">
                    <telerik:RadDock ID="dockAlert" runat="server" DockMode="Docked"
                        DockHandle="TitleBar" Title="Alerts (TOP 10)" AllowedZones="zoneAlert"
                        EnableDrag="false">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                            <ContentTemplate>
                                <telerik:RadGrid ID="gridExpiryFlags" OnItemCreated="gridExpiryFlags_ItemCreated" runat="server" CellSpacing="0" GridLines="None" AutoGenerateColumns="false"
                                     OnNeedDataSource="gridExpiryFlags_NeedDataSource" ShowFooter="true" OnItemDataBound="gridExpiryFlags_ItemDataBound" AllowPaging="true" AllowSorting="true">
                                    <MasterTableView DataKeyNames="type_id,ref_id" ShowGroupFooter="true">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <Columns>
                      
                                            <telerik:GridTemplateColumn DataField="alert_type" HeaderText="Alert Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" Text='<%#Eval("alert_type") %>' runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate >
                                                    <div style="text-align:left;">
                                                        <%--<asp:LinkButton ID="AlertsLink" runat="server">See All...</asp:LinkButton>--%>
                                                         <asp:HyperLink NavigateUrl="Content1" ID="AlertsLink" href="/Source/Admin/Alerts_Master.aspx" runat="server" Text='See All...' Target="_self"></asp:HyperLink>
                                                    </div>
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="item" HeaderText="Item Name">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="RefLink" runat="server" Text='<%#Eval("item") %>'></asp:HyperLink>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="deadline" HeaderText="Deadline" DataType="System.DateTime" DataFormatString="{0:yyyy-MM-dd}" ItemStyle-HorizontalAlign="Center"/>
                                            <telerik:GridTemplateColumn DataField="days_remaining" HeaderText="Days Remaining" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:Label Text='<%#Eval("days_remaining") %>' runat="server"></asp:Label>
                                                </ItemTemplate>                                       
                                            </telerik:GridTemplateColumn>
                                        </Columns>

                                    </MasterTableView>   
                                                                     
                                </telerik:RadGrid>                                
                            </ContentTemplate>
                        </telerik:RadDock>
                        </telerik:RadDockZone>                    
            </telerik:PivotGridTableCell>
        </asp:TableRow>
        <%-- Charts section --%>
        <asp:TableRow>
            <telerik:PivotGridTableCell CssClass="Top">
                  <telerik:RadDockZone ID="zoneFilter" runat="server" Width="450">
                    <telerik:RadDock ID="dockFilter" runat="server" DockMode="Docked"
                        DockHandle="TitleBar" Title="Vehicle Service (TOP 10)" AllowedZones="zoneFilter"
                        EnableDrag="false">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                        <ContentTemplate> 
                            <telerik:RadHtmlChart ID="chrtVHCServices" runat="server"  OnClientSeriesClicked="OnVehicleSeriesClicked" DataSourceID="linq_db_service_count" Width="430px" Legend-Appearance-Visible="false">
                                <Legend>
                                    <Appearance Visible="False"></Appearance>
                                </Legend>
                                
                                <PlotArea>
                                    <XAxis DataLabelsField="vehicle_name">
                                    </XAxis>
                                    <YAxis Step="1">
                                        <TitleAppearance Text="No. of Times Serviced" />
                                    </YAxis>
                                    <Series>
                                        <telerik:BarSeries DataFieldY="srv_count" Name="Vehicle">
                                  
                                        </telerik:BarSeries>
                                    </Series>
                                </PlotArea>
                            </telerik:RadHtmlChart>
                        </ContentTemplate>
                    </telerik:RadDock></telerik:RadDockZone>
            </telerik:PivotGridTableCell>
            <telerik:PivotGridTableCell CssClass="topMidAlign">
                        <telerik:RadDockZone ID="RadDockZone1" runat="server" Width="450">
                    <telerik:RadDock ID="RadDock1" runat="server" DockMode="Docked"
                        DockHandle="TitleBar" Title="Driver Violation  (TOP 10)" AllowedZones="zoneFilter"
                        EnableDrag="false">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                        <ContentTemplate>
                            <telerik:RadHtmlChart ID="chrtDRVViolation" runat="server" OnClientSeriesClicked="OnDriverSeriesClicked" DataSourceID="linq_db_violation_count"  Width="430px" Legend-Appearance-Visible="false">
                                <Legend>
                                    <Appearance Visible="False"></Appearance>
                                </Legend>

                                <PlotArea>
                                    <XAxis DataLabelsField="driver">
                                        
                                       
                                    </XAxis>
                                    <YAxis Step="1">
                                        <TitleAppearance Text="No. of Violation" />
                                    </YAxis>
                                    <Series>
                                        <telerik:BarSeries DataFieldY="violation_count" Name="Driver">
                                    </telerik:BarSeries>
                                    </Series>
                                </PlotArea>
                            </telerik:RadHtmlChart> 
                            
                        </ContentTemplate>
                    </telerik:RadDock>
                </telerik:RadDockZone>
            </telerik:PivotGridTableCell>
        </asp:TableRow>
        <asp:TableRow>
            <telerik:PivotGridTableCell ColumnSpan="2" CssClass="topMidAlign">
                    <telerik:RadDockZone ID="RadDockZone2" runat="server" Width="916">
                    <telerik:RadDock ID="RadDock2" runat="server" DockMode="Docked"
                        DockHandle="TitleBar" Title="Daily Expense" AllowedZones="zoneFilter"
                        EnableDrag="false">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                        <ContentTemplate>
<%-- Expense Chart --%>             
                            <telerik:RadHtmlChart ID="chrt_expense" runat="server" DataSourceID="linq_db_expense" Legend-Appearance-Visible="false">
                            <PlotArea>
                                <XAxis DataLabelsField="day">
                                    <LabelsAppearance/>                                    
                                    <%--  RotationAngle="30" DataFormatString="{0:d}" --%>
                                    <MajorGridLines Visible="false" />
                                </XAxis>
                                <YAxis>
                                    <LabelsAppearance DataFormatString="{0:n0}" />
                                        <TitleAppearance Text="Expense" />
                                        <MajorGridLines Visible="false" />
                                        <MinorGridLines Visible="false" />
                                </YAxis>
                                 <Series>
                                    <telerik:LineSeries DataFieldY="cost" MissingValues="Gap" Name="Expense">
                                    <LabelsAppearance DataFormatString="{0:n0}"></LabelsAppearance>
                                </telerik:LineSeries>
                                </Series>
                            </PlotArea>
                        </telerik:RadHtmlChart>               
                        </ContentTemplate>
                    </telerik:RadDock>
                </telerik:RadDockZone>
            </telerik:PivotGridTableCell>
        </asp:TableRow>
        <%-- Flagging Section --%>
        <asp:TableRow>
            <telerik:PivotGridTableCell ColumnSpan="2" CssClass="topMidAlign">                
                    <telerik:RadDockZone ID="zoneFlag" runat="server" Width="916">
                    <telerik:RadDock ID="dockFlags" runat="server" DockMode="Docked"
                        DockHandle="TitleBar" Title="Flagged Vehicles and Drivers" AllowedZones="zoneFlag"
                        EnableDrag="false">
                        <Commands>
                            <telerik:DockExpandCollapseCommand />
                        </Commands>
                            <ContentTemplate>
                                <telerik:RadGrid ID="gridItemFlags" runat="server" AllowPaging="True" CellSpacing="0" DataSourceID="LinqDataSource1" GridLines="None"
                                    OnItemCommand="gridItemFlags_ItemCommand" OnItemDataBound="gridItemFlags_ItemDataBound" >
                                    <MasterTableView DataSourceID="LinqDataSource1" AutoGenerateColumns="False" DataKeyNames="id" CommandItemDisplay="Top" NoDetailRecordsText="No Flagged Vehicles">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <CommandItemSettings ShowAddNewRecordButton="false" />
                                        <Columns>
                                            <telerik:GridImageColumn HeaderStyle-Width="80px" ImageUrl="..." HeaderText="Item Type" SortExpression="Item Type" UniqueName="img_type">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </telerik:GridImageColumn>
                                            <telerik:GridBoundColumn DataField="type" FilterControlAltText="Filter type column" HeaderText="type" SortExpression="Item Type" UniqueName="type" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="id" DataType="System.Int32" FilterControlAltText="Filter vid column" HeaderText="Item ID" SortExpression="vid" UniqueName="vid">
                                            </telerik:GridBoundColumn>                                            
                                            <telerik:GridBoundColumn DataField="name" FilterControlAltText="Filter name column" HeaderText="Item Name" SortExpression="name" UniqueName="name" Display="false">
                                            </telerik:GridBoundColumn>      
                                            <telerik:GridTemplateColumn DataField="viewItem" FilterControlAltText="" HeaderText="Item Name" UniqueName="viewItem" Display="true">
                                                <ItemTemplate>
                                                <asp:HyperLink ID="lnkDetails" runat="server" Text='<%# Eval("name") %>' CssClass="links"></asp:HyperLink>
                                                    <%-- CommandName="ViewDetail" --%>
                                            </ItemTemplate>
                                            </telerik:GridTemplateColumn>   
                                            <telerik:GridBoundColumn DataField="flag_reason" FilterControlAltText="Filter flag_reason column" HeaderText="Reason For Flagging" SortExpression="flag_reason" UniqueName="flag_reason" >
                                            </telerik:GridBoundColumn>                                    
                                            <telerik:GridBoundColumn DataField="flag" FilterControlAltText="Filter flag column" HeaderText="flag" SortExpression="flag" UniqueName="flag" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="usr_id" DataType="System.Int32" FilterControlAltText="Filter usr_id column" HeaderText="usr_id" SortExpression="usr_id" UniqueName="usr_id" Display="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Flag" HeaderStyle-Width="30px" ImageUrl="~/Design/flagging_images/unflagged.png" Text="Flag" UniqueName="btn_flag">
                                            <HeaderStyle Width="40px" />
                                        </telerik:GridButtonColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>                     
                            </ContentTemplate>
                        </telerik:RadDock>
                        </telerik:RadDockZone>                    
            </telerik:PivotGridTableCell>
        </asp:TableRow>
    </asp:Table>
    <%-- LINQ Data Source Section --%>
    <asp:LinqDataSource ID="linq_db_violation_count" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_db_violation_counts" Where="usr_id == @usr_id">
        <WhereParameters>
            <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="linq_db_expense" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_db_expenses" Where="user_id == @user_id" OrderBy="day">
        <WhereParameters>
            <asp:SessionParameter Name="user_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="linq_db_service_count" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_db_service_counts">
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_item_flags" Where="usr_id == @usr_id">
        <WhereParameters>
            <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_db_srv_vios" Where="usr_id == @usr_id">
        <WhereParameters>
            <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>

</asp:Content>
