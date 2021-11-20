#!/bin/bash -x

sudo service ssh start

if [ ! -e /opt/.initialized ]
then
  sudo touch /opt/.initialized
  tar xzf /home/itversity/softwares/hadoop-3.3.0.tar.gz -C /home/itversity/softwares
  rm -f /home/itversity/softwares/hadoop-3.3.0.tar.gz
  sudo mv -f /home/itversity/softwares/hadoop-3.3.0 /opt
  sudo chown ${USER}:${USER} -R /opt/hadoop-3.3.0
  sudo ln -s /opt/hadoop-3.3.0 /opt/hadoop
  cp -rf configs/opt/hadoop/etc/hadoop/* /opt/hadoop/etc/hadoop/.
  cp -f configs/.profile /home/itversity/.profile
  . ~/.profile
  /opt/hadoop/bin/hdfs namenode -format
  tar xzf /home/itversity/softwares/apache-hive-3.1.2-bin.tar.gz -C /home/itversity/softwares
  rm -f /home/itversity/softwares/apache-hive-3.1.2-bin.tar.gz
  sudo mv -f /home/itversity/softwares/apache-hive-3.1.2-bin /opt
  sudo chown ${USER}:${USER} -R /opt/apache-hive-3.1.2-bin
  sudo ln -s /opt/apache-hive-3.1.2-bin /opt/hive
  cp -rf configs/opt/hive/conf/* /opt/hive/conf/.
  rm /opt/hive/lib/guava-19.0.jar
  cp /opt/hadoop/share/hadoop/hdfs/lib/guava-27.0-jre.jar /opt/hive/lib/
  schematool -dbType postgres -initSchema
  tar xzf /home/itversity/softwares/spark-2.4.8-bin-hadoop2.7.tgz -C /home/itversity/softwares
  rm -rf /home/itversity/softwares/spark-2.4.8-bin-hadoop2.7.tgz
  sudo mv -f /home/itversity/softwares/spark-2.4.8-bin-hadoop2.7 /opt
  sudo ln -s /opt/spark-2.4.8-bin-hadoop2.7 /opt/spark2
  sudo ln -s /opt/hive/conf/hive-site.xml /opt/spark2/conf/
  cp -rf configs/opt/spark2/conf/* /opt/spark2/conf/.
  sudo mkdir -p /opt/spark2/jars/ 
  sudo cp -rf /home/itversity/softwares/postgresql-42.2.19.jar /opt/spark2/jars/postgresql-42.2.19.jar
  sudo chown ${USER}:${USER} -R /opt/spark-2.4.8-bin-hadoop2.7
  tar xzf /home/itversity/softwares/spark-3.1.2-bin-hadoop3.2.tgz -C /home/itversity/softwares
  rm -rf /home/itversity/softwares/spark-3.1.2-bin-hadoop3.2.tgz
  sudo mv -f /home/itversity/softwares/spark-3.1.2-bin-hadoop3.2 /opt
  sudo ln -s /opt/spark-3.1.2-bin-hadoop3.2 /opt/spark3
  sudo ln -s /opt/hive/conf/hive-site.xml /opt/spark3/conf/
  cp -rf configs/opt/spark3/conf/* /opt/spark3/conf/.
  sudo mkdir -p /opt/spark3/jars/ 
  sudo mv -f /home/itversity/softwares/postgresql-42.2.19.jar /opt/spark3/jars/postgresql-42.2.19.jar
  sudo chown ${USER}:${USER} -R /opt/spark-3.1.2-bin-hadoop3.2

  /opt/hadoop/sbin/start-dfs.sh
  /opt/hadoop/sbin/start-yarn.sh

  hdfs dfs -mkdir -p /user/itversity

  hdfs dfs -mkdir -p /spark2-jars
  hdfs dfs -mkdir -p /spark2-logs

  hdfs dfs -put -f /opt/spark2/jars/* /spark2-jars

  hdfs dfs -mkdir -p /spark3-jars
  hdfs dfs -mkdir -p /spark3-logs

  hdfs dfs -put -f /opt/spark3/jars/* /spark3-jars
else
  /opt/hadoop/sbin/start-dfs.sh
  /opt/hadoop/sbin/start-yarn.sh
fi

/home/itversity/.local/bin/jupyter lab --ip 0.0.0.0
