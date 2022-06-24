-- Utilisateur
CREATE OR REPLACE VIEW list_utilisateur AS
	SELECT *
    FROM utilisateur;
    
-- membre
CREATE OR REPLACE VIEW list_membre AS
	SELECT m.id_m, u.nom_u AS nom_membre, u.prenom_u AS prenom_membre
    FROM membre m
    JOIN utilisateur u
		ON m.id_m = u.id_u;

-- co-proprietaire
CREATE OR REPLACE VIEW list_copro AS
	SELECT co.id_co, u.nom_u AS nom_copro, u.prenom_u AS prenom_copro
    FROM `co-proprietaire` co
    JOIN utilisateur u
		ON co.id_co = u.id_u;

-- proprietaire
CREATE OR REPLACE VIEW list_proprietaire AS
	SELECT p.id_pro, u.nom_u AS nom_proprietaire, u.prenom_u AS prenom_proprietaire
    FROM proprietaire p
    JOIN utilisateur u
		ON p.id_pro = u.id_u