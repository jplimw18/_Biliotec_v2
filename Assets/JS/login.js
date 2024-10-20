let btnLogin = document.getElementById('btn-login-cadastro');

let regLogin = document.getElementById('regiao-login');
let btnCloseLogin = document.getElementById('btn-close-login');
let alternarJanelaLogin = false;

let form = document.getElementById('form-login');
let txtEmail = document.getElementById('txt-email-login');
let txtPass = document.getElementById('txt-pass-login');
let btnLogar = document.getElementById('btn-login');

form.onsubmit = (e) => {
    e.preventDefault();
}

if(btnLogin != null) {
    btnLogin.addEventListener('click', abrirJanelaLogin);
}

if(btnCloseLogin != null){
    btnCloseLogin.onclick = () => {
        regLogin.classList.add('escondido');
        alternarJanelaLogin = false;
    }
}

function abrirJanelaLogin() {
    if(!alternarJanelaLogin){
        regLogin.classList.remove('escondido');
        alternarJanelaLogin = !alternarJanelaLogin;
    }else{
        regLogin.classList.add('escondido');
        alternarJanelaLogin = !alternarJanelaLogin
    }
}