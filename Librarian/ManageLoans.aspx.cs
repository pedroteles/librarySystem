using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Librarian_ManageLoans : System.Web.UI.Page
{
    private string userNameSelected
    {

        get
        {

            return ViewState["userNameSelected"] as string;
        }
        set
        {
            ViewState["userNameSelected"] = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            userNameSelected = "";
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        if (GridView2.SelectedIndex == -1)
        {
            lblReturnBookMessage.Text = "Select a book!";
        }
        else
        {
            lblReturnBookMessage.Text = "";
            int loanId = int.Parse(GridView2.SelectedDataKey.Value.ToString());
            returnBook(loanId);
        }
    }

    private void returnBook(int loanId)
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True");
        con.Open();
        updateLoan(loanId, con);
        string message = "Book returned successfully. ";
        string sql = "SELECT [Total] FROM Fines WHERE LoanId = @LoanId";

        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@LoanId", loanId);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            message += string.Format("Book Overdue! Fine: €{0}", dr["Total"]);
        }
        lblReturnBookMessage.Text = message;

        GridView2.SelectedIndex = -1;
        con.Close();
        updateGrids();
        

    }

    private void updateLoan(int loanId, SqlConnection con)
    {
        string sql = "UPDATE Loans SET [ReturnDate] = dateadd(day,datediff(day,(0),getdate()),(0)) WHERE LoanId = @LoanId";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@LoanId", loanId);
        cmd.ExecuteNonQuery();
    }
    protected void btnSearchBook_Click(object sender, EventArgs e)
    {
        SqlDataSourceBookInstances.DataBind();
        GridView3.DataBind();
        
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string userName = txtSearchUser.Text;
        if (userName.Length > 0)
        {
            SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True");
            con.Open();
            string sql = "SELECT UserName FROM Users WHERE UserName = @UserName";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@UserName", userName);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                userNameSelected = dr["UserName"].ToString();
                lblUserInf.Text = userNameSelected;
                txtSearchUser.Enabled = false;
                dr.Close();
                if (isThereFines(userNameSelected, con))
                {
                    lblUserInf.Text += ": There is a pending fine for this user!";
                }
                if (checkLoansLimit(userNameSelected, con))
                {
                    lblUserInf.Text += ": This user has reached the limit of books";
                }
            }
            else
            {
                dr.Close();
                lblUserInf.Text = "User not found!";
            }
            con.Close();
        }
        else
        {
            lblUserInf.Text = "User not found!";
        }

    }

    private bool isThereFines(string userName, SqlConnection con)
    {
        string sql = "SELECT [f].[LoanId] FROM Fines AS [f] INNER JOIN Loans AS [l] ON [f].[LoanId] = [l].[LoanId] INNER JOIN Users AS [u] ON [l].[UserId] = [u].[UserId] WHERE [u].[UserName] = @UserName AND [f].[Paid]=0";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@UserName", userName);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            dr.Close();
            return true;
        }
        dr.Close();
        return false;

    }

    private bool checkLoansLimit(string userName, SqlConnection con)
    {
        int count = 0;
        int limit = 0;
        string sql = "SELECT COUNT(LoanId) AS [Count] FROM Loans AS [l] INNER JOIN Users AS [u] ON [l].[UserId] = [u].[UserId] WHERE [u].[UserName] = @UserName AND [l].ReturnDate IS NULL;";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@UserName", userName);
        SqlDataReader dr = cmd.ExecuteReader();
        
        if (dr.Read())
        {
            count = int.Parse(dr["Count"].ToString());
        }
        dr.Close();
        string sql2 = "SELECT [MaximumItens] FROM SystemParameters";
        cmd = new SqlCommand(sql2, con);
        dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            limit = int.Parse(dr["MaximumItens"].ToString());
        }
        dr.Close();
        if (count >= limit)
        {
            return true;
        }
        return false;
    }


    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        
        if (userNameSelected == "")
        {
            
            lblMessage.Text = "Select a user!";
        }
        else
        { 
            SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True");
            con.Open();
            if (isThereFines(userNameSelected, con))
            {
                lblMessage.Text = "This user cannot borrow books because there is a pending fine.";
            }
            else
            {
                if (checkLoansLimit(userNameSelected, con))
                {
                    lblMessage.Text = "This user cannot borrow books because the limit has been reached.";
                }
                else
                {

                    if (GridView3.SelectedIndex == -1)
                    {
                        lblMessage.Text = "Select an available book!";
                    }
                    else
                    {
                        int bookInstanceId = int.Parse(GridView3.SelectedDataKey.Value.ToString());
                        if(!isBookAvailable(bookInstanceId, con))
                        {
                            lblMessage.Text = "This book is not available!";
                        }
                        else
                        {
                            save(bookInstanceId, userNameSelected,con);
                            lblMessage.Text = "Success";
                        }
                    }
                }
            }
            con.Close();
        }
    }
    protected void btnChange_Click(object sender, EventArgs e)
    {
        lblUserInf.Text = "";
        txtSearchUser.Enabled = true;
        userNameSelected = "";
    }

    private bool isBookAvailable(int bookInstanceId, SqlConnection con)
    {
        string sql = "SELECT [LoanId] FROM Loans WHERE [BookInstanceId] = @BookInstanceId AND [ReturnDate] IS NULL";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@BookInstanceId", bookInstanceId);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            dr.Close();
            return false;
        }
        dr.Close();
        return true;
       
    }

    private void save(int bookInstanceId, string userName, SqlConnection con)
    {
        string sql = "INSERT INTO Loans ([UserId], [BookInstanceId]) SELECT [UserId], @BookInstanceId FROM Users WHERE [UserName] = @UserName";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@BookInstanceId", bookInstanceId);
        cmd.Parameters.AddWithValue("@UserName", userName);
        cmd.ExecuteNonQuery();
        updateGrids();
    }

    private void updateGrids()
    {
        SqlDataSource1.DataBind();
        SqlDataSource2.DataBind();
        SqlDataSourceBookInstances.DataBind();
        GridView1.DataBind();
        GridView2.DataBind();
        GridView3.DataBind();
    }
}