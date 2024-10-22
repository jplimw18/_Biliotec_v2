let form = document.getElementById('form-pesquisa');
let srcBar = form.firstChild.nextSibling;

let resultRegion = document.getElementById('regiao-resultado-pesquisa');

form.onsubmit = (e) => {
    e.preventDefault();
    search();
}

async function search() {
    if (srcBar.value == "") {
        srcBar.focus();
    }
    else {

        let filter = encodeURIComponent(srcBar.value);
        await fetch('../../lib/ManageSearch.aspx?f=${ filter }').then((resp) => {
            return resp.json();
        }).then((data) => {
            if (data != null) {
                if (data["situation"] != null) {
                    srcBar.focus();
                    console.log(data["situation"]);
                }
                else {
                    let h2 = resultRegion.firstElementChild;
                    h2.textContent = 'Resultados para ${ srcBar.value }';
                    for (let i = 0; i < data.length; i++) {
                        let article = document.createElement('article');
                        article.classList.add('item-resultado-pesquisa');

                        let figure = document.creatElement('figure');

                        let img = document.createElement('img');
                        img.src = 'Assets/img/livros/livro1.jpg';
                        img.alt = 'Imagem referente a capa do livro ${ data[i]["Name"] }';
                        img.height = '300';
                        img.loading = 'lazy';

                        let figCaption = document.createElement('figcaption');
                        
                    }
                }
            }
        });
    }
}