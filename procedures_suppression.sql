DELIMITER $$

create procedure delAbonne (in abonneId int)
begin
	delete from Abonne where numeroAbonne = abonneId;
end$$

create procedure delPretNumerique (in numeroAbonneIn int, in numeroLicenceIn int)
begin
	delete from HistoriqueNumerique where Abonne_numeroAbonne = numeroAbonneIn and ContenuNumerique_numeroLicence = numeroLicenceIn;
end$$

create procedure delPretPhysique (in numeroAbonneIn int, in codeBarreIn int, in nomEtablissementIn varchar(45))
begin
	select Etablissement_nomEtablissement into @ne from ContenuPhysique CP, HistoriquePhysique HP
		where HP.Abonne_numeroAbonne = numeroAbonneIn and HP.ContenuPhysique_codeBarre = codeBarreIn and CP.codeBarre = codeBarreIn;
	if @ne = nomEtablissementIn then
		delete from HistoriquePhysique where Abonne_numeroAbonne = numeroAbonneIn and ContenuPhysique_codeBarre = codeBarreIn;
	else
		set @message = concat('Veuillez rendre ce contenu à ', @ne);
		signal sqlstate '45000' set message_text = @message;
	end if;
end$$

create procedure delContenuNumerique (in numeroLicenceIn int)
begin
	delete from ContenuNumerique where numeroLicence = numeroLicenceIn;
end$$

create procedure delContenuPhysique (in codeBarreIn int)
begin
	delete from ContenuPhysique where codeBarre = codeBarreIn;
end$$

create procedure delEtablissement (in nomEtablissementIn varchar(45))
begin
	delete from Etablissement where nomEtablissement = nomEtablissementIn;
end$$

create procedure delDemande (in numeroAbonne int, in numeroCatalogue int)
begin
	delete from Demande where Abonne_numeroAbonne = numeroAbonne and Contenu_numeroCatalogue;
end$$

create procedure delContenu (in numeroCatalogueIn int)
begin
	delete from Contenu where numeroCtalogue = numeroCatalogueIn;
end$$

create procedure delTypeContenu (in typeContenuIn varchar(45))
begin
	delete from TypeContenu where typeContenu = typeContenuIn;
end$$

create procedure delArtiste (in artisteId int)
begin
    delete from Artiste where idArtiste = artisteId;
end$$

create procedure delContenuHasArtiste (in numeroCatalogue int, in artisteId int)
begin
	delete from Contenu_has_Artiste where numeroCatalogue = Contenu_numeroCatalogue and artisteId = Artiste_idArtiste;
end$$

