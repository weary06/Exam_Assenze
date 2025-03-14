CREATE DATABASE dbAssenzeIstituto

CREATE TABLE TipiClasse(
    IDtipologia INT IDENTITY(1,1) PRIMARY KEY,
-- CHECK e NOT NULL esempi di vincoli di dominio
    Tipologia VARCHAR(50) CHECK (Tipologia IN '‘'liceo’,’tecnico’,’professionale’),
    Indirizzo VARCHAR(50) NOT NULL,
    Opzione VARCHAR(50)
)

CREATE TABLE Classi(
    IDclasse VARCHAR(10) PRIMARY KEY,
    TipoClasse_fk INT,
-- FOREIGN KEY ... REFERENCES ... Vincolo di integrità referenziale
    FOREIGN KEY (TipoClasse_fk) REFERENCES TipiClasse(IDtipologia)
    ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Studenti(
    IDstudente INT IDENTITY(1,1) PRIMARY KEY,
    Cognome VARCHAR(50) NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    DataNascita DATE NOT NULL,
    Username VARCHAR(20) NOT NULL,
    [Password] VARCHAR(16) NOT NULL,
    Classe_fk VARCHAR(10),
-- FOREIGN KEY ... REFERENCES ... Vincolo di integrità referenziale
    FOREIGN KEY (Classe_fk) REFERENCES Classi(IDclasse)
    ON DELETE CASCADE ON UPDATE CASCADE
)

12

CREATE TABLE Parentele
(
Figlio_fk INT,
Genitore_fk INT,
PRIMARY KEY(Figlio_fk, Genitore_fk),
-- FOREIGN KEY ... REFERENCES ... Vincolo di integrità referenziale
FOREIGN KEY (Figlio_fk) REFERENCES Studenti(IDstudente),
FOREIGN KEY (Genitore_fk) REFERENCES Studenti(IDstudente),
)



SELECT Cognome, Nome, Materie.Nome, COUNT(*) AS 'Totale ore' FROM Docenti JOIN Presenze ON IDdocente=Docente_fk JOIN Materie ON IDmateria=Materia_fk GROUP BY Cognome, Nome, Materie.Nome ORDER BY Cognome, Nome, Materie.Nome

CREATE VIEW ContaOre(Studente_fk, Classe_fk, TotaleOre) AS SELECT Studente_fk, Classe_fk, SUM(Ore) AS 'TotaleOre' FROM Studenti JOIN Assenze ON IDstudente=Studente_fk GROUP BY Studente_fk, Classe_fk

SELECT Classe_fk, AVG(*) AS 'Media ore assenza per classe' FROM ContaOre GROUP BY Classe_fk