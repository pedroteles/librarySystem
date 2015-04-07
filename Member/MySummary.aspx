<%@ Page Title="" Language="C#" MasterPageFile="~/Member/Member.master" AutoEventWireup="true" CodeFile="MySummary.aspx.cs" Inherits="Member_ManageMyBooks" %>


<asp:Content ID="Content3" runat="server" contentplaceholderid="leftcolumn">
   
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT Loans.LoanId, Books.Title, Books.Isbn, BooksInstances.CallNumber, Loans.Renewals, Loans.DateDue FROM Loans INNER JOIN BooksInstances ON Loans.BookInstanceId = BooksInstances.BookInstanceId INNER JOIN Books ON BooksInstances.BookId = Books.BookId INNER JOIN Users ON Loans.UserId = Users.UserId WHERE (Loans.ReturnDate IS NULL) AND (Users.UserName = @UserName)" EnableCaching="false">
        <SelectParameters>
            <asp:Parameter Name="UserName" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <h2>Checked out</h2>
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="LoanId" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" ShowHeaderWhenEmpty="true" EmptyDataText="No books">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" SelectText="Renew"/>
            <asp:BoundField DataField="LoanId" HeaderText="LoanId" InsertVisible="False" ReadOnly="True" SortExpression="LoanId" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
            <asp:BoundField DataField="CallNumber" HeaderText="CallNumber" SortExpression="CallNumber" />
            <asp:BoundField DataField="Renewals" HeaderText="Renewals" SortExpression="Renewals" />
            <asp:BoundField DataField="DateDue" HeaderText="DateDue" SortExpression="DateDue" />
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
   
    <br />
    <asp:Label ID="lblMessage" runat="server" Text="" ></asp:Label>
   
    
</asp:Content>





