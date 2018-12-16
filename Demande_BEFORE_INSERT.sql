CREATE DEFINER = CURRENT_USER TRIGGER `mediatheque`.`Demande_BEFORE_INSERT` BEFORE INSERT ON `Demande` FOR EACH ROW
BEGIN
	select phyNum into @phyNum from Contenu, TypeContenu where TypeContenu_typeContenu = typeContenu and numeroCatalogue = new.Contenu_numeroCatalogue;
	if @phyNum = 'num' then
		set new.Etablissement_nomEtablissement = 'tous';
    end if;
    
	if (select count(*) from Demande where Abonne_numeroAbonne = new.Abonne_numeroAbonne) >= 3 then
    signal sqlstate '45000' set message_text = 'Cet abonné a déjà effectué 3 demandes';
    end if;
    
    if DATEDIFF(new.dateDemande, (select dateRenouvellement from Abonne where numeroAbonne = new.Abonne_numeroAbonne)) > 365 then
    signal sqlstate '45000' set message_text = 'Veuillez renouveler votre adhésion avant d\'effectuer une demande';
    end if;
    
    select titre into @titre from Contenu where numeroCatalogue = new.Contenu_numeroCatalogue;
    if titreExiste(@titre, null, new.Etablissement_nomEtablissement) <= 0 then
		signal sqlstate '45000' set message_text = 'Le titre renseigné n\'est pas présent dans cet établissement';
    end if;
END