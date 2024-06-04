<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="User_Access.aspx.cs" Inherits="FMS.Source.Child.User_Access" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    </telerik:RadScriptManager>

<%--    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadUserAccess">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadUserAccess" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>--%>

    <telerik:RadGrid ID="RadUserAccess" OnItemCommand="RadUserAccess_ItemCommand"
        runat="server" PageSize="10" 
        AutoGenerateEditColumn="True" CellSpacing="0" 
        DataSourceID="linq_user" GridLines="None">
        <MasterTableView Name="masterUsers" AutoGenerateColumns="False" InsertItemDisplay="Top" CommandItemDisplay="Top" DataKeyNames="child_id" DataSourceID="linq_user" HierarchyLoadMode="ServerBind">
            <CommandItemSettings ExportToPdfText="Export to PDF" AddNewRecordText="Insert new child account"></CommandItemSettings>
            <HeaderStyle HorizontalAlign="Center" />
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
                <telerik:GridBoundColumn DataField="child_id" Visible="false" DataType="System.Int32" FilterControlAltText="Filter child_id column" HeaderText="Child ID" ReadOnly="True" SortExpression="child_id" UniqueName="child_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="username" FilterControlAltText="Filter username column" HeaderText="Username" SortExpression="username" UniqueName="username">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="password" FilterControlAltText="Filter password column" HeaderText="Password" SortExpression="password" UniqueName="password" DataFormatString="******">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn FilterControlAltText="Filter column column" HeaderText="Role" UniqueName="column">
                    <ItemTemplate>
                        <telerik:RadComboBox ID="rcmbRole" ForeColor="Black" runat="server" DataSourceID="linq_role" Enabled="false"
                            SelectedValue='<%#Bind("role_id") %>' DataTextField="role" DataValueField="role_id">
                        </telerik:RadComboBox>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn FilterControlAltText="Filter column column" HeaderText="Parent" UniqueName="column">
                    <ItemTemplate>
                        <telerik:RadComboBox ID="rcmbParent" ForeColor="Black" runat="server" DataSourceID="linq_parent" Enabled="false"
                            SelectedValue='<%#Bind("parent_id") %>' DataTextField="username" DataValueField="usr_id">
                        </telerik:RadComboBox>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>

                <telerik:GridCheckBoxColumn DataField="active" Visible="false" DataType="System.Boolean" FilterControlAltText="Filter active column" HeaderText="Active" SortExpression="active" UniqueName="active">
                </telerik:GridCheckBoxColumn>

                <telerik:GridButtonColumn CommandName="Delete" ConfirmText="Are you sure you want to delete this Item ?"
                    ConfirmDialogType="RadWindow" Reorderable="False" Text="Delete" UniqueName="Delete_Column" ConfirmTitle="Delete Item" />
            </Columns>

            <EditFormSettings EditFormType="Template">
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                <FormTemplate>
                    <table>
                        <tr>
                            <td>
                                <telerik:RadTextBox Visible="false" runat="server" ID="tbx_User_ID" Text='<%#Bind("child_id") %>'></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Username</td>
                            <td>
                                <telerik:RadTextBox runat="server" ID="tbx_Username" Text='<%#Bind("username") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="tbx_Username" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Password</td>
                            <td>
                                <telerik:RadTextBox runat="server" ID="tbx_Password" Text='<%#Bind("password") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="tbx_Password" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>Role</td>
                            <td>
                                <telerik:RadComboBox ID="rcmbRole" ForeColor="Black" runat="server" DataSourceID="linq_role"
                                    SelectedValue='<%#Bind("role_id") %>' DataTextField="role" DataValueField="role_id">
                                </telerik:RadComboBox>

                            </td>
                        </tr>
                        <tr>
                            <td>Parent</td>
                            <td>
                                <telerik:RadComboBox ID="rcmbParent" ForeColor="Black" runat="server" DataSourceID="linq_parent" Enabled="false"
                                    SelectedValue='<%#Bind("parent_id") %>' DataTextField="username" DataValueField="usr_id">
                                </telerik:RadComboBox>
                            </td>
                        </tr>

                        <%--                     <tr>
                            <td>Active</td>
                            <td>
                                <asp:CheckBox runat="server" ID="cbx_Active" Checked='<%#Bind("active") %>' />
                            </td>
                        </tr>--%>
                        <td align="right">
                            <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                CausesValidation="true" ValidationGroup="insert"
                                OnClientClick="if(Page_ClientValidate()) try { return confirm('Are you sure you want to update the data?'); } catch(e){alert(e.message);}"></asp:Button>&nbsp;
                                <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                    CommandName="Cancel"></asp:Button>
                        </td>
                    </table>
                </FormTemplate>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>
    <asp:LinqDataSource ID="linq_user" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" EnableInsert="True" EnableUpdate="True" TableName="tblChildUsers" EnableDelete="True" Where="parent_id == @parent_id">
        <WhereParameters>
            <asp:SessionParameter DefaultValue="0" Name="parent_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="linq_parent" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="tblUsers" Where="usr_id == @usr_id">
        <WhereParameters>
            <asp:SessionParameter DefaultValue="0" Name="usr_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="linq_role" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="tblRoles" Where="user_id == @user_id">
        <WhereParameters>
            <asp:SessionParameter DefaultValue="0" Name="user_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
