<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="SystemParameters.aspx.cs" Inherits="Admin_SystemParameters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="leftcolumn" Runat="Server">
    <table style="width: 100%">
            <tr>
                <td>
        <asp:Label ID="lblFines" runat="server" Text="Fine" Font-Bold="True"></asp:Label>
                </td>
                <td>
        <asp:TextBox ID="txtFine" runat="server" ></asp:TextBox>
        <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="this is not decimal" ControlToValidate="txtFine" Type="Currency" MaximumValue="10" MinimumValue="0" Visible="True"></asp:RangeValidator>
                </td>
            </tr>
            <tr>
                <td>
        <asp:Label ID="lblMaxR" runat="server" Text="MaximumRenewals" Font-Bold="True"></asp:Label>
                </td>
                <td>
        <asp:TextBox ID="txtMaxR" runat="server"></asp:TextBox>
        
        <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="RangeValidator" ControlToValidate="txtMaxR" Type="Integer" MaximumValue="5" MinimumValue="0"></asp:RangeValidator>
                </td>
            </tr>
            <tr>
                <td>
        <asp:Label ID="lblMaxIt" runat="server" Text="MaximumItens" Font-Bold="True"></asp:Label>
                </td>
                <td>
        <asp:TextBox ID="txtMaxIt" runat="server"></asp:TextBox>
        
        <asp:RangeValidator ID="RangeValidator3" runat="server" ErrorMessage="RangeValidator" ControlToValidate="txtMaxIt" Type="Integer" MaximumValue="5" MinimumValue="0"></asp:RangeValidator>
                </td>
            </tr>
            <tr>
                <td>
        <asp:Label ID="lblNum" runat="server" Text="NumberOfDays" Font-Bold="True"></asp:Label>
                </td>
                <td>
        <asp:TextBox ID="txtNum" runat="server"></asp:TextBox>
       

        <asp:RangeValidator ID="RangeValidator4" runat="server" ErrorMessage="RangeValidator" ControlToValidate="txtNum" MaximumValue="7" MinimumValue="0" Type="Integer"></asp:RangeValidator>

                </td>
            </tr>
            <tr>
                <td>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT [Fine], [MaximumRenewals], [MaximumItens], [NumberOfDays] FROM [SystemParameters]"></asp:SqlDataSource>
                </td>
                <td>
        <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" />
                </td>
            </tr>
        </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="rightcolumn" Runat="Server">
</asp:Content>

