##Bootstrapping Puppet onto AWS and Azure Windows Instances

```
resource "aws_instance" "win-pup" {
    ami                         = "<WINDOWS AMI>"
    instance_type               = "<AWS INSTANCE TYPE>"
    key_name                    = "<YOUR KEY PAIR NAME>"
    security_groups             = ["<YOUR SECURITY GROUP ID>"]

    user_data = <<EOF
    <powershell>
        $MsiUrl = "https://downloads.puppetlabs.com/windows/puppet-agent-x64-latest.msi"
        $install_args = @("/qn","/norestart","/i",$MsiUrl,"PUPPET_MASTER_SERVER=<YOUR SERVER PATH>")
        Start-Process -FilePath msiexec.exe -ArgumentList $install_args -Wait -PassThru
    </powershell>
    EOF
    
    tags {
        Name = "Windows-Puppet"
    }
}
```
