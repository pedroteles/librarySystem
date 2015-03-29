using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Collection : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = "SELECT [BookId], [Isbn], [Title], [Summary], [Edition] FROM [Books]";
        string[] keys = Request.QueryString.AllKeys;
        if (keys.Length > 0)
        {
            string key = keys[0];
            string value = Request.QueryString[key];
            if (value != null)
            {
                SqlDataSource1.SelectCommand = string.Format("SELECT [BookId], [Isbn], [Title], [Summary], [Edition] FROM [Books] WHERE {0} LIKE '%{1}%'", key, value);
            }
            
        }
       
        
    
            
    }
}