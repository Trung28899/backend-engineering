provider "aws" {
  profile = "default"
  region = "ca-central-1"
}

# See the docs for this provider here
# 
resource "aws_instance" "app_server"{
  # Check here to see: AWS EC2 Console → Launch Instance → and check the AMI IDs shown for your region.
  # https://ca-central-1.console.aws.amazon.com/ec2/home?region=ca-central-1#LaunchInstances:
  ami = "ami-0a6dc9ac31a91b33c"
  instance_type = "t2.micro"

  tags = {
    Name = "MyTerraformInstance"
  }
}