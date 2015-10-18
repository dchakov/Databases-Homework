namespace StudentSystem.Models
{
    using System.ComponentModel.DataAnnotations.Schema;

    [ComplexType]
    public class StudentInfo
    {
        [Column("Town")]
        public string Town { get; set; }

        [Column("Degree")]
        public string Degree { get; set; }

        [Column("Adress")]
        public string Adress { get; set; }
    }
}
