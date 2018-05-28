#!/bin/bash
fullPath="/data/backup/full"
incrPath="/data/backup/incremental"
now_date=`date +'%F'`
now_hour=`date +'%H'`
#oneHourAgo=`date -d '1 hours ago' +'%F_%H'`
restore_date=$RESTOREDATE

[ -d "$fullPath/$restore_date" ] || (
    echo "not found backup"
    exit 0
)

# prepare function
function prepare(){
    /usr/bin/xtrabackup --prepare --target-dir=${fullPath}/${restore_date}/ > ${fullPath}/restore_$now_date.log 2>&1
}

# restore function
function restore(){
  baktype=$1
  if [ "$baktype" == "full" ];then
    [ -d "/data/data_$now_date" ] && (
      mv /data/data_$now_date /data/data_old_$now_date
    ) || mv /data/data /data/data_$now_date
    /usr/bin/xtrabackup --datadir=/data/data --copy-back --target-dir=${fullPath}/${restore_date}/  > ${fullPath}/restore_$now_date.log 2>&1
  fi
}

# type ftp / minio
# 
# ftp SFTP_USER SFTP_PASS URL(ali-hz-s1.goodrain.net:22)
#
# minio 
#
function download(){
if [ "$UPLOADTYPE" = "minio" ];then
  echo "download from minio complete"
elif [ "$UPLOADTYPE" = "ftp" ];then
  echo "download from ftp complete"
else
  echo "not upload"
fi
}

# ============= Main =============
if [ "$1" == "full" ];then
    download >> ${fullPath}/download_$now_date.log
    prepare
    restore full
elif [ "$1" == "incremental" ];then
    echo "pass"
fi