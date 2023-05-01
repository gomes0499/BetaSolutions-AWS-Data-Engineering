import boto3
import configparser


def dms_trigger_function():
    # Read the config file
    path = "/Users/gomes/Desktop/Projects/utils/Data-Engineer-Real-time-Transactions/config/config.ini"
    config = configparser.ConfigParser()
    config.read(path)

    aws_access_key_id = config.get("AWS", "AWS_ACCESS_KEY_ID")
    aws_secret_access_key = config.get("AWS", "AWS_SECRET_ACCESS_KEY")
    aws_region = config.get("AWS", "AWS_REGION")

    source_endpoint_arn = config.get("DMS", "SOURCE_ENDPOINT_ARN")
    target_endpoint_arn = config.get("DMS", "TARGET_ENDPOINT_ARN")
    replication_instance_arn = config.get("DMS", "REPLICATION_INSTANCE_ARN")

    # Initialize Boto3 DMS client
    dms = boto3.client(
        "dms",
        region_name=aws_region,
        aws_access_key_id=aws_access_key_id,
        aws_secret_access_key=aws_secret_access_key,
    )

    # Create a replication task
    response = dms.create_replication_task(
        ReplicationTaskIdentifier="your-replication-task-identifier",
        SourceEndpointArn=source_endpoint_arn,
        TargetEndpointArn=target_endpoint_arn,
        ReplicationInstanceArn=replication_instance_arn,
        MigrationType="full-load",  # or 'cdc' for Change Data Capture
        TableMappings='{ \
            "rules": [ \
                { \
                    "rule-type": "selection", \
                    "rule-id": "1", \
                    "rule-name": "1", \
                    "object-locator": { \
                        "schema-name": "%", \
                        "table-name": "%" \
                    }, \
                    "rule-action": "include" \
                } \
            ] \
        }',
    )

    replication_task_arn = response["ReplicationTask"]["ReplicationTaskArn"]

    # Start the replication task
    dms.start_replication_task(
        ReplicationTaskArn=replication_task_arn,
        StartReplicationTaskType="start-replication",
    )

    print(f"Replication task created and started: {replication_task_arn}")
