using System.Data.SqlClient;
//n'oubliez pas de changer votre Connection String !!!
string connectionString = @"Data Source=DESKTOP-BJ6JDQ3\SQLEXPRESS;
Initial Catalog=DbSlidesNetCore;
Integrated Security=True;";


using (SqlConnection c = new SqlConnection(connectionString))
{
    using (SqlCommand cmd = c.CreateCommand())
    {
        cmd.CommandText = @"SELECT id FROM Student WHERE LastName = 'Lucas' ";

        c.Open();
        int lastName = (int)cmd.ExecuteScalar();
        c.Close();
        //Console.WriteLine(lastName);
    }




    using (SqlCommand cmd = c.CreateCommand())
    {
        cmd.CommandText = @"SELECT * FROM Student";

        c.Open();
        
        using(SqlDataReader reader = cmd.ExecuteReader())
        {
            List<System.Data.Common.DbColumn> schema = new List<System.Data.Common.DbColumn>();
            schema.AddRange(reader.GetColumnSchema().ToArray());

            foreach(System.Data.Common.DbColumn item in schema)
            {
                Console.WriteLine(item.ColumnName);
            }

            while (reader.Read())
            {
                Console.WriteLine($"L'id de la personne : #{reader["Id"]} -" +
                    $" {reader["LastName"]} {reader[1]}");

            }
        }

        c.Close();
    }

}