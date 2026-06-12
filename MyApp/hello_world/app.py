import json

Records = [{"id": 0, "name":"Peter"},{"id": 1, "name":"John"},{"id": 2, "name":"Chris"}]
sqlQuery = "'SELECT * FROM data WHERE name = %s' % param"

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