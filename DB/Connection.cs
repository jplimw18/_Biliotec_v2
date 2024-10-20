using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrjNewBibliotec.DB {
    public class Connection {
        public static string GetConnection() {
            return "USER=root;PASSWORD=root;SERVER=localhost;DATABASE=Bibliotec";
        }
    }
}