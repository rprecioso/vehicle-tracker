<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_Vehicle.ascx.cs" Inherits="FMS.Source.User_Control.UC_Vehicle" %>

<table style="width: 100%">
    <tr>
        <td colspan="2" style="vertical-align: top; width: 155px; text-align: center;">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Design/vehicle_pg_images/VHC_unavailable.png" Width="250" Height="150" /></td>
    </tr>
    <tr>
        <td style="width: 150px;">VID: </td>
        <td>
            <asp:Label runat="server" ID="lblVid" Text='<%#Eval ("vid") %>' />
        </td>
    </tr>
    <tr>
        <td>Vehicle Name: </td>
        <td>
            <asp:Label runat="server" ID="lblName" Text='<%#Eval ("vehicle_name") %>' />
        </td>
    </tr>
    <tr>
        <td>Model: </td>
        <td>
            <asp:Label runat="server" ID="lblModel" Text='<%#Eval ("vhc_model") %>' />
        </td>
    </tr>
    <tr>
        <td>Type: </td>
        <td>
            <asp:Label runat="server" ID="lblType" Text='<%#Eval ("body_type") %>' />
        </td>
    </tr>
    <tr>
        <td>Color: </td>
        <td>
            <asp:Label runat="server" ID="lblColor" Text='<%#Eval ("color") %>' />
        </td>
    </tr>
    <tr>
        <td>Volume: </td>
        <td>
            <asp:Label runat="server" ID="Label12" Text='<%#Eval ("cc") %>' />
        </td>
    </tr>
    <tr>
        <td>Manufacturer: </td>
        <td>
            <asp:Label runat="server" ID="Label1" Text='<%#Eval ("manufacturer") %>' />
        </td>
    </tr>
    <tr>
        <td>Engine No.: </td>
        <td>
            <asp:Label runat="server" ID="Label2" Text='<%#Eval ("engine_no") %>' />
        </td>
    </tr>
    <tr>
        <td>Chasis No.: </td>
        <td>
            <asp:Label runat="server" ID="Label3" Text='<%#Eval ("chasis_no") %>' />
        </td>
    </tr>
    <tr>
        <td>Manufacturing Year: </td>
        <td>
            <asp:Label runat="server" ID="Label4" Text='<%#Eval ("year_make") %>' />
        </td>
    </tr>
    <tr>
        <td>Chasis Weight: </td>
        <td>
            <asp:Label runat="server" ID="Label13" Text='<%#Eval ("chasis_wt") %>' />
        </td>
    </tr>
    <tr>
        <td>Body Weight: </td>
        <td>
            <asp:Label runat="server" ID="Label10" Text='<%#Eval ("body_wt") %>' />
        </td>
    </tr>
    <tr>
        <td>Gross Weight: </td>
        <td>
            <asp:Label runat="server" ID="Label5" Text='<%#Eval ("gross_wt") %>' />
        </td>
    </tr>
    <tr>
        <td>Registration No: </td>
        <td>
            <asp:Label runat="server" ID="Label11" Text='<%#Eval ("registration_no") %>' />
        </td>
    </tr>
    <tr>
        <td>Registration Expiry Date: </td>
        <td>
            <asp:Label runat="server" ID="Label6" Text='<%#Eval ("registration_expiry_date") %>' />
        </td>
    </tr>
    <tr>
        <td>Seating Capacity: </td>
        <td>
            <asp:Label runat="server" ID="Label7" Text='<%#Eval ("seating_no") %>' />
        </td>
    </tr>
    <tr>
        <td>Remarks: </td>
        <td>
            <asp:Label runat="server" ID="Label14" Text='<%#Eval ("remarks") %>' />
        </td>
    </tr>
    <tr>
        <td>Bluecard: </td>
        <td>
            <asp:Label runat="server" ID="Label8" Text='<%#Eval ("bluecard") %>' />
        </td>
    </tr>
    <tr>
        <td>Road Tax: </td>
        <td>
            <asp:Label runat="server" ID="Label9" Text='<%#Eval ("road_tax") %>' />
        </td>
    </tr>
</table>
<asp:DetailsView ID="DetailsView1" runat="server" DataKeyNames="vid" Height="50px" Width="125px"></asp:DetailsView>

