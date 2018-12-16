CREATE DEFINER = CURRENT_USER TRIGGER `mediatheque`.`Abonne_BEFORE_INSERT` BEFORE INSERT ON `Abonne` FOR EACH ROW
BEGIN
	if DATE_FORMAT(new.dateAdhesion, '%m-%d') = '02-29' then
		set new.dateAdhesion = SUBDATE(CURRENT_DATE(), 1);
        set new.dateRenouvellement = SUBDATE(CURRENT_DATE(), 1);
	end if;
END