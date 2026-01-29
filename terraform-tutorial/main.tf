provider "aws" {
  profile = "default"
  region = "ca-central-1"
}

# See the docs for this resource here
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# you can name the resource "app_server" or any name you like
resource "aws_instance" "app_server"{
  # Check here to see: AWS EC2 Console → Launch Instance → and check the AMI IDs shown for your region.
  # https://ca-central-1.console.aws.amazon.com/ec2/home?region=ca-central-1#LaunchInstances:
  ami = "ami-0a6dc9ac31a91b33c"
  # var comes from variables.tf
  instance_type = var.ec2_instance_type

  tags = {
    # var comes from variables.tf
    Name = var.instance_name
  }
}

# In order to run this, you have to 
# create an IAM user -> Add permission AmazonEC2FullAccess
# -> Create access key -> configure AWS CLI in local machine with 'aws configure' command
# Then run the following commands in terminal:
# terraform init
# terraform apply
# After this -> you'll be able to see an EC2 instance created in your AWS Console.
# To destroy the created resources, run:
# terraform destroy