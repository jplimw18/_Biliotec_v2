using PrjNewBibliotec.DB;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PrjNewBibliotec.Model;
using PrjNewBibliotec.Controllers;
using System.Web.Script.Serialization;

namespace PrjNewBibliotec.lib {
    public partial class ManageSearch : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            Response.ContentType = "application/json";
            string resp = "{\"situation\":\"empty\"}";

            if (!String.IsNullOrEmpty(Request["f"])) {
                string filter = Request["f"].ToString();

                ErrorDataResponse<List<Book>> resultList = new BookController().LoadBooksNonFilter();
                if (resultList.IsError) {
                    resp = "{\"situation\":\"" + resultList.ErrorMsg + "\"}";
                    Response.Write(resp);
                    return;
                }

                JavaScriptSerializer json = new JavaScriptSerializer();
                resp = json.Serialize(resultList.Data);
                Response.Write(resp);
            }
            else {
                Response.Write(resp);
            }
        }
    }
}