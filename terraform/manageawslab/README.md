# Manage Hadoop and Spark Lab on AWS using Terraform

As part of this module you will get all the required terraform based components to setup **Single Node Data Engineering Hadoop and Spark Lab on AWS using Docker**.

## Pre-requisites to setup Hadoop and Spark Lab on AWS using Terraform
Here are the pre-requisites to use this module to setup Single Node Hadoop and Spark Lab.
* Irrespective of the OS (Windows or Mac), you need to setup Terraform so that you can use this module to setup Hadoop and Spark Lab on AWS.
* Also you need to ensure that this repository is cloned.
* Make sure to have valid AWS Account.
* Go to AWS Web Console and then go to EC2 Dashboard to create EC2 Key Pair. Use **itvaws** as name to the Key Pair. It is hardcoded in our terraform script. Also, make sure you do not have passphrase associated with the Kay Pair.

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
Let us understand how to stop and start the ec2 instance where Single Node Hadoop and Spark Lab on AWS is setup using Terraform.

* Here are the commands to stop the ec2 instance. Make sure to stop when you want to take a break. You need to start from the **terraform/manageawslab** folder.
```
terraform output ec2_instance_id # Make sure to replace ec2_instance_id as part of stop_instance as well as start_instance
cd stopawslab
terraform apply \
  -target null_resource.stop_instance \
  -var ec2_instance_id="i-02e61d9f1fd6223ed" \
  -auto-approve
```
* Here are the commands to start the ec2 instance. Keep in mind that the public dns and ip addresses will be refreshed as we are not using static ip. You need to start from the **terraform/manageawslab** folder.
```
cd startawslab
terraform apply \
  -target null_resource.start_spark_lab \
  -var ec2_instance_id="i-02e61d9f1fd6223ed" \
  -auto-approve
terraform output ec2_public_dns
```
