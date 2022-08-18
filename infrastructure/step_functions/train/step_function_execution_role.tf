resource "aws_iam_role" "step_function_lambda_invole_role" {
  name               = var.step_function_lambda_invole_role_name
  assume_role_policy = data.local_file.step_function_lambda_invole_role_file.content
}

resource "aws_iam_policy" "step_function_lambda_invoke_policy" {
  name   = var.step_function_lambda_invoke_policy_name
  policy = data.local_file.train_step_function_lambda_invoke_policy_file.content
}

resource "aws_iam_policy" "step_function_xray_access_policy" {
  name   = var.step_function_xray_access_policy_name
  policy = data.local_file.step_function_xray_access_policy_file.content
}

resource "aws_iam_policy_attachment" "step_function_lambda_invoke_policy_attachment" {
  name       = var.step_function_lambda_invoke_policy_attachment_name
  roles      = [aws_iam_role.step_function_lambda_invole_role.name]
  policy_arn = aws_iam_policy.step_function_lambda_invoke_policy.arn
}

resource "aws_iam_policy_attachment" "step_function_xray_access_policy_attachment" {
  name       = var.step_function_xray_access_policy_attachment_name
  roles      = [aws_iam_role.step_function_lambda_invole_role.name]
  policy_arn = aws_iam_policy.step_function_xray_access_policy.arn
}

data "local_file" "train_step_function_lambda_invoke_policy_file" {
  filename = "./data/policies/train_step_function_lambda_invoke_policy.json"
}
