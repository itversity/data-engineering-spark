# Setup Hadoop and Spark Lab using Terraform

As part of this module we have provided required terraform scripts to setup single node lab on AWS, GCP, and Azure. You can go to relevant folder to get the instructions related to setting up single node lab.

The scripts will take care of the following:
* Provision Ubuntu 20.04 Virtual Machine from underlying cloud provider.
* Setup Docker and Docker Compose
* Deploy Hadoop, Hive, and Spark using Docker along with other supporting components such as Postgres, Python, Jupyter, etc.
* You will also see the Public IP of the server using which you will be able to access jupyter based lab.
