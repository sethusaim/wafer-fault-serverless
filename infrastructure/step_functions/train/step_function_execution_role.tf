resource "aws_iam_role" "step_function_lambda_invole_role" {
  name               = "step_function_lambda_invole_role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "step_function_lambda_invoke_policy" {
  name = "step_function_lambda_invoke_policy"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "lambda:InvokeFunction"
          ],
          "Resource" : [
            "arn:aws:lambda:us-east-1:347460842118:function:test:*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "lambda:InvokeFunction"
          ],
          "Resource" : [
            "arn:aws:lambda:us-east-1:347460842118:function:test"
          ]
        }
      ]
    }
  )
}


resource "aws_iam_policy" "step_function_xray_access_policy" {
  name = "step_function_xray_access_policy"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "xray:PutTraceSegments",
            "xray:PutTelemetryRecords",
            "xray:GetSamplingRules",
            "xray:GetSamplingTargets"
          ],
          "Resource" : [
            "*"
          ]
        }
      ]
    }
  )
}

resource "aws_iam_policy_attachment" "step_function_lambda_invoke_policy_attachment" {
  name       = "step_function_lambda_invoke_policy_attachment"
  roles      = [aws_iam_role.step_function_lambda_invole_role.name]
  policy_arn = aws_iam_policy.step_function_lambda_invoke_policy.arn
}

resource "aws_iam_policy_attachment" "step_function_xray_access_policy_attachment" {
  name       = "step_function_xray_access_policy_attachment"
  roles      = [aws_iam_role.step_function_lambda_invole_role.name]
  policy_arn = aws_iam_policy.step_function_xray_access_policy.arn
}
