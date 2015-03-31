﻿<%@ Page Title="Collection" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Collection.aspx.cs" Inherits="Collection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="
SELECT [b].[BookId], [Isbn], [Title], [Edition], [Summary],	 Subjects = STUFF(
             (SELECT '; ' + SubjectName
              FROM Subjects s INNER JOIN SubjectsInBooks sb on s.SubjectId = sb.SubjectId 
			  WHERE sb.BookId=b.BookId
              FOR XML PATH (''))
             , 1, 1, ''), 
        Authors = STUFF(
             (SELECT '; ' + AuthorSurname +', '+ AuthorFirstName
              FROM Authors a INNER JOIN AuthorsInBooks ab on a.AuthorId = ab.AuthorId 
			  WHERE ab.BookId=b.BookId
              FOR XML PATH (''))
             , 1, 1, '') 
FROM Books AS [b] WHERE [b].[BookId] in (
SELECT DISTINCT [b2].[BookId] from Books AS b2 
INNER JOIN SubjectsInBooks AS sb ON [b2].[BookId]=[sb].[BookId]
INNER JOIN Subjects AS s ON [s].[SubjectId]=[sb].[SubjectId]
INNER JOIN AuthorsInBooks AS ab ON [b2].[BookId]=[ab].[BookId]
INNER JOIN Authors AS a ON [a].[AuthorId]=[ab].[AuthorID]
WHERE ([SubjectName] LIKE '%' + @Subject + '%') AND 
(([Isbn] LIKE '%' + @Isbn + '%') AND 
([Title] LIKE '%' + @Title + '%')) AND
(([AuthorFirstName] LIKE + @Author + '%') OR
([AuthorSurname] LIKE + @Author + '%') OR
(+ @Author LIKE [AuthorFirstName]+' '+[AuthorSurname]) OR
(+ @Author LIKE [AuthorSurname]+' '+[AuthorFirstName]) OR
([AuthorFirstName]+' '+[AuthorSurname] LIKE + @Author + '%')))" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:QueryStringParameter Name="Subject" QueryStringField="Subject" DefaultValue="" Type="String" ConvertEmptyStringToNull="False"/>
            <asp:QueryStringParameter Name="Isbn" QueryStringField="ISBN" Type="String" DefaultValue="" ConvertEmptyStringToNull="False"/>
            <asp:QueryStringParameter Name="Title" QueryStringField="Title" Type="String" DefaultValue="" ConvertEmptyStringToNull="False"/>
            <asp:QueryStringParameter Name="Author" QueryStringField="Author" Type="String" DefaultValue="" ConvertEmptyStringToNull="False"/>
        </SelectParameters>
        
</asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="BookId" DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" ShowHeaderWhenEmpty="true" EmptyDataText="No results found!" ShowFooter="true">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="BookId" HeaderText="BookId" InsertVisible="False" ReadOnly="True" SortExpression="BookId" />
            <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Edition" HeaderText="Edition" SortExpression="Edition" />
            <asp:BoundField DataField="Summary" HeaderText="Summary" SortExpression="Summary" />
            <asp:BoundField DataField="Subjects" HeaderText="Subjects" ReadOnly="True" SortExpression="Subjects" />
            <asp:BoundField DataField="Authors" HeaderText="Authors" ReadOnly="True" SortExpression="Authors" />
       
            <asp:TemplateField HeaderText="View Details">
<ItemTemplate>
    <asp:HyperLink ID="SqlDataSource2" runat='server' NavigateUrl='<%# String.Format("~/Collection.aspx?ID={0}", Eval("ENTITY_ID")) %>'>Select</asp:HyperLink>
</ItemTemplate>
                </asp:TemplateField>
             </Columns>
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#242121" />
    </asp:GridView>
    

<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="
   SELECT [b].[BookId], [Isbn], [Title], [Edition], [Summary], [bi].[BookInstanceId], [CallNumber],
CASE WHEN (SELECT ReturnDate FROM Loans AS [l] WHERE [l].[BookInstanceId]=[bi].[BookInstanceId] AND [l].[LoanId] IN 
(SELECT MAX(LoanId) FROM  Loans AS [l2] WHERE [l2].[BookInstanceId] = [bi].[BookInstanceId] ) ) 
IS NULL AND 
EXISTS (SELECT [l].[Date] FROM Loans AS [l] WHERE [l].[BookInstanceId]=[bi].[BookInstanceId])
THEN 'CHECKED-OUT' ELSE 'Available' END AS [Status],
CASE WHEN (SELECT [l].[DateDue] FROM Loans AS [l] WHERE [l].[BookInstanceId]=[bi].[BookInstanceId] AND ReturnDate IS NULL) IS NOT null
THEN (SELECT [l].[DateDue] FROM Loans AS [l] WHERE [l].[BookInstanceId]=[bi].[BookInstanceId] AND ReturnDate IS NULL) ELSE null END AS [DateDue]
FROM Books AS b 
INNER JOIN 
BooksInstances AS bi
ON [b].[BookId]=[bi].[BookId]
WHERE [b].[BookId] = @pARAMETER
ORDER BY [b].[Title]">
    <SelectParameters>
        <asp:Parameter Name="pARAMETER" />
    </SelectParameters>

</asp:SqlDataSource>
    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="BookId,BookInstanceId" DataSourceID="SqlDataSource2">
        <Columns>
       
            <asp:BoundField DataField="BookId" HeaderText="BookId" InsertVisible="False" ReadOnly="True" SortExpression="BookId" />
            <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Edition" HeaderText="Edition" SortExpression="Edition" />
            <asp:BoundField DataField="Summary" HeaderText="Summary" SortExpression="Summary" />
            <asp:BoundField DataField="BookInstanceId" HeaderText="BookInstanceId" InsertVisible="False" ReadOnly="True" SortExpression="BookInstanceId" />
            <asp:BoundField DataField="CallNumber" HeaderText="CallNumber" SortExpression="CallNumber" />
            <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status" />
            <asp:BoundField DataField="DateDue" HeaderText="DateDue" ReadOnly="True" SortExpression="DateDue" />
        </Columns>
         
    </asp:GridView>

</asp:Content>