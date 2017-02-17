#!/bin/bash

# Define useful vars
PORT="10402"
TMP_DIR="/tmp"
LOG_DIR="/incoming/log"
DATA_DIR="/incoming/data"

# Make sure required directories exist
mkdir -p $TMP_DIR
mkdir -p $LOG_DIR
mkdir -p $DATA_DIR

# Add dicomlistener service
echo "
dicomlistener      $PORT/tcp   # DICOM Listener
dicomlistener      $PORT/udp   # DICOM Listener
" >> /etc/services

# Add dicomlistener xinetd
echo "service dicomlistener
{
   disable             = no
   socket_type         = stream
   wait                = no
   user                = root
   log_on_success      = HOST DURATION
   log_on_failure      = HOST
   server              = python3 px-listen -t $TMP_DIR -l $LOG_DIR -d $DATA_DIR
   disable             = no
   port                = $PORT
   only_from           = 0.0.0.0
}" > /etc/xinetd.d/dicomlistener

# Run xinetd
$@
