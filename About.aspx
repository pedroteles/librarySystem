<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <img id="about" src="Images/about1.png"  />
    <aside id="aboutside">

        <h3>Aside Title</h3>
        <p>        
         additional information.
        </p>
        <ul>
            <li><a id="A1" runat="server" href="~/">Home</a></li>
            <li><a id="A2" runat="server" href="~/About">About</a></li>
            <li><a id="A3" runat="server" href="~/Contact">Contact</a></li>
            <li><a id="A4" runat="server" href="~/Collection">Collection</a></li>
            <li><a id="A5" runat="server" href="~/FAQ">FAQ</a></li>
        </ul><br />

        
    <img id="about1" src="Images/librarysystem_bg.png" />
    </aside>
    <div id="aboutlibrary">
    <hgroup class="title">
        <h1>Welcome to LIBRARY SYSTEM</h1>
  
    </hgroup>

   
        <p>        
            Library System aimed to enhance the procedures of the library, 
            from manually operated to a computerized system. A web based information services 
            as vital alternative to the traditional face-to- face reference service.
        </p>

        <p>        
           Library System is an Online Public Access Catalogue (OPAC), when made available on the Web is called Web OPAC. 
           Information may be available in any media; it is the catalogue that ensures maximum exposure 
           and subsequent use of information sources.
        </p>

        <p>        
            
        </p>
   
       </div>    
    
</asp:Content>