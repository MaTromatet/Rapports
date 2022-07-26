





\copy T_INDIVIDU (NomIndividu,PrenomIndividu,AdresseIndividu,NumeroTelephoneIndividu,AdresseMailIndividu,IdVille) FROM 'INDIVIDU.csv' WITH CSV HEADER DELIMITER ',' QUOTE '"'


\copy T_INDIVIDU (NumeroMatriculeEmploye,TrigrammeSalarie,SalaireEmploye,IdEmployeChef,IdEquipe,idFonction,IdIndividu,IdDivision) FROM 'EMPLOYE.csv' WITH CSV HEADER DELIMITER ',' QUOTE '"'



INSERT INTO T_EMPLOYE(NomIndividu,PrenomIndividu,AdresseIndividu,NumeroTelephoneIndividu,AdresseMailIndividu,IdVille) VALUES
('White','Lila','920-6296 Sed St.','09 23 11 28 42','odio@facilisiseget.co.uk',26),
('Slater','Maxwell','920-6296 Sed St.','06 44 70 43 52','sociis.natoque@elitafeugiat.ca',58),
('Rodgers','Justina','Ap #824-5783 Suspendisse Ave','08 70 21 71 10','diam.luctus.lobortis@sedeu.org',67);