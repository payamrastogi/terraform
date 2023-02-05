import cv2
import logging

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)


def handler(event, context):
    LOGGER.info(f'Event Object: {event}')
    LOGGER.info(f'Context Object: {context}')
    event['action'] = 'filter'
    return event


def filter(file_name):
    try:
        image = cv2.imread(file_name)
        # Gaussian Blur
        res = cv2.GaussianBlur(image, (7, 7), 0)
        cv2.imwrite('result.jpg', res)
    except IOError:
        LOGGER.error('An error occurred')


if __name__ == "__main__":
    filter("../data/image.png")
