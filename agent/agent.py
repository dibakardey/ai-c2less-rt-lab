import requests
import os
import uuid

API_URL = os.getenv("API_URL", "https://your-api-gateway-endpoint/dev/tasks")

def fetch_task():
    # Mock pull from coordinator
    resp = requests.post(API_URL, json={"agent_id": str(uuid.uuid4())})
    if resp.status_code == 200:
        return resp.json()
    return {"task": "none"}

def run_task(task):
    # Mock execution (replace with AI model calls later)
    return {"result": f"Executed task: {task}"}

if __name__ == "__main__":
    task = fetch_task()
    print("Received:", task)
    result = run_task(task.get("task"))
    print("Result:", result)
