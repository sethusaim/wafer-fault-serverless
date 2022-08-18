resource "aws_iam_role" "step_function_lambda_invole_role" {
  name               = "step_function_lambda_invole_role"
  assume_role_policy = data.local_file.step_function_lambda_invole_role_file.content
}

resource "aws_iam_policy" "step_function_lambda_invoke_policy" {
  name   = "step_function_lambda_invoke_policy"
  policy = data.local_file.step_function_lambda_invoke_policy_file.content
}

resource "aws_iam_policy" "step_function_xray_access_policy" {
  name   = "step_function_xray_access_policy"
  policy = data.local_file.step_function_xray_access_policy_file.content
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

data "local_file" "step_function_lambda_invole_role_file" {
  filename = "./data/roles/train_step_function_lambda_invole_role.json"
}

data "local_file" "step_function_xray_access_policy_file" {
  filename = "./data/policies/train_step_function_xray_access_policy.json"
}

data "local_file" "step_function_lambda_invoke_policy_file" {
  filename = "./data/policies/train_step_function_lambda_invoke_policy.json"
}
