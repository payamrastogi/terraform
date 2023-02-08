import logging

import boto3

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)


def handler(event, context):
    LOGGER.info(f'Event Object: {event}')
    LOGGER.info(f'Context Object: {context}')
    resize("uploads/image.png")
    return event


def resize(file_name):
    s3_client = boto3.client("s3")
    S3_BUCKET_NAME = "image-processing-20230204"
    try:
        object_key = file_name  # replace object key
        #file_content = s3_client.get_object(Bucket=S3_BUCKET_NAME, Key=object_key)["Body"].read()
        response = s3_client.head_object(Bucket=S3_BUCKET_NAME,Key=object_key)
        LOGGER.info(response['ContentLength'])
        s3_client.download_file(S3_BUCKET_NAME, object_key, 'image.png')
        response = s3_client.upload_file('image.png', S3_BUCKET_NAME, 'resized/image.png')
        # LOGGER.info(file_content)
        # img = cv2.imread(file_name)
        # # Get number of pixel horizontally and vertically.
        # (height, width) = img.shape[:2]
        # # Specify the size of image along with interpolation methods.
        # # cv2.INTER_AREA is used for shrinking, whereas cv2.INTER_CUBIC
        # # is used for zooming.
        # res = cv2.resize(img, (int(width / 2), int(height / 2)), interpolation=cv2.INTER_CUBIC)
        # # Write image back to disk.
        # cv2.imwrite('result.jpg', res)
        # fileName = "result.jpg"
        # response = s3_client.upload_file(file_name, S3_BUCKET_NAME, "resize/image.png")
    except IOError as e:
        LOGGER.error(e)


if __name__ == "__main__":
    resize("image.png")
