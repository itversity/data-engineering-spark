# Data Engineering Spark

## Setup Lab

### Pre-requisites

Here are the pre-requisites to setup the lab.
* Memory: 16 GB RAM
* CPU: At least Quadcore
* If you are using Windows or Mac, make sure to setup Docker Desktop.
* If your system does not meet the requirement, you need to setup environment using AWS Cloud9.
* Even if you have 16 GB RAM and the Quadcore CPU, the system might slow down over the usage. You can always using AWS Cloud9 as fallback option.

### Configure Docker Desktop

If you are using Windows or Mac, you need to change the settings to use as much resources as possible.
* Go to Docker Desktop preferences.
* Change memory to 12 GB.
* Change CPUs to the maximum number.

### Setup Environment

Here are the steps one need to follow to setup the lab.
* Clone the repository by running `git clone https://github.com/itversity/data-engineering-spark`.
* Create folder by name **cluster_util_db_volume**. It is required to take the back up of the changes in the postgres database.
* The above folder is included in **docker-compose.yaml** as mount point to the **cluster_util_db**.

### Start Environment

Here are the steps to start the environment.
* Run `docker-compose up -d --build`.
* It will set up single node Hadoop, Hive and Spark Environment along with metastore for hive.
* You can run `docker-compose logs -f` to review the progress.
* You can stop the environment using `docker-compose stop` command.
