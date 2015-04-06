using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Librarian_PayFees : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
     
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        updateFine();
        GridView1.DataBind();
    }

    private void updateFine()
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True");
        con.Open();
        string sql = "UPDATE FINES SET [Paid] = 1 WHERE [LoanId] = @LoanId";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@LoanID", GridView1.SelectedDataKey.Value);
        cmd.ExecuteNonQuery();
    }
}