select *

from {{ source('bronze', 'commandes') }}

where

    montant_total < 0

    or date_livraison < date_commande

    or statut is null

    or montant_total is null