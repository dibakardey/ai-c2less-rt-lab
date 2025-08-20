import json

def lambda_handler(event, context):
    # Mock agent receiving instructions
    body = json.loads(event.get("body", "{}"))
    task = body.get("task", "noop")
    return {
        "statusCode": 200,
        "body": json.dumps({"result": f"Agent executed {task}"})
    }