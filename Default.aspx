<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
   
      <aside id="homeside">
          
        <h3>OPENING HOURS </h3>
          <asp:Table ID="Hours" GridLines="Both" runat="server"  Font-Bold="true" CellPadding="20">
        <asp:TableRow>
            <asp:TableCell>
                
                MONDAY  <br /> 
                TUESDAY  <br /> 
                WEDNESDAY  <br /> 
                THURSDAY  <br /> 
                FRIDAY  <br /> 
                SATURDAY <br /> 
                SUNDAY <br /> 
           </asp:TableCell>
            <asp:TableCell HorizontalAlign="Justify" >
            9:00 am - 5:00pm<br />
           9:00 am - 5:00pm<br />
            9:00 am - 5:00pm<br />
            9:00 am - 5:00pm<br />
            9:00 am - 3:00pm<br />
            CLOSE<br />
            CLOSE<br />
            </asp:TableCell> 
            </asp:TableRow>
          </asp:Table>
        
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

          <a href="https://www.gmail.com/">
                <asp:Image ID="google" runat="server" ImageUrl="~/Images/google+.png" 
                width="40px" height="40px"/>
           </a>
          <br />

           <aside id="aboutside1">
        <h3 id="QL">Quick Links</h3>
        <div id="quicklinks">
        <p><strong><a href="http://www.dublin.ie">Dublin.ie</a></strong></p>
        <p><a href="http://www.dublindashboard.ie/pages/index"><strong>Dublin Dashboard</strong></a></p>
        <p><strong><a href="http://www.gov.ie">Gov.ie</a></strong></p>
        <p><a href="http://airo.maynoothuniversity.ie/mapping-resources/airo-research-themes/housing/dcc-housing-monitoring-tool"><strong>Housing Monitoring Tool</strong></a></p>
        <p><strong><a href="http://www.localgov.ie">LocalGov.ie</a></strong></p>
        </div>     
        </aside>
    </aside>
   
   
    <div id="Image">
        
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