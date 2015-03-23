<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="books.aspx.cs" Inherits="books" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Books] WHERE [BookId] = @original_BookId AND [Isbn] = @original_Isbn AND [Title] = @original_Title AND (([Summary] = @original_Summary) OR ([Summary] IS NULL AND @original_Summary IS NULL)) AND (([Edition] = @original_Edition) OR ([Edition] IS NULL AND @original_Edition IS NULL))" InsertCommand="INSERT INTO [Books] ([Isbn], [Title], [Summary], [Edition]) VALUES (@Isbn, @Title, @Summary, @Edition)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [Isbn], [Title], [Summary], [Edition], [BookId] FROM [Books]" UpdateCommand="UPDATE [Books] SET [Isbn] = @Isbn, [Title] = @Title, [Summary] = @Summary, [Edition] = @Edition WHERE [BookId] = @original_BookId AND [Isbn] = @original_Isbn AND [Title] = @original_Title AND (([Summary] = @original_Summary) OR ([Summary] IS NULL AND @original_Summary IS NULL)) AND (([Edition] = @original_Edition) OR ([Edition] IS NULL AND @original_Edition IS NULL))">
        <DeleteParameters>
            <asp:Parameter Name="original_BookId" Type="Int32" />
            <asp:Parameter Name="original_Isbn" Type="Int64" />
            <asp:Parameter Name="original_Title" Type="String" />
            <asp:Parameter Name="original_Summary" Type="String" />
            <asp:Parameter Name="original_Edition" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Isbn" Type="Int64" />
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Summary" Type="String" />
            <asp:Parameter Name="Edition" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Isbn" Type="Int64" />
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Summary" Type="String" />
            <asp:Parameter Name="Edition" Type="String" />
            <asp:Parameter Name="original_BookId" Type="Int32" />
            <asp:Parameter Name="original_Isbn" Type="Int64" />
            <asp:Parameter Name="original_Title" Type="String" />
            <asp:Parameter Name="original_Summary" Type="String" />
            <asp:Parameter Name="original_Edition" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="BookId" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:CommandField ShowEditButton="True" ShowSelectButton="True" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Edition" HeaderText="Edition" SortExpression="Edition" />
            <asp:BoundField DataField="Isbn" HeaderText="ISBN" SortExpression="Isbn" />
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

