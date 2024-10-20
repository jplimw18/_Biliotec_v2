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

            if (e.IsError) {
                Disconnect();
                return new ErrorDataResponse<List<Book>> {
                    IsError = true,
                    Data = null,
                    ErrorMsg = e.ErrorMsg
                };
            }

            ErrorDataResponse<MySqlDataReader> data = Consult("LoadBooksNonFilter", null);

            if (data.IsError) {
                return new ErrorDataResponse<List<Book>> {
                    IsError = true,
                    Data = null,
                    ErrorMsg = data.ErrorMsg
                };
            }

            List<Book> bookList = new List<Book>();
            using (data.Data) {
                if (data.Data.HasRows) {
                    while (data.Data.Read()) {
                        Editor editor = new Editor {
                            Id = data.Data.GetUInt16(0),
                            Name = data.Data.GetString(1)
                        };

                        List<Author> authorList = new List<Author>();
                        string[] authorIds = data.Data.GetString(7).Split(',');
                        string[] authorNames = data.Data.GetString(8).Split(',');

                        for(int i = 0; i < authorIds.Length; i++) {
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

            Disconnect();

            return new ErrorDataResponse<List<Book>> { Data = bookList };
        }
    }
}