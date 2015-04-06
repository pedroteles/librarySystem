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
    protected void Page_Load(object sender, EventArgs e)
    {

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
        string message = "The book returned successfully. ";
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
        GridView2.DataBind();
        

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
                lblUserInf.Text = dr["UserName"].ToString();
                dr.Close();
                if(isThereFines(userName, con)){
                    lblUserInf.Text += ": There is a pending fine for this user!";
                }
                if(checkLoansLimit(userName, con))
                {
                    lblUserInf.Text += ": This user has reached the limit of books";
                }
            }
            else
            {   dr.Close();
                lblUserInf.Text = "User not found!";
            }
            con.Close();
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


}