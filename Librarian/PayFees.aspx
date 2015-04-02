<%@ Page Title="" Language="C#" MasterPageFile="~/Librarian/Librarian.master" AutoEventWireup="true" CodeFile="PayFees.aspx.cs" Inherits="Librarian_PayFees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="leftcolumn" Runat="Server">
    <asp:Label ID="Label1" runat="server" Text="Display: "></asp:Label>
    <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal"
         CellSpacing="0" TextAlign="Left" Width="16px" AutoPostBack="True">
        <asp:ListItem Value="0" Selected="True">Pending</asp:ListItem>
        <asp:ListItem Value="1">Paid</asp:ListItem>
</asp:RadioButtonList> 

    
    
      
   
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT Users.UserName, Fines.LoanId, '€' + CAST(Fines.Total AS NVARCHAR(6)) AS [Total], 
CASE WHEN Fines.Paid = 0 THEN 'No' ELSE 'Yes' END AS [Paid]
, Loans.ReturnDate, Loans.DateDue FROM Fines INNER JOIN Loans ON Fines.LoanId = Loans.LoanId INNER JOIN Users ON Loans.UserId = Users.UserId WHERE (Fines.Paid = @Show)">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadioButtonList1" DefaultValue="0" Name="Show" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="LoanId" DataSourceID="SqlDataSource1" ShowHeaderWhenEmpty="True" EmptyDataText="No results!" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
            <asp:BoundField DataField="LoanId" HeaderText="LoanId" ReadOnly="True" SortExpression="LoanId" />
            <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" ReadOnly="True" />
            <asp:BoundField DataField="Paid" HeaderText="Paid" ReadOnly="True" SortExpression="Paid" />
            <asp:BoundField DataField="ReturnDate" HeaderText="ReturnDate" SortExpression="ReturnDate" />
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

    
    
      
   
</asp:Content>


