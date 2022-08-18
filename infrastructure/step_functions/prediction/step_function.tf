resource "aws_sfn_state_machine" "train_state_machine" {
  name       = "train-state-machine"
  role_arn   = aws_iam_role.step_function_lambda_invole_role.arn
  definition = <<EOF
{
  "Comment": "A Hello World example of the Amazon States Language using an AWS Lambda Function",
  "StartAt": "HelloWorld",
  "States": {
    "HelloWorld": {
      "Type": "Task",
      "Resource": "arn:aws:lambda:us-east-1:347460842118:function:test",
      "End": true
    }
  }
}
EOF
}