🚀 Project: Deploy a Scalable WordPress Website on AWS using Terraform
📌 Project Overview
This project demonstrates how to deploy a highly available and scalable WordPress website on AWS using Terraform. The architecture leverages key AWS services to ensure performance, availability, and security.

🔧 Technologies Used
Terraform

AWS EC2

RDS (MySQL)

Application Load Balancer (ALB)

Auto Scaling Group (ASG)

Custom VPC with Public and Private Subnets

🧱 Architecture Highlights
Custom VPC with segregated public/private subnets for security and isolation.

EC2 Instances in an Auto Scaling Group to host the WordPress application.

RDS MySQL for WordPress database, deployed in private subnets.

Application Load Balancer (ALB) to distribute incoming HTTP traffic.

User-data scripts to automatically install and configure WordPress with a pre-selected theme/template.

🌐 WordPress Theme
A pre-built WordPress theme/template was used instead of a blank installation, ensuring a more complete and visually appealing deployment.
