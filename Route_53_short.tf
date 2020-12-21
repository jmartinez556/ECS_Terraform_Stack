resource "aws_route53_record" "record" {
  zone_id = var.hosted_zone_id
  name    = var.subdomain
  type    = var.record_type
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = false
  }
}
