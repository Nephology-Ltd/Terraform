provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

resource "aws_security_group" "allow_puppet_RDP" {
  name = "allow_puppet_RDP"
  description = "Allow Puppet and RDP"

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
      from_port = 8140 
      to_port = 8140
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  
   ingress {
      from_port = 61613
      to_port = 61613
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  
   ingress {
      from_port = 3389
      to_port = 3389
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
 
}


resource "aws_instance" "win-pup" {
    ami                         = "ami-9ebb39ed"
    region                      = "${var.region}"
    instance_type               = "t2.micro"
    key_name                    = "${var.keypair_name}"
    security_groups             = ["aws_security_group.allow_puppet_RDP.id"]

    user_data = <<EOF
    <powershell>
        $MsiUrl = "https://downloads.puppetlabs.com/windows/puppet-agent-x64-latest.msi"
        $install_args = @("/qn","/norestart","/i",$MsiUrl,"PUPPET_MASTER_SERVER=${var.puppet_master}")
        Start-Process -FilePath msiexec.exe -ArgumentList $install_args -Wait -PassThru
    </powershell>
    EOF

    tags {
        Name = "Windows-Puppet"
    }
}

