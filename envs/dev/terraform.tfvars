#Project variables values
region      = "us-east-1"
environment = "dev"

#State variables values
table_name = "cloudapp-dev-tfstate-lock-table"

#VPC variables values
private_subnets = {
  "dev-private-subnet-01" = {
    cidr                    = "10.0.1.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = false
  },
  "dev-private-subnet-02" = {
    cidr                    = "10.0.2.0/24"
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = false
  }
}

public_subnets = {
  "dev-public-subnet-01" = {
    cidr                    = "10.0.3.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
  },
  "dev-public-subnet-02" = {
    cidr                    = "10.0.4.0/24"
    availability_zone       = "us-east-1b"
    map_public_ip_on_launch = true
  }
}

#EC2 variables values
ami_id = "ami-07593001243a00d0a"

ec2_instances = {
  "CloudApp-web1-dev" = {
    instance_type        = "t2.micro"
    availability_zone    = "us-east-1a"
    instance_description = "Web application"
    subnet_name          = "public-subnet-01"
    subnet_cidr          = "10.0.3.0/24"
    ip_host              = 4
  }
  "CloudApp-web2-dev" = {
    instance_type        = "t2.micro"
    availability_zone    = "us-east-1b"
    instance_description = "Web application"
    subnet_name          = "public-subnet-02"
    subnet_cidr          = "10.0.4.0/24"
    ip_host              = 5
  }
}

allow_firewall_rules = {
  "allow-http" = {
    protocol         = "tcp"
    ports            = ["80"]
    priority         = 1000
    description      = "Allow http communication."
    source_ip_ranges = ["0.0.0.0/0"]
  }
  "allow-https" = {
    protocol         = "tcp"
    ports            = ["443"]
    priority         = 1001
    description      = "Allow https communication."
    source_ip_ranges = ["0.0.0.0/0"]
  }
  "allow-ssh-vpn" = {
    protocol         = "tcp"
    ports            = ["22"]
    priority         = 1002
    description      = "Allow ssh communication via VPN."
    source_ip_ranges = ["0.0.0.0/0"]
  }
  "allow-icmp" = {
    protocol         = "icmp"
    priority         = 2000
    description      = "Allow ICMP."
    source_ip_ranges = ["0.0.0.0/0"]
  }
}

#RDS variables values
pub_subnets         = ["", ""]
db_instance_identifier = "dev-cloudapp-mysql-db"
allowed_ips            = [
    "<IP>/32",
    "<IP>/32"
]