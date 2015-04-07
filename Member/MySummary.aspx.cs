using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Member_ManageMyBooks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userName = Membership.GetUser().UserName;
        SqlDataSource1.SelectParameters["UserName"].DefaultValue = userName;
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int loanId = int.Parse(GridView1.SelectedDataKey.Value.ToString());
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True;Connect Timeout=30;User Instance=False;");
        con.Open();
        if (isLoanRenewable(loanId, con))
        {
            updateLoan(loanId, con);
            GridView1.DataBind();
           // lblMessage.Text = "Book renewed!";
        }

        con.Close();
    }

    private bool isLoanRenewable(int loanId, SqlConnection con)
    {
        lblMessage.Text = "";

        return !isLoanOverDue(loanId, con) & !isThereFines(loanId, con) & !isRenewalsLimitRechead(loanId, con);
    }

    private bool isLoanOverDue(int loanId, SqlConnection con)
    {
        string sql = "SELECT 1 WHERE EXISTS (SELECT [LoanId] FROM [Loans] WHERE [DateDue] < dateadd(day,datediff(day,(0),getdate()),(0)) AND [ReturnDate] IS NULL AND [UserId] =(SELECT [UserId] FROM Loans WHERE [LoanId] = @LoanId) )";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@LoanID", loanId);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            
            dr.Close();
            lblMessage.Text += "There is a Book Overdue! ";
            
            return true;
        }
        dr.Close();
        return false;
    }

    private bool isThereFines(int loanId, SqlConnection con)
    {
        string sql = "SELECT 1 WHERE EXISTS (SELECT [f].[LoanId] FROM Fines AS [f] INNER JOIN Loans AS [l] ON [f].[LoanId] = [l].[LoanId] WHERE [f].[Paid] = 'false' and [l].[UserId]  = (SELECT UserId FROM Loans WHERE LoanId = @LoanId))";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@LoanId", loanId);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            lblMessage.Text += "There are pending fines! ";
            dr.Close();
            return true;
        }
        dr.Close();
        return false;
    }

    private bool isRenewalsLimitRechead(int loanId, SqlConnection con)
    {
        string sql = "SELECT CASE WHEN (Renewals >= (SELECT MaximumRenewals FROM SystemParameters)) THEN 1 ELSE 0 END AS Result FROM Loans WHERE LoanId = @LoanId";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@LoanId", loanId);
        SqlDataReader dr = cmd.ExecuteReader();
        if (dr.Read())
        {
            if (dr["Result"].ToString() == "1")
            {
                lblMessage.Text += "This book cannot be renewed anymore! Please return it! ";
                dr.Close();
                return true;
            }
        }
        dr.Close();
        return false;
    }

    private void updateLoan(int loanId, SqlConnection con)
    {
        string sql = "UPDATE Loans SET [Date] = dateadd(day,datediff(day,(0),getdate()),(0)) WHERE LoanId = @LoanId";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@LoanId", loanId);
        cmd.ExecuteNonQuery();

    }

}