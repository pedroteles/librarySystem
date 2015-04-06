<%@ Page Title="" Language="C#" MasterPageFile="~/Librarian/Librarian.master" AutoEventWireup="true" CodeFile="ManageLoans.aspx.cs" Inherits="Librarian_ManageLoans" %>


<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="leftcolumn" Runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>
    <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="2" BackColor="#F7F6F3" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em">
        <FinishNavigationTemplate>
            <asp:Button ID="FinishPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious" Text="Previous" Visible="False" />
            <asp:Button ID="FinishButton" runat="server" CommandName="MoveComplete" Text="Finish" Visible="false"/>
        </FinishNavigationTemplate>
        <HeaderStyle BackColor="#5D7B9D" BorderStyle="Solid" Font-Bold="True" Font-Size="1.6em" ForeColor="White" HorizontalAlign="Left" />
        <NavigationButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
        <SideBarButtonStyle BorderWidth="0px" Font-Names="Verdana" ForeColor="White" />
        <SideBarStyle BackColor="#7C6F57" BorderWidth="0px" Font-Size="1.6em" VerticalAlign="Top" HorizontalAlign="Left"/>
        <StartNavigationTemplate>
            <asp:Button ID="StartNextButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" CommandName="MoveNext" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" Text="Next" Visible="false" />
        </StartNavigationTemplate>
        <StepNavigationTemplate>
            <asp:Button ID="StepPreviousButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="MovePrevious" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" Text="Previous" Visible="false"/>
            <asp:Button ID="StepNextButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" CommandName="MoveNext" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" Text="Next" Visible="false"/>
        </StepNavigationTemplate>
        <StepStyle BorderWidth="0px" ForeColor="#5D7B9D" />
        <WizardSteps>
            <asp:WizardStep ID="WizardStep1" runat="server" Title="Loans">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT Users.UserName, Loans.LoanId, Loans.BookInstanceId, Loans.Date, Loans.DateDue, Loans.ReturnDate, Loans.Renewals, BooksInstances.CallNumber, Books.Isbn, Books.Title FROM Loans INNER JOIN Users ON Loans.UserId = Users.UserId INNER JOIN BooksInstances ON Loans.BookInstanceId = BooksInstances.BookInstanceId INNER JOIN Books ON BooksInstances.BookId = Books.BookId ORDER BY Loans.LoanId DESC" EnableCaching="false"></asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="LoanId" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="LoanId" HeaderText="LoanId" InsertVisible="False" ReadOnly="True" SortExpression="LoanId" />
                        <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
                        <asp:BoundField DataField="BookInstanceId" HeaderText="BookInstanceId" SortExpression="BookInstanceId" />
                        <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
                        <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                        <asp:BoundField DataField="CallNumber" HeaderText="CallNumber" SortExpression="CallNumber" />
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                        <asp:BoundField DataField="DateDue" HeaderText="DateDue" SortExpression="DateDue" />
                        <asp:BoundField DataField="ReturnDate" HeaderText="ReturnDate" SortExpression="ReturnDate" />
                        <asp:BoundField DataField="Renewals" HeaderText="Renewed" SortExpression="Renewals" />
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
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep2" runat="server" Title="New Loan">
                
                        <asp:Table ID="Table1" runat="server">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Label ID="lblSearchUser" runat="server" Text="Search user"></asp:Label>
                            

</asp:TableCell>
                            <asp:TableCell>
                               <asp:TextBox ID="txtSearchUser" runat="server"></asp:TextBox>                       
                                
                            

</asp:TableCell>
                            <asp:TableCell>
                                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                            

</asp:TableCell>
                        </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Label ID="Label1" runat="server" Text="User:"></asp:Label>
                                

</asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblUserInf" runat="server" Text=""></asp:Label>
                                

</asp:TableCell>
                                <asp:TableCell> 
                                    <asp:Button ID="btnChange" runat="server" Text="Change User" OnClick="btnChange_Click"/>
                                

</asp:TableCell>
                            </asp:TableRow>
                      </asp:Table>      
                        
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Table ID="Table2" runat="server">
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Label ID="lblBookInstanceId" runat="server" Text="ID"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtBookInstanceId" runat="server"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Label ID="lblSearchISBN" runat="server" Text="ISBN"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtSearchISBN" runat="server"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Label ID="lblSearchTitle" runat="server" Text="Title"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtSearchTitle" runat="server"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:Label ID="lblSearchCallNumber" runat="server" Text="Call Number"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtSearchCallNumber" runat="server"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Button ID="btnSearchBook" runat="server" Text="Search" OnClick="btnSearchBook_Click"/>
                                </asp:TableCell>
                            </asp:TableRow>                           
                           
                        </asp:Table>
                        <asp:SqlDataSource ID="SqlDataSourceBookInstances" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT [b].[BookId], [Isbn], [Title], [Edition], [Summary], [bi].[BookInstanceId], [CallNumber],
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
WHERE [b].[BookId] in (
SELECT DISTINCT [b2].[BookId] from Books AS b2 
INNER JOIN BooksInstances as bi2 ON b2.BookId = bi2.BookId 
WHERE (([Isbn] LIKE @Isbn + '%') AND 
([Title] LIKE '%' + @Title + '%')) AND
([bi2].[BookInstanceId] LIKE @BookInstanceId + '%') AND 
([CallNumber] LIKE '%' + @CallNumber+ '%')
)ORDER BY [b].[Title]" CancelSelectOnNullParameter="false" EnableCaching="false">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtSearchISBN" Name="Isbn" PropertyName="Text" ConvertEmptyStringToNull="false"/>
                                <asp:ControlParameter ControlID="txtSearchTitle" Name="Title" PropertyName="Text" ConvertEmptyStringToNull="false"/>
                                <asp:ControlParameter ControlID="txtBookInstanceId" Name="BookInstanceId" PropertyName="Text" ConvertEmptyStringToNull="false"/>
                                <asp:ControlParameter ControlID="txtSearchCallNumber" Name="CallNumber" PropertyName="Text" ConvertEmptyStringToNull="false"/>
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="BookInstanceId" DataSourceID="SqlDataSourceBookInstances" ShowHeaderWhenEmpty="True" EmptyDataText="No results found!" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="BookId" HeaderText="BookId" InsertVisible="False" ReadOnly="True" SortExpression="BookId" />
                                <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
                                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                                <asp:BoundField DataField="Edition" HeaderText="Edition" SortExpression="Edition" />
                                <asp:BoundField DataField="Summary" HeaderText="Summary" SortExpression="Summary" />
                                <asp:BoundField DataField="BookInstanceId" HeaderText="BookInstanceId" ReadOnly="True" SortExpression="BookInstanceId" InsertVisible="False" />
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
                       
                    </ContentTemplate>
                </asp:UpdatePanel>
                 <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label><br />
                        <asp:Button ID="btnConfirm" runat="server" Text="Confirm" OnClick="btnConfirm_Click" />
                
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="Return a book">
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT Users.UserName, Loans.LoanId, Loans.BookInstanceId, Loans.Date, Loans.DateDue,  Loans.Renewals, BooksInstances.CallNumber, Books.Isbn, Books.Title FROM Loans INNER JOIN Users ON Loans.UserId = Users.UserId INNER JOIN BooksInstances ON Loans.BookInstanceId = BooksInstances.BookInstanceId INNER JOIN Books ON BooksInstances.BookId = Books.BookId WHERE Loans.ReturnDate IS NULL;" EnableCaching="false"></asp:SqlDataSource>
                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="LoanId" DataSourceID="SqlDataSource2" CellPadding="4" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="LoanId" HeaderText="LoanId" InsertVisible="False" ReadOnly="True" SortExpression="LoanId" />
                        <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
                        <asp:BoundField DataField="BookInstanceId" HeaderText="BookInstanceId" SortExpression="BookInstanceId" />
                        <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
                        <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                        <asp:BoundField DataField="CallNumber" HeaderText="CallNumber" SortExpression="CallNumber" />
                        <asp:BoundField DataField="Date" HeaderText="Date" SortExpression="Date" />
                        <asp:BoundField DataField="DateDue" HeaderText="DateDue" SortExpression="DateDue" />
                        <asp:BoundField DataField="Renewals" HeaderText="Renewals" SortExpression="Renewals" />
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
                <asp:Label ID="lblReturnBookMessage" runat="server" Text=""></asp:Label><br />
                <asp:Button ID="btnReturn" runat="server" OnClick="btnReturn_Click" Text="Return Book" />
            </asp:WizardStep>
        </WizardSteps>
    </asp:Wizard>
    
</asp:Content> 


