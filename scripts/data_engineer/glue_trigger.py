import boto3
import configparser


def glue_trigger_function():
    # Read the config file
    path = "/Users/gomes/Desktop/Projects/utils/Data-Engineer-Real-time-Transactions/config/config.ini"
    config = configparser.ConfigParser()
    config.read(path)

    aws_access_key_id = config.get("AWS", "AWS_ACCESS_KEY_ID")
    aws_secret_access_key = config.get("AWS", "AWS_SECRET_ACCESS_KEY")
    aws_region = config.get("AWS", "AWS_REGION")

    job_name = config.get("GLUE", "JOB_NAME")

    # Initialize Boto3 Glue client
    glue = boto3.client(
        "glue",
        region_name=aws_region,
        aws_access_key_id=aws_access_key_id,
        aws_secret_access_key=aws_secret_access_key,
    )

    # Trigger the Glue job
    response = glue.start_job_run(JobName=job_name)

    job_run_id = response["JobRunId"]

    print(f"Glue job '{job_name}' triggered with JobRunId: {job_run_id}")
