{{ config(
materialized='view',
schema='gold'
) }}

select

    r.id_retour,
    r.id_ligne,

    v.id_commande,
    v.id_client,
    v.id_produit,

    r.date_retour,

    r.motif,

    r.quantite_retournee,

    r.montant_rembourse,

    r.statut_remboursement

from silver.stg_retours r

inner join {{ ref('fact_ventes') }} v
    on r.id_ligne = v.id_ligne
