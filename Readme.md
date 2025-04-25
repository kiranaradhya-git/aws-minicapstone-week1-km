

### Pre- Requisites

- Install Packer on Windows Server
- Set the Variables for AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY

Below are the commands for setting values in the PowerShell Window

```
Set-Variable -name AWS_ACCESS_KEY_ID -value XXXXXXXXXXXXXXXXXXXXXXXX
Set-Variable -name AWS_SECRET_ACCESS_KEY -value YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY
```

Refer to https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/set-variable?view=powershell-7.5 for setting variables in PowerShell 

### 1. Create the configuration file for Packer to create an AMI with Terraform

This creates an Amazon Linux AMI with Terraform installed.

Create a HCL file for configuring all the parameters and save it as "aws-linux-terraform.pkr.hcl" [Packer Configuration File](https://github.com/kiranaradhya-git/aws-minicapstone-week1-km/blob/main/TerraformEnvironment/aws-linux-terraform.pkr.hcl)

```
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "linux" {
  ami_name      = "Terraform-Environment"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-ebs"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
}

build {
  name = "terraform-env"
  sources = [
    "source.amazon-ebs.linux"
  ]

  provisioner "shell" {
    inline = [
      "echo Installing Terrform",
      "sleep 30",
      "sudo yum install -y yum-utils",
      "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo",
      "sudo yum -y install terraform",
      "terraform -v",
    ]
  }

  provisioner "shell" {
    inline = ["echo This provisioner installed Terraform"]
  }
}

```



**Execute the packer commands (In the same PowerShell Window where you set the Environment)**

- Run the below command to create the machine image

 - Initialize Packer
```
packer.exe init . 
```


- Format 
```
packer.exe fmt .
```


 - Vaildate
```
packer.exe validate .
```

- Build
```
packer.exe build aws-linux-terraform.pkr.hcl
```



### 2. Verify the AMI

After successful execution, the new AMI will be available in the AWS EC2 AMI Dashboard.


![image](https://github.com/user-attachments/assets/4cefa789-f33d-4844-913e-6d5ef71a043e)





### **Provision EC2 Instance using the AMI to use your Terraform Environment**



Create following Terraform files

main.tf provider.tf  

#####  

1. Initialize Terraform

```
terraform init
```



2. If no errors run plan

   ```
   terraform plan
   ```

   

3.  Make sure you have no errors. If you do, fi x them. It should tell you that one resource will be added and none will be deleted or changed. Enter the following to deploy your virtual machine.

```
terraform apply -auto-approve
```



In the AWS console, from the navigation menu, select EC2. You should see your machine starting.



![image](https://github.com/user-attachments/assets/538d04fb-e89a-4edd-a7bf-d700ca278665)

### 3. Testing if Terraform is Installed and working fine

***3.1 Run following command to test Terrafom in installed***

```
terraform -v
```

![image](https://github.com/user-attachments/assets/36d4ff8a-b3af-4dea-8a57-649c1398246b)

#### 3.2 Test Provision Simple AWS Virtual Machine

***a. Clone the below Github Repo on to Newly deployed Terraform Host***



```
 git clone https://github.com/kiranaradhya-git/aws-minicapstone-week1-km.git
```

 ```
 cd aws-minicapstone-week1-km/3-Testing/
 ```



***b. Run Terraform commands to do Tes Virtual Machines***

   ```
     terraform init
   ```

      terrfrom plan

```
  terrafom apply -auto-approve
```



You should see the VM created with the name **" Terraform-Test Provision"** under EC2 in AWS Console 

![image](https://github.com/user-attachments/assets/e609a7b6-4243-4c47-92f6-8537c4d1771b)

### 4. Web Site With Modules

***a. Clone the below Github Repo on to Newly deployed Terraform Host***



```
 git clone https://github.com/kiranaradhya-git/aws-minicapstone-week1-km.git
```

 ```
 cd aws-minicapstone-week1-km/4-wesite-with-modules/kiran-muddaiah-website
 ```



***b. Run Terraform commands to do Tes Virtual Machines***

   ```
     terraform init
   ```

      terrfrom plan

```
  terrafom apply -auto-approve
```



***c. Verify the website build***

![image](https://github.com/user-attachments/assets/622c2399-8510-4df0-998f-de1edab1188e)




---


## Optional References


### Packer Execution Logs

```
==> Builds finished but no artifacts were created.
PS C:\Tools\week1capstone\aws-minicapstone-week1-km>  C:\Tools\packer.exe build aws-linux-terraform.pkr.hcl
terraform-env.amazon-ebs.linux: output will be in this color.

==> terraform-env.amazon-ebs.linux: Prevalidating any provided VPC information
==> terraform-env.amazon-ebs.linux: Prevalidating AMI Name: Terraform-Environment
    terraform-env.amazon-ebs.linux: Found Image ID: ami-016ce30738b9def70
==> terraform-env.amazon-ebs.linux: Creating temporary keypair: packer_680b6d8e-9de5-7cb4-fd64-0d2dfe4b3335
==> terraform-env.amazon-ebs.linux: Creating temporary security group for this instance: packer_680b6d93-1f9a-cf5c-2600-ad3caa59376e
==> terraform-env.amazon-ebs.linux: Authorizing access to port 22 from [0.0.0.0/0] in the temporary security groups...
==> terraform-env.amazon-ebs.linux: Launching a source AWS instance...
    terraform-env.amazon-ebs.linux: Instance ID: i-053a4b63e3864b833
==> terraform-env.amazon-ebs.linux: Waiting for instance (i-053a4b63e3864b833) to become ready...
==> terraform-env.amazon-ebs.linux: Using SSH communicator to connect: 3.95.189.141
==> terraform-env.amazon-ebs.linux: Waiting for SSH to become available...
==> terraform-env.amazon-ebs.linux: Connected to SSH!
==> terraform-env.amazon-ebs.linux: Provisioning with shell script: C:\Users\KMUDDA~1\AppData\Local\Temp\packer-shell3189677779
    terraform-env.amazon-ebs.linux: Installing Terrform
    terraform-env.amazon-ebs.linux: Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
    terraform-env.amazon-ebs.linux: Package yum-utils-1.1.31-46.amzn2.0.1.noarch already installed and latest version
    terraform-env.amazon-ebs.linux: Nothing to do
    terraform-env.amazon-ebs.linux: Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
    terraform-env.amazon-ebs.linux: adding repo from: https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    terraform-env.amazon-ebs.linux: grabbing file https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo to /etc/yum.repos.d/hashicorp.repo
    terraform-env.amazon-ebs.linux: repo saved to /etc/yum.repos.d/hashicorp.repo
    terraform-env.amazon-ebs.linux: Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
    terraform-env.amazon-ebs.linux: Resolving Dependencies
    terraform-env.amazon-ebs.linux: --> Running transaction check
    terraform-env.amazon-ebs.linux: ---> Package terraform.x86_64 0:1.11.4-1 will be installed
    terraform-env.amazon-ebs.linux: --> Processing Dependency: git for package: terraform-1.11.4-1.x86_64
    terraform-env.amazon-ebs.linux: --> Running transaction check
    terraform-env.amazon-ebs.linux: ---> Package git.x86_64 0:2.47.1-1.amzn2.0.2 will be installed
    terraform-env.amazon-ebs.linux: --> Processing Dependency: git-core = 2.47.1-1.amzn2.0.2 for package: git-2.47.1-1.amzn2.0.2.x86_64
    terraform-env.amazon-ebs.linux: --> Processing Dependency: git-core-doc = 2.47.1-1.amzn2.0.2 for package: git-2.47.1-1.amzn2.0.2.x86_64
    terraform-env.amazon-ebs.linux: --> Processing Dependency: perl-Git = 2.47.1-1.amzn2.0.2 for package: git-2.47.1-1.amzn2.0.2.x86_64
    terraform-env.amazon-ebs.linux: --> Processing Dependency: perl(Git) for package: git-2.47.1-1.amzn2.0.2.x86_64
    terraform-env.amazon-ebs.linux: --> Processing Dependency: perl(Term::ReadKey) for package: git-2.47.1-1.amzn2.0.2.x86_64
    terraform-env.amazon-ebs.linux: --> Running transaction check
    terraform-env.amazon-ebs.linux: ---> Package git-core.x86_64 0:2.47.1-1.amzn2.0.2 will be installed
    terraform-env.amazon-ebs.linux: ---> Package git-core-doc.noarch 0:2.47.1-1.amzn2.0.2 will be installed
    terraform-env.amazon-ebs.linux: ---> Package perl-Git.noarch 0:2.47.1-1.amzn2.0.2 will be installed
    terraform-env.amazon-ebs.linux: --> Processing Dependency: perl(Error) for package: perl-Git-2.47.1-1.amzn2.0.2.noarch
    terraform-env.amazon-ebs.linux: ---> Package perl-TermReadKey.x86_64 0:2.30-20.amzn2.0.2 will be installed
    terraform-env.amazon-ebs.linux: --> Running transaction check
    terraform-env.amazon-ebs.linux: ---> Package perl-Error.noarch 1:0.17020-2.amzn2 will be installed
    terraform-env.amazon-ebs.linux: --> Finished Dependency Resolution
    terraform-env.amazon-ebs.linux:
    terraform-env.amazon-ebs.linux: Dependencies Resolved
    terraform-env.amazon-ebs.linux:
    terraform-env.amazon-ebs.linux: ================================================================================
    terraform-env.amazon-ebs.linux:  Package              Arch       Version                   Repository      Size
    terraform-env.amazon-ebs.linux: ================================================================================
    terraform-env.amazon-ebs.linux: Installing:
    terraform-env.amazon-ebs.linux:  terraform            x86_64     1.11.4-1                  hashicorp       27 M
    terraform-env.amazon-ebs.linux: Installing for dependencies:
    terraform-env.amazon-ebs.linux:  git                  x86_64     2.47.1-1.amzn2.0.2        amzn2-core      57 k
    terraform-env.amazon-ebs.linux:  git-core             x86_64     2.47.1-1.amzn2.0.2        amzn2-core      11 M
    terraform-env.amazon-ebs.linux:  git-core-doc         noarch     2.47.1-1.amzn2.0.2        amzn2-core     3.2 M
    terraform-env.amazon-ebs.linux:  perl-Error           noarch     1:0.17020-2.amzn2         amzn2-core      32 k
    terraform-env.amazon-ebs.linux:  perl-Git             noarch     2.47.1-1.amzn2.0.2        amzn2-core      44 k
    terraform-env.amazon-ebs.linux:  perl-TermReadKey     x86_64     2.30-20.amzn2.0.2         amzn2-core      31 k
    terraform-env.amazon-ebs.linux:
    terraform-env.amazon-ebs.linux: Transaction Summary
    terraform-env.amazon-ebs.linux: ================================================================================
    terraform-env.amazon-ebs.linux: Install  1 Package (+6 Dependent packages)
    terraform-env.amazon-ebs.linux:
    terraform-env.amazon-ebs.linux: Total download size: 42 M
    terraform-env.amazon-ebs.linux: Installed size: 133 M
    terraform-env.amazon-ebs.linux: Downloading packages:
    terraform-env.amazon-ebs.linux: Public key for terraform-1.11.4-1.x86_64.rpm is not installed
==> terraform-env.amazon-ebs.linux: warning: /var/cache/yum/x86_64/2/hashicorp/packages/terraform-1.11.4-1.x86_64.rpm: Header V4 RSA/SHA256 Signature, key ID a621e701: NOKEY
    terraform-env.amazon-ebs.linux: --------------------------------------------------------------------------------
    terraform-env.amazon-ebs.linux: Total                                               60 MB/s |  42 MB  00:00
    terraform-env.amazon-ebs.linux: Retrieving key from https://rpm.releases.hashicorp.com/gpg
==> terraform-env.amazon-ebs.linux: Importing GPG key 0xA621E701:
==> terraform-env.amazon-ebs.linux:  Userid     : "HashiCorp Security (HashiCorp Package Signing) <security+packaging@hashicorp.com>"
==> terraform-env.amazon-ebs.linux:  Fingerprint: 798a ec65 4e5c 1542 8c8e 42ee aa16 fcbc a621 e701
==> terraform-env.amazon-ebs.linux:  From       : https://rpm.releases.hashicorp.com/gpg
    terraform-env.amazon-ebs.linux: Running transaction check
    terraform-env.amazon-ebs.linux: Running transaction test
    terraform-env.amazon-ebs.linux: Transaction test succeeded
    terraform-env.amazon-ebs.linux: Running transaction
    terraform-env.amazon-ebs.linux:   Installing : git-core-2.47.1-1.amzn2.0.2.x86_64                           1/7
    terraform-env.amazon-ebs.linux:   Installing : git-core-doc-2.47.1-1.amzn2.0.2.noarch                       2/7
    terraform-env.amazon-ebs.linux:   Installing : 1:perl-Error-0.17020-2.amzn2.noarch                          3/7
    terraform-env.amazon-ebs.linux:   Installing : perl-TermReadKey-2.30-20.amzn2.0.2.x86_64                    4/7
    terraform-env.amazon-ebs.linux:   Installing : perl-Git-2.47.1-1.amzn2.0.2.noarch                           5/7
    terraform-env.amazon-ebs.linux:   Installing : git-2.47.1-1.amzn2.0.2.x86_64                                6/7
    terraform-env.amazon-ebs.linux:   Verifying  : perl-TermReadKey-2.30-20.amzn2.0.2.x86_64                    1/7
    terraform-env.amazon-ebs.linux:   Verifying  : perl-Git-2.47.1-1.amzn2.0.2.noarch                           2/7
    terraform-env.amazon-ebs.linux:   Verifying  : 1:perl-Error-0.17020-2.amzn2.noarch                          3/7
    terraform-env.amazon-ebs.linux:   Verifying  : terraform-1.11.4-1.x86_64                                    4/7
    terraform-env.amazon-ebs.linux:   Verifying  : git-2.47.1-1.amzn2.0.2.x86_64                                5/7
    terraform-env.amazon-ebs.linux:   Verifying  : git-core-doc-2.47.1-1.amzn2.0.2.noarch                       6/7
    terraform-env.amazon-ebs.linux:   Verifying  : git-core-2.47.1-1.amzn2.0.2.x86_64                           7/7
    terraform-env.amazon-ebs.linux:
    terraform-env.amazon-ebs.linux: Installed:
    terraform-env.amazon-ebs.linux:   terraform.x86_64 0:1.11.4-1
    terraform-env.amazon-ebs.linux:
    terraform-env.amazon-ebs.linux: Dependency Installed:
    terraform-env.amazon-ebs.linux:   git.x86_64 0:2.47.1-1.amzn2.0.2
    terraform-env.amazon-ebs.linux:   git-core.x86_64 0:2.47.1-1.amzn2.0.2
    terraform-env.amazon-ebs.linux:   git-core-doc.noarch 0:2.47.1-1.amzn2.0.2
    terraform-env.amazon-ebs.linux:   perl-Error.noarch 1:0.17020-2.amzn2
    terraform-env.amazon-ebs.linux:   perl-Git.noarch 0:2.47.1-1.amzn2.0.2
    terraform-env.amazon-ebs.linux:   perl-TermReadKey.x86_64 0:2.30-20.amzn2.0.2
    terraform-env.amazon-ebs.linux:
    terraform-env.amazon-ebs.linux: Complete!
    terraform-env.amazon-ebs.linux: Terraform v1.11.4
    terraform-env.amazon-ebs.linux: on linux_amd64
==> terraform-env.amazon-ebs.linux: Provisioning with shell script: C:\Users\KMUDDA~1\AppData\Local\Temp\packer-shell2159236170
    terraform-env.amazon-ebs.linux: This provisioner installed Terraform
==> terraform-env.amazon-ebs.linux: Stopping the source instance...
    terraform-env.amazon-ebs.linux: Stopping instance
==> terraform-env.amazon-ebs.linux: Waiting for the instance to stop...
==> terraform-env.amazon-ebs.linux: Creating AMI Terraform-Environment from instance i-053a4b63e3864b833
    terraform-env.amazon-ebs.linux: AMI: ami-092ca7dcd8e147cd3
==> terraform-env.amazon-ebs.linux: Waiting for AMI to become ready...
==> terraform-env.amazon-ebs.linux: Skipping Enable AMI deprecation...
==> terraform-env.amazon-ebs.linux: Skipping Enable AMI deregistration protection...
==> terraform-env.amazon-ebs.linux: Terminating the source AWS instance...
==> terraform-env.amazon-ebs.linux: Cleaning up any extra volumes...
==> terraform-env.amazon-ebs.linux: No volumes to clean up, skipping
==> terraform-env.amazon-ebs.linux: Deleting temporary security group...
==> terraform-env.amazon-ebs.linux: Deleting temporary keypair...
Build 'terraform-env.amazon-ebs.linux' finished after 4 minutes 43 seconds.

==> Wait completed after 4 minutes 43 seconds

==> Builds finished. The artifacts of successful builds are:
--> terraform-env.amazon-ebs.linux: AMIs were created:
us-east-1: ami-092ca7dcd8e147cd3
```

