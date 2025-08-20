import json
import uuid
import boto3
import os

dynamodb = boto3.resource("dynamodb")
table_name = os.getenv("DDB_TABLE", "ai-c2less-task-logs")
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    """
    Handles task distribution for agents.
    API Gateway triggers this with POST /tasks
    """

    # Parse agent ID if provided
    body = {}
    if "body" in event and event["body"]:
        try:
            body = json.loads(event["body"])
        except:
            pass

    agent_id = body.get("agent_id", str(uuid.uuid4()))

    # Demo task (later replace with AI or real tasks)
    task = {
        "task_id": str(uuid.uuid4()),
        "task": "classify_image",
        "payload": {"image_url": "https://example.com/sample.jpg"},
        "agent_id": agent_id
    }

    # Log the task into DynamoDB
    table.put_item(Item=task)

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(task)
    }
