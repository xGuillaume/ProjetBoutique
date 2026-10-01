{{ config(
materialized='view',
schema='gold'
) }}

select

    id_produit,

    nom_produit,

    categorie,

    sous_categorie,

    genre_cible,

    marque,

    matiere,

    collection

from silver.stg_produits