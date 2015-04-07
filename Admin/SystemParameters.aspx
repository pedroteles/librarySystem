<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="SystemParameters.aspx.cs" Inherits="Admin_SystemParameters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="leftcolumn" Runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <table style="width: 100%">
            <tr>
                <td>
        <asp:Label ID="lblFines" runat="server" Text="Fine" Font-Bold="True"></asp:Label>
                </td>
                <td>
        <asp:TextBox ID="txtFine" runat="server" ></asp:TextBox>
      <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="This is not an number!" ControlToValidate="txtFine" Type="Double" MaximumValue="20" MinimumValue="0"></asp:RangeValidator>
                </td>
            </tr>
            <tr>
                <td>
        <asp:Label ID="lblMaxR" runat="server" Text="MaximumRenewals" Font-Bold="True"></asp:Label>
                </td>
                <td>
        <asp:TextBox ID="txtMaxR" runat="server"></asp:TextBox>
        
        <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="This is not an Integer" ControlToValidate="txtMaxR" Type="Integer" MaximumValue="20" MinimumValue="0"></asp:RangeValidator>
                </td>
            </tr>
            <tr>
                <td>
        <asp:Label ID="lblMaxIt" runat="server" Text="MaximumItens" Font-Bold="True"></asp:Label>
                </td>
                <td>
        <asp:TextBox ID="txtMaxIt" runat="server"></asp:TextBox>
        
        <asp:RangeValidator ID="RangeValidator3" runat="server" ErrorMessage="This is not an Integer" ControlToValidate="txtMaxIt" Type="Integer" MaximumValue="20" MinimumValue="0"></asp:RangeValidator>
                </td>
            </tr>
            <tr>
                <td>
        <asp:Label ID="lblNum" runat="server" Text="NumberOfDays" Font-Bold="True"></asp:Label>
                </td>
                <td>
        <asp:TextBox ID="txtNum" runat="server"></asp:TextBox>
       

        <asp:RangeValidator ID="RangeValidator4" runat="server" ErrorMessage="This is not an Integer" ControlToValidate="txtNum" MaximumValue="30" MinimumValue="0" Type="Integer"></asp:RangeValidator>

                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
        <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" />
                    <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                </td>
            </tr>
        </table>
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>


