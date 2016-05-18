##Bootstrapping Puppet onto AWS Windows Instances

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

*INSTALLDIR
*PUPPET_MASTER_SERVER
*PUPPET_CA_SERVER
*PUPPET_AGENT_CERTNAME
*PUPPET_AGENT_ENVIRONMENT
*PUPPET_AGENT_STARTUP_MODE
*PUPPET_AGENT_ACCOUNT_USER
*PUPPET_AGENT_ACCOUNT_PASSWORD
*PUPPET_AGENT_ACCOUNT_DOMAIN


Please see the [Puppet documentation](https://docs.puppet.com/puppet/latest/reference/install_windows.html#msi-properties) for more information on these.

