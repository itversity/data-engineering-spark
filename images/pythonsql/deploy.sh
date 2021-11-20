#!/bin/bash -x

if [ ! -e /opt/.initialized ]
then
  sudo touch /opt/.initialized
#  sudo chown -R itversity:itversity /home/itversity/itversity-material
fi

/home/itversity/.local/bin/jupyter lab --ip 0.0.0.0
