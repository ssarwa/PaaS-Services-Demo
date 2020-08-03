using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace School_Engage_Demo.Models
{
    public class Containers
    {
        public Containers()
        {
            Pdfs = new List<string>();
            Images = new List<string>();
        }
        public IList<string> Pdfs { get; set; }
        public IList<string> Images { get; set; }

    }
}