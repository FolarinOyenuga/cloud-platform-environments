```
resource "aws_iam_user" "ims_extractor_user" {
  name = "hmpps-manage-intelligence-preprod-extractor-user"
  path = "/system/hmpps-manage-intelligence-preprod-users/"
}

resource "aws_iam_access_key" "key_2023" {
  user = aws_iam_user.ims_extractor_user.name
}

data "aws_iam_policy_document" "ims_legacy_extractor_s3_policy" {
  statement {
    actions = ["s3:PutObject", "sqs:SendMessage"]

    resources = [
      module.manage_intelligence_extractor_bucket.bucket_arn,
      "${module.manage_intelligence_extractor_bucket.bucket_arn}/*",
      "${module.ims_extractor_queue.sqs_arn}"
    ]
  }

  statement {
    effect = "Deny"

    actions = ["s3:*"]

    resources = [
      module.hmpps_pin_phone_monitor_document_s3_bucket.bucket_arn,
      "${module.hmpps_pin_phone_monitor_document_s3_bucket.bucket_arn}/*"
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_iam_user_policy" "ims_extractor_policy" {
  name   = "hmpps-manage-intelligence-legacy-extracto-policy-preprod"
  policy = data.aws_iam_policy_document.ims_legacy_extractor_s3_policy.json
  user   = aws_iam_user.ims_extractor_user.name
}

resource "kubernetes_secret" "ims_legacy_extractor_user" {
  metadata {
    name      = "ims-extractor-user-preprod"
    namespace = var.namespace
  }

  data = {
    arn               = aws_iam_user.ims_extractor_user.arn
    access_key_id     = aws_iam_access_key.key_2023.id
    secret_access_key = aws_iam_access_key.key_2023.secret
  }
}
```