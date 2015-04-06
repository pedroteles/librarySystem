<%@ Page Title="Collection" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Collection.aspx.cs" Inherits="Collection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>

<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="BodyContent">

    <aside id="collectionpage">
        <h3 id="collection1">Database Online</h3>

        <div id="collectionside">
        <p>        
            Access the following Database Online
        </p>
        <ul>
            <li><a href="http://www.irishnewsarchive.com/" title="Links to external site">Irish Newspaper Archives</a></li>
            <li><a href="http://www.irishtimes.com/search/archive.html" title="Links to external site">Irish Times Digital Archive</a></li>
            <li><a href="http://dib.cambridge.org/" title="Links to external site">Dictionary of Irish Biography</a></li>
            <li><a href="http://www.emeraldinsight.com/" title="Links to external site">Emerald</a></li>
            <li><a href="http://www.jstor.org/action/showJournals?browseType=collectionInfoPage&amp;selectCollection=ireland" title="The Ireland Collection (links to external site) ">Ireland Collection</a> </li>
        </ul>
            </div>
    </aside>    

 </asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">


<div id="CollectionTable">
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
LEFT JOIN SubjectsInBooks AS sb ON [b2].[BookId]=[sb].[BookId]
LEFT JOIN Subjects AS s ON [s].[SubjectId]=[sb].[SubjectId]
LEFT JOIN AuthorsInBooks AS ab ON [b2].[BookId]=[ab].[BookId]
LEFT JOIN Authors AS a ON [a].[AuthorId]=[ab].[AuthorID]
WHERE (([SubjectName] LIKE '%' + @Subject + '%') OR ([SubjectName] IS NULL)) AND 
(([Isbn] LIKE '%' + @Isbn + '%') AND 
([Title] LIKE '%' + @Title + '%')) AND
(([AuthorFirstName] LIKE + @Author + '%') OR
([AuthorSurname] LIKE + @Author + '%') OR
(+ @Author LIKE [AuthorFirstName]+' '+[AuthorSurname]) OR
(+ @Author LIKE [AuthorSurname]+' '+[AuthorFirstName]) OR
([AuthorFirstName]+' '+[AuthorSurname] LIKE + @Author + '%') OR 
([AuthorFirstName] IS NULL)))" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:QueryStringParameter Name="Subject" QueryStringField="Subject" DefaultValue="" Type="String" ConvertEmptyStringToNull="False"/>
            <asp:QueryStringParameter Name="Isbn" QueryStringField="ISBN" Type="String" DefaultValue="" ConvertEmptyStringToNull="False"/>
            <asp:QueryStringParameter Name="Title" QueryStringField="Title" Type="String" DefaultValue="" ConvertEmptyStringToNull="False"/>
            <asp:QueryStringParameter Name="Author" QueryStringField="Author" Type="String" DefaultValue="" ConvertEmptyStringToNull="False"/>
        </SelectParameters>
        
</asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        DataKeyNames="BookId" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Edition" HeaderText="Edition" SortExpression="Edition" />
            <asp:BoundField DataField="Summary" HeaderText="Summary" SortExpression="Summary" />
            <asp:BoundField DataField="Subjects" HeaderText="Subjects" ReadOnly="True" SortExpression="Subjects" />
            <asp:BoundField DataField="Authors" HeaderText="Authors" ReadOnly="True" SortExpression="Authors" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT [b].[BookId], [Isbn], [Title], [Edition], [Summary], [bi].[BookInstanceId], [CallNumber],
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
WHERE [b].[BookId] = @BookId
ORDER BY [b].[Title]">
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="BookId" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="BookId,BookInstanceId" DataSourceID="SqlDataSource2" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White"/>
        <Columns>
            <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Edition" HeaderText="Edition" SortExpression="Edition" />
            <asp:BoundField DataField="Summary" HeaderText="Summary" SortExpression="Summary" />
            <asp:BoundField DataField="CallNumber" HeaderText="CallNumber" SortExpression="CallNumber" />
            <asp:BoundField DataField="Status" HeaderText="Status" ReadOnly="True" SortExpression="Status" />
            <asp:BoundField DataField="DateDue" HeaderText="DateDue" ReadOnly="True" SortExpression="DateDue" />
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
</div>
</asp:Content>