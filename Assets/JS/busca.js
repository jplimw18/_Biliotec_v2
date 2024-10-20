let form = document.getElementById('form-pesquisa');
let srcBar = document.getElementById('bar-pesquisa');
let srcBtn = document.getElementById('btn-pesquisa');

form.onsubmit = (e) => {
    e.preventDefault();
}

if (srcBtn != null) {
    srcBtn.addEventListener('click', search)
}
async function search() {
    if (srcBar.value == "") {
        srcBar.focus();
        return;
    }

    await fetch('../../lib/ManageSearch.aspx?f=' + srcBar.value).then((resp) => {
        return resp.json();
    }).then((data) => {
        if (data != null) {
            if (data["situation"] != null) {
                srcBar.focus();
                console.log(data["situation"]);
                return;
            }
            
            for (let i = 0; i < data.length; i++) {
                console.log(data[i].Name);
            }
        }
    });
}