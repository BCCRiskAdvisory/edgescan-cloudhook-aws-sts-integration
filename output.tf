output "external_id" {
  value = local.external_id
}

output "role_arn" {
  value = aws_iam_role.edgescan_integration.arn
}