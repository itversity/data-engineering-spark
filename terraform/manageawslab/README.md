# Manage Hadoop and Spark Lab on AWS using Terraform

As part of this module you will get all the required terraform based components to setup **Single Node Data Engineering Hadoop and Spark Lab on AWS using Docker**.

## Pre-requisites to setup Hadoop and Spark Lab on AWS using Terraform
Here are the pre-requisites to use this module to setup Single Node Hadoop and Spark Lab.
* Irrespective of the OS (Windows or Mac), you need to setup Terraform so that you can use this module to setup Hadoop and Spark Lab on AWS.
* Also you need to ensure that this repository is cloned.

## Steps to Setup Single Node Hadoop and Spark Lab on AWS using Terraform
Once terraform is installed you can go to this folder and perform following steps to Setup Single Node Hadoop and Spark Lab on AWS using Terraform.
* Initialize Terraform so that other Terraform commands can be run using `terraform init`.
* Run the below command to setup Single Node Hadoop and Spark Lab on AWS using Terraform. This will take few minutes to setup the required components for single node hadoop and spark on AWS and also start them.

```
terraform apply \
  -target aws_instance.deessentials \
  -var instance_type="m2.2xlarge" \
  -auto-approve
```

* Following are the tasks that will be performed when the above command is run.
  * Provision Ubuntu based VM using m2.2xlarge configuration.
  * Install Docker, Docker Compose and other required components.
  * Pull custom ITVersity docker image for single node hadoop and spark.
  * Create and run required docker containers for Hadoop, Hive Metastore, Spark, Jupyter, etc.

## Steps to Destroy Single Node Hadoop and Spark Lab on AWS using Terraform
At any point in time you can run `terraform destroy -auto-approve` to clean up most of the components used for this lab.

## Manage Single Node Hadoop and Spark Lab on AWS using Terraform

terraform output aws_instance.deessentials.public_dns
terraform apply \
  -target null_resource.stop_instance \
  -var ec2_instance_id="i-0440a6b38cdb676d0" \
  -var ec2_public_dns=ec2-34-200-220-125.compute-1.amazonaws.com
