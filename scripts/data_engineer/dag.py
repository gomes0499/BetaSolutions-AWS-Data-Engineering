from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.providers.amazon.aws.hooks.base_aws import AwsBaseHook

# Import  scripts functions
from rds import rds_function
from dummy_data import dummy_data_function
from dms_trigger import dms_trigger_function
from glue_trigger import glue_trigger_function
from redshift import redshift_function

# Default arguments for the DAG
default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2023, 5, 1),
    "email_on_failure": True,
    "email_on_retry": False,
    "email": ["gomes.dataengineer@gmail.com"],
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

# Create the DAG
dag = DAG(
    "your_dag_name",
    default_args=default_args,
    description="DAG to execute AWS scripts",
    schedule_interval=None,  # Set to None for manual triggering
    catchup=False,
)

# Define the tasks
rds_task = PythonOperator(
    task_id="rds_task",
    python_callable=rds_function,
    dag=dag,
)

dummy_data_task = PythonOperator(
    task_id="dummy_data_task",
    python_callable=dummy_data_function,
    dag=dag,
)

dms_trigger_task = PythonOperator(
    task_id="dms_trigger_task",
    python_callable=dms_trigger_function,
    dag=dag,
)

glue_trigger_task = PythonOperator(
    task_id="glue_trigger_task",
    python_callable=glue_trigger_function,
    dag=dag,
)

redshift_task = PythonOperator(
    task_id="redshift_task",
    python_callable=redshift_function,
    dag=dag,
)

# Define the task dependencies
rds_task >> dummy_data_task >> dms_trigger_task >> glue_trigger_task >> redshift_task
