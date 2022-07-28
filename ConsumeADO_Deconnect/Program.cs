using System.Data;
using System.Data.SqlClient;
//n'oubliez pas de changer votre Connection String !!!

string connectionString = @"Data Source=DESKTOP-BJ6JDQ3\SQLEXPRESS;
Initial Catalog=DbSlidesNetCore;
Integrated Security=True;";

using(SqlConnection c = new SqlConnection(connectionString))
{
    using(SqlCommand cmd = c.CreateCommand())
    {
        cmd.CommandText = "SELECT * FROM Section; SELECT * FROM Student";

        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = cmd;
        DataSet ds = new DataSet();
        da.Fill(ds);
        

        if(ds.Tables.Count > 0)
        {
            foreach(DataRow dr in ds.Tables[0].Rows)
            {
                Console.WriteLine($"{ dr["SectionName"] }");
            }

            foreach (DataRow dr in ds.Tables[1].Rows)
            {
                Console.WriteLine($"{ dr["LastName"] }");
            }
        }
    }
}