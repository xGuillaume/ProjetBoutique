select *

from {{ source('bronze', 'lignes_commande') }}

where

    quantite <= 0

    or prix_unitaire_facture < 0

    or remise_pct < 0

    or remise_pct > 100