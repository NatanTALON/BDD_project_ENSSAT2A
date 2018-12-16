call rechercheArtiste("Di Caprio", null, null);

call rechercheArtiste("Dion", "Céline", null);

call rechercheArtiste("Dion", null, "chanteur");

call rechercheGenre("Horreur");
call rechercheGenre("Drame");

call rechercheTitre("Titanic");
call rechercheTitre("Tit");

select titreExiste("Coucou", null, 'tous');
select titreExiste("Eragon", null, 'ENSSAT');
select titreExiste("Eragon", 'Livre', 'tous');
select titreExiste("Eragon", 'Livre', 'Orange Labs');