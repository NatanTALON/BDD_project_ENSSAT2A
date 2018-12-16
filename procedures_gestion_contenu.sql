DELIMITER $$

create procedure listePretsAbonne (in numeroAbonneIn int)
begin
	select ContenuNumerique_Contenu_numeroCatalogue as numero_catalogue, ContenuNumerique_numeroLicence as licence_ou_code_barre from HistoriqueNumerique where Abonne_numeroAbonne = numeroAbonneIn
    union
    select ContenuPhysique_Contenu_numeroCatalogue as numero_catalogue, ContenuPhysique_codeBarre as licence_ou_code_barre from HistoriquePhysique where Abonne_numeroAbonne = numeroAbonneIn;
end$$

create procedure listeEmprunteursContenu (in numeroCatalogueIn int)
begin
	select nomAbonne, prenomAbonne from Abonne, HistoriqueNumerique HN, HistoriquePhysique HP
    where (HN.Abonne_numeroAbonne = numeroAbonne and ContenuNumerique_Contenu_numeroCatalogue = numeroCatalogueIn and HN.rendu = 0) or (HP.Abonne_numeroAbonne = numeroAbonne and ContenuPhysique_Contenu_numeroCatalogue = numeroCatalogueIn and HP.rendu = 0);
end$$

create function contenuEstDisponible (numeroCatalogueIn int, nomEtablissementIn varchar(45)) returns int
begin
	select phyNum into @phyNum from Contenu, TypeContenu where numeroCatalogue = numeroCatalogueIn and TypeContenu_typeContenu = typeContenu;
    if @phyNum = 'phy' then
		if nomEtablissementIn = 'tous' then
			select count(codeBarre) into @nbContenu from ContenuPhysique where Contenu_numeroCatalogue = numeroCatalogueIn;
			select count(Abonne_numeroAbonne) into @nbDemande from Demande where Contenu_numeroCatalogue = numeroCatalogueIn;
		else
			select count(codeBarre) into @nbContenu from ContenuPhysique where Contenu_numeroCatalogue = numeroCatalogueIn and Etablissement_nomEtablissement = nomEtablissementIn;
			select count(Abonne_numeroAbonne) into @nbDemande from Demande where Contenu_numeroCatalogue = numeroCatalogueIn and Etablissement_nomEtablissement = nomEtablissementIn;
		end if;
        select count(ContenuPhysique_codeBarre) into @nbEmprunt from HistoriquePhysique where rendu = 0 and ContenuPhysique_Contenu_numeroCatalogue = numeroCatalogueIn;
    else
		select count(numeroLicence) into @nbContenu from ContenuNumerique where Contenu_numeroCatalogue = numeroCatalogueIn;
        select count(Abonne_numeroAbonne) into @nbDemande from Demande where Contenu_numeroCatalogue = numeroCatalogueIn;
        select count(ContenuNumerique_numeroLicence) into @nbEmprunt from HistoriqueNumerique where rendu = 0 and ContenuNumerique_Contenu_numeroCatalogue = numeroCatalogueIn;
    end if;
    
    return @nbContenu - @nbDemande - @nbEmprunt;
end$$

create function abonneEstDemandeur (numeroAbonneIn int, numeroCatalogueIn int) returns int
begin
	select count(*) into @estDemandeur from Demande where Abonne_numeroAbonne = numeroAbonneIn and Contenu_numeroCatalogue = numeroCatalogueIn;
    return @estDemandeur;
end$$

create procedure echeancier ()
begin
	select Abonne_numeroAbonne as abonne, ContenuPhysique_codeBarre from HistoriquePhysique where rendu = 0 and DATEDIFF(CURRENT_DATE(), dateRetourPhysique) > 0
    union
    select Abonne_numeroAbonne as abonne, ContenuNumerique_numeroLicence from HistoriqueNumerique where rendu = 0 and DATEDIFF(CURRENT_DATE(), dateRetourNumerique) > 0;
end$$

create function nbEmprunteurActuel () returns int
begin
	select count(Abonne_numeroAbonne) into @nbPhysique from HistoriquePhysique where rendu = 0;
    select count(Abonne_numeroAbonne) into @nbNumerique from HistoriqueNumerique where rendu = 0;
    return @nbPhysique + @nbNumerique;
end$$

create function nbEmpruntActuel () returns int
begin
	select count(ContenuPhysique_codeBarre) into @nbPhysique from HistoriquePhysique where rendu = 0;
    select count(ContenuNumerique_numeroLicence) into @nbNumerique from HistoriqueNumerique where rendu = 0;
    return @nbPhysique + @nbNumerique;
end$$

