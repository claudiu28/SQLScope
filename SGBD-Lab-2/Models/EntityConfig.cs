using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGBD_Lab_2.Models
{
    class EntityConfig
    {
        public string Table { get; set; } = default!;
        public List<ColumnsProps> Columns { get; set; } = [];
        public string? SelectCommand { get; set; }
        public string? UpdateCommand { get; set; }
        public string? DeleteCommand { get; set; }
        public string? InsertCommand { get; set; }


    }
}
