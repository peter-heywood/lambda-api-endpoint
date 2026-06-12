import json

Records = [{"id": 0, "name":"Peter"},{"id": 1, "name":"John"},{"id": 2, "name":"Chris"}]
superSecret = "b3jCHHM28xJRAF3AxOLj4N7AJT9sQM73nPCdC68BVFH"

def lambda_handler(event, context):
    if event['queryStringParameters']:
        try:
            return {
            "statusCode": 200,
            "body": json.dumps(Records[int(event['queryStringParameters']['id'])]),
            }   
        except:
            return {
            "statusCode": 400,
            "body": json.dumps({
                "message": f"ID {event['queryStringParameters']['id']} not found",
            }),
            }   
    else: 
        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": "No ID provided in URL",
            }),
        }