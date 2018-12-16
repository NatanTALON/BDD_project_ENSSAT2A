CREATE DEFINER = CURRENT_USER TRIGGER `mediatheque`.`TypeContenu_BEFORE_INSERT` BEFORE INSERT ON `TypeContenu` FOR EACH ROW
BEGIN
	if new.phyNum != 'phy' and new.phyNum != 'num' then
    signal sqlstate '45000' set message_text = 'Un contenu physique doit être noté phy, un contenu numérique doit être noté num';
    end if;
END
