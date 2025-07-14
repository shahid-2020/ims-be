def handler(event, context):
    try:
        print("Received event:", event)
        
        return {
            "statusCode": 200,
            "body": "Event processed successfully"
        }
    except Exception as e:
        print("Error processing event:", str(e))
        return {
            "statusCode": 500,
            "body": "Internal server error"
        }