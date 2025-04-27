using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SGBD_Lab_2.Models
{
    class Config
    {
        public string ConnectionString { get; set; } = default!;
        public string Title { get; set; } = default!;

        public EntityConfig Parent { get; set; } = default!;

        public EntityConfig Child { get; set; } = default!;
    }
}
