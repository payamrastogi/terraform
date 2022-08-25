def handler (event, context):
    print (event)
    response = {
        'statusCode': 200,
        'body': 'Hello World!'
    }
    return response
