DROP SCHEMA IF EXISTS BiblioTec;
CREATE SCHEMA BiblioTec;
USE BiblioTec;

CREATE TABLE editora
(
	cd_editora INT,
	nm_editora VARCHAR(200),
	CONSTRAINT pk_editora PRIMARY KEY (cd_editora)
);

CREATE TABLE livro 
(
	cd_livro INT,
	cd_ISBN VARCHAR(200),
	nm_livro TEXT,
	aa_edicao INT,
	ds_sinopse TEXT,
	cd_editora INT,
	na_imagem LONGBLOB,
	CONSTRAINT pk_livro PRIMARY KEY (cd_livro),
	CONSTRAINT fk_livro_editora1 FOREIGN KEY (cd_editora)
		REFERENCES editora(cd_editora)
);

CREATE TABLE  autor 
(
  cd_autor INT,
  nm_autor VARCHAR(200),
  CONSTRAINT pk_autor PRIMARY KEY (cd_autor) 
);

CREATE TABLE  categoria 
(
  cd_categoria INT,
  nm_categoria VARCHAR(200),
  CONSTRAINT pk_categoria PRIMARY KEY (cd_categoria) 
);

CREATE TABLE  livro_categoria 
(
  cd_livro INT,
  cd_categoria INT,
  CONSTRAINT pk_livro_cat PRIMARY KEY (cd_livro, cd_categoria) ,
  CONSTRAINT fk_livro_categoria_livro1 FOREIGN KEY (cd_livro)
    REFERENCES livro (cd_livro),
  CONSTRAINT fk_livro_categoria_categoria1 FOREIGN KEY (cd_categoria)
    REFERENCES categoria (cd_categoria)
);

CREATE TABLE  localizacao 
(
  cd_localizacao INT,
  nm_localizacao VARCHAR(255),
  CONSTRAINT pk_localizacao PRIMARY KEY (cd_localizacao)
);

CREATE TABLE  exemplar 
(
  cd_exemplar INT,
  cd_livro INT,
  ic_fixo TINYINT(1),
  cd_localizacao INT,
  CONSTRAINT pk_exemplar PRIMARY KEY (cd_exemplar, cd_livro),
  CONSTRAINT fk_exemplar_livro1 FOREIGN KEY (cd_livro)
    REFERENCES livro (cd_livro),
  CONSTRAINT fk_exemplar_localizacao1 FOREIGN KEY (cd_localizacao)
    REFERENCES localizacao (cd_localizacao)
);


CREATE TABLE  tipo_usuario 
(
  cd_tipo_usuario INT,
  nm_tipo_usuario VARCHAR(45),
  CONSTRAINT pk_tipo_usuario PRIMARY KEY (cd_tipo_usuario)
);

CREATE TABLE  usuario 
(
  nm_login VARCHAR(200),
  nm_usuario VARCHAR(255),
  nm_senha VARCHAR(64),
  ic_bloqueado TINYINT(1),
  dt_bloqueio DATE,
  cd_tipo_usuario INT,
  CONSTRAINT pk_usuario PRIMARY KEY (nm_login),
  CONSTRAINT fk_usuario_tipo_usuario1 FOREIGN KEY (cd_tipo_usuario)
    REFERENCES tipo_usuario (cd_tipo_usuario)
);

CREATE TABLE  tipo_emprestimo 
(
  cd_tipo_emprestimo INT,
  nm_tipo_emprestimo VARCHAR(45),
  CONSTRAINT pk_tipo_emp PRIMARY KEY (cd_tipo_emprestimo)
);

CREATE TABLE  emprestimo 
(
  nm_login VARCHAR(200),
  cd_exemplar INT,
  cd_livro INT,
  dt_emprestimo DATE,
  hr_emprestimo TIME,
  dt_devoucao_estimada DATE,
  dt_devolucao DATE,
  cd_tipo_emprestimo INT,
  CONSTRAINT pk_emp PRIMARY KEY (nm_login, cd_exemplar, cd_livro, dt_emprestimo),
  CONSTRAINT fk_usuario_exemplar_usuario1 FOREIGN KEY (nm_login)
    REFERENCES usuario (nm_login),
  CONSTRAINT fk_usuario_exemplar_exemplar1 FOREIGN KEY (cd_exemplar , cd_livro)
    REFERENCES exemplar (cd_exemplar , cd_livro),
  CONSTRAINT fk_emprestimo_tipo_emprestimo1 FOREIGN KEY (cd_tipo_emprestimo)
    REFERENCES tipo_emprestimo (cd_tipo_emprestimo)
);

CREATE TABLE  tipo_ocorrencia 
(
  cd_tipo_ocorrencia INT,
  nm_tipo_ocorrencia VARCHAR(45),
  CONSTRAINT pk_tipo_ocorrencia PRIMARY KEY (cd_tipo_ocorrencia)
);

CREATE TABLE  ocorrencia 
(
  nm_login VARCHAR(200),
  cd_exemplar INT,
  cd_livro INT,
  dt_emprestimo DATE,
  cd_tipo_ocorrencia INT,
  ds_ocorrencia TEXT,
  CONSTRAINT pk_ocorrencia PRIMARY KEY (nm_login, cd_exemplar, cd_livro, dt_emprestimo, cd_tipo_ocorrencia) ,
  CONSTRAINT fk_emprestimo_tipo_ocorrencia_emprestimo1 FOREIGN KEY (nm_login , cd_exemplar , cd_livro , dt_emprestimo)
    REFERENCES emprestimo (nm_login , cd_exemplar , cd_livro , dt_emprestimo),
  CONSTRAINT fk_emprestimo_tipo_ocorrencia_tipo_ocorrencia1 FOREIGN KEY (cd_tipo_ocorrencia)
    REFERENCES tipo_ocorrencia (cd_tipo_ocorrencia)
);

CREATE TABLE  computador 
(
  dt_uso_computador DATE,
  nm_login VARCHAR(200),
  CONSTRAINT pk_computador PRIMARY KEY (dt_uso_computador, nm_login) ,
  CONSTRAINT fk_computador_usuario1 FOREIGN KEY (nm_login)
    REFERENCES usuario (nm_login)
);

CREATE TABLE  livro_autor 
(
  cd_livro INT,
  cd_autor INT,
  CONSTRAINT pk_livro_autor PRIMARY KEY (cd_livro, cd_autor),
  CONSTRAINT fk_livro_autor_livro1 FOREIGN KEY (cd_livro)
    REFERENCES livro (cd_livro),
  CONSTRAINT fk_livro_autor_autor1 FOREIGN KEY (cd_autor)
    REFERENCES autor (cd_autor)
);

INSERT INTO categoria (cd_categoria, nm_categoria) VALUES (1, 'Literatura');
INSERT INTO categoria (cd_categoria, nm_categoria) VALUES (2, 'Biografia');
INSERT INTO categoria (cd_categoria, nm_categoria) VALUES (3, 'Educação');
INSERT INTO categoria (cd_categoria, nm_categoria) VALUES (4, 'Filosofia');
INSERT INTO categoria (cd_categoria, nm_categoria) VALUES (5, 'Química');
INSERT INTO categoria (cd_categoria, nm_categoria) VALUES (6, 'Geografia');
INSERT INTO categoria (cd_categoria, nm_categoria) VALUES (7, 'Matemática');
INSERT INTO categoria (cd_categoria, nm_categoria) VALUES (8, 'Investigação');

/*editora*/
INSERT INTO editora (cd_editora, nm_editora) VALUES (1, 'Rocco');
INSERT INTO editora (cd_editora, nm_editora) VALUES (2, 'L&PM Pocket');
INSERT INTO editora (cd_editora, nm_editora) VALUES (3, 'Pé da Letra');
INSERT INTO editora (cd_editora, nm_editora) VALUES (4, 'Suma');
INSERT INTO editora (cd_editora, nm_editora) VALUES (5, 'Harper Collins Brasil');
INSERT INTO editora (cd_editora, nm_editora) VALUES (6, 'Ática');
-- x --

/*Autores*/
INSERT INTO autor (cd_autor, nm_autor) VALUES (1, 'J. K. Rowling');
INSERT INTO autor (cd_autor, nm_autor) VALUES (2, 'Sun Tzu');
INSERT INTO autor (cd_autor, nm_autor) VALUES (3, 'Arthur Conan Doyle');
INSERT INTO autor (cd_autor, nm_autor) VALUES (4, 'Stephen King');
INSERT INTO autor (cd_autor, nm_autor) VALUES (5, 'Owen King');
INSERT INTO autor (cd_autor, nm_autor) VALUES (6, 'Rafael Procopio');
INSERT INTO autor (cd_autor, nm_autor) VALUES (7, 'Luiz Roberto Dante');
-- x --

/*Desgraça dos livros*/
INSERT INTO livro (cd_livro, cd_ISBN, nm_livro, aa_edicao, ds_sinopse, cd_editora, na_imagem) VALUES (1, '00000001', 'Harry Potter e o cálice de fogo', 2017, 'Nesta aventura, o feiticeiro cresceu e está com 14 anos. O início do ano letivo de Harry Potter reserva muitas emoções, mágicas, e acontecimentos inesperados, além de um novo torneio em que os alunos de Hogwarts terão de demonstrar todas as habilidade mágicas e não-mágicas que vêm adquirindo ao longo de suas vidas. Harry é escolhido pelo Cálice de Fogo para competir como um dos campeões de Hogwarts, tendo ao lado seus fiéis amigos. Muitos desafios, feitiços, poções e confusões estão reservados para Harry. Além disso, ele terá que lidar ainda com os problemas comuns da adolescência - amor, amizade, aceitação e rejeição.', 1, null);
INSERT INTO livro (cd_livro, cd_ISBN, nm_livro, aa_edicao, ds_sinopse, cd_editora, na_imagem) VALUES (2, '00000002', 'Sherlock Holmes - O cão dos Baskervilles', 2019, 'O cão dos Baskervilles é um romance no qual Holmes e seu parceiro tentam desvendar o mistério presente na morte de Sir Charles Baskerville. Além do falecimento repentino, a lenda sobre um cão do mal que assombra a família há anos envolverá Sherlock Holmes e Dr. Watson em uma trama que vai exigir muito deles', 3, null);
INSERT INTO livro (cd_livro, cd_ISBN, nm_livro, aa_edicao, ds_sinopse, cd_editora, na_imagem) VALUES (3, '00000003', 'Sherlock Holmes - O signo dos quatro', 2019, 'O signo dos quatro foi o segundo romance publicado pelo autor e traz uma trama envolvente que tem início quando uma bela moça aparece na Baker Street, 221, pedindo ajuda de Sherlock Holmess para descobrir o que aconteceu com seu pai. A partir daí, Holmes e seu parceiro, Watson, partem para desvendar o mistério', 3, null);
INSERT INTO livro (cd_livro, cd_ISBN, nm_livro, aa_edicao, ds_sinopse, cd_editora, na_imagem) VALUES (4, '00000004', 'Sherlock Holmes - Um escândalo na Boêmia e outras aventuras', 2019, 'O conto Um escândalo na Boêmia faz parte da coletânea de contos mais conhecida do autor e cativou a todos desde que foi apresentado ao público, tornando-se uma das histórias mais famosas do detetive. NEste Livro, Você encontra essa e outras aventuras', 3, null);
INSERT INTO livro (cd_livro, cd_ISBN, nm_livro, aa_edicao, ds_sinopse, cd_editora, na_imagem) VALUES (5, '00000005', 'Sherlock Holmes - O roubo da coroa de Berilos e outras aventuras', 2019, 'O conto faz parte da coletânea de contos mais conhecida do autor. Nele você ajudará Holmes a desvendar o mistério e quem roubou a coroa mais preciosa da Europa. Neste livro, você encontra essa e outras aventuras', 3, null);
INSERT INTO livro (cd_livro, cd_ISBN, nm_livro, aa_edicao, ds_sinopse, cd_editora, na_imagem) VALUES (6, '00000006', 'Sherlock Holmes - A liga dos cabeças vermelhas e outras aventuras', 2019, 'O conto faz parte da coletânea de contos ais conhecida do autor e cativou a todos desde que foi apresentado ao público por ser uma história extraordinária do começo ao fim. Neste livro, você encontrara essa e outras aventuras', 3, null);
INSERT INTO livro (cd_livro, cd_ISBN, nm_livro, aa_edicao, ds_sinopse, cd_editora, na_imagem) VALUES (7, '00000007', 'A arte da guerra', 2012, 'Qual é a originalidade deste que é o mais antigo tratado de guerra? É que é melhor ganhar a guerra antes mesmo de desembainhar a espada. O inimigo não deve ser aniquilado, mas, de preferência, deve ser vencido quando seus domínios ainda estiverem intactos. Muitas vezes, a vitória arduamente conquistada guarda um sabor amargo de derrota, mesmo para os próprios vencedores. A arte da guerra do chinês Sun Tzu, um texto que remonta à turbulenta época dos Estados Combatentes na China há quase 2.500 anos, chegou até nos trazendo as idéias de um filósofo-estrategista que comandou e venceu muitas batalhas.', 2, null);
INSERT INTO livro (cd_livro, cd_ISBN, nm_livro, aa_edicao, ds_sinopse, cd_editora, na_imagem) VALUES (8, '00000008', 'Belas adormecidas', 2017, 'Pelo mundo todo, algo de estranho começa a acontecer quando as mulheres adormecem: elas são imediatamente envoltas em casulos. Se despertadas, se o casulo é rasgado e os corpos expostos, as mulheres se tornam bestiais, reagindo com fúria cega antes de voltar a dormir. Em poucos dias, quase cem por cento da população mundial feminina pegou no sono. Sozinhos e desesperados, os homens se dividem entre os que fariam de tudo para proteger as mulheres adormecidas e aqueles que querem aproveitar a crise para instaurar o caos. Grupos de homens formam as “Brigadas do Maçarico”,incendeiam em massa casulos, e em diversas partes do mundo guerras parecem prestes a eclodir. Mas na pequena cidade de Dooling as autoridades locais precisam lidar com o único caso de imunidade à doença do sono: Evie Black, uma mulher misteriosa com poderes inexplicáveis. Escrito por Stephen King e Owen King, Belas Adormecidas é um livro provocativo, dramático e corajoso, que aborda temas cada vez mais urgentes e relevantes.', 4, null);
INSERT INTO livro (cd_livro, cd_ISBN, nm_livro, aa_edicao, ds_sinopse, cd_editora, na_imagem) VALUES (9, '00000009', 'Sou péssimo em matemática', 2019, 'A matemática tem tantas fórmulas e regras que às vezes assusta, é ou não é? Você tenta fazer a conta uma, duas, três vezes, até arrancar a folha de papel, jogar o lápis para longe e dizer: "Não tem jeito, eu sou péssimo em matemática".Mas acredite: tem jeito, sim. E digo mais: esse jeito pode ser muito divertido.Quer aprender matemática? Vem comigo! Você não está sozinho, eu estou contigo.', 5, null);
INSERT INTO livro (cd_livro, cd_ISBN, nm_livro, aa_edicao, ds_sinopse, cd_editora, na_imagem) VALUES (10, '00000010', 'Matemática - Contexto & Aplicações - Volume 2', 2020, 'Esta obra reflete sua experiência no trabalho com a metodologia de resoluções de problemas e apresenta os conceitos de forma objetiva', 6, null);
-- x --

/*autor_livro*/
INSERT INTO livro_autor (cd_livro, cd_autor) VALUES (1, 1);

INSERT INTO livro_autor (cd_livro, cd_autor) VALUES (2, 3);
INSERT INTO livro_autor (cd_livro, cd_autor) VALUES (3, 3);
INSERT INTO livro_autor (cd_livro, cd_autor) VALUES (4, 3);
INSERT INTO livro_autor (cd_livro, cd_autor) VALUES (5, 3);
INSERT INTO livro_autor (cd_livro, cd_autor) VALUES (6, 3);

INSERT INTO livro_autor (cd_livro, cd_autor) VALUES (7, 2);

INSERT INTO livro_autor (cd_livro, cd_autor) VALUES (8, 4);
INSERT INTO livro_autor (cd_livro, cd_autor) VALUES (8, 5);

INSERT INTO livro_autor (cd_livro, cd_autor) VALUES (9, 6);

INSERT INTO livro_autor (cd_livro, cd_autor) VALUES (10, 7);
-- x --

/*Livro_categoria*/
INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (1, 1);

INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (2, 8);
INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (3, 8);
INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (4, 8);
INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (5, 8);
INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (6, 8);

INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (2, 1);
INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (3, 1);
INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (4, 1);
INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (5, 1);
INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (6, 1);

INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (7, 1);

INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (8, 1);

INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (9, 7);

INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (10, 3);
INSERT INTO livro_categoria (cd_livro, cd_categoria) VALUES (10, 7);
-- x --

INSERT INTO localizacao (cd_localizacao, nm_localizacao) VALUES (1, 'E02C01P01 - Estante 02 - Coluna 01 - Prateleira 01');


INSERT INTO exemplar (cd_exemplar, cd_livro, ic_fixo, cd_localizacao) VALUES (1, 1, 1, 1);
INSERT INTO exemplar (cd_exemplar, cd_livro, ic_fixo, cd_localizacao) VALUES (2, 1, 0, 1);

INSERT INTO tipo_usuario (cd_tipo_usuario, nm_tipo_usuario) VALUES (1, 'Admin');
INSERT INTO tipo_usuario (cd_tipo_usuario, nm_tipo_usuario) VALUES (2, 'Operador');
INSERT INTO tipo_usuario (cd_tipo_usuario, nm_tipo_usuario) VALUES (3, 'Cliente');

INSERT INTO usuario (nm_login, nm_usuario, nm_senha, ic_bloqueado, dt_bloqueio, cd_tipo_usuario) VALUES ('admin', 'Administrador', '123', 0, NULL, 1);
INSERT INTO usuario (nm_login, nm_usuario, nm_senha, ic_bloqueado, dt_bloqueio, cd_tipo_usuario) VALUES ('operador', 'Operador', '123', 0, NULL, 2);
INSERT INTO usuario (nm_login, nm_usuario, nm_senha, ic_bloqueado, dt_bloqueio, cd_tipo_usuario) VALUES ('12577', 'Frederico Arco e Flexa Machado Justo', '123', 0, NULL, 3);

INSERT INTO tipo_emprestimo (cd_tipo_emprestimo, nm_tipo_emprestimo) VALUES (1, 'Consulta');
INSERT INTO tipo_emprestimo (cd_tipo_emprestimo, nm_tipo_emprestimo) VALUES (2, 'Empréstimo');

INSERT INTO tipo_ocorrencia (cd_tipo_ocorrencia, nm_tipo_ocorrencia) VALUES (1, 'Devolução com leve dano');
INSERT INTO tipo_ocorrencia (cd_tipo_ocorrencia, nm_tipo_ocorrencia) VALUES (2, 'Devolução com grave dano');



/* scrr */

