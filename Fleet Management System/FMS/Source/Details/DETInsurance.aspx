<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DETInsurance.aspx.cs" Inherits="FMS.Source.Details.DETInsurance" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function CloseAndRebind(args) {
            GetRadWindow().close();
            GetRadWindow().BrowserWindow.refreshGrid(args);
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)

            return oWindow;
        }

        function CancelEdit() {
            GetRadWindow().close();
        }
    </script>
</head>
<body>

    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="DetVHCInsurance">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="DetVHCInsurance" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server"></telerik:RadAjaxLoadingPanel>

        <table id="tbForms" runat="server">
            <tr>
                <td></td>
            </tr>
            <tr>
                <td>
                    <asp:FormView ID="DetVHCInsurance" runat="server"
                        OnItemUpdating="DetVHCInsurance_ItemUpdating"
                        OnItemUpdated="DetVHCInsurance_ItemUpdated"
                        OnItemInserting="DetVHCInsurance_ItemInserting"
                        OnItemInserted="DetVHCInsurance_ItemInserted"
                        OnItemCommand="DetVHCInsurance_ItemCommand"
                        DataSourceID="linq_vhcinsurance" EmptyDataText="No Insurance Data Found" CellPadding="4" EnableModelValidation="True">
                        <%--OnItemCreated="DetVHCInsurance_ItemCreated"--%>
                        <ItemTemplate>
                            <table>
                                <tr>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <%--<tr>
                                    <td>VID
                                    </td>
                                    <td>
                                        <asp:Label ID="vidLabel" runat="server" Text='<%# Bind("vid") %>' />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td><strong>Vehicle Name</strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="vehicle_nameLabel" runat="server" Text='<%# Bind("vehicle_name") %>' />
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>Insurance ID
                                    </td>
                                    <td>
                                        <asp:Label ID="ins_idLabel" runat="server" Text='<%# Bind("ins_id") %>' />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td><strong>Company</strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="insurance_companyLabel" runat="server" Text='<%# Bind("insurance_company") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Certificate No.</strong>
                                     
                                    </td>
                                    <td>
                                        <asp:Label ID="cert_noLabel" runat="server" Text='<%# Bind("cert_no") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>   <strong>Issued</strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="issue_dateLabel" runat="server" Text='<%# Bind("issue_date","{0:yyyy-MM-dd}") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>   <strong>Expiry</strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="expiry_dateLabel" runat="server" Text='<%# Bind("expiry_date","{0:yyyy-MM-dd}") %>' />
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>Policy ID
                                    </td>
                                    <td>
                                        <asp:Label ID="policy_idLabel" runat="server" Text='<%# Bind("policy_id") %>' />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>   <strong>Policy Type</strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="policy_typeLabel" runat="server" Text='<%# Bind("policy_type") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>   <strong>Sum Insured</strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="sum_insuredLabel" runat="server" Text='<%# Bind("sum_insured","{0:n2}") %>' />
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>Takaful Contribution
                                    </td>
                                    <td>
                                        <asp:Label ID="takaful_contributionLabel" runat="server" Text='<%# Bind("takaful_contribution") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>No Claim Discount (NCD)
                                    </td>
                                    <td>
                                        <asp:Label ID="ncdLabel" runat="server" Text='<%# Bind("ncd") %>' />
                                    </td>
                                </tr>--%>
                                <%--<tr>
                                    <td>User ID
                                    </td>
                                    <td>
                                        <asp:Label ID="usr_idLabel" runat="server" Text='<%# Bind("usr_id") %>' />
                                    </td>
                                </tr>--%>
                          
                            </table>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="insert" />
                            <telerik:RadTextBox ID="ins_idLabel" runat="server" Text='<%# Bind("ins_id") %>' Visible="false" />
                            <table>
                                <tr>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <%--<tr>
                                    <td>VID
                                    </td>
                                    <td>
                                        <asp:Label ID="vidLabel" runat="server" Text='<%# Bind("vid") %>' />
                                    </td>
                                </tr>--%>
                                <tr>
                                    
                                    <td><strong>Vehicle Name</strong>
                                    </td>
                                    <td>
                                        <telerik:RadComboBox runat="server" DataSourceID="linq_vehicle"
                                            DataValueField="vid" DataTextField="vehicle_name"
                                            SelectedValue='<%#Bind("vid") %>' ID="rcmbVehicle">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>Insurance ID
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="ins_idLabel" runat="server" Text='<%# Bind("ins_id") %>' />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td><strong>Company</strong>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="insurance_companyLabel" runat="server" Text='<%# Bind("insurance_company") %>' />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="insurance_companyLabel" ErrorMessage="Company is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Certificate No.</strong>
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="cert_noLabel" runat="server" Text='<%# Bind("cert_no") %>' />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="cert_noLabel" ErrorMessage="Certificate No. is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Issued</strong>
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker MinDate="1/1/1900" runat="server"  MaxDate="12/12/3000" ID="rdpIssueeDate"
                                            DbSelectedDate='<%#Bind("issue_date") %>' DateInput-DisplayText='<%#Bind("issue_date","{0:yyyy-MM-dd}") %>'>
                                            <DateInput ID="DateInput1" runat="server" DateFormat="yyyy-MM-dd">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RangeValidator ID="DateInputRangeValidator" runat="server" ControlToValidate="rdpIssueeDate"
                                            ErrorMessage="Input a proper date"
                                            Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                                        <asp:RequiredFieldValidator ID="PickerRequiredFieldValidator" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="rdpIssueeDate" ErrorMessage="Issue Date is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Expiry</strong>Expiry 
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker MinDate="1/1/1900" runat="server"  MaxDate="12/12/3000" ID="rdpExpiryDate"
                                            DbSelectedDate='<%#Bind("expiry_date") %>' DateInput-DisplayText='<%#Bind("expiry_date","{0:yyyy-MM-dd}") %>' >
                                            <DateInput ID="DateInput2" runat="server" DateFormat="yyyy-MM-dd">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="rdpExpiryDate"
                                            ErrorMessage="Input a proper date"
                                            Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="rdpExpiryDate" ErrorMessage="Expiry Date is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>Policy ID
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="policy_idLabel" runat="server" Text='<%# Bind("policy_id") %>' />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td><strong>Policy Type</strong>
                                    </td>
                                    <td>
                                        <%--<asp:Label ID="policy_idLabel" runat="server" Text='<%# Bind("policy_type_id") %>' />--%>
                                        <telerik:RadComboBox runat="server" DataSourceID="linq_insurancepolicy"
                                            DataValueField="policy_type_id" DataTextField="policy_type"
                                            SelectedValue='<%#Bind("policy_type_id") %>' ID="rcmbPolicyType">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Insured Amount
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="sum_insuredLabel" runat="server" Type="Number" Text='<%# Bind("sum_insured") %>' />
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>Takaful Contribution
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="takaful_contributionLabel" runat="server" Text='<%# Bind("takaful_contribution") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>No Claim Discount (NCD)
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="ncdLabel" runat="server" Text='<%# Bind("ncd") %>' />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td></td>
                                    <td>
                                        <telerik:RadButton ID="lbtnSave" runat="server" Text="Save" CommandName="Update" ValidationGroup="insert" />
                                        <telerik:RadButton ID="lbtnCancel" runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false" />
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>User ID
                                    </td>
                                    <td>
                                        <asp:Label ID="usr_idLabel" runat="server" Text='<%# Bind("usr_id") %>' />
                                    </td>
                                </tr>--%>
                            </table>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="insert" />
                            <telerik:RadTextBox ID="ins_idLabel" runat="server" Text='<%# Bind("ins_id") %>' Visible="false" />
                            <table>
                                <tr>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <%--<tr>
                                    <td>VID
                                    </td>
                                    <td>
                                        <asp:Label ID="vidLabel" runat="server" Text='<%# Bind("vid") %>' />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>Vehicle Name
                                    </td>
                                    <td>
                                        <telerik:RadComboBox runat="server" DataSourceID="linq_vehicle"
                                            DataValueField="vid" DataTextField="vehicle_name"
                                            SelectedValue='<%#Bind("vid") %>' ID="rcmbVehicle">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>Insurance ID
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="ins_idLabel" runat="server" Text='<%# Bind("ins_id") %>' />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>Company
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="insurance_companyLabel" runat="server" Text='<%# Bind("insurance_company") %>' />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="insurance_companyLabel" ErrorMessage="Company is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Certificate No.
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="cert_noLabel" runat="server" Text='<%# Bind("cert_no") %>' />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="cert_noLabel" ErrorMessage="Certificate No. is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Issued
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker MinDate="1/1/1900" runat="server"  MaxDate="12/12/3000" ID="rdpIssueeDate"
                                            DbSelectedDate='<%#Bind("issue_date") %>' DateInput-DisplayText='<%#Bind("issue_date","{0:yyyy-MM-dd}") %>'>
                                            <DateInput ID="DateInput1" runat="server" DateFormat="yyyy-MM-dd">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RangeValidator ID="DateInputRangeValidator" runat="server" ControlToValidate="rdpIssueeDate"
                                            ErrorMessage="Input a proper date"
                                            Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                                        <asp:RequiredFieldValidator ID="PickerRequiredFieldValidator" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="rdpIssueeDate" ErrorMessage="Issue Date is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Expiry 
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker MinDate="1/1/1900" runat="server"  MaxDate="12/12/3000" ID="rdpExpiryDate"
                                            DbSelectedDate='<%#Bind("expiry_date") %>' DateInput-DisplayText='<%#Bind("expiry_date","{0:yyyy-MM-dd}") %>' >
                                            <DateInput ID="DateInput2" runat="server" DateFormat="yyyy-MM-dd">
                                            </DateInput>
                                        </telerik:RadDatePicker>
                                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="rdpExpiryDate"
                                            ErrorMessage="Input a proper date"
                                            Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="insert"
                                            ControlToValidate="rdpExpiryDate" ErrorMessage="Expiry Date is required." Text="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>Policy ID
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="policy_idLabel" runat="server" Text='<%# Bind("policy_id") %>' />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>Policy Type
                                    </td>
                                    <td>
                                        <%--<asp:Label ID="policy_idLabel" runat="server" Text='<%# Bind("policy_type_id") %>' />--%>
                                        <telerik:RadComboBox runat="server" DataSourceID="linq_insurancepolicy"
                                            DataValueField="policy_type_id" DataTextField="policy_type"
                                            SelectedValue='<%#Bind("policy_type_id") %>' ID="rcmbPolicyType">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Insured Amount
                                    </td>
                                    <td>
                                        <telerik:RadNumericTextBox ID="sum_insuredLabel" runat="server" Type="Number" Text='<%# Bind("sum_insured") %>' />
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>Takaful Contribution
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="takaful_contributionLabel" runat="server" Text='<%# Bind("takaful_contribution") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>No Claim Discount (NCD)
                                    </td>
                                    <td>
                                        <telerik:RadTextBox ID="ncdLabel" runat="server" Text='<%# Bind("ncd") %>' />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td></td>
                                    <td>
                                        <telerik:RadButton ID="lbtnSave" runat="server" Text="Save" CommandName="Add" ValidationGroup="insert" />
                                        <telerik:RadButton ID="lbtnCancel" runat="server" Text="Cancel" CommandName="Cancel" CausesValidation="false" />
                                    </td>
                                </tr>
                                <%--<tr>
                                    <td>User ID
                                    </td>
                                    <td>
                                        <asp:Label ID="usr_idLabel" runat="server" Text='<%# Bind("usr_id") %>' />
                                    </td>
                                </tr>--%>
                            </table>
                        </InsertItemTemplate>

                    </asp:FormView>
                </td>
            </tr>
        </table>


        <asp:LinqDataSource ID="linq_vehicle" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" Where="usr_id == @usr_id" TableName="vw_user_vehicles">
            <WhereParameters>
                <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" DefaultValue="0" />
            </WhereParameters>
        </asp:LinqDataSource>

        <asp:LinqDataSource ID="linq_vhcinsurance" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_vehicle_insurances" Where="ins_id == @ins_id">
            <WhereParameters>
                <asp:QueryStringParameter Name="ins_id" QueryStringField="id" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>

        <asp:LinqDataSource ID="linq_insurancepolicy" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="refINSPolicyTypes">
        </asp:LinqDataSource>

        <asp:LinqDataSource ID="linq_driver" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_driver_names" Where="usr_id == @usr_id">
            <WhereParameters>
                <asp:SessionParameter Name="usr_id" SessionField="parent_id" Type="Int32" DefaultValue="0" />
            </WhereParameters>
        </asp:LinqDataSource>

    </form>
</body>
</html>
