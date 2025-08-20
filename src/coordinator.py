import json

def lambda_handler(event, context):
    # Mock coordinator that dispatches tasks to agent
    body = json.loads(event.get("body", "{}"))
    command = body.get("command", "noop")
    return {
        "statusCode": 200,
        "body": json.dumps({"dispatched": command, "status": "ok"})
    }