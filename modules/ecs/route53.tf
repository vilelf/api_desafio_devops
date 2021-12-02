resource "aws_route53_record" "subdominio" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name = "api.fabricio.stdev.xyz"
  type = "CNAME"
  ttl = "300"
  records = [aws_alb.alb.dns_name]
}

data "aws_route53_zone" "zone" {
  name = "fabricio.stdev.xyz"
}