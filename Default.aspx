<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    
    <div class="Image" style="padding-left: 95px">
        
        <a href="About.aspx">
<asp:Image ID="About" runat="server" ImageUrl="~/Images/About.png" 
    width="250px" height="175px"/>   
        </a>
         
        
        <a href="Collection.aspx">
<asp:Image ID="Collection" runat="server" ImageUrl="~/Images/Collection.png" 
    width="250px" height="175px"/>
        </a>

        <a href="Contact.aspx">
<asp:Image ID="ContactUs" runat="server" ImageUrl="~/Images/ContactUs.png" 
    width="250px" height="175px" />
        </a>
        
    </div>
         
    <div class="Image1" style="padding-left: 95px">
        
        <a href="Account/Login.aspx">
<asp:Image ID="Login" runat="server" ImageUrl="~/Images/myLibrary.png" 
    width="250px" height="175px"/>   
        </a>
         
        
        <a href="FAQ.aspx">
<asp:Image ID="FAQ" runat="server" ImageUrl="~/Images/FAQ.png" 
    width="250px" height="175px"/>
        </a>

        <a href="Contact.aspx">
<asp:Image ID="Image3" runat="server" ImageUrl="~/Images/ContactUs.png" 
    width="250px" height="175px" />
        </a>
        
    </div>  
            
    <ol class="round">
       
        <li class="two">
            <h5>Add NuGet packages and jump-start your coding</h5>
            NuGet makes it easy to install and update free libraries and tools.
            <a href="http://go.microsoft.com/fwlink/?LinkId=245147">Learn more…</a>
        </li>
        <li class="three">
            <h5>Find Web Hosting</h5>
            You can easily find a web hosting company that offers the right mix of features and price for your applications.
            <a href="http://go.microsoft.com/fwlink/?LinkId=245143">Learn more…</a>
        </li>
    </ol>
</asp:Content>