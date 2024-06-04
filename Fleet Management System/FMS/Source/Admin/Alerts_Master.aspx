<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Alerts_Master.aspx.cs" Inherits="FMS.Source.Admin.Alerts_Master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function ShowVehicleForm(id) {
                window.radopen("/Source/Details/DETVehicle.aspx?id=" + id + "&mode=view", "vhcDialog");
                return false;
            }
            function ShowInsuranceForm(id) {
                window.radopen("/Source/Details/DETInsurance.aspx?id=" + id + "&mode=view", "vhcDialog");
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
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RADVHCServices" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="gridExpiryFlags">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gridExpiryFlags" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="vhcDialog" OnClientClose="refreshGrid"  runat="server" Title="Alert Details" Height="500px"
                Width="380px" ReloadOnShow="true" VisibleStatusbar="false"  ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
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
        </tr>

    </table>
    <telerik:RadGrid ID="gridExpiryFlags" runat="server" PageSize="10"  CellSpacing="0" GridLines="None" AutoGenerateColumns="false" OnItemCreated="gridExpiryFlags_ItemCreated"
        OnNeedDataSource="gridExpiryFlags_NeedDataSource" OnItemDataBound="gridExpiryFlags_ItemDataBound" AllowPaging="true" AllowSorting="true">
        <MasterTableView DataKeyNames="type_id, ref_id">
            <HeaderStyle HorizontalAlign="Center" />
            <Columns>                
                <telerik:GridTemplateColumn HeaderStyle-Width="50px" FilterControlAltText="Filter column column" ReadOnly="true" HeaderText="No" UniqueName="column" Reorderable="False" HeaderStyle-HorizontalAlign="Left">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Container.DataSetIndex+1 %>'></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="50px" />
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="alert_type" HeaderText="Alert Type" />
                <%-- <telerik:GridBoundColumn DataField="item" HeaderText="Item Involved" />--%>
                <telerik:GridTemplateColumn DataField="item" HeaderText="Item">
                    <ItemTemplate>
                        <asp:HyperLink ID="RefLink" runat="server" Text='<%#Eval("item") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="deadline" ItemStyle-HorizontalAlign="Center" HeaderText="Deadline" DataType="System.DateTime" DataFormatString="{0:yyyy-MM-dd}"  HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridBoundColumn DataField="days_remaining" HeaderText="Days Remaining" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                <%--     <telerik:GridTemplateColumn DataField="ref_id" HeaderText="Ref. ID">
                    <ItemTemplate>
                        <asp:HyperLink ID="RefLink" runat="server" Text='<%#Eval("ref_id") %>'></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>--%>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
</asp:Content>
