variable "env" {
  type        = string
  description = "The environment the blue and green ASG will be part of. Valid values are: 'production', 'staging', 'preview', and 'shared'"
}

variable "project" {
  type        = string
  description = "The name of the project this setup will be part of."
}

variable "project_id" {
  type        = string
  description = "The ID of the project this setup will be part of."
}

variable "deployment_type" {
  type        = string
  default     = "vm"
  description = "The deployment type the resources brought up by this module are part of."
}

variable "owner" {
  type        = string
  description = "The name of the owner for the blue and green ASG setups."
}

variable "end_date" {
  type        = string
  description = "The date the resources brought up should expire. Please format the date using the ISO-8601 format or use a '-' if the resources don't have an expiry date."
}

variable "vpc_id" {
  type        = string
  description = "The ID for the VPC the blue and green ASGs will be installed in."
}

variable "ssh_key_name" {
  type        = string
  description = "The SSH key (get list from the key pairs dashboard in the EC2 service page) to install in the instances brought up in this ASG."
}

variable "blue_ami" {
  type        = string
  description = "The ID for the AMI to use for the instances in the blue ASG."
}

variable "blue_asg_max_size" {
  type        = string
  description = "The maximum number of instances to bring up in the blue ASG."
}

variable "blue_asg_min_size" {
  type        = string
  description = "The minimum number of instances to bring up in the blue ASG."
}

variable "deploy_blue" {
  type        = bool
  default     = true
  description = "Whether to provision the blue ASG."
}

variable "green_ami" {
  type        = string
  description = "The ID for the AMI to use for the instances in the green ASG."
}

variable "green_asg_max_size" {
  type        = string
  description = "The maximum number of instances to bring up in the green ASG."
}

variable "green_asg_min_size" {
  type        = string
  description = "The minimum number of instances to bring up in the green ASG."
}

variable "deploy_green" {
  type        = bool
  default     = false
  description = "Whether to provision the green ASG."
}

variable "alb_bucket_name" {
  type        = string
  default     = ""
  description = "The name of the bucket to put the load balancer logs."
}

variable "alb_ssl_policy" {
  type        = string
  description = "The AWS TLS policy to associate with the load balancer."
  default     = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

variable "data_bucket_name" {
  type        = string
  default     = ""
  description = "Name of the data bucket to create for this ASG."
}

variable "iam_s3_user" {
  type        = string
  default     = ""
  description = "The IAM user to be given read and write access to this ASGs data bucket."
}

variable "create_certificate" {
  type        = number
  default     = 0
  description = "Whether to create an AWS managed TLS certificate for the load balancer. '0' is not, '1' is yes."
}

variable "route53_zone_name" {
  type        = string
  default     = ""
  description = "The Route 53 DNS zone to create the domain names to associate with the load balancer."
}

variable "service_domain" {
  type        = string
  description = "The main domain name to associate with the load balancer."
}

variable "iam_server_ssl_cert" {
  type        = string
  default     = ""
  description = "The IAM certificate name to attach to the load balancer. Set to a blank string if no certificate exists."
}

variable "instance_type" {
  type        = string
  description = "The type for the instances to be brought up by the blue and green ASGs."
}

variable "cnames" {
  type        = list(string)
  default     = []
  description = "The CNAMEs to associate with service_domain."
}

variable "cloudwatch_alarm_actions" {
  type        = list(string)
  description = "List of IDs for cloudwatch actions that should be fired when alarms are raised."
}

variable "deployed_app" {
  type        = string
  default     = "rapidpro"
  description = "The name of the deployed app."
}

variable "attached_volume_size" {
  type        = string
  description = "The size of the EBS volumes to attach to the EC2 instances behind the ASGs."
}

variable "data_bucket_region" {
  type        = string
  default     = "eu-west-1"
  description = "The region to place the data bucket. Defaults to eu-west-1."
}

variable "health_check_path" {
  type        = string
  default     = "/"
  description = "The path to hit to get the health status of the app."
}

variable "http_health_check_protocol" {
  default     = "HTTP"
  type        = string
  description = "The protocol to use for health checks."
}

variable "http_health_check_matcher" {
  type        = string
  default     = "200"
  description = "The HTTP status code that indicates a healthy host if HTTP port hit."
}

variable "https_health_check_matcher" {
  type        = string
  default     = "200"
  description = "The HTTP status code that indicates a healthy host if HTTPS port hit."
}

variable "redirect_paths" {
  default = []
  type = list(object({
    condition   = string
    host        = string
    path        = string
    status_code = string
    }
  ))
  description = "List of redirect rules to apply to the load balancer."
}

variable "create_route53_records" {
  type        = bool
  default     = true
  description = "Whether to attempt to create the Route 53 records associated with this ASG."
}

variable "create_s3_user" {
  type        = bool
  default     = false
  description = "Whether to attempt to create the IAM user for accessing the S3 bucket to be created in this module."
}

variable "create_s3_bucket" {
  type        = bool
  default     = false
  description = "Whether to attempt to create the S3 bucket to be created in this module."
}

variable "enable_alb_logs" {
  type        = bool
  default     = true
  description = "Whether to enable capturing ALB logs and sending them to S3."
}

variable "acm_certificate_domain" {
  type        = string
  default     = ""
  description = "The domain related to the ACM certificate to attach to the load balancer. Set to a blank string if no ACM certificate exists."
}

variable "alb_subnet_ids" {
  description = "Optional subnet IDs to attach the RapidPro Load balancer to. Set to empty list [] to attach to all subnets in the VPC. Note that each ALB can only be assigned to at least two subnets and at most one subnet per availability zone."
  type        = list(string)
  default     = []
}

variable "hosts_subnet_ids" {
  description = "Optional subnet IDs to attach the RapidPro hosts to. Set to empty list [] to attach to all subnets in the VPC."
  type        = list(string)
  default     = []
}

variable "asg_ssh_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks to allow SSH access to the EC2 instances brought up."
}

variable "asg_http_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks to allow SSH access to the EC2 instances brought up."
}

variable "asg_https_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "List of CIDR blocks to allow HTTP access to the EC2 instances brought up."
}

variable "compute_region" {
  type        = string
  description = "The region compute resources are brought up."
}

variable "ec2_instance_role" {
  type        = string
  description = "The name of the IAM role to attach to the EC2 instances."
  default     = "ec2-instances"
}

variable "target_group_port" {
  type        = number
  default     = 80
  description = "The port to hit in the EC2 instances brought up."
}

variable "target_group_protocol" {
  type        = string
  default     = "HTTP"
  description = "The protocol to use to hit the target_group_port."
}

variable "alb_logs_user_identifiers" {
  type        = list(string)
  description = "List of ARNs for users that are allowed to access the ALB logs from the S3 bucket set up."
  default = [
    "arn:aws:iam::127311923021:root", // us-east-1
    "arn:aws:iam::033677994240:root", // us-east-2
    "arn:aws:iam::027434742980:root", // us-west-1
    "arn:aws:iam::797873946194:root", // us-west-2
    "arn:aws:iam::985666609251:root", // ca-central-1
    "arn:aws:iam::054676820928:root", // eu-central-1
    "arn:aws:iam::156460612806:root", // eu-west-1
    "arn:aws:iam::652711504416:root", // eu-west-2
    "arn:aws:iam::009996457667:root", // eu-west-3
    "arn:aws:iam::897822967062:root", // eu-north-1
    "arn:aws:iam::754344448648:root", // ap-east-1
    "arn:aws:iam::582318560864:root", // ap-northeast-1
    "arn:aws:iam::600734575887:root", // ap-northeast-2
    "arn:aws:iam::383597477331:root", // ap-northeast-3
    "arn:aws:iam::114774131450:root", // ap-southeast-1
    "arn:aws:iam::783225319266:root", // ap-southeast-2
    "arn:aws:iam::718504428378:root", // ap-south-1
    "arn:aws:iam::507241528517:root", // sa-east-1
    "arn:aws:iam::048591011584:root", // us-gov-west-1*
    "arn:aws:iam::190560391635:root", // us-gov-east-1*
    "arn:aws:iam::638102146993:root", // cn-north-1**
    "arn:aws:iam::037604701340:root",
  ] // cn-northwest-1**
}
