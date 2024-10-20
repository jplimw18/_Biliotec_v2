using MySql.Data.MySqlClient;
using Mysqlx;
using PrjNewBibliotec.DB;
using PrjNewBibliotec.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;

namespace PrjNewBibliotec.Controllers {
    public class EditorController : DBFunctions {
        public ErrorDataResponse<List<Editor>> LoadEditorNonFilter() {
            ErrorResponse e = Connect();

            if (e.IsError) {
                return new ErrorDataResponse<List<Editor>> {
                    IsError = true,
                    Data = null,
                    ErrorMsg = e.ErrorMsg
                };
            }

            ErrorDataResponse<MySqlDataReader> data = Consult("LoadEditors", null);
            if (data.IsError) {
                return new ErrorDataResponse<List<Editor>> {
                    IsError = true,
                    Data = null,
                    ErrorMsg = data.ErrorMsg
                };
            }

            List<Editor> editorList = new List<Editor>();

            using (data.Data) {
                if (data.Data.HasRows) {
                    while (data.Data.Read()) {
                        Editor editor = new Editor();
                        editor.Id = ushort.Parse(data.Data[0].ToString());
                        editor.Name = data.Data.GetString(1);

                        editorList.Add(editor);
                    }
                }
            }

            return new ErrorDataResponse<List<Editor>> { Data = editorList };
        }

        public ErrorDataResponse<List<Editor>> LoadEditors() {
            ErrorResponse e = Connect();

            if (e.IsError) {
                return new ErrorDataResponse<List<Editor>> {
                    IsError = true,
                    Data = null,
                    ErrorMsg = e.ErrorMsg
                };
            }

            ErrorDataResponse<MySqlDataReader> data = Consult("LoadEditorWFilter", null);

            if (data.IsError) {
                if (!data.Data.IsClosed) {
                    data.Data.Close();
                }

                Disconnect();

                return new ErrorDataResponse<List<Editor>> {
                    IsError = true,
                    Data = null,
                    ErrorMsg = data.ErrorMsg
                };
            }

            List<Editor> editorList = new List<Editor>();
            using (data.Data) {
                if (data.Data.HasRows) {
                    while (data.Data.Read()) {
                        Editor editor = new Editor {
                            Id = data.Data.GetUInt16(0),
                            Name = data.Data.GetString(1)
                        };

                        editorList.Add(editor);
                    }
                }
            }
            return new ErrorDataResponse<List<Editor>> { Data = editorList };
        }
    }
}