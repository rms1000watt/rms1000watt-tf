terragrunt {
  terraform {
    // source = "git::git@github.com:rms1000watt/rms1000watt-tf//apps/website?ref=0.1.0"
    source = "../../../../apps/website"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}

domain_name = "rms1000watt.com"

route53_zone_id = "Z2Y6QFXZWKU10Y"
