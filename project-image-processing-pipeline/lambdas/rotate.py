import logging

import cv2

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)


# event object contains the information about the event invoking the lambda
# context object contains lambda runtime information
def handler(event, context):
    LOGGER.info(f'Event Object: {event}')
    LOGGER.info(f'Context Object: {context}')
    event['rotate'] = 'filter'
    return event


def rotate(file_name, rotate_by):
    try:
        # Read image from the disk.
        img = cv2.imread(file_name)

        # Shape of image in terms of pixels.
        (rows, cols) = img.shape[:2]

        # getRotationMatrix2D creates a matrix needed for transformation.
        # We want matrix for rotation w.r.t center to 45 degree without scaling.
        M = cv2.getRotationMatrix2D((cols / 2, rows / 2), rotate_by, 1)
        res = cv2.warpAffine(img, M, (cols, rows))

        # Write image back to disk.
        cv2.imwrite('result.jpg', res)
    except IOError:
        LOGGER.error('An error occurred')


if __name__ == "__main__":
    rotate("../data/image.png", 90)
