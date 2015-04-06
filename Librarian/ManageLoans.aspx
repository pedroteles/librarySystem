<%@ Page Title="" Language="C#" MasterPageFile="~/Librarian/Librarian.master" AutoEventWireup="true" CodeFile="ManageLoans.aspx.cs" Inherits="Librarian_ManageLoans" %>

<asp:Content ID="Content1" ContentPlaceHolderID="leftcolumn" Runat="Server">

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
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT Users.UserName, Loans.LoanId, Loans.BookInstanceId, Loans.Date, Loans.DateDue, Loans.ReturnDate, Loans.Renewals, BooksInstances.CallNumber, Books.Isbn, Books.Title FROM Loans INNER JOIN Users ON Loans.UserId = Users.UserId INNER JOIN BooksInstances ON Loans.BookInstanceId = BooksInstances.BookInstanceId INNER JOIN Books ON BooksInstances.BookId = Books.BookId"></asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="LoanId" DataSourceID="SqlDataSource1">
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
                </asp:GridView>
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep2" runat="server" Title="New Loan"></asp:WizardStep>
            <asp:WizardStep runat="server" Title="Return a book">
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT Users.UserName, Loans.LoanId, Loans.BookInstanceId, Loans.Date, Loans.DateDue,  Loans.Renewals, BooksInstances.CallNumber, Books.Isbn, Books.Title FROM Loans INNER JOIN Users ON Loans.UserId = Users.UserId INNER JOIN BooksInstances ON Loans.BookInstanceId = BooksInstances.BookInstanceId INNER JOIN Books ON BooksInstances.BookId = Books.BookId WHERE Loans.ReturnDate IS NULL;"></asp:SqlDataSource>
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


