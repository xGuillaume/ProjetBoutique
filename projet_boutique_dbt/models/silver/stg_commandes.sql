select

    id_commande,

    id_client,

    cast(date_commande as date) as date_commande,

    coalesce(
        trim(statut),
        'INCONNU'
    ) as statut,

    montant_total,

    coalesce(
        trim(canal_commande),
        'INCONNU'
    ) as canal_commande,

    coalesce(
        trim(mode_paiement),
        'INCONNU'
    ) as mode_paiement,

    coalesce(
        trim(mode_livraison),
        'INCONNU'
    ) as mode_livraison,

    frais_livraison,

    coalesce(
        trim(code_promo),
        'AUCUN'
    ) as code_promo,

    cast(date_livraison as date) as date_livraison

from {{ source('bronze', 'commandes') }}
