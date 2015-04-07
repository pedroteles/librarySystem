<%@ Page Title="" Language="C#" MasterPageFile="~/Member/Member.master" AutoEventWireup="true" CodeFile="MyReadingHistory.aspx.cs" Inherits="Member_MyReadingHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="leftcolumn" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT Books.Title, Books.Isbn, Loans.Date, BooksInstances.CallNumber FROM Loans INNER JOIN BooksInstances ON Loans.BookInstanceId = BooksInstances.BookInstanceId INNER JOIN Books ON BooksInstances.BookId = Books.BookId INNER JOIN Users ON Loans.UserId = Users.UserId WHERE (Users.UserName = @UserName) ORDER BY Loans.Date DESC, Books.Title">
        <SelectParameters>
            <asp:Parameter Name="UserName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <h3>My Reading History</h3>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
            <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
            <asp:BoundField DataField="CallNumber" HeaderText="CallNumber" SortExpression="CallNumber" />
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


