<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DETVehicle.aspx.cs" Inherits="FMS.Source.Details.DETVehicle" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
    <title></title>
    <style type="text/css">
        
    </style>
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
        <div>
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
            <asp:FormView ID="DETVHCDetails"
                OnItemCommand="DETVHCDetails_ItemCommand"
                OnItemInserted="DETVHCDetails_ItemInserted"
                OnItemInserting="DETVHCDetails_ItemInserting"
                OnItemUpdated="DETVHCDetails_ItemUpdated"
                OnItemUpdating="DETVHCDetails_ItemUpdating"
                EmptyDataText="No Vehicle Data Found"
                runat="server" DataKeyNames="vid"
                DataSourceID="linq_vhc_details"
                EnableModelValidation="True">
                <EditItemTemplate>
                    <table>
                        <tr>
                            <td colspan="2">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="edit" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Image ID="imgVehicle" ImageUrl='<%# "~/Source/Details/ImageHandler.ashx?type=vehicle&id=" + Eval("vid") %>' runat="server" Width="250" Height="150" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:FileUpload ID="fpFile" runat="server" />
                            </td>

                        </tr>
                        <tr>
                            <td>VID</td>
                            <td>
                                <telerik:RadTextBox ReadOnly="true" ID="tbxVID" runat="server"
                                    Text='<%#Bind("vid") %>'>
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Vehicle</td>
                            <td>
                                <telerik:RadTextBox ReadOnly="true" ID="tbxVehicleName"
                                    runat="server" Text='<%#Bind("vehicle_name") %>'>
                                </telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Vehicle Name is required."
                                    Text="*" ValidationGroup="edit" ControlToValidate="tbxVehicleName" />
                            </td>
                        </tr>
                        <tr>
                            <td>Manufacturer</td>
                            <td>
                                <telerik:RadTextBox ID="tbxManufacturer" runat="server" Text='<%#Bind("manufacturer") %>'></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Model</td>
                            <td>
                                <telerik:RadTextBox ID="tbxModel" runat="server" Text='<%#Bind("vhc_model") %>'></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Year</td>
                            <td>
                                <telerik:RadNumericTextBox ID="tbxYearMake" runat="server" Type="Number" InputType="Number" Text='<%#Bind("year_make") %>' MaxLength="4">
                                    <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Type</td>
                            <td>
                                <telerik:RadTextBox ID="tbxType" runat="server" Text='<%#Bind("body_type") %>'></telerik:RadTextBox>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Body Type is required." Text="*"
                                    ValidationGroup="edit" ControlToValidate="tbxType" />--%>
                            </td>
                        </tr>
                        <tr>
                            <td>Color</td>
                            <td>
                                <telerik:RadTextBox ID="tbxColor" runat="server" Text='<%#Bind("color") %>'></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Volume (cc)</td>
                            <td>
                                <telerik:RadNumericTextBox ID="tbxVolume" runat="server" Type="Number" Text='<%#Bind("cc") %>'>
                                    <NumberFormat DecimalDigits="0" />
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>

                        <tr>
                            <td>Engine No.</td>
                            <td>
                                <telerik:RadTextBox ID="tbxEngineNo" runat="server" Text='<%#Bind("engine_no") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Engine No. is required." Text="*"
                                    ValidationGroup="edit" ControlToValidate="tbxEngineNo" />
                            </td>
                        </tr>
                        <tr>
                            <td>Chasis No.</td>
                            <td>
                                <telerik:RadTextBox ID="tbxChasisNo" runat="server" Text='<%#Bind("chasis_no") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Chasis No. is required." Text="*"
                                    ValidationGroup="edit" ControlToValidate="tbxChasisNo" />
                            </td>
                        </tr>
                        <tr>
                            <td>Gross Weight (kg)</td>
                            <td>
                                <telerik:RadTextBox ID="tbxGrossWeight" InputType="Number" runat="server" Text='<%#Bind("gross_wt")%>' />

                            </td>
                        </tr>
                        <tr>
                            <td>Body Weight (kg)</td>
                            <td>
                                <telerik:RadTextBox ID="tbxBodyWeight" InputType="Number" runat="server" Text='<%#Bind("body_wt")%>' />

                            </td>
                        </tr>
                        <tr>
                            <td>Chasis Weight (kg)</td>
                            <td>
                                <telerik:RadTextBox ID="tbxChasisWeight" InputType="Number" runat="server" Text='<%#Bind("chasis_wt")%>' />

                            </td>
                        </tr>
                        <tr>
                            <td>Reg. Expiry</td>
                            <td>
                                <telerik:RadDatePicker MinDate="1/1/1900" DateInput-ReadOnly="true" runat="server" ID="rdpRegDate" DbSelectedDate='<%#Bind("registration_expiry_date") %>'
                                    DateInput-DisplayText='<%#Bind("registration_expiry_date","{0:yyyy-MM-dd}") %>'>
                                    <DateInput ID="DateInput2" runat="server" DateFormat="yyyy-MM-dd">
                                    </DateInput>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Registration Expiry is required." Text="*"
                                    ValidationGroup="edit" ControlToValidate="rdpRegDate" />
                            </td>
                        </tr>
                        <tr>
                            <td>Reg. No.</td>
                            <td>
                                <telerik:RadTextBox ID="tbxRegistrationNo" runat="server" Text='<%#Bind("registration_no") %>'></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Registration No. is required." Text="*"
                                    ValidationGroup="edit" ControlToValidate="tbxRegistrationNo" />
                            </td>
                        </tr>
                        <tr>
                            <td>Seating Cap.</td>
                            <td>
                                <telerik:RadNumericTextBox ID="tbxSeatNo" runat="server" Type="Number" Text='<%#Bind("seating_no") %>' MaxLength="2">
                                    <NumberFormat DecimalDigits="0" />
                                </telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Remarks</td>
                            <td>
                                <telerik:RadTextBox ID="tbxRemarks" runat="server" Text='<%#Bind("remarks") %>' TextMode="MultiLine" Height="75px"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>Blue Card</td>
                            <td>
                                <telerik:RadTextBox ID="tbxBlueCard" runat="server" Text='<%#Bind("bluecard") %>'></telerik:RadTextBox>
                            </td>
                        </tr>--%>
                        <%--<tr>
                            <td>Road Tax</td>
                            <td>
                                <telerik:RadTextBox ID="tbxRoadTax" runat="server" InputType="Number" Text='<%#Bind("road_tax") %>'></telerik:RadTextBox>
                            </td>
                        </tr>--%>
                        <tr>
                            <td></td>
                            <td>
                                <telerik:RadButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Save" ValidationGroup="edit" />
                                <telerik:RadButton ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            </td>
                        </tr>
                    </table>

                </EditItemTemplate>
                <ItemTemplate>
                    <table style="width: 400px;">
                        <tr>
                            <td colspan="2">
                                <asp:Image ID="imgVehicle" ImageUrl='<%# "~/Source/Details/ImageHandler.ashx?type=vehicle&id=" + Eval("vid") %>' runat="server" Width="250" Height="150" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 220px;"><strong>VID</strong>
                            </td>
                            <td>

                                <asp:Label ID="tbxVID1" runat="server"
                                    Text='<%#Bind("vid") %>'>
                                </asp:Label>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Vehicle
                                </strong>
                            </td>
                            <td>

                                    <asp:Label ID="tbxVehicleName1"
                                        runat="server" Text='<%#Bind("vehicle_name") %>'>
                                    </asp:Label></td>
                        </tr>
                        <tr>
                            <td><strong>Manufacturer</strong>
                            </td>
                            <td>

                                <asp:Label ID="tbxManufacturer1" runat="server" Text='<%#Bind("manufacturer") %>'></asp:Label>

                            </td>
                        </tr>
                        <tr>
                            <td><strong>Model</strong>
                            </td>
                            <td>
                                
                                    <asp:Label ID="tbxMode1l" runat="server" Text='<%#Bind("vhc_model") %>'></asp:Label>
                                
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Year</strong>
                            </td>
                            <td>
                                
                                    <asp:Label ID="tbxYearMake1" runat="server" Type="Number" InputType="Number" Text='<%#Bind("year_make") %>' MaxLength="4">                                            
                                    </asp:Label>
                                
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Type</strong>
                            </td>
                            <td>

                                
                                    <asp:Label ID="tbxType1" runat="server" Text='<%#Bind("body_type") %>'></asp:Label>
                                
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Color</strong>
                            </td>
                            <td>
                                
                                    <asp:Label ID="tbxColor1" runat="server" Text='<%#Bind("color") %>'></asp:Label>
                                
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Volume (cc)
                                </strong>
                            </td>
                            <td>
                                
                                    <asp:Label ID="tbxVolume1" runat="server" Type="Number" Text='<%#Bind("cc", "{0:n0}") %>'>                                            
                                    </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Engine No.
                                </strong>
                            </td>
                            <td>
                                    <asp:Label ID="tbxEngineNo1" runat="server" Text='<%#Bind("engine_no") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Chasis No.
                                </strong>
                                 
                            </td>
                            <td>
                                    <asp:Label ID="tbxChasisNo1" runat="server" Text='<%#Bind("chasis_no") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Gross Weight (kg)
                                </strong>
                            </td>
                            <td>
                                    <asp:Label ID="tbxGrossWeight1" runat="server" Type="Number" Text='<%#Bind("gross_wt","{0:n0}") %>'></asp:Label>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Body Weight (kg)
                                </strong>
                            </td>
                            <td>
                                    <asp:Label ID="tbxBodyWeight1" runat="server" Type="Number" Text='<%#Bind("body_wt","{0:n0}") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Chasis Weight (kg)
                                </strong>
                            </td>
                            <td>
                                    <asp:Label ID="tbxChasisWeight1" runat="server" Type="Number" Text='<%#Bind("chasis_wt","{0:n0}") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Reg. Expiry
                                </strong>
                            </td>
                            <td>
                                    <asp:Label runat="server" ID="rdpRegDate1" Text='<%#Bind("registration_expiry_date","{0:yyyy-MM-dd}") %>'>
                                    </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Reg. No.
                                </strong>
                            </td>
                            <td>
                                    <asp:Label ID="tbxRegistrationNo1" runat="server" Text='<%#Bind("registration_no") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Seating Cap.
                                </strong>
                            </td>
                            <td>
                                    <asp:Label ID="tbxSeatNo1" runat="server" Type="Number" Text='<%#Bind("seating_no", "{0:n0}") %>' MaxLength="2">                                            
                                    </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <strong>Remarks
                                </strong>
                            </td>
                            <td>
                                    <asp:Label ID="tbxRemarks1" runat="server" Text='<%#Bind("remarks") %>' TextMode="MultiLine" Height="75px" Width="250px"></asp:Label>

                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:FormView>
            <asp:LinqDataSource ID="linq_vhc_details" runat="server" ContextTypeName="FMS_BusinessObjects.FMS_DBDataContext" TableName="tblVehicles" Where="vid == @vid">
                <WhereParameters>
                    <asp:QueryStringParameter DefaultValue="0" Name="vid" QueryStringField="id" Type="Int32" />
                </WhereParameters>
            </asp:LinqDataSource>
        </div>
    </form>
</body>
</html>
