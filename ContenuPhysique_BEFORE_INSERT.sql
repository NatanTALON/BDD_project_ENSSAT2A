CREATE DEFINER = CURRENT_USER TRIGGER `mediatheque`.`ContenuPhysique_BEFORE_INSERT` BEFORE INSERT ON `ContenuPhysique` FOR EACH ROW
BEGIN
	select phyNum into @phynum from TypeContenu, Contenu
		where new.Contenu_numeroCatalogue = numeroCatalogue and TypeContenu_typeContenu = typeContenu;
	if @phynum != 'phy' then
	signal sqlstate '45000' set message_text = 'Ce contenu n\'est pas physique';
    end if;
END
