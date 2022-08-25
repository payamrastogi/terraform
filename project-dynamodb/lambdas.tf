data "archive_file" "create-note-archive" {
 source_file = "lambdas/create-note.js"
 output_path = "lambdas/create-note.zip"
 type = "zip"
}

## create-note lambda
resource "aws_lambda_function" "create-note" {
 environment {
   variables = {
     NOTES_TABLE = aws_dynamodb_table.tf_notes_table.name
   }
 }
 memory_size = "128"
 timeout = 10
 runtime = "nodejs14.x"
 architectures = ["arm64"]
 handler = "lambdas/create-note.handler"
 function_name = "create-note"
 role = aws_iam_role.iam_for_lambda.arn
 filename = "lambdas/create-note.zip"
 source_code_hash = "${data.archive_file.create-note-archive.output_base64sha256}"
}

## delete-note lambda
data "archive_file" "delete-notes-archive" {
 source_file = "lambdas/delete-note.js"
 output_path = "lambdas/delete-note.zip"
 type = "zip"
}

resource "aws_lambda_function" "delete-note" {
 environment {
   variables = {
     NOTES_TABLE = aws_dynamodb_table.tf_notes_table.name
   }
 }
 memory_size = "128"
 timeout = 10
 runtime = "nodejs14.x"
 architectures = ["arm64"]
 handler = "lambdas/delete-note.handler"
 function_name = "delete-note"
 role = aws_iam_role.iam_for_lambda.arn
 filename = "lambdas/delete-note.zip"
 source_code_hash = "${data.archive_file.delete-notes-archive.output_base64sha256}"
}

data "archive_file" "get-all-notes-archive" {
 source_file = "lambdas/get-all-notes.js"
 output_path = "lambdas/get-all-notes.zip"
 type = "zip"
}


resource "aws_lambda_function" "get-all-notes" {
 environment {
   variables = {
     NOTES_TABLE = aws_dynamodb_table.tf_notes_table.name
   }
 }
 memory_size = "128"
 timeout = 10
 runtime = "nodejs14.x"
 architectures = ["arm64"]
 handler = "lambdas/get-all-notes.handler"
 function_name = "get-all-notes"
 role = aws_iam_role.iam_for_lambda.arn
 filename = "lambdas/get-all-notes.zip"
  source_code_hash = "${data.archive_file.get-all-notes-archive.output_base64sha256}"
}