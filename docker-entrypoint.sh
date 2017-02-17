#!/bin/bash

# Define useful vars
PORT="10401"
TMP_DIR="/tmp"
LOG_DIR="/incoming/log"
DATA_DIR="/incoming/data"

# Make sure required directories exist
mkdir -p $TMP_DIR
mkdir -p $LOG_DIR
mkdir -p $DATA_DIR

# Add dicomlistener service
sudo echo "
dicomlistener      $PORT/tcp   # DICOM Listener
dicomlistener      $PORT/udp   # DICOM Listener
" >> /etc/services

# Add dicomlistener xinetd
sudo echo "
service dicomlistener
{
   socket_type         = stream
   wait                = no
   log_on_success      = HOST DURATION
   log_on_failure      = HOST
   server              = python3 px-listen -t $TMP_DIR -l $LOG_DIR -d $DATA_DIR
   disable             = no
   port                = $PORT
}
" >> /etc/xinetd.d/dicomlistener

# Run xinetd
$@

