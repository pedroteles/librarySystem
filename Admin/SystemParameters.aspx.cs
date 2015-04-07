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

        if (!IsPostBack)
        {
            SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True");
            con.Open();

            using (SqlCommand cmd = new SqlCommand("SELECT [Fine], [MaximumRenewals], [MaximumItens], [NumberOfDays] FROM SystemParameters", con))
            {
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtFine.Text = dr["Fine"].ToString();
                    txtMaxR.Text = dr["MaximumRenewals"].ToString();
                    txtMaxIt.Text = dr["MaximumItens"].ToString();
                    txtNum.Text = dr["NumberOfDays"].ToString();

                }

                dr.Close();
            }
            con.Close();
        }
       

    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True");
        con.Open();
        string sql = "UPDATE SystemParameters SET [Fine] = @Fine, [MaximumRenewals] = @MaximumRenewals, [MaximumItens] = @MaximumItens, [NumberOfDays] = @NumberOfDays";
        SqlCommand cmd = new SqlCommand(sql, con);

        cmd.Parameters.AddWithValue("@Fine", txtFine.Text);
        cmd.Parameters.AddWithValue("@MaximumRenewals", txtMaxR.Text);
        cmd.Parameters.AddWithValue("@MaximumItens", txtMaxIt.Text);
        cmd.Parameters.AddWithValue("@NumberOfDays", txtNum.Text);
        cmd.ExecuteNonQuery();
        con.Close();
        lblMessage.Text = "Saved!";
    }
}