DELIMITER $$

create procedure addAbonne (in nom varchar(45), in prenom varchar(45), in addresse varchar(100))
begin
	insert into Abonne (nomAbonne, prenomAbonne, adresseAbonne, dateAdhesion, dateRenouvellement) values (nom, prenom, addresse, CURRENT_DATE(), CURRENT_DATE());
end$$

create procedure addPretNumerique (in numeroAbonneIn int, in numeroLicenceIn int)
begin
	select Contenu_numeroCatalogue into @numeroCatalogue from ContenuNumerique where ContenuNumerique.numeroLicence = numeroLicenceIn;
    select tempsEmprunt into @tempsEmprunt from TypeContenu, Contenu where Contenu.numeroCatalogue = @numeroCatalogue and Contenu.TypeContenu_typeContenu = TypeContenu.typeContenu;
    insert into HistoriqueNumerique values (numeroAbonneIn, numeroLicenceIn, @numeroCatalogue, CURRENT_DATE(), CURRENT_DATE()+@tempsEmprunt, 0);
end$$

create procedure addPretPhysique (in numeroAbonneIn int, in codeBarreIn int)
begin
	select Contenu_numeroCatalogue into @numeroCatalogue from ContenuPhysique where ContenuPhysique.codeBarre = codeBarreIn;
    select tempsEmprunt into @tempsEmprunt from TypeContenu, Contenu where Contenu.numeroCatalogue = @numeroCatalogue and Contenu.TypeContenu_typeContenu = TypeContenu.typeContenu;
    insert into HistoriquePhysique values (numeroAbonneIn, codeBarreIn, @numeroCatalogue, CURRENT_DATE(), CURRENT_DATE()+@tempsEmprunt, 0);
end$$

create procedure addContenuNumerique (in numeroLicenceIn int, in numeroCatalogueIn int, in editeurIn varchar(45))
begin
    insert into ContenuNumerique values (numeroLicenceIn, numeroCatalogueIn, editeurIn);
end$$

create procedure addContenuPhysique (in codeBarreIn int, in numeroCatalogueIn int, in editeurIn varchar(45), in etablissementIn varchar(45))
begin
    insert into ContenuPhysique values (codeBarreIn, numeroCatalogueIn, etablissementIn, editeurIn);
end$$

create procedure addEtablissement (in nomEtablissement varchar(45), in addresseEtablissement varchar(100), in numeroTelEtablissement varchar(10))
begin
	insert into Etablissement values (nomEtablissement, addresseEtablissement, numeroTelEtablissement);
end$$

create procedure addDemande (in numeroAbonne int, in numeroCatalogue int, in etablissementDemande varchar(45))
begin
	insert into Demande values (numeroAbonne, numeroCatalogue, etablissementDemande, CURRENT_DATE(), null);
end$$

create procedure addContenu (in numeroCatalogue int, in titre varchar(100), in genre varchar(45), in typeContenu varchar(45))
begin
	insert into Contenu values (numeroCatalogue, titre, genre, typeContenu);
end$$

create procedure addTypeContenu (in typeContenu varchar(45), in tempsEmprunt int, in phyNumIn varchar(3))
begin
	insert into TypeContenu values (typeContenu, tempsEmprunt, phyNumIn);
end$$

create procedure addArtiste (in nomArtiste varchar(45), in prenomArtiste varchar(45))
begin
    insert into Artiste (nomArtiste, prenomArtiste) values (nomArtiste, prenomArtiste);
end$$

create procedure addContenuHasArtiste (in numeroCatalogue int, in artisteId int, in roleArtiste varchar(45))
begin
	insert into Contenu_has_Artiste values (numeroCatalogue, artisteId, roleArtiste);
end$$

