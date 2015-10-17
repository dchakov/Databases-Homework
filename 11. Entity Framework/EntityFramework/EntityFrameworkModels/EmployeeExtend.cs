using System.Collections.Generic;
using System.Data.Linq;

namespace EntityFrameworkModels
{
    public partial class Employee
    {
        public ICollection<Territory> TerritoryProperty
        {
            get
            {
                return this.Territories;
            }
        }
    }
}
