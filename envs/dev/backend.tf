terraform {
    backend "s3" {
        bucket = "clapp-tf-state-dev20250106214054559800000001"
        key = "terraform.tfstate"
        region = "us-east-1"
    }
}