using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Librarians : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string userId = GridView1.SelectedDataKey.Value.ToString();
        setAsLibrarian(userId);
        GridView1.DataBind();
    }
    private void setAsLibrarian(string userId)
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=|DataDirectory|\aspnet-librarySystem-20150310153417.mdf;Integrated Security=True;Connect Timeout=30;User Instance=False;");
        con.Open();
        string sql = "INSERT INTO UsersInRoles (UserId, RoleId) SELECT @UserId, [RoleId] FROM Roles WHERE [RoleName] = 'librarian' ";
        SqlCommand cmd = new SqlCommand(sql, con);
        cmd.Parameters.AddWithValue("@UserId", userId);
        cmd.ExecuteNonQuery();
        con.Close();
    }
}