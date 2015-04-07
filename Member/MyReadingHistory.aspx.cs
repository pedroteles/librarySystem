using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Member_MyReadingHistory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userName = Membership.GetUser().UserName;
        SqlDataSource1.SelectParameters["UserName"].DefaultValue = userName;
    }
}