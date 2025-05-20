#
#  Common settings required in various modules
#
variable "aws_settings" {
  type = map(string)
  description = "General settings required in various modules"
  default = {
    account_id = "149532386180"
    region = "eu-central-1"  # set this also in main.tf backend s3 region!
    stage = "development"
  }
}

variable "ctf_tags" {
  type = map(string)
  default = {
    creator = "initial_terraform"
    creatorUrl = "https://github.com/Hg347/ctf-rush"
    project = "ctf-rush"
    environment = "Development"
    context = "terraform"
    purpose = "initial setup"
  }
}