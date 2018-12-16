DELIMITER $$

create procedure rechercheArtiste (in nom varchar(45), in prenom varchar(45), in role varchar(45))
begin
	if prenom is null and role is null then
		select nomArtiste, prenomArtiste, titre, roleArtiste, TypeContenu_typeContenu from Artiste, Contenu, Contenu_has_Artiste where idArtiste = Artiste_idArtiste and nomArtiste = nom and Contenu_numeroCatalogue = numeroCatalogue;
	end if;
    if prenom is null and role is not null then
		select nomArtiste, prenomArtiste, titre, roleArtiste, TypeContenu_typeContenu from Artiste, Contenu, Contenu_has_Artiste where idArtiste = Artiste_idArtiste and nomArtiste = nom and roleArtiste = role and Contenu_numeroCatalogue = numeroCatalogue;
    end if;
    if role is null and prenom is not null then
		select nomArtiste, prenomArtiste, titre, roleArtiste, TypeContenu_typeContenu from Artiste, Contenu, Contenu_has_Artiste where idArtiste = Artiste_idArtiste and nomArtiste = nom and prenomArtiste = prenom and Contenu_numeroCatalogue = numeroCatalogue;
    end if;
    if role is not null and prenom is not null then
		select nomArtiste, prenomArtiste, titre, roleArtiste, TypeContenu_typeContenu from Artiste, Contenu, Contenu_has_Artiste where idArtiste = Artiste_idArtiste and nomArtiste = nom and roleArtiste = role and prenomArtiste = prenom and Contenu_numeroCatalogue = numeroCatalogue;
    end if;
end$$

create procedure rechercheTitre (in titreIn varchar(100))
begin
	select numeroCatalogue, titre, TypeContenu_typeContenu from Contenu where titre like concat('%',titreIn,'%');
end$$

create function titreExiste (titreIn varchar(100), typeContenuIn varchar(45), nomEtablissementIn varchar(45)) returns int
begin
	if typeContenuIn is null then
		if nomEtablissementIn = 'tous' then
			select count(titre) into @t from Contenu where titre = titreIn;
		else
			select count(titre) into @t from Contenu, ContenuPhysique where titre = titreIn and Contenu_numeroCatalogue = numeroCatalogue and Etablissement_nomEtablissement = nomEtablissementIn;
        end if;
    else
		if nomEtablissementIn = 'tous' then
			select count(titre) into @t from Contenu where titre = titreIn and TypeContenu_typeContenu = typeContenuIn;
		else
			select count(titre) into @t from Contenu, ContenuPhysique where titre = titreIn and TypeContenu_typeContenu = typeContenuIn and Contenu_numeroCatalogue = numeroCatalogue and Etablissement_nomEtablissement = nomEtablissementIn;
        end if;
    end if;
    return @t;
end$$

create procedure rechercheGenre (in genreIn varchar(45))
begin
	select numeroCatalogue, titre from Contenu where genre = genreIn;
end$$

