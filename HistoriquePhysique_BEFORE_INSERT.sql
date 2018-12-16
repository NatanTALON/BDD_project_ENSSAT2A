CREATE DEFINER = CURRENT_USER TRIGGER `mediatheque`.`HistoriquePhysique_BEFORE_INSERT` BEFORE INSERT ON `HistoriquePhysique` FOR EACH ROW
BEGIN
	if ((select count(ContenuPhysique_codeBarre) from HistoriquePhysique where Abonne_numeroAbonne = new.Abonne_numeroAbonne and rendu = 0) + (select count(ContenuNumerique_numeroLicence) from HistoriqueNumerique where Abonne_numeroAbonne = new.Abonne_numeroAbonne and rendu = 0)) >= 5 then
    signal sqlstate '45000' set message_text = 'Cet abonné a déjà emprunté 5 contennus';
    end if;
    
    if DATEDIFF(new.dateRetourPhysique, (select dateRenouvellement from Abonne where numeroAbonne = new.Abonne_numeroAbonne)) > 365 then
    signal sqlstate '45000' set message_text = 'Veuillez renouveler votre adhésion avant d\'emprunter ce contenu';
    end if;
    
    if (select ContenuPhysique_codeBarre from HistoriquePhysique where ContenuPhysique_codeBarre = new.ContenuPhysique_codeBarre) is not null then
    signal sqlstate '45000' set message_text = 'Ce contenu est déjà emprunté';
    end if;
END