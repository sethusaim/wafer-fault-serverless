data "local_file" "step_function_lambda_invole_role_file" {
  filename = "./data/roles/step_function_lambda_invole_role.json"
}

data "local_file" "step_function_xray_access_policy_file" {
  filename = "./data/policies/step_function_xray_access_policy.json"
}

data "local_file" "train_step_function_lambda_invoke_policy_file" {
  filename = "./data/policies/train_step_function_lambda_invoke_policy.json"
}

data "local_file" "pred_step_function_lambda_invoke_policy_file" {
  filename = "./data/policies/pred_step_function_lambda_invoke_policy.json"
}

data "local_file" "pred_step_function_file" {
  filename = "./data/step_functions/pred_step_function.json"
}

data "local_file" "train_step_function_file" {
  filename = "./data/step_functions/train_step_function.json"
}