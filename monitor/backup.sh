#!/bin/bash

#
# Global Variables
##################################################

SCRIPT_NAME="backup"

BACKUP_TOOL=/bin/tar

BACKUP_PATH=~/backup/

EMAIL=tanri.lee@gmail.com

LOG_DIR=/var/log/${SCRIPT_NAME}

LOG_FILE=${LOG_DIR}/${SCRIPT_NAME}.log

DAY_OF_MONTH=`date +%d`

# Functions
#################################################
function write_log

{

        echo "`date +%F_%T` $*" >> ${LOG_FILE}

}

function err_handle

{

        ERR=$1

        COMMAND=$2

        if [ ${ERR} = 0 ]

        then
                write_log "command ${COMMAND} completed successfully"
        else
                write_log "Error: command ${COMMAND} failed with error code=${ERR}"
                cat ${LOG_FILE} | mail -s "${SCRIPT_NAME} script on `hostname` failed!" ${EMAIL}
                exit 2
        fi
}

function backup_dir

{

        DIR_NAME=$1

        BACKUP_DIR=$2

        write_log "start backup ${DIR_NAME} repository"
        # do backing up 
        $sudo tar -cpzf /home/ri/backup/backup.tar.gz --exclude=/home/ri/backup/backup.tar.gz --exclude=/temp --exclude=/mnt --exclude=/proc --exclude=/dev --exclude=/var/lib/lxcfs --exclude=/var/lib/lxd --one-file-system /
        err_handle $? "$sudo tar -cpzf /home/ri/backup/backup.tar.gz --exclude=/home/ri/backup/backup.tar.gz --exclude=/temp --exclude=/mnt --exclude=/proc --exclude=/dev --one-file-system /"
        # send to storage server
        $sudo scp  -i ~/.ssh/id_rsa -q -o LogLevel=QUIET -r  /home/ri/backup/backup.tar.gz ri@192.168.56.1:~/backup/monitor
        err_handle $? "scp  -i ~/.ssh/id_rsa -q -o LogLevel=QUIET -r  /home/ri/backup/backup.tar.gz ri@192.168.56.1:~/backup/monitor"
       
        write_log "finish backup ${DIR_NAME} repository"

}

# Main
##################################################

write_log "------------- Start backup script -----------------------"

backup_dir "${DIR}" "${BACKUP_PATH}/ backup.tar.gz"

write_log "-------------- Finish backup script ----------------------"


