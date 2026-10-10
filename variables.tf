variable "batch_scheduling_policies" {
  description = <<EOT
Map of batch_scheduling_policies, attributes below
Required:
    - name
Optional:
    - region
    - tags
    - tags_all
    - fair_share_policy (block):
        - compute_reservation (optional)
        - share_decay_seconds (optional)
        - share_distribution (optional, block):
            - share_identifier (required)
            - weight_factor (optional)
EOT

  type = map(object({
    name     = string
    region   = optional(string)
    tags     = optional(map(string))
    tags_all = optional(map(string))
    fair_share_policy = optional(object({
      compute_reservation = optional(number)
      share_decay_seconds = optional(number)
      share_distribution = optional(list(object({
        share_identifier = string
        weight_factor    = optional(number)
      })))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.batch_scheduling_policies : (
        v.fair_share_policy == null || (v.fair_share_policy.share_distribution == null || (length(v.fair_share_policy.share_distribution) <= 500))
      )
    ])
    error_message = "Each share_distribution list must contain at most 500 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.batch_scheduling_policies : (
        v.fair_share_policy == null || (v.fair_share_policy.compute_reservation == null || (v.fair_share_policy.compute_reservation >= 0 && v.fair_share_policy.compute_reservation <= 99))
      )
    ])
    error_message = "must be between 0 and 99"
  }
  validation {
    condition = alltrue([
      for k, v in var.batch_scheduling_policies : (
        v.fair_share_policy == null || (v.fair_share_policy.share_decay_seconds == null || (v.fair_share_policy.share_decay_seconds >= 0 && v.fair_share_policy.share_decay_seconds <= 604800))
      )
    ])
    error_message = "must be between 0 and 604800"
  }
  validation {
    condition = alltrue([
      for k, v in var.batch_scheduling_policies : (
        v.fair_share_policy == null || (v.fair_share_policy.share_distribution == null || alltrue([for item in v.fair_share_policy.share_distribution : (item.weight_factor == null || (item.weight_factor >= 0.0001 && item.weight_factor <= 999.9999))]))
      )
    ])
    error_message = "must be between 0.0001 and 999.9999"
  }
  # Note: 2 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

