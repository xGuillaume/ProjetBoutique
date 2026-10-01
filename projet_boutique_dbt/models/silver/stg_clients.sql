with clients_controles as (

    select
        *,
        row_number() over (
            partition by
                trim(nom),
                trim(prenom),
                upper(trim(ville))
            order by id_client
        ) as duplicate_rank

    from {{ source('bronze', 'clients') }}

)

select

    id_client,

    coalesce(trim(nom), 'INCONNU') as nom,

    coalesce(trim(prenom), 'INCONNU') as prenom,

    lower(
        coalesce(trim(email), 'INCONNU')
    ) as email,

    upper(
        coalesce(trim(ville), 'INCONNU')
    ) as ville,

    cast(date_inscription as date) as date_inscription,

    coalesce(
        trim(genre),
        'Non renseigne'
    ) as genre,

    cast(date_naissance as date) as date_naissance,

    coalesce(
        trim(code_postal),
        'INCONNU'
    ) as code_postal,

    coalesce(
        trim(region),
        'INCONNU'
    ) as region,

    coalesce(
        trim(canal_acquisition),
        'INCONNU'
    ) as canal_acquisition,

    coalesce(
        optin_newsletter,
        false
    ) as optin_newsletter,

    duplicate_rank

from clients_controles