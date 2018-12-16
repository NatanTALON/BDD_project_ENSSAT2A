use mediatheque;

call addAbonne("Dion", "Céline", "Chez toi, Lannion");
call addAbonne("Sanschaise", "Pédro", "Chez lui, Tabouret");
insert into Abonne (nomAbonne, prenomAbonne, adresseAbonne, dateAdhesion, dateRenouvellement) values ("Cordeau", "Rémy", "addresse", "2010-01-01", "2010-01-01");
insert into Abonne (nomAbonne, prenomAbonne, adresseAbonne, dateAdhesion, dateRenouvellement) values ("Zialou", "Bob", "addresse", "2016-02-29", "2010-01-01");
select * from Abonne;

call addTypeContenu("Livre", 15, "phy");
call addTypeContenu("Blu-ray", 7, "phy");
#call addTypeContenu("CD", 7, "hop");		#déclenche un trigger
call addTypeContenu("eBook", 15, "num");
#select * from TypeContenu;

call addContenu(1, "Eragon", "Fantasy", "Livre");
call addContenu(2, "Resident Evil", "Horreur", "Blu-ray");
call addContenu(3, "Eragon", "Fantasy", "eBook");
call addContenu(4, "Titanic", "Drame", "Blu-ray");
call addContenu(5, "Harry Potter", "Fantasy", "eBook");
#select * from Contenu;

call addArtiste("Dion", "Céline");
call addArtiste("Di Caprio", "Leonardo");
#select * from Artiste;

call addEtablissement("tous", "bidon", "0000000000");
call addEtablissement("ENSSAT", "6 rue Kerampont, Lannion", "0296469000");
call addEtablissement("Orange Labs", "2 avenue Pierre Marzin, Lannion", "0964447130");
#select * from Etablissement;

call addContenuNumerique(1, 3, "Mobipocket");
call addContenuNumerique(2, 5, "Mobipocket");
call addContenuNumerique(3, 5, "Mobipocket");
#call addContenuNumerique(2, 1, "Mobipocket");	#déclenche un trigger
#call addContenuNumerique(3, 4, "Mobipocket");	#déclenche un trigger
#select * from ContenuNumerique;

call addContenuPhysique(1, 1, "Bayard", "ENSSAT");
call addContenuPhysique(2, 2, "Dolby", "Orange Labs");
call addContenuPhysique(3, 2, "Dolby", "ENSSAT");
call addContenuPhysique(4, 4, "Dolby", "Orange Labs");
#call addContenuPhysique(3, 3, "Bayard", "ENSSAT");	#déclenche un trigger
#select * from ContenuPhysique;

call addPretNumerique(1, 1);
#select * from HistoriqueNumerique;

call addPretPhysique(1, 1);
#select * from HistoriquePhysique;

call addDemande(2, 3, "ENSSAT");
call addDemande(2, 1, "tous");
call addDemande(2, 4, "tous");
#call addDemande(2, 5, "tous"); 	#déclenche un trigger
#call addDemande(3, 3, "ENSSAT");	#déclenche un trigger
#call addDemande(2, 2, "Orange Labs");	#ne marche pas car le contenu 2 n'est pas présent à Orange Labs
#call addDemande(1, 7, "ENSSAT");	#ne marche pas car le contenu 7 n'est pas présent dans la table
#select * from Demande;

call addContenuHasArtiste(4, 2, "acteur");
call addContenuHasArtiste(4, 1, "chanteur");
#select * from Contenu_has_Artiste;
