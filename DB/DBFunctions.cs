using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

namespace PrjNewBibliotec.DB {
    public struct ErrorResponse {
        public bool IsError;
        public string ErrorMsg;
    }

    public struct ErrorDataResponse<T> {
        public bool IsError;
        public string ErrorMsg;
        public T Data;
    }
    public class DBFunctions {
        private MySqlConnection connection = null;

        protected ErrorResponse Connect() {
            ErrorResponse err = new ErrorResponse();
            try {
                connection = new MySqlConnection(Connection.GetConnection());
                connection.Open();
            }
            catch (MySqlException e) {
                err.IsError = true;
                err.ErrorMsg = $"DB: {e.Message}";
            }
            catch (Exception e) {
                err.IsError = true;
                err.ErrorMsg = $"Genérico: {e.Message}";
            }

            return err;
        }

        protected ErrorResponse Execute(string command, List<MySqlParameter> parameters) {
            ErrorResponse err = new ErrorResponse();

            try {
                MySqlCommand cSQL = new MySqlCommand(command, connection);
                cSQL.CommandType = System.Data.CommandType.StoredProcedure;

                if (parameters != null & parameters.Count > 0) {
                    cSQL.Parameters.Add(parameters);
                }

                cSQL.ExecuteNonQuery();
            }
            catch (MySqlException e) {
                err.IsError = true;
                err.ErrorMsg = $"DB: {e.Message}";
            }
            catch (Exception e) {
                err.IsError = true;
                err.ErrorMsg = $"Genérico: {e.Message}";
            }
            finally {
                Disconnect();
            }

            return err;
        }

        protected ErrorDataResponse<MySqlDataReader> Consult(string command, List<MySqlParameter> parameters) {
            ErrorDataResponse<MySqlDataReader> err = new ErrorDataResponse<MySqlDataReader>();

            try {
                MySqlCommand cSQL = new MySqlCommand(command, connection);
                cSQL.CommandType = System.Data.CommandType.StoredProcedure;

                if (parameters != null && parameters.Count > 0) {
                    foreach(MySqlParameter param in parameters) {
                        cSQL.Parameters.Add(param);
                    }
                }

                err.Data = cSQL.ExecuteReader();
            }
            catch (MySqlException e) {
                err.IsError = true;
                err.ErrorMsg = $"DB: {e.Message}";
                err.Data = null;
            }
            catch (Exception e) {
                err.IsError = true;
                err.ErrorMsg = $"Genérico: {e.Message}";
                err.Data = null;
            }

            return err;
        }

        protected ErrorResponse Disconnect() {
            ErrorResponse err = new ErrorResponse();
            try {
                if (connection != null) {
                    if (connection.State == System.Data.ConnectionState.Open) {
                        connection.Close();
                    }
                }
            }
            catch (MySqlException e) {
                err.IsError = true;
                err.ErrorMsg = $"DB: {e.Message}";
            }
            catch (Exception e) {
                err.IsError = true;
                err.ErrorMsg = $"Genérico: {e.Message}";
            }

            return err;
        }
    }
}