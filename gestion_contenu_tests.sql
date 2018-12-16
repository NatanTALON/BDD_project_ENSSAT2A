call listePretsAbonne(1);
call listePretsAbonne(2);

call listeEmprunteursContenu(1);
call listeEmprunteursContenu(2);
call listeEmprunteursContenu(3);

select contenuEstDisponible(1, 'ENSSAT');
select contenuEstDisponible(4, 'Orange Labs');
select contenuEstDisponible(3, 'tous');

select abonneEstDemandeur(2, 2);
select abonneEstDemandeur(2, 3);

call echeancier();
insert into HistoriquePhysique values (1, 1, 1, '2018-04-07', '2018-04-20', 0);
call echeancier();

select nbEmprunteurActuel();

select nbEmpruntActuel();

