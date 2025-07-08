# 🚀 3-Tier Infrastructure Deployment Using Terraform Modules

## Introduction

 In this project, we follow Infrastructure as Code (IaC) principles to define, manage, and deploy infrastructure and application components in an automated and repeatable way.
   
The architecture is structured into three tiers:
1)Web Tier – Handles incoming traffic using NGINX as a reverse proxy.
2)App Tier – Processes backend logic using PHP.
3)Database Tier – Stores application data using Amazon RDS (Relational Database Service).

We use Terraform to provision the entire infrastructure, including VPC, subnets, security groups, EC2 instances, and RDS.
To organize reusable and maintainable code, we use Terraform modules for each layer.
We also leverage Terraform provisioners (such as remote-exec) to automatically install and configure required software like NGINX and PHP on EC2 instances after launch.

---

##  Tools Used

| Tool         | Purpose                        |
|--------------|--------------------------------|
| Terraform    | Infrastructure provisioning   |
| AWS EC2      | Compute instances              |
| AWS RDS      | Managed MySQL DB               |
| AWS VPC      | Networking and isolation       |

---

##  Architecture Overview

### 1️) Web Tier
- Deployed in public subnets
- EC2 instances with a web server (Apache/Nginx)
- Accessible via HTTP/HTTPS and SSH

### 2️) Application Tier
- Deployed in private subnets
- EC2 instances running backend services (e.g., PHP/Python/Node.js)
- Communicates only with Web Tier and DB Tier
- No direct internet access

### 3️) Database Tier
- Deployed in private subnets
- Amazon RDS MySQL
- Accessible only from Application Tier

---


##  Security Groups

| Layer         | Inbound Access From               |
|---------------|-----------------------------------|
| Web Tier      | HTTP/HTTPS/SSH from internet      |
| App Tier      | Custom port (e.g., 8080) from Web |
| Database Tier | MySQL (3306) from App Tier        |

---

##  Project Structure


 3-Tier_Architecture/
├── main.tf               
├── variables.tf         
├── outputs.tf            
├── terraform.tfvars      
├── modules/
      ├── vpc/ 
             ├── main.tf
             ├── variable.tf
      ├── web/  
             ├── main.tf
             ├── variable.tf
      ├── app/              
             ├── main.tf
             ├── variable.tf
      ├── db/               
             ├── main.tf
             ├── variable.tf
      |── security/         
             ├── main.tf
             ├── variable.tf


---

##  Setup Instructions (Using EC2 instance)

 1. Launch server
       - Launch an EC2 instance with Ubuntu OS from the AWS Console.
       - Create and download a .pem SSH key pair.
       - Allow port 22 (SSH) in the security group for secure remote access.  

 2. Open in VS Code
      Go on terraform official website and get command to install terraform in your server


 3. Create folders/files
    Create the following root files:
        - main.tf
        - variables.tf
        - outputs.tf
        - terraform.tfvars
    Inside 3-tier-terraform, create a folder named modules. Inside modules, create following directories:
         - vpc
         - web
         - app
         - db
         - security
Each module folder should contains its own main.tf and variable.tf files

4.  Initialize & Deploy Terraform
       - terraform init
       - terraform plan
       - terraform apply


##  Output Values

* Public IP of Web EC2 instance
* Private IPs of App EC2 instance
* RDS MySQL endpoint
* Subnet and VPC IDs

---


##  



Verify AWS Console to ensure all resources are removed.

---

## 📈 Benefits of Modular Terraform

* 🔍 **Clarity** – Separation of concerns improves maintainability
* ♻️ **Reusability** – Modules can be reused in different environments
* 📏 **Consistency** – Predictable and parameterized deployments
* 🚀 **Scalability** – Easy to add/remove components
* 🤖 **Automation** – Full IaC workflow

---

## 🧪 Future Enhancements

* Add ALB for Web Tier
* Enable Auto Scaling Groups
* Use Secrets Manager or SSM for DB credentials
* Enable HTTPS via ACM
* Add CloudWatch for logging and monitoring
* Use remote backend with S3 & DynamoDB

---

## ✅ Conclusion

This project provides a **modular, secure, and scalable** AWS infrastructure using Terraform. It is a strong base for production-ready applications and can easily be extended for high availability, automation, and DevOps pipelines.

---

**Author**: [Swatiz-cloud](https://github.com/Swatiz-cloud)
📌 *Feel free to fork and contribute!*

