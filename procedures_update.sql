DELIMITER $$

create procedure renouvelerAbonnement (in numeroAbonneIn int)
begin
	if DATE_FORMAT(CURRENT_DATE(), '%d%m') = '2902' then
		update Abonne set dateRenouvellement = SUBDATE(CURRENT_DATE(), 1) where numeroAbonne = numeroAbonneIn;
	else
		update Abonne set dateRenouvellement = CURRENT_DATE() where numeroAbonne = numeroAbonneIn;
    end if;
end$$

create procedure updateDemandes()
begin
	delete from Demande where DATEDIFF(CURRENT_DATE(), IFNULL(dateDisponibilite, '0000-01-01')) > 7;
end$$

create function retourPretNumerique (numeroAbonneIn int, numeroLicenceIn int) returns int
begin
	update HistoriqueNumerique set rendu = 1 where numeroAbonneIn = Abonne_numeroAbonne and ContenuNumerique_numeroLicence = numeroLicenceIn;
    select Contenu_numeroCatalogue into @numCatalogue from ContenuNumerique where numeroLicence = numeroLicenceIn;
    update Demande set dateDisponibilite = CURRENT_DATE() where Contenu_numeroCatalogue = @numCatalogue and dateDisponibilite is null;
    select dateRetourNumerique into @dateRetour from HistoriqueNumerique where numeroAbonneIn = Abonne_numeroAbonne and ContenuNumerique_numeroLicence = numeroLicenceIn;
    if DATEDIFF(CURRENT_DATE(), @dateRetour) > 0 then
		return 1;
	else
		return 0;
	end if;
end$$

create function retourPretPhysique (numeroAbonneIn int, codeBarreIn int) returns int
begin
	update HistoriquePhysique set rendu = 1 where numeroAbonneIn = Abonne_numeroAbonne and ContenuPhysique_codeBarre = codeBarreIn;
    select Contenu_numeroCatalogue into @numCatalogue from ContenuPhysique where codeBarre = codeBarreIn;
    update Demande set dateDisponibilite = CURRENT_DATE() where Contenu_numeroCatalogue = @numCatalogue and dateDisponibilite is null;
    select dateRetourPhysique into @dateRetour from HistoriquePhysique where numeroAbonneIn = Abonne_numeroAbonne and ContenuPhysique_codeBarre = codeBarreIn;
    if DATEDIFF(CURRENT_DATE(), @dateRetour) > 0 then
		return 1;
	else
		return 0;
	end if;
end$$

create procedure pret (in numeroAbonneIn int, in codeBarreOuLicence int, in phyNum varchar(3))
begin
	if phyNum = "phy" then
		call addPretPhysique(numeroAbonneIn, codeBarreOuLicence);
        select Contenu_numeroCatalogue into @numCatalogue from ContenuPhysique where codeBarre = codeBarreOuLicence;
        call delDemande(@numCatalogue, numeroAbonneIn);
        select Etablissement_nomEtablissement into @etab from ContenuPhysique where codeBarre = codeBarreOuLicence;
	end if;
    if phyNum = "num" then
		call addPretNumerique(numeroAbonneIn, codeBarreOuLicence);
        select Contenu_numeroCatalogue into @numCatalogue from ContenuNumerique where numeroLicence = codeBarreOuLicence;
        call delDemande(@numCatalogue, numeroAbonneIn);
        set @etab = 'tous';
    end if;
    if contenuEstDisponible(@numCatalogue, @etab) > 0 then
		update Demande set dateDisponibilite = null where Contenu_numeroCatalogue = @numCatalogue and Etablissement_nomEtablissement = @etab;
    end if;
end$$

create procedure renouvellementPretPhysique (in numeroAbonneIn int, in codeBarreIn int)
begin
	select Contenu_numeroCatalogue into @numCat from ContenuPhysique where codeBarre = codeBarreIn;
	select count(*) into @nbdemande from Demande
		where Abonne_numeroAbonne = numeroAbonneIn and Contenu_numeroCatalogue = @numCat and (Etablissement_nomEtablissement = (select Etablissement_nomEtablissement from ContenuPhysique where codeBarre = codeBarreIn) or Etablissement_nomEtablissement = 'tous');
    if @nbdemande > 0 then
		signal sqlstate '45000' set message_text = 'Vous ne pouvez pas renouveler votre prêt car un autre abonné demande ce contenu';
	else
		select tempsEmprunt into @tempsEmprunt from TypeContenu TC, Contenu C, ContenuPhysique CP where C.numeroCatalogue = CP.Contenu_numeroCatalogue and C.TypeContenu_typeContenu = TC.typeContenu and codeBarre = codeBarreIn;
		update HistoriquePhysique set dateRetourPhysique = ADDDATE(dateRetourPhysique, @tempsEmprunt) where Abonne_numeroAbonne = numeroAbonneIn and ContenuPhysique_codeBarre = codeBarreIn;
    end if;
end$$

create procedure renouvellementPretNumerique (in numeroAbonneIn int, in numeroLicenceIn int)
begin
	select Contenu_numeroCatalogue into @numCat from ContenuNumerique where numeroLicence = numeroLicenceIn;
	select count(*) into @nbdemande from Demande
		where Abonne_numeroAbonne = numeroAbonneIn and Contenu_numeroCatalogue = @numCat;
    if @nbdemande > 0 then
		signal sqlstate '45000' set message_text = 'Vous ne pouvez pas renouveler votre prêt car un autre abonné demande ce contenu';
	else
		select tempsEmprunt into @tempsEmprunt from TypeContenu TC, Contenu C, ContenuNumerique CN where C.numeroCatalogue = CN.Contenu_numeroCatalogue and C.TypeContenu_typeContenu = TC.typeContenu and numeroLicence = numeroLicenceIn;
		update HistoriqueNumerique set dateRetourNumerique = ADDDATE(dateRetourNumerique, @tempsEmprunt) where Abonne_numeroAbonne = numeroAbonneIn and ContenuNumerique_numeroLicence = numeroLicenceIn;
    end if;
end$$

