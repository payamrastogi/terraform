import glob
import logging

import cv2 as cv

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)


def handler(event, context):
    LOGGER.info(f'Event Object: {event}')
    LOGGER.info(f'Context Object: {context}')
    event['action'] = 'filter'
    return event


def convert_to_jpeg(file_name):
    try:
        jpg_file_path = file_name[:-3] + "jpg"
        # Load .png image
        image = cv.imread(file_name)
        # Save .jpg image
        cv.imwrite(jpg_file_path, image, [int(cv.IMWRITE_JPEG_QUALITY), 100])
    except IOError:
        LOGGER.error("An error occurred")


if __name__ == "__main__":
    convert_to_jpeg("../data/image.png")
