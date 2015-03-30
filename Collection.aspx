<%@ Page Title="Collection" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Collection.aspx.cs" Inherits="Collection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="
SELECT DISTINCT [b].[BookId], [Isbn], [Title], [Edition], Subjects = STUFF(
             (SELECT '; ' + SubjectName
              FROM Subjects s INNER JOIN SubjectsInBooks sb on s.SubjectId = sb.SubjectId 
			  WHERE sb.BookId=b.BookId
              FOR XML PATH (''))
             , 1, 1, ''), 
        Authors = STUFF(
             (SELECT '; ' + AuthorFirstName+' '+AuthorSurname 
              FROM Authors a INNER JOIN AuthorsInBooks ab on a.AuthorId = ab.AuthorId 
			  WHERE ab.BookId=b.BookId
              FOR XML PATH (''))
             , 1, 1, '') 
FROM Books AS [b]
INNER JOIN SubjectsInBooks AS sb ON [b].[BookId]=[sb].[BookId]
INNER JOIN Subjects AS s ON [s].[SubjectId]=[sb].[SubjectId]
INNER JOIN AuthorsInBooks AS ab ON [b].[BookId]=[ab].[BookId]
INNER JOIN Authors AS a ON [a].[AuthorId]=[ab].[AuthorID]
WHERE ([SubjectName] LIKE '%' + @Subject + '%') AND 
(([Isbn] LIKE '%' + @Isbn + '%') AND 
([Title] LIKE '%' + @Title + '%')) AND
(([AuthorFirstName] LIKE + @Author + '%') OR
([AuthorSurname] LIKE + @Author + '%') OR
(+ @Author LIKE [AuthorFirstName]+' '+[AuthorSurname]) OR
(+ @Author LIKE [AuthorSurname]+' '+[AuthorFirstName]) OR
([AuthorFirstName]+' '+[AuthorSurname] LIKE + @Author + '%'))" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:QueryStringParameter Name="Subject" QueryStringField="Subject" DefaultValue="" Type="String" ConvertEmptyStringToNull="False"/>
            <asp:QueryStringParameter Name="Isbn" QueryStringField="ISBN" Type="String" DefaultValue="" ConvertEmptyStringToNull="False"/>
            <asp:QueryStringParameter Name="Title" QueryStringField="Title" Type="String" DefaultValue="" ConvertEmptyStringToNull="False"/>
            <asp:QueryStringParameter Name="Author" QueryStringField="Author" Type="String" DefaultValue="" ConvertEmptyStringToNull="False"/>
        </SelectParameters>
        
</asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" DataKeyNames="BookId" DataSourceID="SqlDataSource1" ForeColor="Black">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Edition" HeaderText="Edition" SortExpression="Edition" />
            <asp:BoundField DataField="Subjects" HeaderText="Subjects" ReadOnly="True" SortExpression="Subjects" />
            <asp:BoundField DataField="Authors" HeaderText="Authors" ReadOnly="True" SortExpression="Authors" />
        </Columns>
        <FooterStyle BackColor="#CCCCCC" />
        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
        <RowStyle BackColor="White" />
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#808080" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#383838" />
    </asp:GridView>
    </asp:Content>

