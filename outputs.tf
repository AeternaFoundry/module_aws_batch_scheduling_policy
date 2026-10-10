output "batch_scheduling_policies_id" {
  description = "Map of id values across all batch_scheduling_policies, keyed the same as var.batch_scheduling_policies"
  value       = { for k, v in aws_batch_scheduling_policy.batch_scheduling_policies : k => v.id if v.id != null && length(v.id) > 0 }
}
output "batch_scheduling_policies_arn" {
  description = "Map of arn values across all batch_scheduling_policies, keyed the same as var.batch_scheduling_policies"
  value       = { for k, v in aws_batch_scheduling_policy.batch_scheduling_policies : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "batch_scheduling_policies_fair_share_policy" {
  description = "Map of fair_share_policy values across all batch_scheduling_policies, keyed the same as var.batch_scheduling_policies"
  value       = { for k, v in aws_batch_scheduling_policy.batch_scheduling_policies : k => one(v.fair_share_policy) if v.fair_share_policy != null && length(v.fair_share_policy) > 0 }
}
output "batch_scheduling_policies_name" {
  description = "Map of name values across all batch_scheduling_policies, keyed the same as var.batch_scheduling_policies"
  value       = { for k, v in aws_batch_scheduling_policy.batch_scheduling_policies : k => v.name if v.name != null && length(v.name) > 0 }
}
output "batch_scheduling_policies_region" {
  description = "Map of region values across all batch_scheduling_policies, keyed the same as var.batch_scheduling_policies"
  value       = { for k, v in aws_batch_scheduling_policy.batch_scheduling_policies : k => v.region if v.region != null && length(v.region) > 0 }
}
output "batch_scheduling_policies_tags" {
  description = "Map of tags values across all batch_scheduling_policies, keyed the same as var.batch_scheduling_policies"
  value       = { for k, v in aws_batch_scheduling_policy.batch_scheduling_policies : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "batch_scheduling_policies_tags_all" {
  description = "Map of tags_all values across all batch_scheduling_policies, keyed the same as var.batch_scheduling_policies"
  value       = { for k, v in aws_batch_scheduling_policy.batch_scheduling_policies : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}

