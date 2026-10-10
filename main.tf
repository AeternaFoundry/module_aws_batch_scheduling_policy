resource "aws_batch_scheduling_policy" "batch_scheduling_policies" {
  for_each = var.batch_scheduling_policies

  name     = each.value.name
  region   = each.value.region
  tags     = each.value.tags
  tags_all = each.value.tags_all

  dynamic "fair_share_policy" {
    for_each = each.value.fair_share_policy != null ? [each.value.fair_share_policy] : []
    content {
      compute_reservation = fair_share_policy.value.compute_reservation
      share_decay_seconds = fair_share_policy.value.share_decay_seconds
      dynamic "share_distribution" {
        for_each = fair_share_policy.value.share_distribution != null ? fair_share_policy.value.share_distribution : []
        content {
          share_identifier = share_distribution.value.share_identifier
          weight_factor    = share_distribution.value.weight_factor
        }
      }
    }
  }
}

