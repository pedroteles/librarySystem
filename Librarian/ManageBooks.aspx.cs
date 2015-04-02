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
        BooksView.ActiveViewIndex = 0;
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
}