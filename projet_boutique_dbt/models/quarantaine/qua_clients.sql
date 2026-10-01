with clients_controles as (

    select
        *,
        row_number() over (
            partition by
                trim(nom),
                trim(prenom),
                upper(trim(ville))
            order by id_client
        ) as rn

    from {{ source('bronze', 'clients') }}

)

select *

from clients_controles

where

    email is null

    or email !~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'

    or rn > 1

    or cast(date_naissance as date)
       > cast(date_inscription as date)
