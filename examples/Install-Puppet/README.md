###Bootstrapping Puppet onto AWS Windows Instances using Powershell

This example is for reference to bootstrapping Puppet onto a vanilla AWS EC2 Windows instance using powershell, as there are a lot of examples out there covering Linux and some covering the use of WinRm, Though the use of WinRm is a standard way of executing commands on a machine, I find the Powershell solution a little more straight forward as there is configure WinRm first.

The example expects that you already have :

An AWS active VPC with relevant subnets and security keys in place, the script examples will create security group inclduing RDP, though this is only required to valaidate the Puppet install, I highly recommend you amend the source cidr_blocks to your IP's.

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

There are a few MSI parameters you can pass in the argumanets list, these are

* INSTALLDIR
* PUPPET_MASTER_SERVER
* PUPPET_CA_SERVER
* PUPPET_AGENT_CERTNAME
* PUPPET_AGENT_ENVIRONMENT
* PUPPET_AGENT_STARTUP_MODE
* PUPPET_AGENT_ACCOUNT_USER
* PUPPET_AGENT_ACCOUNT_PASSWORD
* PUPPET_AGENT_ACCOUNT_DOMAIN


Please see the [Puppet documentation](https://docs.puppet.com/puppet/latest/reference/install_windows.html#msi-properties) for more information on these.

#### Note

You may want to cahnge the region, if so then ensure you change the AMI as well as these can differ between regions.
