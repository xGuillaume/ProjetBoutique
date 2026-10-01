--------------------------------------------------------
-- OPTIMISATION DES PERFORMANCES
-- Création des index sur les colonnes de jointure
--------------------------------------------------------

-- Requête 1 : Chiffre d'affaires par client
CREATE INDEX idx_lignes_commande_id_commande
ON bronze.lignes_commande (id_commande);

CREATE INDEX idx_commandes_id_client
ON bronze.commandes (id_client);


-- Requête 2 : Chiffre d'affaires par produit
CREATE INDEX idx_lignes_commande_id_produit
ON bronze.lignes_commande (id_produit);


-- Requête 3 : Analyse des retours par produit
-- Réutilisation de l'index créé sur id_produit
-- car cette requête utilise la même colonne de jointure
-- entre les lignes de commande et les produits.