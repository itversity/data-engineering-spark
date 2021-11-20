FROM ubuntu:18.04

RUN apt update && \
    apt install openjdk-8-jdk openssh-server -y && \
    apt install python3 python3-venv python3-pip -y && \
    apt install sudo telnet groff postgresql-client vim -y && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" itversity && \
    echo "itversity:itversity" | chpasswd && \
    adduser itversity sudo

RUN sed -i "s/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers

USER itversity

WORKDIR /home/itversity
COPY --chown=itversity:itversity .ssh .ssh
RUN chmod 700 -R .ssh

COPY --chown=itversity:itversity requirements.txt /requirements.txt
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -r /requirements.txt

COPY --chown=itversity:itversity softwares /softwares
COPY --chown=itversity:itversity deploy.sh /deploy.sh
COPY --chown=itversity:itversity configs/.profile .profile
COPY --chown=itversity:itversity configs /configs
COPY --chown=itversity:itversity kernels .kernels

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV HIVE_HOME=/opt/hive
ENV PATH=$PATH:${HIVE_HOME}/bin
ENV SPARK2_HOME=/opt/spark2
ENV PATH=$PATH:${SPARK2_HOME}/bin
ENV SPARK3_HOME=/opt/spark3
ENV PATH=$PATH:${SPARK3_HOME}/bin
ENV PATH=$PATH:/home/itversity/.local/bin

RUN jupyter kernelspec \
    install .kernels/pyspark2 \
    --user
RUN jupyter kernelspec \
    install .kernels/pyspark3 \
    --user

RUN chmod u+x /deploy.sh

CMD ["/deploy.sh"]

# CMD ["/home/itversity/.local/bin/jupyter", "lab", "--ip", "0.0.0.0"]
