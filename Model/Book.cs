using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PrjNewBibliotec.Model {
    public class Book {
        public ushort Id { get; set; }
        public string ISBN { get; set; }
        public string Name { get; set; }
        public ushort Year { get; set; }
        public string Synopsis { get; set; }
        public Editor Editor { get; set; }
        public List<Category> Category { get; set; }
        public List<Author> Author { get; set; }
        public byte[] Image { get; set; }

        public Book() { }
        public Book (ushort id, string ibsn, string name, ushort year, string synopsis, Editor publisher, List<Author> author, List<Category> category, byte[] image) {
            this.Id = id;
            this.ISBN = ibsn;
            this.Name = name;
            this.Year = year;
            this.Synopsis = synopsis;
            this.Editor = publisher;
            this.Author = author;
            this.Category = category;
            this.Image = image;
        }
    }
}