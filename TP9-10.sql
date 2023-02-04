CREATE DATABASE EXERCICE910;
DROP DATABASE EXERCICE910
CREATE TABLE utilisateur(
id INT PRIMARY KEY  NOT NULL , 
 nom VARCHAR(22) NOT NULL,
 prenom VARCHAR (22) NOT NULL
);

-- Insertion des donnees dans la table "utilisateur"
INSERT INTO utilisateur(id,nom,prenom) 
VALUES (1,'Daniel','GOGO');
INSERT INTO utilisateur(id,nom,prenom) 
VALUES (2,'Kossi','Dani');



-- la liste des donnees de la table utilisateur
SELECT * FROM utilisateur;

-- creation de la table de recuperation

CREATE TABLE recuperation_utilisateur(
id INT PRIMARY KEY  NOT NULL , 
 nom VARCHAR(22) NOT NULL,
 prenom VARCHAR (22) NOT NULL
);

-- *****************************************
--					PARTIE A
-- *****************************************


-- Creation des trigger's

CREATE TRIGGER tr_recuperation_utilisateur_supprimer
ON utilisateur
AFTER UPDATE,DELETE 
AS
BEGIN
	-- SET NOCOUNT ON;
	DECLARE 
		@id INT,
		@nom VARCHAR(22),
		@prenom VARCHAR(22);

	SELECT 
		@id = deleted.id,
		@nom = deleted.nom,
		@prenom = deleted.prenom
	FROM deleted;

	INSERT INTO recuperation_utilisateur(id,nom,prenom) 
	VALUES (@id,@nom,@prenom);

	END;

-- Suppression d'un Utilisateur

DELETE FROM utilisateur WHERE nom= 'Kossi';


-- Recuperation des donnees supprimer

SELECT * FROM recuperation_utilisateur;

-- Verification de l'existance des donnees dans la table utilisateur

SELECT * FROM utilisateur;

-- Mis a jour d'un utilisateur

UPDATE utilisateur
SET prenom = 'Kossi Daniel' 
WHERE prenom = 'GOGO';


-- *****************************************
--					PARTIE B
-- *****************************************

CREATE TABLE facture(
id INT PRIMARY KEY  NOT NULL , 
 numero INT NOT NULL,
 datefacture date NOT NULL,
 totalfacture INT  NOT NULL
);


CREATE TABLE details_facture(
id INT PRIMARY KEY  NOT NULL , 
);

ALTER TABLE details_facture 
	ADD CONSTRAINT fk_facture
	FOREIGN KEY (id)
	REFERENCES facture (id);

-- Insertion des donnees 

INSERT INTO facture(id,numero,datefacture,totalfacture)
	VALUES(1,232,'2020-12-12',233);

INSERT INTO details_facture(id) VALUES (1)
SELECT * FROM details_facture;

-- objet de recuperation 


CREATE PROCEDURE pro_details_facture (@id INT)
AS 
BEGIN 
	SELECT 
		f.numero as 'numero facture',
		f.datefacture as 'date de la facture' , 
		f.totalfacture as ' total de la facture'
	FROM facture f 
	INNER JOIN details_facture df
	ON df.id = f.id 
	WHERE f.id = @id
END

	EXEC pro_details_facture 1;