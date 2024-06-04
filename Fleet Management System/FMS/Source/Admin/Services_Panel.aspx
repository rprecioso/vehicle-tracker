<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Services_Panel.aspx.cs" Inherits="FMS.Source.Child.Services_Panel" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <telerik:RadGrid ID="RadGrid1" runat="server" PageSize="10"  AllowPaging="True"
        OnItemCommand="RadGrid1_ItemCommand" OnPreRender="RadGrid1_PreRender"
        AllowSorting="True" AutoGenerateEditColumn="True" CellSpacing="0"
        DataSourceID="linq_services" GridLines="None" AllowAutomaticDeletes="True"
        AllowAutomaticInserts="True" AllowAutomaticUpdates="True">

        <MasterTableView AutoGenerateColumns="False" DataKeyNames="srv_id" CommandItemDisplay="Top" InsertItemDisplay="Top" DataSourceID="linq_services">
            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
            <HeaderStyle HorizontalAlign="Center" />
            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
            </RowIndicatorColumn>

            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
            </ExpandCollapseColumn>

            <Columns>
                <telerik:GridTemplateColumn FilterControlAltText="Filter column column" ReadOnly="true" HeaderText="No" UniqueName="column">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Container.DataSetIndex+1 %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="srv_id" DataType="System.Int32"
                    FilterControlAltText="Filter srv_id column" HeaderText="srv_id"
                    Visible="false"
                    ReadOnly="True" SortExpression="srv_id" UniqueName="srv_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="service" FilterControlAltText="Filter service column" HeaderText="service" SortExpression="service" UniqueName="service">
                </telerik:GridBoundColumn>
                <telerik:GridCheckBoxColumn DataField="active" DataType="System.Boolean"
                    FilterControlAltText="Filter active column" HeaderText="active"
                    Visible="false"
                    SortExpression="active" UniqueName="active">
                </telerik:GridCheckBoxColumn>
                <telerik:GridBoundColumn DataField="usr_id" DataType="System.Int32"
                    Visible="false"
                    FilterControlAltText="Filter usr_id column" HeaderText="usr_id"
                    SortExpression="usr_id" UniqueName="usr_id">
                </telerik:GridBoundColumn>
            </Columns>

            <EditFormSettings EditFormType="Template">
                <EditColumn FilterControlAltText="Filter EditCommandColumn column"></EditColumn>
                <FormTemplate>
                    <table width="50%" border="0" rules="none" cellpadding="1" cellspacing="0">
                        <tr>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadTextBox ReadOnly="true" Visible="false" ValidationGroup="insert"
                                    ID="tbxSrvid" runat="server" Text='<%#Bind("srv_id") %>'>
                                </telerik:RadTextBox>
                            </td>
                        </tr>

                        <tr>
                            <td>Service Name</td>
                            <td>
                                <telerik:RadTextBox ID="tbxService" runat="server" Text='<%#Bind("service") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="tbxService" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td align="right">
                                <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                    runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' CausesValidation="true" ValidationGroup="insert"
                                    OnClientClick="if(Page_ClientValidate()) try { return confirm('Are you sure you want to update the data?'); } catch(e){alert(e.message);}"></asp:Button>&nbsp;                               
                                <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                    CommandName="Cancel"></asp:Button>
                            </td>
                        </tr>
                    </table>
                </FormTemplate>
            </EditFormSettings>
        </MasterTableView>

        <FilterMenu EnableImageSprites="False"></FilterMenu>
    </telerik:RadGrid>
    <asp:LinqDataSource ID="linq_services" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="refServices" Where="usr_id == @usr_id">
        <WhereParameters>
            <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
