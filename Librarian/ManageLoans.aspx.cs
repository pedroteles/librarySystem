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
}