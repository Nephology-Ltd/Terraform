provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

resource "aws_instance" "win-choc" {
    ami                         = "ami-9ebb39ed"
    region                      = "${var.region}"
    instance_type               = "t2.micro"
    key_name                    = "${var.keypair_name}"
    
    user_data = <<EOF
    <powershell>

    </powershell>
    EOF
    tags {
        Name = "Windows-Chocolatey"
    }
}
