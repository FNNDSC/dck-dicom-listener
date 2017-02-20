#!/bin/bash

# Define useful vars
PORT="10402"
TMP_DIR="/tmp"
LOG_DIR="/incoming/log"
DATA_DIR="/incoming/data"
STORESCP="/usr/bin/storescp"

# Make sure required directories exist
mkdir -p $TMP_DIR
mkdir -p $LOG_DIR
mkdir -p $DATA_DIR

# Add dicomlistener xinetd
echo "service dicomlistener
{
   disable             = no
   socket_type         = stream
   wait                = no
   user                = root
   server              = /usr/local/bin/px-listen
   server_args         = -e $STORESCP -t $TMP_DIR -l $LOG_DIR -d $DATA_DIR
   type                = UNLISTED
   port                = $PORT
   bind                = 0.0.0.0
}" > /etc/xinetd.d/dicomlistener

# Run xinetd
$@
