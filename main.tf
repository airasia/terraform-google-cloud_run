resource "google_project_service" "gcr_api" {
  service            = "containerregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloud_run_api" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "compute_api" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_service_account_iam_member" "sa_user_user_groups" {
  # See https://cloud.google.com/run/docs/reference/iam/roles#additional-configuration
  for_each           = var.deployer_user_groups
  service_account_id = data.google_compute_default_service_account.default_gce_sa.name
  role               = "roles/iam.serviceAccountUser"
  member             = "group:${each.value}"
}

resource "google_service_account_iam_member" "sa_user_service_accounts" {
  # See https://cloud.google.com/run/docs/reference/iam/roles#additional-configuration
  for_each           = var.deployer_service_accounts
  service_account_id = data.google_compute_default_service_account.default_gce_sa.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${each.value}"
}

resource "google_project_iam_member" "deployer_user_groups" {
  # See https://cloud.google.com/run/docs/reference/iam/roles#additional-configuration
  for_each = var.deployer_user_groups
  role     = "roles/run.admin"
  member   = "group:${each.value}"
}

resource "google_project_iam_member" "deployer_service_accounts" {
  # See https://cloud.google.com/run/docs/reference/iam/roles#additional-configuration
  for_each = var.deployer_service_accounts
  role     = "roles/run.admin"
  member   = "serviceAccount:${each.value}"
}

data "google_compute_default_service_account" "default_gce_sa" {
  depends_on = [google_project_service.compute_api]
}
