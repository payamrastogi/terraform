import logging

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)


# event object contains the information about the event invoking the lambda
# context object contains lambda runtime information
def handler(event, context):
    LOGGER.info(f'Event Object: {event}')
    LOGGER.info(f'Context Object: {context}')
    event['rotate'] = 'filter'
    return event
