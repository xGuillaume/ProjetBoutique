select

    id_ligne,

    id_commande,

    id_produit,

    quantite,

    prix_unitaire_facture,

    coalesce(
        trim(taille),
        'INCONNU'
    ) as taille,

    coalesce(
        trim(couleur),
        'INCONNU'
    ) as couleur,

    remise_pct

from {{ source('bronze', 'lignes_commande') }}