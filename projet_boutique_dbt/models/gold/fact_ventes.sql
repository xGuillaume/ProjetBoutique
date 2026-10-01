{{ config(
materialized='view',
schema='gold'
) }}

select

    lc.id_ligne,
    c.id_commande,
    c.id_client,
    lc.id_produit,

    c.date_commande,
    c.date_livraison,

    c.canal_commande,
    c.mode_livraison,
    c.code_promo,

    lc.quantite,
    lc.prix_unitaire_facture,

    p.cout_unitaire,

    lc.remise_pct,

    lc.quantite * lc.prix_unitaire_facture
        as chiffre_affaires,

    lc.quantite * p.cout_unitaire
        as cout_total,

    (
        lc.quantite * lc.prix_unitaire_facture
        -
        lc.quantite * p.cout_unitaire
    ) as marge

from silver.stg_lignes_commande lc

inner join silver.stg_commandes c
    on lc.id_commande = c.id_commande

inner join silver.stg_produits p
    on lc.id_produit = p.id_produit
