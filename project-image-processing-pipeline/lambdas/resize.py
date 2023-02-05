import logging

import cv2

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)


def handler(event, context):
    LOGGER.info(f'Event Object: {event}')
    LOGGER.info(f'Context Object: {context}')
    return event


def resize(file_name):
    try:
        # read image from s3
        img = cv2.imread(file_name)
        # Get number of pixel horizontally and vertically.
        (height, width) = img.shape[:2]
        # Specify the size of image along with interpolation methods.
        # cv2.INTER_AREA is used for shrinking, whereas cv2.INTER_CUBIC
        # is used for zooming.
        res = cv2.resize(img, (int(width / 2), int(height / 2)), interpolation=cv2.INTER_CUBIC)
        # Write image back to disk.
        cv2.imwrite('result.jpg', res)
    except IOError:
        LOGGER.error('An error occurred')


if __name__ == "__main__":
    resize("../data/image.png")
