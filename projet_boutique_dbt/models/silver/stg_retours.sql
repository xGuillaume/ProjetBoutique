select

    id_retour,

    id_ligne,

    cast(date_retour as date) as date_retour,

    coalesce(
        trim(motif),
        'INCONNU'
    ) as motif,

    quantite_retournee,

    coalesce(
        trim(statut_remboursement),
        'INCONNU'
    ) as statut_remboursement,

    montant_rembourse

from {{ source('bronze', 'retours') }}