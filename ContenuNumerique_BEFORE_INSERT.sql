CREATE DEFINER = CURRENT_USER TRIGGER `mediatheque`.`ContenuNumerique_BEFORE_INSERT` BEFORE INSERT ON `ContenuNumerique` FOR EACH ROW
BEGIN
	select phyNum into @phynum from TypeContenu, Contenu
		where new.Contenu_numeroCatalogue = numeroCatalogue and TypeContenu_typeContenu = typeContenu;
	if @phynum != 'num' then
	signal sqlstate '45000' set message_text = 'Ce contenu n\'est pas numérique';
    end if;
END
