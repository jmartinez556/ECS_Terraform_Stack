# ROUTE 53
resource "aws_route53_record" "dawn" {
  zone_id = var.hosted_zone_id
  name    = var.subdomain
  type    = var.record_type
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = false
  }
}
# ROUTE 53
resource "aws_route53_record" "dusk" {
  zone_id = var.hosted_zone_id
  name    = var.subdomain2
  type    = var.record_type
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = false
  }
}