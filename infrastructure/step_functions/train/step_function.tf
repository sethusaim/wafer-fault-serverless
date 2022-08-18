resource "aws_sfn_state_machine" "train_state_machine" {
  name       = var.train_state_machine_name
  role_arn   = aws_iam_role.step_function_lambda_invole_role.arn
  definition = data.local_file.train_step_function_file.content
}

data "local_file" "step_function_lambda_invole_role_file" {
  filename = "./data/roles/step_function_lambda_invole_role.json"
}

data "local_file" "step_function_xray_access_policy_file" {
  filename = "./data/policies/step_function_xray_access_policy.json"
}

data "local_file" "train_step_function_file" {
  filename = "./data/step_functions/train_step_function.json"
}