using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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
    private void resetNewBookFields()
    {
        txtNewEdition.Text = "";
        txtNewISBN.Text = "";
        txtNewSummary.Text = "";
        txtNewTitle.Text = "";
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        resetNewBookFields();
        resetErrorMessages();
        BooksView.ActiveViewIndex = 0;
    }

    private int saveNewBook(SqlConnection con)
    {
        //sql to insert a new book and retrieve the id created
        string sqlInsert = "INSERT INTO [Books] ([Isbn], [Title], [Summary], [Edition]) VALUES"+
            "(@Isbn, @Title, @Summary, @Edition);" + "SELECT SCOPE_IDENTITY()";
        
        int id;

        SqlCommand cmd = new SqlCommand(sqlInsert, con);
        cmd.Parameters.Add("@Isbn", SqlDbType.NVarChar, 20);
        cmd.Parameters.Add("@Title", SqlDbType.NVarChar, 100);
        cmd.Parameters.Add("@Summary", SqlDbType.Text);
        cmd.Parameters.Add("@Edition", SqlDbType.NVarChar, 10);

        cmd.Parameters["@Isbn"].Value = txtNewISBN.Text;
        cmd.Parameters["@Title"].Value = txtNewTitle.Text;
        cmd.Parameters["@Summary"].Value = txtNewSummary.Text;
        cmd.Parameters["@Edition"].Value = txtNewEdition.Text;
        
        id = int.Parse(cmd.ExecuteScalar().ToString());



        //return the id of the created book
        return id;
    }
    protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True;Connect Timeout=30;User Instance=False;");
        con.Open();
        int id = saveNewBook(con);
        GridView1.DataBind();


        //close the connection
        con.Close();


        BooksView.ActiveViewIndex = 0;

    }
}
