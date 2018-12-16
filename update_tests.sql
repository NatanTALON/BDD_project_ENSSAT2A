call renouvelerAbonnement(1);

call updateDemandes();

select retourPretNumerique(1,1);

select retourPretPhysique(2, 1);

call pret(1, 2, 'num');
call pret(1, 3, 'num');
#call pret(1, 1, 'phy');		#déclenche un trigger car le contenu est déjà emprunté
call pret(1, 2, 'phy');
#call pret(1, 3, 'phy');		#déclenche un trigger
#call pret(3, 4, 'phy');			#déclenche un trigger
select * from HistoriquePhysique;

call renouvellementPretNumerique(1, 1);
call renouvellementPretPhysique(2, 1);