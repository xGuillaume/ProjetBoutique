select

    id_produit,

    coalesce(
        trim(nom_produit),
        'INCONNU'
    ) as nom_produit,

    coalesce(
        trim(categorie),
        'INCONNU'
    ) as categorie,

    prix_unitaire,

    stock_actuel,

    coalesce(
        trim(sous_categorie),
        'INCONNU'
    ) as sous_categorie,

    coalesce(
        trim(genre_cible),
        'INCONNU'
    ) as genre_cible,

    coalesce(
        trim(marque),
        'INCONNU'
    ) as marque,

    coalesce(
        trim(matiere),
        'INCONNU'
    ) as matiere,

    coalesce(
        trim(collection),
        'INCONNU'
    ) as collection,

    cout_unitaire,

    cast(date_ajout_catalogue as date) as date_ajout_catalogue,

    coalesce(actif, false) as actif

from {{ source('bronze', 'produits') }}
