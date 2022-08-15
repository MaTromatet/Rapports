
CREATE OR REPLACE VIEW plansExtractView AS
select p.id, p."name", p.aidcategory as catégorie,
			 regexp_replace(regexp_replace(regexp_replace(p.caption, E'[\\\\n\\\\r]+', ' ', 'g'), ';', '', 'g'), E'<[^>]+>', '', 'gi') as phrase_accroche,
			 regexp_replace(p.keynumberscaptions, E'[\\\\n\\\\r]+', ' ', 'g') as chiffres_clés,
			 p.active, p2."label" as "type",
			 array_to_string(array(select a2."label" from activityarea a2
			 left join plan_activityarea pa on a2.id = pa.activityareaid
			 where pa.planid = p.id), ' / ') as filières,
			 array_to_string(array(select c2."label" from category c2
			 left join plan_category pc on c2.id = pc.categoryid
			 where pc.planid = p.id), ' / ') as catégories_de_projet,
			 array_to_string(array(select e2."label" from eligibleexpense e2
			 left join plan_eligibleexpense pe on e2.id = pe.eligibleexpenseid
			 where pe.planid = p.id), ' / ') as dépenses_éligibles,
			 array_to_string(array(select regexp_replace(g2."label", E'[\\\\t]+', ' ', 'g') from goal g2
			 left join plan_goal pg on g2.id = pg.goalid
			 where pg.planid = p.id), ' / ') as objectifs,
			 array_to_string(array(select r2."label" from recipient r2
			 left join plan_recipient pr on r2.id = pr.recipientid
			 where pr.planid = p.id), ' / ') as bénéficiaires,
			 array_to_string(array(select a3."label" from aidtype a3
			 left join plan_aidtype pa3 on a3.id = pa3.aidtypeid
			 where pa3.planid = p.id), ' / ') as nature_aide,
			 array_to_string(array(select t2."label" from tag t2
			 left join plan_tag pt on t2.id = pt.tagid
			 where pt.planid = p.id), ' / ') as tags,
			 array_to_string(array(select n2."label" from naf n2
			 left join plan_excludednaf pe2 on n2.id = pe2.excludednafid
			 where pe2.planid = p.id), ' / ') as naf_exclus,
			 p.createdat, p.updatedat, P.startdate, p.enddate, s."name" as operateur,
			 array_to_string(array(select concat(i2.firstname, ' ', i2.lastname) from interlocutor i2
			 left join plan_expert pe3 on i2.id = pe3.interlocutorid
			 where pe3.planid = p.id), ' / ') as experts,
			 concat(coalesce(f2.originalname, f2."name"), ' ', p.detailedcardfilename) as "Lien fiche descriptive (pdf)(nom du document + nom pour l'affichage s'il y en a un spécifique)",
			 array_to_string(array(select COALESCE (f.originalname, f."name") from file f
			 left join plan_document pd on f.id = pd.fileid
			 where pd.planid = p.id), ' / ') as documents,
			 array_to_string(array(select COALESCE (f.originalname, f."name") from file f
			 left join plan_faq pf on f.id = pf.fileid
			 where pf.planid = p.id), ' / ') as "Documents visibles uniquement sur le portail Agents (Lien vers la FAQ, PDF)",
			 array_to_string(array(select COALESCE (f.originalname, f."name") from file f
			 left join plan_submission_link psl on f.id = psl.fileid
			 where psl.planid = p.id), ' / ') as "Liens de dépot de dossier PDF (+ nom du lien s'il existe dans la colonne suivante, séparés par des slashs)",
			 array_to_string(array(select concat(psl.linkurl, ' ', psl.linkname) from plan_submission_link psl
			 where psl.planid = p.id), ' / ') as "Liens de dépot de dossier URL (URL + nom du lien s'il exite, séparés par des slashs)",
			 array_to_string(array(select concat(pv.title, ' : ', pv.videourl) from plan_video pv
			 where pv.planid = p.id), ' / ') as "Vidéos (nom de la vidéo : URL de la vidéo, séparés par des slashs)",
			 p.minage, p.maxage, p.minnbofemployees, p.maxnbofemployees,
			 CONCAT('https://hubentreprendre.laregion.fr/financement/', p.slug) as "Lien URL de la page"
			 from plan p
			 left join plantype p2 on p2.id = p.plantypeid
			 left join "structure" s on s.id = p.operatorid
			 left join file f2 on f2.id = p.detailedcard
			 group by p.id, p."name", p.description, phrase_accroche, chiffres_clés, p.active, "type",
			 "Lien fiche descriptive (pdf)(nom du document + nom pour l'affichage s'il y en a un spécifique)", p.createdat, p.updatedat, P.startdate, p.enddate, operateur,
			 p.minage, p.maxage, p.minnbofemployees, p.maxnbofemployees, "Lien URL de la page"
			 order by p."name" asc