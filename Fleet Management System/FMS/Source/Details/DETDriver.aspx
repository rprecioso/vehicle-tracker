<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DETDriver.aspx.cs" Inherits="FMS.Source.Details.DETDriver" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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

        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <div>
            <asp:FormView runat="server" ID="DetDriver"
                OnItemUpdating="DetDriver_ItemUpdating"
                OnItemUpdated="DetDriver_ItemUpdated"
                OnItemInserting="DetDriver_ItemInserting"
                OnItemInserted="DetDriver_ItemInserted"
                OnItemCommand="DetDriver_ItemCommand"
                OnItemCreated="DetDriver_ItemCreated"
                DataKeyNames="drv_id"
                EmptyDataText="No Driver Data Found"
                EnableModelValidation="True"
                DataSourceID="linq_drv_details">

                <EmptyDataTemplate>
                    There is nothing to see here.
                </EmptyDataTemplate>
                <ItemTemplate>
                    <table>
                        <tr>
                            <td colspan="2" style="text-align: center">
                                <asp:Image ID="imgVehicle" ImageUrl='<%# "~/Source/Details/ImageHandler.ashx?type=driver&id=" + Eval("drv_id") %>' runat="server" Width="150" Height="150" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadTextBox ID="tbx_drv_id" Visible="false" runat="server" Text='<%#Bind("drv_id")%>' />
                                <telerik:RadTextBox ID="tbx_sal_id" Visible="false" runat="server" Text='<%#Bind("sal_id")%>' />
                                <telerik:RadTextBox ID="tbx_emp_sta_id" Visible="false" runat="server" Text='<%#Bind("emp_sta_id")%>' />
                                <telerik:RadTextBox ID="tbx_drv_lic_id" Visible="false" runat="server" Text='<%#Bind("drv_lic_id")%>' />
                            </td>
                        </tr>

                        <tr>
                            <td><strong>Employee ID</strong></td>
                            <td>
                                
                                    <asp:Label ID="tbx_emp_id" runat="server" Text='<%#Bind("emp_id")%>' />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>First Name</strong></td>
                            <td>
                                
                                    <asp:Label ID="tbx_first_name" runat="server" InputType="Text" Text='<%#Bind("first_name")%>' />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Last Name</strong></td>
                            <td>
                                
                                    <asp:Label ID="tbx_last_name" runat="server" Text='<%#Bind("last_name")%>' />
                            </td>
                        </tr>

                        <tr>
                            <td><strong>Mobile No.</strong></td>
                            <td>
                                
                                    <asp:Label ID="tbx_mobile_no" runat="server" Text='<%#Bind("mobile_no")%>' />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Phone No.</strong></td>
                            <td>
                                
                                    <asp:Label ID="tbx_phone_no" InputType="Number" runat="server" Text='<%#Bind("phone_no")%>' />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Home Address</strong></td>
                            <td>
                                
                                    <asp:Label ID="tbx_home_address" TextMode="MultiLine" runat="server" Text='<%#Bind("home_address")%>' />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Birth Date</strong></td>
                            <td>
                                
                                    <asp:Label runat="server" Text='<%#Bind("birth_date","{0:yyyy-MM-dd}") %>' ID="rdp_birth_date" />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>ID Type</strong></td>
                            <td>
                                
                                    <asp:Label ID="tbx_gov_id" runat="server" Text='<%#Bind("gov_id")%>' />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>ID No.</strong></td>
                            <td>
                                
                                    <asp:Label ID="tbx_gov_id_no" runat="server" Text='<%#Bind("gov_id_no")%>' />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Salary Type</strong></td>
                            <td>
                                
                                    <asp:Label ID="rcmb_salary" runat="server" Text='<%#Bind("salary_type") %>' />


                            </td>
                        </tr>
                        <tr>
                            <td><strong>Salary</strong></td>
                            <td>
                                
                                    <asp:Label ID="tbx_salary" InputType="Number" runat="server" Text='<%#Bind("salary", "{0:n0}")%>' />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Employment Status</strong></td>
                            <td>
                                
                                    <asp:Label ID="rcmb_emp_status" runat="server" Text='<%#Bind("emp_status") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Hire Date</strong></td>
                            <td>
                                
                                    <asp:Label runat="server" Text='<%#Bind("hire_date","{0:yyyy-MM-dd}") %>' ID="rdp_hire_date" />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>License Type</strong></td>
                            <td>
                                
                                    <asp:Label ID="tbx_license_type" Text='<%#Bind("license_type") %>' runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td><strong>License No.</strong></td>
                            <td>
                                
                                    <asp:Label runat="server" ID="tbx_license_no" Text='<%#Bind("license_no") %>' />
                            </td>

                        </tr>
                        <tr>
                            <td><strong>License Expiry</strong></td>
                            <td>
                                
                                    <asp:Label runat="server" Text='<%#Bind("license_expiry_date","{0:yyyy-MM-dd}") %>' ID="rdp_license_expiry_date" />
                            </td>
                        </tr>
                    </table>

                </ItemTemplate>
                <EditItemTemplate>
                    <table>
                        <tr>
                            <td colspan="2" style="text-align: center">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align: center">
                                <asp:Image ID="imgVehicle" ImageUrl='<%# "~/Source/Details/ImageHandler.ashx?type=driver&id=" + Eval("drv_id") %>' runat="server" Width="150" Height="150" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:FileUpload ID="fpFile" runat="server" />
                            </td>

                        </tr>
                        <%--                    <tr>
                            <td colspan="2">
                                <telerik:RadButton ID="btnSaveImage" runat="server" Text="Save Image"></telerik:RadButton>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>
                                <telerik:RadTextBox ID="tbx_drv_id" Visible="false" runat="server" Text='<%#Bind("drv_id")%>' />
                                <telerik:RadTextBox ID="tbx_sal_id" Visible="false" runat="server" Text='<%#Bind("sal_id")%>' />
                                <telerik:RadTextBox ID="tbx_emp_sta_id" Visible="false" runat="server" Text='<%#Bind("emp_sta_id")%>' />
                                <telerik:RadTextBox ID="tbx_drv_lic_id" Visible="false" runat="server" Text='<%#Bind("drv_lic_id")%>' />
                            </td>
                        </tr>

                        <tr>
                            <td>Employee ID</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_emp_id" runat="server" Text='<%#Bind("emp_id")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ErrorMessage="Employee ID is required." ControlToValidate="tbx_emp_id" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>First Name</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_first_name" runat="server" InputType="Text" Text='<%#Bind("first_name")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                    ErrorMessage="First Name is required." ControlToValidate="tbx_first_name" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Last Name</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_last_name" runat="server" Text='<%#Bind("last_name")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                    ErrorMessage="Last Name is required." ControlToValidate="tbx_last_name" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>

                        <tr>
                            <td>Mobile No.</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_mobile_no" InputType="Number" runat="server" Text='<%#Bind("mobile_no")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                    ErrorMessage="Mobile No. is required." ControlToValidate="tbx_mobile_no" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Phone No.</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_phone_no" InputType="Number" runat="server" Text='<%#Bind("phone_no")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                    ErrorMessage="Phone No. is required." ControlToValidate="tbx_phone_no" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Home Address</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_home_address" TextMode="MultiLine" runat="server" Text='<%#Bind("home_address")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                    ErrorMessage="Home Address is required." ControlToValidate="tbx_home_address" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Birth Date</td>
                            <td>
                                <telerik:RadDatePicker MinDate="1/1/1900" runat="server" DbSelectedDate='<%#Bind("birth_date") %>' ID="rdp_birth_date" DateInput-DateFormat="yyyy-MM-dd" DateInput-DisplayText='<%#Bind("birth_date","{0:yyyy-MM-dd}") %>' >
                                    <DateInput ID="DateInput1" runat="server" DateFormat="yyyy-MM-dd"/>
                                </telerik:RadDatePicker>                                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                                    ErrorMessage="Birth Date is required." ControlToValidate="rdp_birth_date" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>ID Type</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_gov_id" runat="server" Text='<%#Bind("gov_id")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                    ErrorMessage="ID Type is required." ControlToValidate="tbx_gov_id" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>ID No.</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_gov_id_no" runat="server" Text='<%#Bind("gov_id_no")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server"
                                    ErrorMessage="ID No. is required." ControlToValidate="tbx_gov_id_no" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Salary Type</td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_salary" runat="server" SelectedValue='<%#Bind("sal_id") %>'
                                    DataSourceID="linq_salary" DataTextField="type" DataValueField="sal_id">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server"
                                    ErrorMessage="Salary Type is required." ControlToValidate="rcmb_salary" Text="*"
                                    ValidationGroup="edit" />

                            </td>
                        </tr>
                        <tr>
                            <td>Salary</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_salary" InputType="Number" runat="server" Text='<%#Bind("salary")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server"
                                    ErrorMessage="Salary Type is required." ControlToValidate="rcmb_salary" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Employment Status</td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_emp_status" runat="server" SelectedValue='<%#Bind("emp_sta_id") %>'
                                    DataSourceID="linq_emp_status" DataTextField="status"
                                    DataValueField="emp_sta_id">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server"
                                    ErrorMessage="Employment Status is required." ControlToValidate="rcmb_emp_status" Text="*"
                                    ValidationGroup="edit" />

                            </td>
                        </tr>
                        <tr>
                            <td>Hire Date</td>
                            <td>
                                <telerik:RadDatePicker MinDate="1/1/1900" runat="server" DbSelectedDate='<%#Bind("hire_date") %>' ID="rdp_hire_date" DateInput-DisplayDateFormat="yyyy-MM-dd" DateInput-DateFormat="yyyy-MM-dd" DateInput-DisplayText='<%#Bind("hire_date","{0:yyyy-MM-dd}") %>' >
                                    <DateInput ID="DateInput5" runat="server" DateFormat="yyyy-MM-dd"/>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server"
                                    ErrorMessage="Hire Date is required." ControlToValidate="rdp_hire_date" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>License Type</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_license_type" Text='<%#Bind("license_type") %>' runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server"
                                    ErrorMessage="License Type is required." ControlToValidate="tbx_license_type" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>License No.</td>
                            <td>
                                <telerik:RadTextBox runat="server" ID="tbx_license_no" Text='<%#Bind("license_no") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server"
                                    ErrorMessage="License No. is required." ControlToValidate="tbx_license_no" Text="*"
                                    ValidationGroup="edit" />
                            </td>

                        </tr>
                        <tr>
                            <td>License Expiry Date</td>
                            <td>
                                <telerik:RadDatePicker MinDate="1/1/1900" runat="server" DbSelectedDate='<%#Bind("license_expiry_date") %>' ID="rdp_license_expiry_date" DateInput-DisplayDateFormat="yyyy-MM-dd" DateInput-DateFormat="yyyy-MM-dd" DateInput-DisplayText='<%#Bind("license_expiry_date","{0:yyyy-MM-dd}") %>' >
                                    <DateInput ID="DateInput2" runat="server" DateFormat="yyyy-MM-dd"/>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server"
                                    ErrorMessage="License Expiry Date is required." ControlToValidate="rdp_license_expiry_date" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadButton ID="lbtnSave" runat="server" Text="Save" CommandName="Update"
                                    OnClientClick="if(Page_ClientValidate())try { return confirm('Are you sure you want to update the data?'); } catch(e){alert(e.message);}"
                                    CausesValidation="true" ValidationGroup="edit" />
                                <telerik:RadButton ID="lbtnCancel" runat="server" Text="Cancel" CommandName="Cancel"
                                    OnClientClick="if(Page_ClientValidate())try { return confirm('Are you sure you want to cancel the input of data?'); } catch(e){alert(e.message);}"
                                    CausesValidation="false" />
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <table>
                        <tr>
                            <td colspan="2" style="text-align: center">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <telerik:RadTextBox ID="tbx_drv_id" Visible="false" runat="server" Text='<%#Bind("drv_id")%>' />
                                <telerik:RadTextBox ID="tbx_sal_id" Visible="false" runat="server" Text='<%#Bind("sal_id")%>' />
                                <telerik:RadTextBox ID="tbx_emp_sta_id" Visible="false" runat="server" Text='<%#Bind("emp_sta_id")%>' />
                                <telerik:RadTextBox ID="tbx_drv_lic_id" Visible="false" runat="server" Text='<%#Bind("drv_lic_id")%>' />
                            </td>
                        </tr>
                        <tr>
                            <td>Photo</td>
                            <td>
                                <asp:FileUpload ID="fpFile" runat="server" />
                            </td>

                        </tr>
                        <tr>
                            <td>Employee ID</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_emp_id" runat="server" Text='<%#Bind("emp_id")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                    ErrorMessage="Employee ID is required." ControlToValidate="tbx_emp_id" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>First Name</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_first_name" runat="server" InputType="Text" Text='<%#Bind("first_name")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                    ErrorMessage="First Name is required." ControlToValidate="tbx_first_name" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Last Name</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_last_name" runat="server" Text='<%#Bind("last_name")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                    ErrorMessage="Last Name is required." ControlToValidate="tbx_last_name" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>

                        <tr>
                            <td>Mobile No.</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_mobile_no" InputType="Number" runat="server" Text='<%#Bind("mobile_no")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                    ErrorMessage="Mobile No. is required." ControlToValidate="tbx_mobile_no" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Phone No.</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_phone_no" InputType="Number" runat="server" Text='<%#Bind("phone_no")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                    ErrorMessage="Phone No. is required." ControlToValidate="tbx_phone_no" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Home Address</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_home_address" TextMode="MultiLine" runat="server" Text='<%#Bind("home_address")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                    ErrorMessage="Home Address is required." ControlToValidate="tbx_home_address" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Birth Date</td>
                            <td>
                                <telerik:RadDatePicker MinDate="1/1/1900" runat="server" DbSelectedDate='<%#Bind("birth_date") %>' ID="rdp_birth_date" DateInput-DateFormat="yyyy-MM-dd" DateInput-DisplayText='<%#Bind("birth_date","{0:yyyy-MM-dd}") %>' > 
                                    <DateInput ID="DateInput1" runat="server" DateFormat="yyyy-MM-dd"/>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                                    ErrorMessage="Birth Date is required." ControlToValidate="rdp_birth_date" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>ID Type</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_gov_id" runat="server" Text='<%#Bind("gov_id")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server"
                                    ErrorMessage="ID Type is required." ControlToValidate="tbx_gov_id" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>ID No.</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_gov_id_no" runat="server" Text='<%#Bind("gov_id_no")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server"
                                    ErrorMessage="ID No. is required." ControlToValidate="tbx_gov_id_no" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Salary Type</td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_salary" runat="server" SelectedValue='<%#Bind("sal_id") %>'
                                    DataSourceID="linq_salary" DataTextField="type" DataValueField="sal_id">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server"
                                    ErrorMessage="Salary Type is required." ControlToValidate="rcmb_salary" Text="*"
                                    ValidationGroup="edit" />

                            </td>
                        </tr>
                        <tr>
                            <td>Salary</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_salary" InputType="Number" runat="server" Text='<%#Bind("salary")%>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server"
                                    ErrorMessage="Salary Type is required." ControlToValidate="rcmb_salary" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>Employment Status</td>
                            <td>
                                <telerik:RadComboBox ID="rcmb_emp_status" runat="server" SelectedValue='<%#Bind("emp_sta_id") %>'
                                    DataSourceID="linq_emp_status" DataTextField="status"
                                    DataValueField="emp_sta_id">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server"
                                    ErrorMessage="Employment Status is required." ControlToValidate="rcmb_emp_status" Text="*"
                                    ValidationGroup="edit" />

                            </td>
                        </tr>
                        <tr>
                            <td>Hire Date</td>
                            <td>
                                <telerik:RadDatePicker MinDate="1/1/1900" runat="server" DbSelectedDate='<%#Bind("hire_date") %>' ID="rdp_hire_date" DateInput-DisplayDateFormat="yyyy-MM-dd" DateInput-DateFormat="yyyy-MM-dd" DateInput-DisplayText='<%#Bind("hire_date","{0:yyyy-MM-dd}") %>' >
                                    <DateInput ID="DateInput4" runat="server" DateFormat="yyyy-MM-dd"/>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server"
                                    ErrorMessage="Hire Date is required." ControlToValidate="rdp_hire_date" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>License Type</td>
                            <td>
                                <telerik:RadTextBox ID="tbx_license_type" Text='<%#Bind("license_type") %>' runat="server" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server"
                                    ErrorMessage="License Type is required." ControlToValidate="tbx_license_type" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td>License No.</td>
                            <td>
                                <telerik:RadTextBox runat="server" ID="tbx_license_no" Text='<%#Bind("license_no") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server"
                                    ErrorMessage="License No. is required." ControlToValidate="tbx_license_no" Text="*"
                                    ValidationGroup="edit" />
                            </td>

                        </tr>
                        <tr>
                            <td>License Expiry</td>
                            <td>
                                <telerik:RadDatePicker MinDate="1/1/1900" runat="server" DbSelectedDate='<%#Bind("license_expiry_date") %>' ID="rdp_license_expiry_date" DateInput-DisplayDateFormat="yyyy-MM-dd" DateInput-DateFormat="yyyy-MM-dd" DateInput-DisplayText='<%#Bind("license_expiry_date","{0:yyyy-MM-dd}") %>' >
                                    <DateInput ID="DateInput3" runat="server" DateFormat="yyyy-MM-dd"/>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server"
                                    ErrorMessage="License Expiry Date is required." ControlToValidate="rdp_license_expiry_date" Text="*"
                                    ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadButton ID="RadButton1" runat="server" Text="Save" CommandName="Add"
                                    OnClientClick="if(Page_ClientValidate())try { return confirm('Are you sure you want to save the data?'); } catch(e){alert(e.message);}"
                                    CausesValidation="true" ValidationGroup="edit" />
                                <telerik:RadButton ID="RadButton2" runat="server" Text="Cancel" CommandName="Cancel"
                                    OnClientClick="if(Page_ClientValidate())try { return confirm('Are you sure you want to cancel the input of data?'); } catch(e){alert(e.message);}"
                                    CausesValidation="false" />
                            </td>
                        </tr>
                    </table>
                </InsertItemTemplate>
            </asp:FormView>
            <asp:LinqDataSource ID="linq_drv_details" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="vw_driver_details" Where="drv_id == @drv_id">
                <WhereParameters>
                    <asp:QueryStringParameter DefaultValue="0" Name="drv_id" QueryStringField="id" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>
            <asp:LinqDataSource ID="linq_salary" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="refSalaries" Where="user_id == @user_id">
                <WhereParameters>
                    <asp:SessionParameter Name="user_id" SessionField="parent_id" Type="int32" DefaultValue="0" />
                </WhereParameters>
            </asp:LinqDataSource>
            <asp:LinqDataSource ID="linq_emp_status" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="refEMPStatus" Where="user_id == @user_id">
                <WhereParameters>
                    <asp:SessionParameter Name="user_id" SessionField="parent_id" Type="Int32" DefaultValue="0" />
                </WhereParameters>
            </asp:LinqDataSource>
        </div>
    </form>
</body>
</html>
