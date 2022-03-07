# Data Engineering Spark
This is ITVersity repository to provide appropriate single node hands on lab for students to learn skills such as Python, SQL, Hadoop, Hive, and Spark. This is extensively used as part of our Udemy courses as well as our upcoming guided programs. You can also use our [state-of-the-art](https://labs.itversity.com) multi-node Hadoop and Spark lab.

## Udemy Courses

This GitHub repository can be leveraged to setup Single Node Hadoop and Spark Cluster along with Jupyterlab and Postgres to learn Python, SQL, Hadoop, Hive, and Spark which are covered as part of the below Udemy courses. They are available at a max of $25 and we provide $10 coupons 3 times every month. Also, these courses are part of Udemy for business.
* [Data Engineering Essentials Hands-on - Python, SQL, and Spark](https://www.udemy.com/course/data-engineering-essentials-sql-python-and-spark/?referralCode=EEF55B4668DA42F6154D)
* [Spark SQL and Pyspark 2 or Pyspark 3](https://www.udemy.com/course/cca-175-spark-and-hadoop-developer-python-pyspark/?referralCode=86C8942891469FD0AD6D)

##### Receive Udemy Course Coupons by filling [ITVersity Course Coupons - Github Data Engineering Spark Repository](https://forms.gle/p9jE3nT5r2XU1cVX6) form

## Technologies Covered

As part of this custom image built by us, we have included the following.
* Hadoop (HDFS, YARN, and Map Reduce)
* Hive
* Spark 2
* Spark 3
* Jupyter based environment
* If you set up the environment as instructed as part of our courses then you will also get the data sets as well as material in the form of Jupyter Notebooks.

For all video lectures, up-to-date material, live support - feel free to sign up for our Udemy courses or our upcoming guided programs.

## Setup Python and SQL Lab

### Pre-requisites

Here are the pre-requisites to setup the Python and SQL lab.
* Memory: 8 GB RAM
* CPU: At least Quadcore
* If you are using Windows or Mac, make sure to setup Docker Desktop.
* If your system does not meet the requirement, you need to setup environment using AWS Cloud9.
* Even if you have 16 GB RAM and the Quadcore CPU, the system might slow down over the usage. You can always using AWS Cloud9 as fallback option.

### Configure Docker Desktop

If you are using Windows or Mac, you need to change the settings to use as much resources as possible.
* Go to Docker Desktop preferences.
* Change memory to 4 GB.
* Change CPUs to the maximum number.

### Clone Repository

Here are the steps one need to follow to setup the lab.
* Clone the repository by running `git clone https://github.com/itversity/data-engineering-spark`.

### Start Environment

Here are the steps to start the environment.
* Run `docker-compose up -d --build itvdflab`.
* It will set up environment with Jupyter Lab and Postgresql. You can validate by running `docker-compose ps`.
* You can run `docker-compose logs -f` to review the progress.
* You can stop the environment using `docker-compose stop` command.

### Access the Lab

Here are the steps to access the lab.
* Make sure both Postgres and Jupyter Lab containers are up and running by using `docker-compose ps`
* Get the token from the Jupyter Lab container using below command.

```shell
docker-compose exec itvdflab \
  sh -c "cat .local/share/jupyter/runtime/jpserver-*.json"
```

* Use the token to login using [http://localhost:8888/lab](http://localhost:8888/lab)

### Access Python and SQL Material

Once you login, you should be able to go through the first major module under **itversity-material** to access the content.

## Setup Hadoop and Spark Lab

### Pre-requisites

Here are the pre-requisites to setup the lab.
* Memory: 16 GB RAM
* CPU: At least Quadcore
* If you are using Windows or Mac, make sure to setup Docker Desktop.
* If your system does not meet the requirement, you need to setup environment using AWS Cloud9.
* Even if you have 16 GB RAM and the Quadcore CPU, the system might slow down once we start the docker containers due to the requirements of the resources. You can always use AWS Cloud9 as fallback option.
* In my case, I will be demonstrating using Cloud9.

### Configure Docker Desktop

If you are using Windows or Mac, you need to change the settings to use as much resources as possible.
* Go to Docker Desktop preferences.
* Change memory to 12 GB.
* Change CPUs to the maximum number.

### Setup Environment

Here are the steps one need to follow to setup the lab.
* Clone the repository by running `git clone https://github.com/itversity/data-engineering-spark`.

### Delete Python and SQL Environment

Hadoop and Spark require more horse power. Also, there is no need to keep containers related to Python and SQL up and running while going through Hadoop and Spark material.
* We can tear down containers related to Python and SQL by running below command.

```shell
docker-compose rm -v itvdflab
docker-compose rm -v pg.itversity.com
```

### Pull the Image

Hadoop and Spark image is quite big. It is close to 1.5 GB.
* Make sure to pull it before running `docker-compose` command to setup the lab.
* You can pull the image using `docker pull itversity/itvdelab`.
* You can validate if the image is successfully pulled or not by running `docker images` command.

### Start Environment

Here are the steps to start the environment.
* Run `docker-compose up -d --build itvdelab`.
* It will set up single node Hadoop, Hive and Spark Environment along with metastore for hive.
* You can run `docker-compose logs -f itvdelab` to review the progress. It will take some time to complete the setup process.
* You can stop the environment using `docker-compose stop` command.

### Access the Lab

Here are the steps to access the lab.
* Make sure both Postgres and Jupyter Lab containers are up and running by using `docker-compose ps`
* Get the token from the Jupyter Lab container using below command.

```shell
docker-compose exec itvdelab \
  sh -c "cat .local/share/jupyter/runtime/jpserver-*.json"
```

* Use the token to login using [http://localhost:8888/lab](http://localhost:8888/lab)

### Access Hadoop and Pyspark Material

Once you login, you should be able to go through the third major module under **itversity-material** to access the content.
