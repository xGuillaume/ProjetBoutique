{{ config(
materialized='view',
schema='gold'
) }}

select

    id_client,

    nom,

    prenom,

    genre,

    ville,

    region,

    canal_acquisition,

    date_inscription

from silver.stg_clients