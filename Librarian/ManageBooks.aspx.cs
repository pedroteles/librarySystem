using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Librarian_ManageBooks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        Menu mi = (Menu)sender;

        MultiView1.ActiveViewIndex = int.Parse(mi.SelectedValue);
    }
    protected void BooksMenu_MenuItemClick(object sender, MenuEventArgs e)
    {
        Menu mi = (Menu)sender;

        BooksView.ActiveViewIndex = int.Parse(mi.SelectedValue);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (validateFields())
        {
            BooksView.ActiveViewIndex = 0;
        } 
    }
    protected void btnEditSave_Click(object sender, EventArgs e)
    {
        BooksView.ActiveViewIndex = 0;
    }
    protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        BooksView.ActiveViewIndex = 1;
    }
    protected void btnEditInstanceSave_Click(object sender, EventArgs e)
    {
        InstancesView.ActiveViewIndex = 0;
    }
    protected void btnNewInstanceSave_Click(object sender, EventArgs e)
    {
        InstancesView.ActiveViewIndex = 0;
    }
    protected void InstancesMenu_MenuItemClick(object sender, MenuEventArgs e)
    {
        Menu mi = (Menu)sender;

        InstancesView.ActiveViewIndex = int.Parse(mi.SelectedValue);
    }
    protected void GridView2_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        InstancesView.ActiveViewIndex = 1;
    }

    private bool validateFields()
    {
        resetErrorMessages();
        return validateTxtEdition() & validateTxtNewISBN() & validateTxtTitle();
    }
    private bool validateTxtNewISBN()
    {
        //return true if isbn lenght grater than 0 and less than 21
        if (txtNewISBN.Text.Length > 0 && txtNewISBN.Text.Length <=20)
        {
            return true;
        }
        else
        {
            lblNewISBNError.Text = "Minimum 1 and Maximum 20 characters required.";
            return false;
        }
    }
    private bool validateTxtTitle()
    {
        //return true if isbn lenght grater than 0 and less than 101
        if(txtNewTitle.Text.Length > 0 && txtNewTitle.Text.Length <= 100)
        {
            return true;
        }
        else
        {
            lblNewTitleError.Text = "Minimum 1 and Maximum 100 characters required.";
            return false;
        }
    }

    private bool validateTxtEdition()
    {
        //return true if edition less than 11
        if( txtNewEdition.Text.Length < 11){
            return true;
        }
        else
        {
            lblNewEditionError.Text = "Maximum 10 characters required.";
            return false;
        }
    }
    private void resetErrorMessages()
    {
        lblNewEditionError.Text = "";
        lblNewISBNError.Text = "";
        lblNewTitleError.Text = "";
    }

}

