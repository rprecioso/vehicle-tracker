<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DETTracking.aspx.cs" Inherits="FMS.Source.Details.VHCTracking" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Design/css/menu.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <table>
                <tr>

                    <td>
                        <asp:Image ID="imgMap" runat="server" />
                    </td>
                </tr>
                <tr>

                    <td style="vertical-align: top;">
                        <asp:DetailsView ID="dvVehicle" runat="server" AutoGenerateRows="False" DataKeyNames="ObjectID"
                             DataSourceID="dsTFDBVehicleTrack" EnableModelValidation="True" Width="640px" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <CommandRowStyle BackColor="#C5BBAF" Font-Bold="True" />
                            <EditRowStyle BackColor="#7C6F57" />
                            <FieldHeaderStyle BackColor="#D0D0D0" Font-Bold="True" />
                            <Fields>
                                <asp:BoundField DataField="ObjectID" HeaderText="VID" ReadOnly="True" SortExpression="ObjectID" />
                                <asp:BoundField DataField="ObjectRegNum" HeaderText="Registration No." SortExpression="ObjectRegNum" />
                                <asp:BoundField DataField="GSMVoiceNum" HeaderText="Mobile No." SortExpression="GSMVoiceNum" />
                                <asp:BoundField DataField="StatusDes" HeaderText="Status" SortExpression="StatusDes" />
                                <asp:BoundField DataField="Speed" HeaderText="Speed" SortExpression="Speed" />
                                <asp:BoundField DataField="Lon" HeaderText="Lon" SortExpression="Lon" />
                                <asp:BoundField DataField="Lat" HeaderText="Lat" SortExpression="Lat" />
                                <asp:BoundField DataField="LastDataTime" HeaderText="Last Data Time" SortExpression="LastDataTime" />
                            </Fields>
                            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#E3EAEB" />
                        </asp:DetailsView>
                        <asp:SqlDataSource ID="dsTFDBVehicleTrack" runat="server" ConnectionString="<%$ ConnectionStrings:TFDBConnectionString %>" SelectCommand="SELECT TOP (1)
	obj.ObjectID,
	obj.ObjectRegNum,
	obj.GSMVoiceNum,
	track.StatusDes,
	track.Speed,
	track.Lon,
	track.Lat,
	track.LastDataTime
FROM
	A_Tracks track
	JOIN
		A_ObjectInfo obj
		ON track.ObjectID = obj.ObjectID
WHERE
	obj.ObjectID = @objectid
ORDER BY track.LastDataTime DESC">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="objectid" QueryStringField="vid" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>

                </tr>
            </table>
        </div>
    </form>
</body>
</html>
