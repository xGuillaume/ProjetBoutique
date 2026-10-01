select *

from {{ source('bronze', 'produits') }}

where

    prix_unitaire < 0

    or cout_unitaire < 0

    or matiere is null