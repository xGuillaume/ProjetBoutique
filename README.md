# Projet Boutique — Pipeline de données et reporting

Ce projet met en place une chaîne de traitement de données pour une boutique de prêt-à-porter, depuis l’ingestion des données sources jusqu’à la préparation de tables analytiques prêtes pour la visualisation dans Power BI.

L’architecture comprend :
- ingestion des données depuis PostgreSQL,
- contrôle de volumes et journalisation,
- nettoyage et transformation des données en couche Silver,
- modélisation analytique en couche Gold,
- orchestration avec Airflow,
- exploitation dans Power BI.

---

## Objectif métier

Le projet vise à garantir :
- la fiabilité des données sources,
- la cohérence des transformations,
- la mise à disposition de données d’analyse prêtes à l’emploi,
- le suivi de la qualité des données via des contrôles automatiques,
- la visualisation de KPI métier pour la direction et les équipes opérationnelles.

---

## Architecture du projet

### 1. Ingestion
Les données sont chargées depuis PostgreSQL dans la base `boutique_pret_a_porter` via Python et les librairies `pandas` et `SQLAlchemy`.

Les tables traitées sont :
- clients
- produits
- commandes
- lignes_commande
- retours

### 2. Contrôle qualité
Le script d’ingestion vérifie :
- les volumes attendus,
- la conformité des lignes chargées,
- la création d’un journal de chargement dans `journal_chargement.txt`.

### 3. Nettoyage et standardisation
Les règles de nettoyage sont documentées dans :
- `regles_nettoyage_silver.txt`

Les principales règles incluent :
- suppression des espaces en début/fin de chaîne,
- remplacement des valeurs manquantes,
- normalisation des villes,
- validation des emails,
- contrôle des dates,
- détection des doublons métier,
- vérification de l’intégrité référentielle.

### 4. Modélisation dbt
Le projet dbt est situé dans :
- `projet_boutique_dbt/`

Il contient les modèles pour les couches :
- Silver : `stg_*`
- Quarantaine : `qua_*`
- Gold : `dim_*` et `fact_*`

### 5. Orchestration
Le DAG Airflow est défini dans :
- `dags/pipeline_boutique.py`

Le pipeline exécute :
1. ingestion Bronze,
2. profilage Bronze,
3. modèles dbt Silver,
4. tests de qualité,
5. modèles dbt Gold,
6. archivage du rapport de qualité.

### 6. Reporting BI
Le dossier `powerBI/` contient les éléments liés à la mise en forme et à la restitution métier avec Power BI.

---

## Arborescence du projet

```text
ProjetBoutique/
├── .venv/                          # environnement virtuel Python local
├── dags/                          # orchestration Airflow
│   └── pipeline_boutique.py
├── logs/                          # logs applicatifs et Airflow
├── powerBI/                       # fichiers Power BI / exports analytiques
├── projet_boutique_dbt/           # projet dbt
│   ├── analyses/
│   ├── macros/
│   ├── models/
│   ├── seeds/
│   ├── snapshots/
│   ├── tests/
│   ├── dbt_project.yml
│   ├── README.md
│   └── target/
├── SQL/                           # scripts SQL et requêtes d’optimisation
├── journal_chargement.txt         # journal de chargement Bronze
├── regles_nettoyage_silver.txt    # règles de qualité Silver
├── rapport_profilage.txt          # résultats de profilage des données
├── README.md                      # documentation du projet
└── ...
```

> Les dossiers `.venv`, `logs`, `target` et les fichiers générés peuvent être exclus du dépôt Git selon les besoins de sécurité et de reproductibilité.

---

## Prérequis

Avant de lancer le projet, il est nécessaire d’avoir installé :
- Python 3.11
- PostgreSQL
- Airflow
- dbt
- pandas
- SQLAlchemy
- psycopg2

---

## Installation

### 1. Créer un environnement virtuel

```powershell
cd C:\Users\GK\Documents\Guillaume\Jour 7-8\ProjetBoutique
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

### 2. Installer les dépendances

```powershell
pip install pandas sqlalchemy psycopg2-binary
```

### 3. Vérifier la base PostgreSQL
La base doit être accessible localement sur :
- host : `localhost`
- port : `5432`
- base : `boutique_pret_a_porter`

---

## Exécution locale

### Ingestion Bronze

```powershell
python .venv\ingestion_bronze.py
```

### Profilage des données

```powershell
python .venv\profilage_bronze.py
```

### dbt

```powershell
cd projet_boutique_dbt
dbt run
dbt test
```

### Airflow

```powershell
airflow dags trigger pipeline_boutique
```

---

## Qualité des données

Le projet applique plusieurs contrôles de qualité :
- volumes attendus comparés aux données chargées,
- doublons métier,
- valeurs manquantes,
- dates incohérentes,
- intégrité référentielle,
- anomalies de prix et montants,
- quotas de quarantaine.

Les résultats sont enregistrés dans :
- `journal_chargement.txt`
- `rapport_profilage.txt`
- `regles_nettoyage_silver.txt`

---

## Fichiers clés

- `dags/pipeline_boutique.py` : orchestration du pipeline
- `journal_chargement.txt` : journal de vérification des chargements
- `regles_nettoyage_silver.txt` : règles de nettoyage et contrôle Silver
- `projet_boutique_dbt/` : modèles dbt et transformations
- `powerBI/` : éléments visuels / analyse métier

---

## Exemple de flux de données

```text
PostgreSQL Bronze
        ↓
Python d’ingestion
        ↓
Contrôle volumes / journal
        ↓
dbt Silver (nettoyage et standardisation)
        ↓
dbt Quarantaine (données non conformes)
        ↓
dbt Gold (dimensions et faits)
        ↓
Power BI / reporting
```

---

## Points de vigilance

- Ne pas versionner le dossier `.venv` s’il est local au projet.
- Ne pas publier les fichiers de logs ou les sorties de build sans contrôle.
- Vérifier toujours les identifiants et fichiers de connexion avant publication GitHub.
- Prévoir un `.gitignore` adapté pour exclure les artefacts générés.

---

## Statut

Ce projet est un pipeline de données orienté analytique, destiné à un usage local de démonstration, de validation et de reporting métier. Il est conçu pour être étendu facilement avec de nouveaux jeux de données, de nouveaux contrôles qualité ou de nouveaux modèles dbt.

---

## Auteur

Projet réalisé dans le cadre d’un atelier de mise en place d’infrastructure data et de reporting avec Airflow, dbt et Power BI.
