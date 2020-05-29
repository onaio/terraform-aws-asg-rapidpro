## Terraform - RapidPro Auto Scaling Group Module for AWS [![Build Status](https://travis-ci.org/onaio/terraform-aws-asg-rapidpro.svg?branch=master)](https://travis-ci.org/onaio/terraform-aws-asg-rapidpro)

This module brings up a [RapidPro](https://app.rapidpro.io/) Auto Scaling Group deployment on AWS. It brings up two Auto Scaling Groups, blue and green, behind a single Application Load Balancer.

Check [variables.tf](./variables.tf) for a list of variables that can be set for this module.

## Requirements

This module imports the following modules:

1. [onaio/terraform-aws-asg-base](https://github.com/onaio/terraform-aws-asg-base)
1. [onaio/terraform-aws-asg-compute](https://github.com/onaio/terraform-aws-asg-compute)

## Note on IAM Role

If using this module with [sre-tooling](https://github.com/onaio/sre-tooling)(not mandatory), make sure the EC2 instances that are created using this module are attached to an IAM role (using the `ec2_instance_role` variable) that has the following permissions:

  - ec2:DeleteTags
  - ec2:CreateTags
  - All ec2:Describe* permissions

These permissions are needed by SRE Tooling to update the details of the tags of the instances from within the instances.
