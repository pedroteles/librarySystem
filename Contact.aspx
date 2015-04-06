<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <h1><%: Title %></h1>
        <h2>Details.</h2>
    </hgroup>

    <div id="googlemap">
    <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d9528.610508346517!2d-6.265523!3d53.340524!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xd5fd5a41e4548a27!2sDublin+Business+School!5e0!3m2!1sen!2sie!4v1428348316843" width="500" height="350"></iframe>
    </div>

    <section class="contact">
        <header>
            <h3>Phone:</h3>
        </header>
        <p>
            <span class="label">Main:</span>
            <span>+ 353(0) 1 34567 </span>
        </p>
        <p>
            <span class="label">Fax:</span>
            <span>+ 353(0)1 123456</span>
        </p>
    </section>

    <section class="contact">
        <header>
            <h3>Email:</h3>
        </header>
        <p>
            <span class="label">Support:</span>
            <span><a href="mailto:librarysystem@gmail.com.com">librarysystem@gmail.com</a></span>
        </p>
       
    </section>

    <section class="contact">
        <header>
            <h3>Address:</h3>
        </header>
        <p>
            
Dublin Business School,<br />
13/14 Aungier Street,<br /> 
Dublin 2, Ireland 
            
        </p>
    </section>
    

</asp:Content>