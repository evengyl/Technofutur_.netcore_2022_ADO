
using System.Data.SqlClient;
//n'oubliez pas de changer votre Connection String !!!
string connectionString = @"Data Source=(localdb)\NetCoreTechno2022;Initial Catalog=DbSlides;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

using(SqlConnection c = new SqlConnection(connectionString))
{
    using(SqlCommand cmd = c.CreateCommand())
    {
        /* Insert Et Update SIMPLE */
        /*
        cmd.CommandText = "INSERT INTO Section (Id, SectionName) VALUES (4242, 'Pignouf')";
        cmd.CommandText = "UPDATE Section SET SectionName = 'Pignouffard' WHERE Id = 4242";

        c.Open();
        int affectedLine = cmd.ExecuteNonQuery();

        if (affectedLine > 0)
            Console.WriteLine(affectedLine);
        else
            throw new ArgumentException("Erreur DML");
        */


        /* Utilisation des tables inserted et deleted */

        //cmd.CommandText = "INSERT INTO Section (Id, SectionName) " +
        //    "output inserted.Id " +
        //    "VALUES (4444, 'Pignouf')";

        //cmd.CommandText = "UPDATE Section SET SectionName = 'BandeDePignoufs' " +
        //    "output deleted.Id WHERE Id = 4343";


        //c.Open();

        //using (SqlDataReader reader = cmd.ExecuteReader())
        //{
        //    while(reader.Read())
        //    {
        //        Console.WriteLine($"Id Inserted = {reader[0]}");
        //        Console.WriteLine($"Id Deleted = {reader[1]}");
        //    }
        //}


        /* Utilisation de la table deleted avec ordre DML delete*/
        //cmd.CommandText = "DELETE FROM Section output deleted.Id WHERE Id = 4242";
        //c.Open();
        //int IdDeleted = (int)cmd.ExecuteScalar();
        //Console.WriteLine(IdDeleted);


        //cmd.CommandText = "DELETE FROM Section output deleted.Id WHERE Id in (4343, 4444)";
        //c.Open();

        //using (SqlDataReader reader = cmd.ExecuteReader())
        //{
        //    while (reader.Read())
        //    {
        //        Console.WriteLine($"Id Deleted = {reader[0]}");
        //    }
        //}


        //Exemple de requète paramétrées
        /* Insert Et Update PARAMETERS */
        /*
        cmd.CommandText = "INSERT INTO Section (Id, SectionName) VALUES (@Id, @SectionName)";

        //technique d'injections de paramètres la moins marrante...
        SqlParameter pInsert_id = new SqlParameter()
        {
            ParameterName = "Id",
            Value = 4242
        };

        SqlParameter pInsert_sectionName = new SqlParameter()
        {
            ParameterName = "SectionName",
            Value = "Pignouf"
        };
        // méthode d'attributions des params au commander
        cmd.Parameters.Add(pInsert_id);
        cmd.Parameters.Add(pInsert_sectionName);

        */



        //cmd.CommandText = "UPDATE Section SET SectionName = @sectionName WHERE Id = @id";
        //// méthode facile d'attributions des params au commander
        //cmd.Parameters.AddWithValue("sectionName", "SaValeurDirectBandeDePignouf");
        //cmd.Parameters.AddWithValue("id", 4242);
        //// Pour ajouter un null manuellement en DB !
        //cmd.Parameters.AddWithValue("exemple", DBNull.Value);
        //// --> Null en c# n'est pas un Null en T-sql (tous les autres aussi...)!



       

        c.Open();
        int affectedLine = cmd.ExecuteNonQuery();

        if (affectedLine > 0)
            Console.WriteLine(affectedLine);
        else
            throw new ArgumentException("Erreur DML");
        


    }
}