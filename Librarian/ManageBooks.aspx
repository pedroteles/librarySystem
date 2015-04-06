<%@ Page Title="" Language="C#" MasterPageFile="~/Librarian/Librarian.master" AutoEventWireup="true" CodeFile="ManageBooks.aspx.cs" Inherits="Librarian_ManageBooks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="leftcolumn" Runat="Server">
    <asp:Menu ID="Menu1" Width="168px" runat="server" Orientation="Horizontal" StaticEnableDefaultPopOutImage="False" OnMenuItemClick="Menu1_MenuItemClick">
        <Items>
            <asp:MenuItem ImageUrl="../Images/orderedList0.png" 
                          Text="Books" Value="0"></asp:MenuItem>
            <asp:MenuItem ImageUrl="../Images/orderedList1.png" 
                          Text="Instances" Value="1"></asp:MenuItem>
        </Items>
    </asp:Menu>

    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0"  >
       <asp:View ID="Tab1" runat="server"  >
           <br />
           <br />
           <asp:Menu ID="BooksMenu" Width="168px" runat="server" Orientation="Horizontal" StaticEnableDefaultPopOutImage="False" OnMenuItemClick="BooksMenu_MenuItemClick">
                <Items>
                    <asp:MenuItem ImageUrl="../Images/orderedList0.png" 
                                  Text="New Book" Value="1"></asp:MenuItem>
                </Items>
           </asp:Menu>
           <asp:MultiView ID="BooksView" runat="server" ActiveViewIndex="0"  >
               <asp:View ID="BooksTable" runat="server">
                   <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT [b].[BookId], [Isbn], [Title], [Edition], [Summary],	 Subjects = STUFF(
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
FROM Books AS [b]" EnableCaching="false"></asp:SqlDataSource>
                   <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="BookId" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanging="editBook">
                       <AlternatingRowStyle BackColor="White" />
                       <Columns>
                           <asp:CommandField ShowSelectButton="True" SelectText="Edit"/>
                           <asp:BoundField DataField="BookId" HeaderText="BookId" InsertVisible="False" ReadOnly="True" SortExpression="BookId" />
                           <asp:BoundField DataField="Isbn" HeaderText="Isbn" SortExpression="Isbn" />
                           <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                           <asp:BoundField DataField="Edition" HeaderText="Edition" SortExpression="Edition" />
                           <asp:BoundField DataField="Summary" HeaderText="Summary" SortExpression="Summary" />
                           <asp:BoundField DataField="Subjects" HeaderText="Subjects" ReadOnly="True" SortExpression="Subjects" />
                           <asp:BoundField DataField="Authors" HeaderText="Authors" ReadOnly="True" SortExpression="Authors" />
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
               
               <asp:View ID="BookDetails" runat="server"  >
                   <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="0" OnFinishButtonClick="Wizard1_FinishButtonClick" DisplaySideBar="False" BackColor="#F7F6F3" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" OnNextButtonClick="Wizard1_NextButtonClick">
                       <FinishNavigationTemplate>
                           <asp:Button ID="FinishPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious" Text="Previous" />
                           <asp:Button ID="FinishButton" runat="server" CommandName="MoveComplete" Text="Finish" />
                       </FinishNavigationTemplate>
                       <HeaderStyle BackColor="#5D7B9D" BorderStyle="Solid" Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Left" />
                       <NavigationButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
                       <SideBarButtonStyle BorderWidth="0px" Font-Names="Verdana" ForeColor="White" />
                       <SideBarStyle BackColor="#7C6F57" BorderWidth="0px" Font-Size="0.9em" VerticalAlign="Top" />
                       <StartNavigationTemplate>
                           <asp:Button ID="StartNextButton" runat="server" CommandName="MoveNext" Text="Next" />
                       </StartNavigationTemplate>
                       <StepNavigationTemplate>
                           <asp:Button ID="StepPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious" Text="Previous" />
                           <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext" Text="Next" />
                       </StepNavigationTemplate>
                       <StepStyle BorderWidth="0px" ForeColor="#5D7B9D" />
                       <WizardSteps>
                           <asp:WizardStep runat="server" title="Details">
                               <asp:Table ID="TableNewBook" runat="server">
                                   <asp:TableRow runat="server">
                                       <asp:TableCell runat="server"><asp:Label runat="server" Text="ISBN" ID="lblNewISBN"></asp:Label>
</asp:TableCell>
                                       <asp:TableCell runat="server"><asp:TextBox runat="server" ID="txtNewISBN"></asp:TextBox>
</asp:TableCell>
                                       <asp:TableCell runat="server"><asp:Label runat="server" ID="lblNewISBNError"></asp:Label>
</asp:TableCell>
                                   </asp:TableRow>
                                   <asp:TableRow runat="server">
                                       <asp:TableCell runat="server"><asp:Label runat="server" Text="Title" ID="lblNewTitle"></asp:Label>
</asp:TableCell>
                                       <asp:TableCell runat="server"><asp:TextBox runat="server" ID="txtNewTitle"></asp:TextBox>
</asp:TableCell>
                                       <asp:TableCell runat="server"><asp:Label runat="server" ID="lblNewTitleError"></asp:Label>
</asp:TableCell>
                                   </asp:TableRow>
                                   <asp:TableRow runat="server">
                                       <asp:TableCell runat="server"><asp:Label runat="server" Text="Summary" ID="lblNewSummary"></asp:Label>
</asp:TableCell>
                                       <asp:TableCell runat="server"><asp:TextBox runat="server" ID="txtNewSummary"></asp:TextBox>
</asp:TableCell>
                                   </asp:TableRow>
                                   <asp:TableRow runat="server">
                                       <asp:TableCell runat="server"><asp:Label runat="server" Text="Edition" ID="lblNewEdition"></asp:Label>
</asp:TableCell>
                                       <asp:TableCell runat="server"><asp:TextBox runat="server" ID="txtNewEdition"></asp:TextBox>
</asp:TableCell>
                                       <asp:TableCell runat="server"><asp:Label runat="server" ID="lblNewEditionError"></asp:Label>
</asp:TableCell>
                                   </asp:TableRow>
                               </asp:Table>
                           </asp:WizardStep>
                           <asp:WizardStep runat="server" title="Authors">
                                                         

                                   
                               <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT [AuthorId], AuthorFirstName+' ' +AuthorSurname AS [AuthorName] FROM [Authors]"></asp:SqlDataSource>
                               <asp:Label ID="Label1" runat="server" Text="All Authors"></asp:Label><br />
                               <asp:ListBox ID="lstNewAllAuthors" runat="server" DataSourceID="SqlDataSource3" DataTextField="AuthorName" DataValueField="AuthorId"></asp:ListBox>
                               <asp:Button ID="btnNewAuthorAdd" runat="server" Text="Add" OnClick="btnNewAuthorAdd_Click"/>
                               
                               <br />
                                   
                               <asp:Label ID="lblNewBookAuthors" runat="server" Text="Book Authors"></asp:Label><br />
                                   
                               <asp:ListBox ID="lstNewAuthors" runat="server">
                               </asp:ListBox>
                              
                               
                               
                              
                               <asp:Button ID="btnRemoveNewAuthor" runat="server" OnClick="btnRemoveNewAuthor_Click" Text="Remove" />
                              
                               
                               
                              
                           </asp:WizardStep>
                           <asp:WizardStep runat="server" Title="Subjects">
                               <asp:SqlDataSource ID="SqlDataSourceSubjects" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT * FROM [Subjects]"></asp:SqlDataSource>
                               <asp:Label ID="lblAllNewSubjects" runat="server" Text="All Subjects"></asp:Label><br />
                               <asp:ListBox ID="lstNewAllSubjects" runat="server" DataSourceID="SqlDataSourceSubjects" DataTextField="SubjectName" DataValueField="SubjectId"></asp:ListBox>
                               <asp:Button ID="btnAddNewSubject" runat="server" Text="Add" OnClick="btnAddNewSubject_Click" /><br />
                               <asp:Label ID="lblNewSubjects" runat="server" Text="Book Subjects"></asp:Label><br />
                               <asp:ListBox ID="lstNewSubjects" runat="server"></asp:ListBox>
                               <asp:Button ID="btnRemoveNewSubject" runat="server" OnClick="btnRemoveNewSubject_Click" Text="Remove" />
                               <br />
                           </asp:WizardStep>
                       </WizardSteps>
                   </asp:Wizard>
                   <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"/>
               </asp:View>

</asp:MultiView>

         </asp:View>
    <asp:View ID="Tab2" runat="server">        
           <br />
           <br />
           <asp:Menu ID="InstancesMenu" Width="168px" runat="server" Orientation="Horizontal" StaticEnableDefaultPopOutImage="False" OnMenuItemClick="InstancesMenu_MenuItemClick">
                <Items>
                    <asp:MenuItem ImageUrl="../Images/orderedList0.png" 
                                  Text="New Instance" Value="2"></asp:MenuItem>
                </Items>
           </asp:Menu>
           <asp:MultiView ID="InstancesView" runat="server" ActiveViewIndex="0"  >
               <asp:View ID="InstancesTable" runat="server">
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDatabase %>" SelectCommand="SELECT [b].[Title], [b].[Isbn], [b].[Summary], [b].[Edition], [b].[BookId], [bi].[BookInstanceId], [bi].[CallNumber] FROM Books AS [b] INNER JOIN BooksInstances AS [bi] ON [b].[BookId] = [bi].[BookId];"></asp:SqlDataSource>
                    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="BookId,BookInstanceId" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None" OnSelectedIndexChanging="GridView2_SelectedIndexChanging">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" SelectText="Edit"/>
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

               <asp:View ID="EditInstance" runat="server">
                   edit Instance<asp:Button ID="btnEditInstanceSave" runat="server" Text="Button" OnClick="btnEditInstanceSave_Click" />
               </asp:View>

               <asp:View ID="NewInstance" runat="server">
                   new Instance<asp:Button ID="btnNewInstanceSave" runat="server" Text="Button" OnClick="btnNewInstanceSave_Click" />
               </asp:View>

               </asp:MultiView>
             </asp:View>
       
</asp:MultiView>
</asp:Content>


