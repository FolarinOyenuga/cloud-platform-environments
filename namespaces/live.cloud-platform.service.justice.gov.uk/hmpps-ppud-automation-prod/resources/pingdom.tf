resource "pingdom_check" "ppud_automation_api_health" {
  type                     = "http"
  name                     = "ppud-automation-api /health - PROD"
  host                     = "ppud-automation-api.hmpps.service.justice.gov.uk"
  resolution               = 1
  notifywhenbackup         = true
  sendnotificationwhendown = 6
  notifyagainevery         = 0
  url                      = "/health"
  encryption               = true
  port                     = 443
  tags                     = "hmpps,make-recall-decision,isproduction_true,cloudplatform-managed"
  probefilters             = "region:EU"
  integrationids           = [121586]
}
