select
    r.*
from {{ source('bronze', 'retours') }} r
left join {{ source('bronze', 'lignes_commande') }} lc
    on r.id_ligne = lc.id_ligne
left join {{ source('bronze', 'commandes') }} c
    on lc.id_commande = c.id_commande

where

    r.date_retour < c.date_commande

    or r.quantite_retournee <= 0

    or r.montant_rembourse < 0
