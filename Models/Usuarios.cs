using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PruebaDocker.Models
{
    public partial class Usuarios
    {
        [ScaffoldColumn(false)]
        public int UserId { get; set; }
        public string Nombre { get; set; }
        public string Email { get; set; }
        public bool Activo { get; set; }
    }
}
