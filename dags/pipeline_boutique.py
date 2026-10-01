from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from datetime import datetime

import os
import shutil


def archive_report():

    archive_dir = "archives"

    os.makedirs(archive_dir, exist_ok=True)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

    shutil.copy(
        "journal_chargement.txt",
        f"archives/journal_chargement_{timestamp}.txt"
    )


with DAG(
    dag_id="pipeline_boutique",
    start_date=datetime(2025, 1, 1),
    catchup=False
) as dag:

    ingestion_bronze = BashOperator(
        task_id="ingestion_bronze",
        bash_command='"/mnt/c/Users/GK/Documents/Guillaume/Jour 7-8/ProjetBoutique/.venv/Scripts/python.exe" "/mnt/c/Users/GK/Documents/Guillaume/Jour 7-8/ProjetBoutique/.venv/ingestion_bronze.py"'
    )

    profilage_bronze = BashOperator(
        task_id="profilage_bronze",
        bash_command='"/mnt/c/Users/GK/Documents/Guillaume/Jour 7-8/ProjetBoutique/.venv/Scripts/python.exe" "/mnt/c/Users/GK/Documents/Guillaume/Jour 7-8/ProjetBoutique/.venv/profilage_bronze.py"'
    )

    dbt_silver = BashOperator(
        task_id="dbt_silver",
        bash_command="dbt run --select stg_clients stg_commandes stg_lignes_commande stg_produits stg_retours"
    )

    dbt_tests = BashOperator(
        task_id="dbt_tests",
        bash_command="dbt run --select qua_clients qua_commandes qua_lignes_commande qua_produits qua_retours"
    )

    dbt_gold = BashOperator(
        task_id="dbt_gold",
        bash_command="dbt run --select fact_ventes fact_retours dim_clients dim_produits"
    )

    archive_quality_report = PythonOperator(
        task_id="archive_quality_report",
        python_callable=archive_report
    )

    (
        ingestion_bronze
        >> profilage_bronze
        >> dbt_silver
        >> dbt_tests
        >> dbt_gold
        >> archive_quality_report
    )