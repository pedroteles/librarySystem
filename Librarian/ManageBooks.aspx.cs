using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Librarian_ManageBooks : System.Web.UI.Page
{



    private Hashtable tableAuthors
    {

        get
        {

            return ViewState["tableAuthors"] as Hashtable;
        }
        set
        {
            ViewState["tableAuthors"] = value;
        }
    }

    private Hashtable tableSubjects
    {
        get
        {

            return ViewState["tableSubjects"] as Hashtable;
        }
        set
        {
            ViewState["tableSubjects"] = value;
        }
    }

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
        tableAuthors = new Hashtable();
        tableSubjects = new Hashtable();
        Menu mi = (Menu)sender;

        BooksView.ActiveViewIndex = int.Parse(mi.SelectedValue);
        GridView1.SelectedIndex = -1;
    }

    protected void btnEditSave_Click(object sender, EventArgs e)
    {
        BooksView.ActiveViewIndex = 0;
    }
    protected void editBook(object sender, GridViewSelectEventArgs e)
    {
        GridViewRow row = GridView1.Rows[e.NewSelectedIndex];
        int bookId = int.Parse(row.Cells[1].Text);
        //set text boxes
        //set hash tables
        prepareWizardToEdit(bookId);
        //button save
        BooksView.ActiveViewIndex = 1;
    }
    protected void btnEditInstanceSave_Click(object sender, EventArgs e)
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
        if (txtNewISBN.Text.Length > 0 && txtNewISBN.Text.Length <= 20)
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
        if (txtNewTitle.Text.Length > 0 && txtNewTitle.Text.Length <= 100)
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
        if (txtNewEdition.Text.Length < 11)
        {
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
    private void resetHashtables()
    {
        tableAuthors = new Hashtable();
        tableSubjects = new Hashtable();
        updateLstNewAuthors();
        updateLstNewSubjects();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        resetNewBookFields();
        resetHashtables();
        resetErrorMessages();
        BooksView.ActiveViewIndex = 0;
        Wizard1.ActiveStepIndex = 0;
    }

    private int saveNewBook(SqlConnection con)
    {
        //sql to insert a new book and retrieve the id created
        string sqlInsert = "INSERT INTO [Books] ([Isbn], [Title], [Summary], [Edition]) VALUES" +
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

    private void updateBook(int bookId, SqlConnection con)
    {
        string sqlInsert = "UPDATE Books SET Isbn = @Isbn, Title = @Title, Summary = @Summary, Edition = @Edition WHERE BookId = @BookID";
        SqlCommand cmd = new SqlCommand(sqlInsert, con);
        cmd.Parameters.AddWithValue("@BookId", bookId);
        cmd.Parameters.AddWithValue("@Isbn", txtNewISBN.Text);
        cmd.Parameters.AddWithValue("@Title", txtNewTitle.Text);
        cmd.Parameters.AddWithValue("@Summary", txtNewSummary.Text);
        cmd.Parameters.AddWithValue("@Edition", txtNewEdition.Text);
        cmd.ExecuteNonQuery();
    }

    private void updateAuthors(int bookId, SqlConnection con)
    {
        string sql = "DELETE FROM AuthorsInBooks WHERE BookId = @BookID";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@BookId", bookId);
        cmd.ExecuteNonQuery();
        saveNewAuthors(bookId, con);
    }
    private void updateSubjects(int bookId, SqlConnection con)
    {
        string sql = "DELETE FROM SubjectsInBooks WHERE BookId = @BookID";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@BookId", bookId);
        cmd.ExecuteNonQuery();
        saveNewSubjects(bookId, con);
    }

    private void saveNewAuthors(int bookId, SqlConnection con)
    {

        string sql = "INSERT INTO [AuthorsInBooks] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId)";
        SqlCommand cmd;
        foreach (var authorId in tableAuthors.Keys)
        {
            cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@BookId", bookId);
            cmd.Parameters.AddWithValue("@AuthorId", authorId);
            cmd.ExecuteNonQuery();
        }
    }

    private void saveNewSubjects(int bookId, SqlConnection con)
    {

        string sql = "INSERT INTO [SubjectsInBooks] ([BookId], [SubjectId]) VALUES (@BookId, @SubjectId)";
        SqlCommand cmd;
        foreach (var authorId in tableSubjects.Keys)
        {
            cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@BookId", bookId);
            cmd.Parameters.AddWithValue("@SubjectId", authorId);
            cmd.ExecuteNonQuery();
        }
    }

    private void saveNewInstance(int bookId, SqlConnection con)
    {
        string sql = "INSERT INTO [BooksInstances] ([BookId],[CallNumber]) VALUES (@BookId, @CallNumber)";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@BookId", bookId);
        cmd.Parameters.AddWithValue("@CallNumber", txtCallNumber.Text);
        cmd.ExecuteNonQuery();
    }

    protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True;Connect Timeout=30;User Instance=False;");
        con.Open();
        if (GridView1.SelectedIndex == -1)
        {
            int bookId = saveNewBook(con);

            saveNewAuthors(bookId, con);
            saveNewSubjects(bookId, con);
        }
        else
        {
            int bookId = int.Parse(GridView1.SelectedDataKey.Value.ToString());
            updateBook(bookId, con);
            updateAuthors(bookId, con);
            updateSubjects(bookId, con);

        }
        //close the connection
        con.Close();
        resetNewBookFields();
        resetHashtables();
        GridView1.DataBind();
        BooksView.ActiveViewIndex = 0;
        Wizard1.ActiveStepIndex = 0;

    }



    protected void btnNewAuthorAdd_Click(object sender, EventArgs e)
    {
        if (lstNewAllAuthors.SelectedIndex != -1)
        {
            if (!tableAuthors.ContainsKey(lstNewAllAuthors.SelectedValue))
            {
                tableAuthors.Add(lstNewAllAuthors.SelectedValue, lstNewAllAuthors.SelectedItem.Text);
                updateLstNewAuthors();
            }

        }

    }

    private void updateLstNewAuthors()
    {
        lstNewAuthors.Items.Clear();

        foreach (DictionaryEntry row in tableAuthors)
        {
            lstNewAuthors.Items.Add(new ListItem(row.Value.ToString(), row.Key.ToString()));
        }

    }
    protected void btnRemoveNewAuthor_Click(object sender, EventArgs e)
    {
        if (lstNewAuthors.SelectedIndex != -1)
        {
            tableAuthors.Remove(lstNewAuthors.SelectedValue);
            updateLstNewAuthors();
        }
    }
    protected void Wizard1_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (!validateFields())
        {
            e.Cancel = true;
        }
    }
    protected void btnAddNewSubject_Click(object sender, EventArgs e)
    {
        if (lstNewAllSubjects.SelectedIndex != -1)
        {
            if (!tableSubjects.ContainsKey(lstNewAllSubjects.SelectedValue))
            {
                tableSubjects.Add(lstNewAllSubjects.SelectedValue, lstNewAllSubjects.SelectedItem.Text);
                updateLstNewSubjects();
            }

        }
    }

    private void updateLstNewSubjects()
    {
        lstNewSubjects.Items.Clear();

        foreach (DictionaryEntry row in tableSubjects)
        {
            lstNewSubjects.Items.Add(new ListItem(row.Value.ToString(), row.Key.ToString()));
        }
    }
    protected void btnRemoveNewSubject_Click(object sender, EventArgs e)
    {
        if (lstNewSubjects.SelectedIndex != -1)
        {
            tableSubjects.Remove(lstNewSubjects.SelectedValue);
            updateLstNewSubjects();
        }
    }

    private void prepareWizardToEdit(int bookId)
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True");
        con.Open();

        prepareTextBoxesToEdit(bookId, con);
        prepareTableAuthorToEdit(bookId, con);
        prepareTableSubjectsToEdit(bookId, con);

        con.Close();
    }
    private void prepareTextBoxesToEdit(int bookId, SqlConnection con)
    {
        SqlCommand cmd = new SqlCommand("SELECT [BookId],[Isbn],[Title],[Summary], [Edition] FROM Books WHERE [BookId] = @BookId", con);
        cmd.Parameters.AddWithValue("@BookId", bookId);
        SqlDataReader dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            txtNewISBN.Text = dr["Isbn"].ToString();
            txtNewTitle.Text = dr["Title"].ToString();
            txtNewSummary.Text = dr["Summary"].ToString();
            txtNewEdition.Text = dr["Edition"].ToString();

        }

        dr.Close();

    }
    private void prepareTableAuthorToEdit(int bookId, SqlConnection con)
    {
        tableAuthors = new Hashtable();

        SqlCommand cmd = new SqlCommand("SELECT [a].[AuthorId],[AuthorFirstName],[AuthorSurname] FROM Authors AS [a] INNER JOIN AuthorsInBooks AS [ab] ON [a].[AuthorId] = [ab].[AuthorId] WHERE [ab].[BookId] = @BookId", con);
        cmd.Parameters.AddWithValue("@BookId", bookId);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            tableAuthors.Add(int.Parse(dr["AuthorId"].ToString()), dr["AuthorFirstName"].ToString() + " " + dr["AuthorSurname"].ToString());
        }
        dr.Close();
        updateLstNewAuthors();

    }
    private void prepareTableSubjectsToEdit(int bookId, SqlConnection con)
    {
        tableSubjects = new Hashtable();

        SqlCommand cmd = new SqlCommand("SELECT [s].[SubjectId],[SubjectName] FROM Subjects AS [s] INNER JOIN SubjectsInBooks AS [sb] ON [s].[SubjectId] = [sb].[SubjectId] WHERE [sb].[BookId] = @BookId", con);
        cmd.Parameters.AddWithValue("@BookId", bookId);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            tableSubjects.Add(int.Parse(dr["SubjectId"].ToString()), dr["SubjectName"].ToString());
        }
        dr.Close();
        updateLstNewSubjects();
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        SqlDataSourceSearchBooks.DataBind();
        GridSearchBook.DataBind();
    }
    protected void Wizard2_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (GridSearchBook.SelectedIndex == -1)
        {
            e.Cancel = true;
        }
    }
    protected void Wizard2_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (validateCallNumber())
        {
            SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True");
            con.Open();
            int bookId = int.Parse(GridSearchBook.SelectedDataKey.Value.ToString());
            saveNewInstance(bookId, con);
            con.Close();
            resetNewInstance();
            SqlDataSource2.DataBind();
            GridView2.DataBind();
            InstancesView.ActiveViewIndex = 0;
            Wizard2.ActiveStepIndex = 0;

           
        }
    }
    private bool validateCallNumber()
    {
        lblCallNumberError.Text= "";
        if (txtCallNumber.Text.Length < 1 || txtCallNumber.Text.Length > 15)
        {
            lblCallNumberError.Text = "Minimum 1 and Maximum 15 characters required!";
            return false;
        }
        return true;
    }

    private void resetNewInstance()
    {
        lblCallNumberError.Text = "";
        txtCallNumber.Text = "";
    }

    protected void btnCancelInstance_Click(object sender, EventArgs e)
    {
        resetNewInstance();
        InstancesView.ActiveViewIndex = 0;
        Wizard2.ActiveStepIndex = 0;
    }
}
