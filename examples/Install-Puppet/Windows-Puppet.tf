provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "${var.region}"
}

resource "aws_instance" "win-pup" {
    ami                         = "ami-9ebb39ed"
    region                      = "${var.region}"
    instance_type               = "t2.micro"
    key_name                    = "${var.keypair_name}"
    security_groups             = ["${var.security_group_id}"]

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

