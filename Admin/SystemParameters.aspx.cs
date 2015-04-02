using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_SystemParameters : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True");
        con.Open();
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;

        cmd.CommandText = " UPDATE [SystemParameters] SET [Fine] = @Fine, [MaximumRenewals] = @MaximumRenewals, [MaximumItens] = @MaximumItens, [NumberOfDays] = @NumberOfDays";

        cmd.Parameters.Add("@Fine", SqlDbType.Float, 50);
        cmd.Parameters.Add("@MaximumRenewals", SqlDbType.Int, 50);
        cmd.Parameters.Add("@MaximumItens", SqlDbType.Int, 50);
        cmd.Parameters.Add("@NumberOfDays", SqlDbType.Int, 50);

        cmd.Parameters["@Fine"].Value = txtFine.Text;
        cmd.Parameters["@MaximumRenewals"].Value = txtMaxR.Text;
        cmd.Parameters["@MaximumItens"].Value = txtMaxIt.Text;
        cmd.Parameters["@NumberOfDays"].Value = txtNum.Text;
        cmd.ExecuteNonQuery();
        con.Close();
    }
}