----------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------- CREATION DE LA BASE DE DONNEES -----------------------------------------------------------------------
-------------------------------------------------------- InfoPlus -----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------

-- Création des Tables InfoPlus----------------------------------------------------------------------------------------------------------------------
CREATE TABLE T_INDIVIDU(
   IdIndividu SERIAL,
   NomIndividu VARCHAR(50),
   PrenomIndividu VARCHAR(50),
   AdresseIndividu VARCHAR(150),
   NumeroTelephoneIndividu VARCHAR(50),
   AdresseMailIndividu VARCHAR(100),
   IdVille INTEGER
);

CREATE TABLE T_EMPLOYE(
   IdEmploye SERIAL,
   NumeroMatriculeEmploye VARCHAR(50),
   TrigrammeSalarie VARCHAR(3),
   SalaireEmploye MONEY,
   IdEmployeChef INTEGER,
   IdEquipe INTEGER,
   idFonction INTEGER,
   IdIndividu INTEGER,
   IdDivision INTEGER
);

-- Création des clés primaires -----------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE T_INDIVIDU ADD PRIMARY KEY (IdIndividu);
ALTER TABLE T_EMPLOYE ADD PRIMARY KEY (IdEmploye);

-------------- Création des contraintes ------------------------------------------------------------------------------------------------------------------------

-- Création des clés étrangères --
ALTER TABLE T_INDIVIDU 
ADD CONSTRAINT fk_individu_ville FOREIGN KEY (IdVille) REFERENCES T_VILLE(IdVille)
ON DELETE CASCADE;

ALTER TABLE T_EMPLOYE 
ADD CONSTRAINT fk_employe_employe FOREIGN KEY (IdEmployeChef) REFERENCES T_EMPLOYE(IdEmploye)
ON DELETE CASCADE,
ADD CONSTRAINT fk_employe_equipe FOREIGN KEY (IdEquipe) REFERENCES T_EQUIPE(IdEquipe)
ON DELETE CASCADE,
ADD CONSTRAINT fk_employe_fonction FOREIGN KEY (idFonction) REFERENCES T_FONCTION(idFonction)
ON DELETE CASCADE,
ADD CONSTRAINT fk_employe_individu FOREIGN KEY (IdIndividu) REFERENCES T_INDIVIDU(IdIndividu)
ON DELETE CASCADE,
ADD CONSTRAINT fk_employe_division FOREIGN KEY (IdDivision) REFERENCES T_DIVISION(IdDivision)
ON DELETE CASCADE;

-- Champ non null --
ALTER TABLE T_INDIVIDU
ALTER COLUMN NomIndividu SET NOT NULL;

ALTER TABLE T_EMPLOYE
ALTER COLUMN IdIndividu SET NOT NULL;

-- Champ unique --
ALTER TABLE T_EMPLOYE ADD UNIQUE (NumeroMatriculeEmploye);
ALTER TABLE T_EMPLOYE ADD UNIQUE (TrigrammeSalarie);



 