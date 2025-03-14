SELECT titolo AS 'titolo libro'
FROM Testo JOIN Pubblica ON Testo.id=id_testo
    JOIN Editore ON Editore.id=id_edit
WHERE ragione_sociale=@nome_editore AND prezzo<=10.0