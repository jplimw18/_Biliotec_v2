using PrjNewBibliotec.DB;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PrjNewBibliotec.Model;
using MySql.Data.MySqlClient;

namespace PrjNewBibliotec.Controllers {
    public class BookController : DBFunctions {
        public ErrorDataResponse<List<Book>> LoadBooksNonFilter() {
            ErrorResponse e = Connect();
            ErrorDataResponse<List<Book>> res = new ErrorDataResponse<List<Book>>();

            if (e.IsError) {
                Disconnect();
                res.IsError = true;
                res.ErrorMsg = e.ErrorMsg;
                res.Data = null;
            }
            else {

                ErrorDataResponse<MySqlDataReader> data = Consult("LoadBooksNonFilter", null);

                if (data.IsError) {
                    res.IsError = true;
                    res.ErrorMsg = data.ErrorMsg;
                    res.Data = null;
                }
                else {
                    List<Book> bookList = new List<Book>();
                    using (data.Data) {
                        if (data.Data.HasRows) {
                            while (data.Data.Read()) {
                                Editor editor = new Editor {
                                    Id = data.Data.GetUInt16(5),
                                    Name = data.Data.GetString(6)
                                };

                                List<Author> authorList = new List<Author>();
                                string[] authorIds = data.Data.GetString(7).Split(',');
                                string[] authorNames = data.Data.GetString(8).Split(',');

                                for (int i = 0; i < authorIds.Length; i++) {
                                    authorList.Add(new Author {
                                        Id = ushort.Parse(authorIds[i]),
                                        Name = authorNames[i]
                                    });
                                }

                                List<Category> categorylist = new List<Category>();
                                string[] categoryIds = data.Data.GetString(9).Split(',');
                                string[] categoryNames = data.Data.GetString(10).Split(',');

                                for (int i = 0; i < categoryIds.Length; i++) {
                                    categorylist.Add(new Category {
                                        Id = ushort.Parse(categoryIds[i]),
                                        Name = categoryNames[i]
                                    });
                                }

                                Book book = new Book {
                                    Id = data.Data.GetUInt16(0),
                                    ISBN = data.Data.GetString(1),
                                    Name = data.Data.GetString(2),
                                    Year = data.Data.GetUInt16(3),
                                    Synopsis = data.Data.GetString(4),
                                    Editor = editor,
                                    Category = categorylist,
                                    Author = authorList
                                };

                                bookList.Add(book);
                            }
                        }
                    }

                    res.IsError = false;
                    res.Data = bookList;
                }
                
                Disconnect();
            }

            return res;
        }
    }
}