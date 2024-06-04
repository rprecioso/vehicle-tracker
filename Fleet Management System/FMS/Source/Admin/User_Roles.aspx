<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="User_Roles.aspx.cs" Inherits="FMS.Source.Admin.User_Roles" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadUserRoles">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadUserRoles" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadGrid ID="RadUserRoles" OnDetailTableDataBind="RadUserRoles_DetailTableDataBind" runat="server" DataSourceID="linq_user_roles"
        CellSpacing="0" OnItemCommand="RadUserRoles_ItemCommand" GridLines="None">
        <MasterTableView Width="500" AutoGenerateColumns="False"
            EditMode="InPlace" DataKeyNames="role_id" InsertItemDisplay="Top" CommandItemDisplay="Top"
            DataSourceID="linq_user_roles" HierarchyDefaultExpanded="True" Name="mas_role">
            <CommandItemSettings AddNewRecordText="Add new Role" />
            <DetailTables>
                <telerik:GridTableView Width="500" runat="server" DataKeyNames="mod_id,role_id"
                    Name="det_mod_per" AutoGenerateColumns="False">
                    <DetailTables>
                        <telerik:GridTableView Width="500" runat="server" EditMode="InPlace"
                            DataKeyNames="func_per_id"
                            Name="det_mod" AutoGenerateColumns="False" AllowAutomaticDeletes="True" AllowAutomaticInserts="True" AllowAutomaticUpdates="True">
                            <ParentTableRelation>
                                <telerik:GridRelationFields DetailKeyField="mod_id" MasterKeyField="mod_id" />
                                <telerik:GridRelationFields DetailKeyField="role_id" MasterKeyField="role_id" />
                            </ParentTableRelation>
                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                <HeaderStyle Width="20px" />
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                <HeaderStyle Width="20px" />
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridBoundColumn DataField="mod_per_id" FilterControlAltText="Filter mod_per_id column" Display="false" UniqueName="mod_per_id">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="func_id" FilterControlAltText="Filter func_id column" Display="false" UniqueName="func_id">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="function" FilterControlAltText="Filter function column" ReadOnly="True" UniqueName="function">
                                </telerik:GridBoundColumn>
                                <telerik:GridCheckBoxColumn DataField="permission" FilterControlAltText="Filter permission column" HeaderText="Allowed" UniqueName="permission">
                                </telerik:GridCheckBoxColumn>
                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column">
                                </telerik:GridEditCommandColumn>
                            </Columns>
                            <EditFormSettings EditFormType="Template">
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                                <FormTemplate>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblFunction" runat="server" Text='<%# Bind("function") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbxPermission" Checked='<%# Bind("permission") %>' runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <telerik:RadButton ID="btnUpdate" CommandName="Update" runat="server" Text="Update"></telerik:RadButton>
                                            </td>
                                            <td>
                                                <telerik:RadButton ID="btnCancel" CommandName="Cancel" runat="server" Text="Cancel"></telerik:RadButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:HiddenField ID="role_id" Value='<%# Bind("role_id") %>' runat="server" />
                                                <asp:HiddenField ID="mod_per_id" Value='<%# Bind("mod_per_id") %>' runat="server" />
                                                <asp:HiddenField ID="func_per_id" Value='<%# Bind("func_per_id") %>' runat="server" />
                                                <asp:HiddenField ID="func_id" Value='<%# Bind("func_id") %>' runat="server" />
                                                <asp:HiddenField ID="mod_id" Value='<%# Bind("mod_id") %>' runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </FormTemplate>
                            </EditFormSettings>
                        </telerik:GridTableView>
                    </DetailTables>
                    <ParentTableRelation>
                        <telerik:GridRelationFields DetailKeyField="role_id" MasterKeyField="role_id" />
                    </ParentTableRelation>
                    <CommandItemSettings ExportToPdfText="Export to PDF" />
                    <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                        <HeaderStyle Width="20px" />
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                        <HeaderStyle Width="20px" />
                    </ExpandCollapseColumn>
                    <Columns>
                        <telerik:GridBoundColumn DataField="module" EmptyDataText="No Module Data" FilterControlAltText="Filter module column" HeaderText="Modules Available" ReadOnly="True" UniqueName="module">
                        </telerik:GridBoundColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                        </EditColumn>
                    </EditFormSettings>
                </telerik:GridTableView>
            </DetailTables>
            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>

            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                <HeaderStyle Width="20px"></HeaderStyle>
            </ExpandCollapseColumn>

            <Columns>
                <telerik:GridBoundColumn DataField="role" FilterControlAltText="Filter role column" HeaderText="Role" SortExpression="role" UniqueName="role">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="description" FilterControlAltText="Filter description column" HeaderText="Description" SortExpression="description" UniqueName="description">
                </telerik:GridBoundColumn>
                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column">
                </telerik:GridEditCommandColumn>
            </Columns>

            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>


    </telerik:RadGrid>
    <asp:LinqDataSource ID="linq_user_roles" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="tblRoles" Where="user_id == @user_id">
        <WhereParameters>
            <asp:SessionParameter DefaultValue="0" Name="user_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="linq_mod_per" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="relMODPermissions" Where="role_id == @role_id">
        <WhereParameters>
            <asp:Parameter DefaultValue="0" Name="role_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="linq_func_per" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_perm_functions" Where="mod_id == @mod_id &amp;&amp; role_id == @role_id">
        <WhereParameters>
            <asp:Parameter DefaultValue="0" Name="mod_id" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="role_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="linq_mod_roles" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_module_roles" Where="role_id == @role_id">
        <WhereParameters>
            <asp:Parameter DefaultValue="0" Name="role_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
