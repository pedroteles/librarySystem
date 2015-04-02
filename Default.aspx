﻿<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

      <aside>
        <h3>Aside Title</h3>
        <p>        
            Use this area to provide additional information.
        </p>
        <ul>
            <li><a id="A1" runat="server" href="~/">Home</a></li>
            <li><a id="A2" runat="server" href="~/About">About</a></li>
            <li><a id="A3" runat="server" href="~/Contact">Contact</a></li>
            <li><a id="A4" runat="server" href="~/Collection">Collection</a></li>
            <li><a id="A5" runat="server" href="~/FAQ">FAQ</a></li>
        </ul>

           <h3>Social Links</h3><br />
           <a href="https://www.facebook.com/">
                <asp:Image ID="Facebook" runat="server" ImageUrl="~/Images/facebook.png" 
                 width="40px" height="40px"/>
           </a>

           <a href="https://www.twitter.com/">
                <asp:Image ID="twitter" runat="server" ImageUrl="~/Images/twitter.png" 
                width="40px" height="40px"/>
           </a>

            <a href="https://www.blogspot.com/">
                <asp:Image ID="blogspot" runat="server" ImageUrl="~/Images/blogspot.png" 
                width="40px" height="40px"/>
           </a>
    </aside>
    <br />
   
    <div class="Image" style="padding-left: 95px">
        
        <a href="About.aspx">
<asp:Image ID="About" runat="server" ImageUrl="~/Images/About.png" 
    width="250px" height="175px" />   
        </a>
         
        
        <a href="Collection.aspx">
<asp:Image ID="Collection" runat="server" ImageUrl="~/Images/Collection.png" 
    width="250px" height="175px"/>
        </a>

        <a href="Contact.aspx">
<asp:Image ID="ContactUs" runat="server" ImageUrl="~/Images/ContactUs.png" 
    width="250px" height="175px" />
        </a>
        
        
        <a href="Account/Login.aspx">
<asp:Image ID="Login" runat="server" ImageUrl="~/Images/myLibrary.png" 
    width="250px" height="175px"/>   
        </a>
                 
        <a href="FAQ.aspx">
<asp:Image ID="FAQ" runat="server" ImageUrl="~/Images/FAQ.png" 
    width="250px" height="175px"/>
        </a>

        <a href="Others.aspx">
<asp:Image ID="OtherServices" runat="server" ImageUrl="~/Images/Others.png" 
    width="250px" height="175px" />
        </a>
        
    </div>  

            
    
</asp:Content>