<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Vendors_Panel.aspx.cs" Inherits="FMS.Source.Admin.Vendors_Panel" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function ShowFlagForm(id, type) {
            window.radopen("/Source/Details/DETFlag.aspx?id=" + id + "&type=" + type, "vhcFlagDialog");
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
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" OnAjaxRequest="RadAjaxManager1_AjaxRequest">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="vhcFlagDialog" runat="server" Title="Reason for Flagging" Height="30px"
                Width="500px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleStatusbar="false">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <telerik:RadGrid ID="RadGrid1" OnPreRender="RadGrid1_PreRender" OnItemCommand="RadGrid1_ItemCommand" OnItemDataBound="RadGrid1_ItemDataBound"
        runat="server" PageSize="10" DataSourceID="linq_vendors" AllowAutomaticInserts="True"
        AllowAutomaticUpdates="True" AutoGenerateEditColumn="True" CellSpacing="0" AllowPaging="true"
        GridLines="None">
        <MasterTableView AutoGenerateColumns="False" DataKeyNames="vend_id" EditMode="EditForms" CommandItemDisplay="Top" InsertItemDisplay="Top" DataSourceID="linq_vendors">
            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
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
                <telerik:GridBoundColumn DataField="vend_id" DataType="System.Int32"
                    FilterControlAltText="Filter vend_id column" HeaderText="vend_id"
                    Visible="false"
                    ReadOnly="True" SortExpression="vend_id" UniqueName="vend_id">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="vendor" FilterControlAltText="Filter vendor column" HeaderText="Vendor" SortExpression="vendor" UniqueName="vendor">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="contact" FilterControlAltText="Filter contact column" HeaderText="Contact Person" SortExpression="contact" UniqueName="contact">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="address" FilterControlAltText="Filter address column" HeaderText="Address" SortExpression="address" UniqueName="address">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="contact_phone" FilterControlAltText="Filter contact column" HeaderText="Phone No." SortExpression="contact_phone" UniqueName="contact_phone">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="tin_no" FilterControlAltText="Filter tin_no column" HeaderText="TIN No." SortExpression="tin_no" UniqueName="tin_no">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="contact_email" FilterControlAltText="Filter contact column" HeaderText="Email" SortExpression="contact_email" UniqueName="contact_email">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="website" FilterControlAltText="Filter contact column" HeaderText="Website" SortExpression="website" UniqueName="website" Display="false">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn FilterControlAltText="Filter website_link column" ReadOnly="true" HeaderText="Website" UniqueName="website_link">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnk_website" runat="server" Text='<%# Eval("website") %>' NavigateUrl='<%# "http://" + Eval("website") %>' Target="_blank"></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn FilterControlAltText="Filter reason_elipse column" ReadOnly="true" UniqueName="reason_elipse" Reorderable="False" HeaderText="Flag Reason" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lbl_reason" runat="server" Text='<%#Eval("flag_reason").ToString().Length > 5 ? Eval("flag_reason").ToString().Substring(0, 5) + "..." : Eval("flag_reason").ToString()%>' />
                        <telerik:RadToolTip ID="tipRemarks" runat="server" TargetControlID="lbl_reason" Skin="Metro" Text='<%#Eval("flag_reason")%>'>
                        </telerik:RadToolTip>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Flag" HeaderStyle-Width="30px" ImageUrl="~/Design/flagging_images/unflagged.png" Text="Flag" UniqueName="btn_flag">
                    <HeaderStyle Width="40px" />
                </telerik:GridButtonColumn>
                <telerik:GridBoundColumn DataField="flag_reason" FilterControlAltText="Filter flag_reason column" HeaderText="flag_reason" SortExpression="flag_reason" UniqueName="flag_reason" Display="false">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="flag" FilterControlAltText="Filter flag column" HeaderText="flag" SortExpression="flag" UniqueName="flag" Display="false">
                </telerik:GridBoundColumn>

                <telerik:GridBoundColumn DataField="user_id" DataType="System.Int32"
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
                                    ID="tbxVendID" runat="server" Text='<%#Bind("vend_id") %>'>
                                </telerik:RadTextBox>
                            </td>
                        </tr>

                        <tr>
                            <td>Name</td>
                            <td>
                                <telerik:RadTextBox ID="tbxVendor" runat="server" Text='<%#Bind("vendor") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="tbxVendor" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                            </td>
                        </tr>


                        <tr>
                            <td>Contact Person</td>
                            <td>
                                <telerik:RadTextBox ID="tbxContact" runat="server" Text='<%#Bind("contact") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="tbxContact" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td>Address</td>
                            <td>
                                <telerik:RadTextBox ID="tbxAddress" runat="server" Text='<%#Bind("address") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="tbxAddress" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td>Phone No.</td>
                            <td>
                                <telerik:RadNumericTextBox ID="tbxPhoneNo" Type="Number" runat="server" Text='<%#Bind("contact_phone") %>'>
                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="tbxPhoneNo" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td>TIN No.</td>
                            <td>
                                <telerik:RadNumericTextBox ID="tbxTIN" runat="server" Text='<%#Bind("tin_no") %>' InputType="Number" >     
                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />                               
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="tbxTIN" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td>Email</td>
                            <td>
                                <telerik:RadTextBox ID="tbxEmail" runat="server" Text='<%#Bind("contact_email") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="tbxEmail" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <tr>
                            <td>Website</td>
                            <td>
                                <telerik:RadTextBox ID="tbxWebsite" runat="server" Text='<%#Bind("website") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ValidationGroup="insert"
                                    ControlToValidate="tbxWebsite" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                    runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' CausesValidation="true" ValidationGroup="insert"
                                    ></asp:Button>&nbsp;                               
                                <%-- OnClientClick="if(Page_ClientValidate()) try { return confirm('Are you sure you want to update the data?'); } catch(e){alert(e.message);}" --%>
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
    <asp:LinqDataSource ID="linq_vendors" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="tblVendors" Where="user_id == @usr_id">
        <WhereParameters>
            <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
