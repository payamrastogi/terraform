import boto3
import json

import logging

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)


def handler(event, context):
    LOGGER.info(f'Event Object: {event}')
    LOGGER.info(f'Context Object: {context}')
    trigger_step_function("uploads/image.png")
    return event


def trigger_step_function(file_name):
    sf = boto3.client('stepfunctions', region_name='us-east-1')
    input_dict = {'file': file_name}
    response = sf.start_execution(
        stateMachineArn='arn:aws:states:us-east-1:xxxxxxx:iam_role', input=json.dumps(input_dict))
