<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_Services.ascx.cs" Inherits="FMS.Source.User_Control.UC_Services" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:FormView ID="detVHCService" runat="server" DataKeyNames="vhc_srv_id" CellPadding="4" EnableModelValidation="True" ForeColor="#333333">
    <EditRowStyle BackColor="#7C6F57" />
    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
    <ItemTemplate>
       <table width="50%" border="0" rules="none" cellpadding="1" cellspacing="0">
        <tr>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>
                <telerik:RadTextBox ReadOnly="true" Visible="false" ID="tbxVhcSrvId" runat="server" Text='<%#Bind("vhc_srv_id") %>'></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>Service Receipt No.</td>
            <td>
                <telerik:RadTextBox ReadOnly="true" Visible="false" ID="tbxServiceReceiptNo" runat="server" Text='<%#Bind("service_receipt_no") %>'></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="insert"
                    ControlToValidate="tbxServiceReceiptNo" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
            </td>

        </tr>
        <tr>
            <td>Vehicle</td>
            <td>
                <telerik:RadComboBox runat="server" DataSourceID="linq_vehicle" DataValueField="vid" DataTextField="vehicle_name" SelectedValue='<%#Bind("vid") %>' ID="rcmbVehicle"></telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>Service Type</td>
            <td>
                <telerik:RadComboBox runat="server"
                    AppendDataBoundItems="true" DataSourceID="linq_services" DataValueField="srv_id" CausesValidation="true"
                    DataTextField="service" SelectedValue='<%#Bind("srv_id") %>' ID="rcmbServiceType">
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td></td>

            <td>
                <telerik:RadTextBox ID="tbxNewService" Visible="false" runat="server" Text="" ValidationGroup="srv"></telerik:RadTextBox>

                <telerik:RadButton ID="btnNewService" Visible="false" runat="server" Text="Add New Service" CausesValidation="true" ValidationGroup="srv"></telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:CustomValidator ID="srvCusValidator" runat="server" OnServerValidate="srvCusValidator_ServerValidate" ErrorMessage="Duplicate service name, please choose another service name." ControlToValidate="tbxNewService" ValidationGroup="srv" />
            </td>
        </tr>

        <tr>
            <td>Service Date</td>
            <td>
                <telerik:RadDatePicker runat="server" MinDate="01/01/1900" MaxDate="12/12/3000" ID="rdpServiceDate"
                    DbSelectedDate='<%#Bind("date_started") %>' DateInput-DisplayText='<%#Bind("date_started","{0:yyyy/MM/dd}") %>'>
                    <DateInput ID="DateInput1" runat="server" DateFormat="yyyy/MM/dd">
                    </DateInput>
                </telerik:RadDatePicker>
                <asp:RangeValidator ID="DateInputRangeValidator" runat="server" ControlToValidate="rdpServiceDate"
                    ErrorMessage="Input a proper date"
                    Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                <asp:RequiredFieldValidator ID="PickerRequiredFieldValidator" runat="server" Display="Dynamic" ValidationGroup="insert"
                    ControlToValidate="rdpServiceDate" ErrorMessage="Please select a date"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td>Completion Date</td>
            <td>
                <telerik:RadDatePicker runat="server" ID="rdpCompletionDate" DbSelectedDate='<%#Bind("date_completed") %>'
                    DateInput-DisplayText='<%#Bind("date_completed","{0:yyyy/MM/dd}") %>'>
                    <DateInput ID="DateInput2" runat="server" DateFormat="yyyy/MM/dd">
                    </DateInput>
                </telerik:RadDatePicker>
                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="rdpCompletionDate"
                    ErrorMessage="Input a proper date"
                    Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="insert"
                    ControlToValidate="rdpCompletionDate" ErrorMessage="Please select a date"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Serviced by</td>
            <td>
                <telerik:RadTextBox ID="tbxServicedby" runat="server" Text='<%#Bind("srv_by") %>'></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="insert"
                    ControlToValidate="tbxServicedby" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Brought by</td>
            <td>
                <telerik:RadComboBox ID="rcmbBroughtby" runat="server" DataSourceID="linq_driver" SelectedValue='<%#Bind("brought_by") %>' DataTextField="Name" DataValueField="drv_id"></telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>Remarks</td>
            <td>
                <telerik:RadTextBox ID="tbxRemarks" runat="server" Text='<%#Bind("remarks") %>'></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="insert"
                    ControlToValidate="tbxRemarks" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td></td>
            <td align="left">

                <telerik:RadButton ID="rbtnSave" runat="server" Text="Save"
                    OnClientClick="if(Page_ClientValidate()) try { return confirm('Are you sure you want to update the data?'); } catch(e){alert(e.message);}"
                    CausesValidation="true" ValidationGroup="insert">
                </telerik:RadButton>
                <telerik:RadButton ID="rbtnCancel" runat="server" Text="Cancel"></telerik:RadButton>


            </td>
        </tr>
    </table>
    </ItemTemplate>
    <EditItemTemplate>
        <table >
            <tr>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <telerik:RadTextBox ReadOnly="true" Visible="false" ID="tbxVhcSrvId" runat="server" Text='<%#Bind("vhc_srv_id") %>'></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td>Service Receipt No.</td>
                <td>
                    <telerik:RadTextBox ReadOnly="true" Visible="false" ID="tbxServiceReceiptNo" runat="server" Text='<%#Bind("service_receipt_no") %>'></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="insert"
                        ControlToValidate="tbxServiceReceiptNo" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                </td>

            </tr>
            <tr>
                <td>Vehicle</td>
                <td>
                    <telerik:RadComboBox runat="server" DataSourceID="linq_vehicle" DataValueField="vid" DataTextField="vehicle_name" SelectedValue='<%#Bind("vid") %>' ID="rcmbVehicle"></telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td>Service Type</td>
                <td>
                    <telerik:RadComboBox runat="server"
                        AppendDataBoundItems="true" DataSourceID="linq_services" DataValueField="srv_id" CausesValidation="true"
                        DataTextField="service" SelectedValue='<%#Bind("srv_id") %>' ID="rcmbServiceType">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td></td>

                <td>
                    <telerik:RadTextBox ID="tbxNewService" Visible="false" runat="server" Text="" ValidationGroup="srv"></telerik:RadTextBox>

                    <telerik:RadButton ID="btnNewService" Visible="false" runat="server" Text="Add New Service" CausesValidation="true" ValidationGroup="srv"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:CustomValidator ID="srvCusValidator" runat="server" OnServerValidate="srvCusValidator_ServerValidate" ErrorMessage="Duplicate service name, please choose another service name." ControlToValidate="tbxNewService" ValidationGroup="srv" />
                </td>
            </tr>

            <tr>
                <td>Service Date</td>
                <td>
                    <telerik:RadDatePicker runat="server" MinDate="01/01/1900" MaxDate="12/12/3000" ID="rdpServiceDate"
                        DbSelectedDate='<%#Bind("date_started") %>' DateInput-DisplayText='<%#Bind("date_started","{0:yyyy/MM/dd}") %>'>
                        <DateInput ID="DateInput1" runat="server" DateFormat="yyyy/MM/dd">
                        </DateInput>
                    </telerik:RadDatePicker>
                    <asp:RangeValidator ID="DateInputRangeValidator" runat="server" ControlToValidate="rdpServiceDate"
                        ErrorMessage="Input a proper date"
                        Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="PickerRequiredFieldValidator" runat="server" Display="Dynamic" ValidationGroup="insert"
                        ControlToValidate="rdpServiceDate" ErrorMessage="Please select a date"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td>Completion Date</td>
                <td>
                    <telerik:RadDatePicker runat="server" ID="rdpCompletionDate" DbSelectedDate='<%#Bind("date_completed") %>'
                        DateInput-DisplayText='<%#Bind("date_completed","{0:yyyy/MM/dd}") %>'>
                        <DateInput ID="DateInput2" runat="server" DateFormat="yyyy/MM/dd">
                        </DateInput>
                    </telerik:RadDatePicker>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="rdpCompletionDate"
                        ErrorMessage="Input a proper date"
                        Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="insert"
                        ControlToValidate="rdpCompletionDate" ErrorMessage="Please select a date"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>Serviced by</td>
                <td>
                    <telerik:RadTextBox ID="tbxServicedby" runat="server" Text='<%#Bind("srv_by") %>'></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="insert"
                        ControlToValidate="tbxServicedby" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>Brought by</td>
                <td>
                    <telerik:RadComboBox ID="rcmbBroughtby" runat="server" DataSourceID="linq_driver" SelectedValue='<%#Bind("brought_by") %>' DataTextField="Name" DataValueField="drv_id"></telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td>Remarks</td>
                <td>
                    <telerik:RadTextBox ID="tbxRemarks" runat="server" Text='<%#Bind("remarks") %>'></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="insert"
                        ControlToValidate="tbxRemarks" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td></td>
                <td >
                    <telerik:RadButton ID="rbtnSave" runat="server" Text="Save"
                        OnClientClick="if(Page_ClientValidate()) try { return confirm('Are you sure you want to update the data?'); } catch(e){alert(e.message);}"
                        CausesValidation="true" ValidationGroup="insert">
                    </telerik:RadButton>
                    <telerik:RadButton ID="rbtnCancel" runat="server" Text="Cancel"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </EditItemTemplate>
    <InsertItemTemplate>
            <table width="50%" border="0" rules="none" cellpadding="1" cellspacing="0">
        <tr>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>
                <telerik:RadTextBox ReadOnly="true" Visible="false" ID="tbxVhcSrvId" runat="server" Text='<%#Bind("vhc_srv_id") %>'></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>Service Receipt No.</td>
            <td>
                <telerik:RadTextBox ReadOnly="true" Visible="false" ID="tbxServiceReceiptNo" runat="server" Text='<%#Bind("service_receipt_no") %>'></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ValidationGroup="insert"
                    ControlToValidate="tbxServiceReceiptNo" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
            </td>

        </tr>
        <tr>
            <td>Vehicle</td>
            <td>
                <telerik:RadComboBox runat="server" DataSourceID="linq_vehicle" DataValueField="vid" DataTextField="vehicle_name" SelectedValue='<%#Bind("vid") %>' ID="rcmbVehicle"></telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>Service Type</td>
            <td>
                <telerik:RadComboBox runat="server"
                    AppendDataBoundItems="true" DataSourceID="linq_services" DataValueField="srv_id" CausesValidation="true"
                    DataTextField="service" SelectedValue='<%#Bind("srv_id") %>' ID="rcmbServiceType">
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td></td>

            <td>
                <telerik:RadTextBox ID="tbxNewService" Visible="false" runat="server" Text="" ValidationGroup="srv"></telerik:RadTextBox>

                <telerik:RadButton ID="btnNewService" Visible="false" runat="server" Text="Add New Service" CausesValidation="true" ValidationGroup="srv"></telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:CustomValidator ID="srvCusValidator" runat="server" OnServerValidate="srvCusValidator_ServerValidate" ErrorMessage="Duplicate service name, please choose another service name." ControlToValidate="tbxNewService" ValidationGroup="srv" />
            </td>
        </tr>

        <tr>
            <td>Service Date</td>
            <td>
                <telerik:RadDatePicker runat="server" MinDate="01/01/1900" MaxDate="12/12/3000" ID="rdpServiceDate"
                    DbSelectedDate='<%#Bind("date_started") %>' DateInput-DisplayText='<%#Bind("date_started","{0:yyyy/MM/dd}") %>'>
                    <DateInput ID="DateInput1" runat="server" DateFormat="yyyy/MM/dd">
                    </DateInput>
                </telerik:RadDatePicker>
                <asp:RangeValidator ID="DateInputRangeValidator" runat="server" ControlToValidate="rdpServiceDate"
                    ErrorMessage="Input a proper date"
                    Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                <asp:RequiredFieldValidator ID="PickerRequiredFieldValidator" runat="server" Display="Dynamic" ValidationGroup="insert"
                    ControlToValidate="rdpServiceDate" ErrorMessage="Please select a date"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td>Completion Date</td>
            <td>
                <telerik:RadDatePicker runat="server" ID="rdpCompletionDate" DbSelectedDate='<%#Bind("date_completed") %>'
                    DateInput-DisplayText='<%#Bind("date_completed","{0:yyyy/MM/dd}") %>'>
                    <DateInput ID="DateInput2" runat="server" DateFormat="yyyy/MM/dd">
                    </DateInput>
                </telerik:RadDatePicker>
                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="rdpCompletionDate"
                    ErrorMessage="Input a proper date"
                    Display="Dynamic" MaximumValue="3000-12-12-23-59-59" MinimumValue="1990-01-01-00-00-00"></asp:RangeValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ValidationGroup="insert"
                    ControlToValidate="rdpCompletionDate" ErrorMessage="Please select a date"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Serviced by</td>
            <td>
                <telerik:RadTextBox ID="tbxServicedby" runat="server" Text='<%#Bind("srv_by") %>'></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ValidationGroup="insert"
                    ControlToValidate="tbxServicedby" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Brought by</td>
            <td>
                <telerik:RadComboBox ID="rcmbBroughtby" runat="server" DataSourceID="linq_driver" SelectedValue='<%#Bind("brought_by") %>' DataTextField="Name" DataValueField="drv_id"></telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>Remarks</td>
            <td>
                <telerik:RadTextBox ID="tbxRemarks" runat="server" Text='<%#Bind("remarks") %>'></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ValidationGroup="insert"
                    ControlToValidate="tbxRemarks" ErrorMessage="Do not leave this blank"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td></td>
            <td align="left">

                <telerik:RadButton ID="rbtnSave" runat="server" Text="Save"
                    OnClientClick="if(Page_ClientValidate()) try { return confirm('Are you sure you want to update the data?'); } catch(e){alert(e.message);}"
                    CausesValidation="true" ValidationGroup="insert">
                </telerik:RadButton>
                <telerik:RadButton ID="rbtnCancel" runat="server" Text="Cancel"></telerik:RadButton>


            </td>
        </tr>
    </table>
    </InsertItemTemplate>
    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="#E3EAEB" />

</asp:FormView>
