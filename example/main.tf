data "aws_caller_identity" "current" {}
module "tags" {
  source  = "sourcefuse/arc-tags/aws"
  version = "1.2.3"

  environment = var.environment
  project     = var.namespace

  extra_tags = {
    MonoRepo     = "True"
    MonoRepoPath = "terraform/kms"
  }
}


module "kms" {
  source                  = "sourcefuse/arc-kms/aws"
  version                 = "1.0.0" // use the latest version from registry.
  enabled                 = var.enabled
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  alias                   = var.alias
  tags                    = module.tags.tags
  policy                  = local.kms_policy
}
