-- Criação do banco de dados com comando para utilizá-lo.
USE master;
CREATE DATABASE Prova_Anuska;
USE Prova_Anuska;


------------------------------------ 1) Aspectos estruturais
------------------------------------ 1.1) Comandos para definição das estruturas do modelo (tabelas, campos e restrições de PK e FK).

--CREATE TABLE Genero
--(
--             cd_genero INT NOT NULL
--           , ds_genero VARCHAR(30) NOT NULL
--           , CONSTRAINT Genero_cd_genero_pk PRIMARY KEY(cd_genero)
--);

--CREATE TABLE Censura
--(
--             cd_censura INT NOT NULL
--           , ds_censura VARCHAR(30) NOT NULL
--           , CONSTRAINT Censura_cd_censura_pk PRIMARY KEY(cd_censura)
--);

--CREATE TABLE Ator
--(
--             cd_ator INT NOT NULL
--           , nm_ator VARCHAR(50) NOT NULL
--           , CONSTRAINT Ator_cd_ator_pk PRIMARY KEY(cd_ator)
--);

--CREATE TABLE Filme
--(
--             cd_filme      INT NOT NULL
--           , cd_censura    INT NOT NULL
--           , cd_genero     INT NOT NULL
--           , nm_filme      VARCHAR(50) NOT NULL
--           , ds_sinopse    VARCHAR(250) NOT NULL
--           , nr_duracao    VARCHAR(20) NOT NULL
--           , dt_lancamento DATE NOT NULL
--           , fl_dublado    CHAR(1) NOT NULL
--           , CONSTRAINT Filme_cd_filme_pk PRIMARY KEY(cd_filme)
--           , CONSTRAINT Filme_cd_censura_fk FOREIGN KEY(cd_censura) REFERENCES Censura(cd_censura)
--           , CONSTRAINT Filme_cd_genero_fk FOREIGN KEY(cd_genero) REFERENCES Genero(cd_genero)
--);

--CREATE TABLE Filme_Ator
--(
--             cd_filme INT NOT NULL
--           , cd_ator  INT NOT NULL
--           , CONSTRAINT Filme_Ator_cd_filme_cd_ator_pk PRIMARY KEY(cd_filme, cd_ator)
--         , CONSTRAINT Filme_Ator_cd_filme_fk FOREIGN KEY(cd_filme) REFERENCES Filme(cd_filme)
--          , CONSTRAINT Filme_Ator_cd_ator_fk FOREIGN KEY(cd_ator) REFERENCES Ator(cd_ator)
--);


---------------------------------------------------------------- 2)

---- a)
ALTER TABLE Ator
ADD dt_nascimento DATE NOT NULL;

-- b)
ALTER TABLE Censura
ADD CONSTRAINT Censura_ds_censura_uk UNIQUE(ds_censura);

---- c)
ALTER TABLE Filme ALTER COLUMN nm_filme VARCHAR(100) NOT NULL;
 
--------------------------------------------------------------- 3) inserção de dados

INSERT INTO Genero (cd_genero, ds_genero)
  VALUES 
	(1, 'Drama'),
	(2, 'Ação'),
	(3, 'Comédia'),
	(4, 'Infantil'),
	(5, 'Animação'),
	(6, 'Aventura'),
	(7, 'Dança'),
	(8, 'Documentário'),
	(9, 'Faroeste'),
	(10, 'Espionagem');

INSERT INTO Censura (cd_censura, ds_censura)
  VALUES 
	(1, 'Livre'),
	(2, '10 anos'),
	(3, '12 anos'),
	(4, '14 anos'),
	(5, '16 anos'),
	(6, '18 anos'),
	(7, 'Adulto');

INSERT INTO Ator (cd_ator, nm_ator, dt_nascimento)
  VALUES 
	(1, 'Angelina Jolie', '2021-01-01'),
	(2, 'Will Smith', '2021-01-01'),
	(3, 'Adam Sandler', '2021-01-01'),
	(4, 'Julia Roberts', '2021-01-01'),
	(5, 'Nicolas Cage', '2021-01-01'),
	(6, 'John Travolta', '2021-01-01'),
	(7, 'Cameron Diaz', '2021-01-01'),
	(8, 'Nicole Kidman', '2021-01-01'),
	(9, 'Jim Carrey', '2021-01-01'),
	(10, 'Johnny Depp', '2021-01-01');

INSERT INTO Filme (cd_filme, cd_censura, cd_genero, nm_filme, ds_sinopse, nr_duracao, dt_lancamento, fl_dublado)
  VALUES 
	(1, 1, 4, 'Os Caça-Fantasmas', 'Sinopse do filme Os Caça-Fantasmas', '02:00', '2008-05-16', 'S'),
	(2, 2, 2, 'Senhor dos Anéis', 'Sinopse do filme Senhor dos Anéis', '01:45', '2020-08-23', 'N'),
	(3, 1, 4, 'Rocky, um Lutador', 'Sinopse do filme Rocky, um Lutador', '02:05', '2012-04-25', 'S'),
	(4, 4, 2, 'Avatar', 'Sinopse do filme Avatar', '02:30', '2019-01-02', 'N'),
	(5, 1, 4, 'O Rei Leão', 'Sinopse do filme O Rei Leão', '01:25', '1994-08-07', 'S'),
	(6, 7, 1, 'Batman', 'Sinopse do filme Batman', '01:47', '2020-06-08', 'N'),
	(7, 1, 4, 'Jurassic Park', 'Sinopse do filme Jurassic Park', '01:59', '2005-07-29', 'S'),
	(8, 1, 8, 'Titanic', 'Sinopse do filme Titanic', '02:04', '1985-01-08', 'N'),
	(9, 7, 9, 'Matrix', 'Sinopse do filme Matrix', '02:34', '1997-03-25', 'S'),
	(10, 3, 10, 'Clube da Luta', 'Sinopse do filme Clube da Luta', '01:48', '2000-09-12', 'N');

INSERT INTO Filme_Ator (cd_filme, cd_ator)
  VALUES 
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 6),
	(7, 7),
	(8, 8),
	(9, 9),
	(10, 10),
	(1, 2),
	(1, 3),
	(1, 4),
	(1, 5),
	(2, 3),
	(2, 4),
	(2, 5),
	(3, 4),
	(4, 6),
	(7, 8),
	(9, 10);


---------------------------------------------------------- 4) 
SELECT F.nm_filme
FROM Filme AS F
     INNER JOIN Censura AS C
        ON F.cd_censura = C.cd_censura
     INNER JOIN Genero AS G
        ON F.cd_genero = G.cd_genero
WHERE C.ds_censura = 'Adulto'
      AND F.fl_dublado = 'N'
      AND G.ds_genero = 'Drama'
ORDER BY F.dt_lancamento DESC;


---------------------------------------------------------- 5)
SELECT G.ds_genero
     , COUNT(F.cd_genero) AS qtd_filmes
FROM Genero AS G
     INNER JOIN Filme AS F
        ON G.cd_genero = F.cd_genero
GROUP BY G.ds_genero;


---------------------------------------------------------- 6)
SELECT F.nm_filme
     , A.nm_ator
FROM Filme_Ator AS FA
     INNER JOIN Filme AS F
        ON FA.cd_filme = F.cd_filme
     INNER JOIN Ator AS A
        ON FA.cd_ator = A.cd_ator
WHERE YEAR(dt_lancamento) = 2020;


----------------------------------------------------------- 7)
DECLARE @MaiorQuantidade AS integer = 0;
SET @MaiorQuantidade = (SELECT TOP 1 COUNT(g.cd_genero) as 'Qtde' FROM Filme f
INNER JOIN Genero g ON f.cd_genero = g.cd_genero
GROUP BY g.cd_genero, g.ds_genero
ORDER BY 'Qtde' DESC);

SELECT g.ds_genero as 'Gênero' FROM Filme f
INNER JOIN Genero g ON f.cd_genero = g.cd_genero
GROUP BY g.cd_genero, g.ds_genero
HAVING COUNT(g.cd_genero) = @MaiorQuantidade