### GENERATE OUTPUTS

output "alb_fqdn" {
  description = "FQDN of the ALB"
  value = aws_lb.app.dns_name
}