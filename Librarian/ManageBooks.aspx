<%@ Page Title="" Language="C#" MasterPageFile="~/Librarian/Librarian.master" AutoEventWireup="true" CodeFile="ManageBooks.aspx.cs" Inherits="Librarian_ManageBooks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="leftcolumn" Runat="Server">
    <asp:Menu
        ID="Menu1"
        Width="168px"
        runat="server"
        Orientation="Horizontal"
        StaticEnableDefaultPopOutImage="False"
        OnMenuItemClick="Menu1_MenuItemClick">
    <Items>
        <asp:MenuItem ImageUrl="../Images/orderedList0.png" 
                      Text="Books" Value="0"></asp:MenuItem>
        <asp:MenuItem ImageUrl="../Images/orderedList1.png" 
                      Text="Instances" Value="1"></asp:MenuItem>
    </Items>
</asp:Menu>

    <asp:MultiView 
    ID="MultiView1"
    runat="server"
    ActiveViewIndex="0"  >
   <asp:View ID="Tab1" runat="server"  >
       <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT * FROM [Books]"></asp:SqlDataSource>
       <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="BookId" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None">
           <AlternatingRowStyle BackColor="White" />
           <Columns>
               <asp:CommandField ShowSelectButton="True" />
               <asp:BoundField DataField="BookId" HeaderText="BookId" InsertVisible="False" ReadOnly="True" SortExpression="BookId" />
               <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
               <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
               <asp:BoundField DataField="Summary" HeaderText="Summary" SortExpression="Summary" />
               <asp:BoundField DataField="Edition" HeaderText="Edition" SortExpression="Edition" />
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

     </asp:View>
    <asp:View ID="Tab2" runat="server">
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT [b].[Title], [b].[Isbn], [b].[Summary], [b].[Edition], [b].[BookId], [bi].[BookInstanceId], [bi].[CallNumber] FROM Books AS [b] INNER JOIN BooksInstances AS [bi] ON [b].[BookId] = [bi].[BookId];"></asp:SqlDataSource>
        <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="BookId,BookInstanceId" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
                <asp:BoundField DataField="Summary" HeaderText="Summary" SortExpression="Summary" />
                <asp:BoundField DataField="Edition" HeaderText="Edition" SortExpression="Edition" />
                <asp:BoundField DataField="BookInstanceId" HeaderText="Number" InsertVisible="False" ReadOnly="True" SortExpression="BookInstanceId" />
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
    </asp:View>
       
</asp:MultiView>
</asp:Content>


