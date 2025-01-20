terraform {
    backend "s3" {
        bucket = "clapp-tf-state-dev20250120175010721300000002"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}