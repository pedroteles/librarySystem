<%@ Page Title="" Language="C#" MasterPageFile="~/Member/Member.master" AutoEventWireup="true" CodeFile="MyFines.aspx.cs" Inherits="Member_RenewBooks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="leftcolumn" Runat="Server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT '€' + CAST(Fines.Total AS NVARCHAR(6)) AS [Total], Fines.Paid, Fines.LoanId, Loans.DateDue, Loans.ReturnDate FROM Fines INNER JOIN Loans ON Fines.LoanId = Loans.LoanId INNER JOIN Users ON Loans.UserId = Users.UserId WHERE (Users.UserName = @UserName)">
        <SelectParameters>
            <asp:Parameter Name="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <h3>My Fines</h3>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="LoanId" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True" SortExpression="Total" />
            <asp:CheckBoxField DataField="Paid" HeaderText="Paid" SortExpression="Paid" />
            <asp:BoundField DataField="LoanId" HeaderText="LoanId" ReadOnly="True" SortExpression="LoanId" />
            <asp:BoundField DataField="DateDue" HeaderText="DateDue" SortExpression="DateDue" />
            <asp:BoundField DataField="ReturnDate" HeaderText="ReturnDate" SortExpression="ReturnDate" />
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>

</asp:Content>


