FROM python:3.8

RUN apt-get update && \
    apt-get -y install sudo telnet groff postgresql-client vim && \
    rm -rf /var/lib/apt/list/*

RUN adduser --disabled-password --gecos "" itversity && \
    echo "itversity:itversity" | chpasswd && \
    adduser itversity sudo

RUN sed -i "s/%sudo\tALL=(ALL:ALL) ALL/%sudo\tALL=(ALL:ALL) NOPASSWD:ALL/g" /etc/sudoers

USER itversity

WORKDIR /home/itversity
COPY images/pythonsql/labrequirements.txt /labrequirements.txt

RUN python -m pip install --upgrade pip
RUN python -m pip install -r /labrequirements.txt

RUN echo "export PATH=\${PATH}:/home/itversity/.local/bin" >> ~/.bashrc

COPY --chown=itversity:itversity images/pythonsql/deploy.sh /deploy.sh
RUN chmod u+x /deploy.sh

CMD ["/deploy.sh"]
