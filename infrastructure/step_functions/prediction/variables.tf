variable "step_function_lambda_invole_role_name" {
  default = "step_function_lambda_invole_role"
  type = string
}

variable "step_function_lambda_invoke_policy_name" {
  default = "step_function_lambda_invoke_policy"
  type = string
}

variable "step_function_xray_access_policy_name" {
  default = "step_function_xray_access_policy"
  type = string
}

variable "step_function_lambda_invoke_policy_attachment_name" {
  default = "step_function_lambda_invoke_policy_attachment"
  type = string
}

variable "step_function_xray_access_policy_attachment_name" {
  default = "step_function_xray_access_policy_attachment"
  type = string
}

variable "pred_state_machine_name" {
  default = "pred-state-machine"
  type = string
}
