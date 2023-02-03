#### Project: Image Processing Pipeline
This project demonstrates how API Gateway, SNS, Step Functions, and S3 can be used together to build a scalable, robust, and flexible image processing pipeline.

##### Description 
An API that accepts image uploads, processes the images using a series of steps, and stores the processed images in S3.

##### Components

- **API Gateway:** A REST API that accepts image uploads and triggers the processing pipeline.
- **SNS:** A messaging service that acts as a communication channel between the API Gateway and the processing steps.
- **Step Functions:** A workflow service that coordinates the processing steps and ensures that each step is completed before the next one starts.
- **S3:** A storage service that stores the raw and processed images.

##### Processing Steps:
1. Image Resizing: Resizes the uploaded image to a specified size.
2. Image Rotation: Rotates the image based on the specified orientation.
3. Image Format Conversion: Converts the image format to the specified format (e.g., PNG, JPEG, etc.).
4. Image Filtering: Applies a series of filters to the image (e.g., sharpen, blur, etc.).

Each step in the processing pipeline is implemented as a separate AWS Lambda function and triggered by SNS messages. 
The Step Functions workflow manages the flow of processing steps, ensuring that each step is completed before the next one starts. 
The processed images are stored in S3 for later retrieval.




