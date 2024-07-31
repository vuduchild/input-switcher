#!/bin/bash
SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

# Switch to channel 1
CHANNEL=0x00
# Switch to channel 2
#CHANNEL=0x01

LOG_VID=046D
KBD_PID=B36A
MSE_PID=B034


# Switch MX Keys to other device
#                                                                                                                     A    B    C    D    E          F    G
sudo ${DIR}/hidapitester --vidpid ${LOG_VID}:${KBD_PID} --usage 0x0202 --usagePage 0xFF43 --open --length 20 --send-output 0x11,0xFF,0x09,0x1d,${CHANNEL},0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
# Switch MX Mouse to other device
#                                                                                                                     A    B    C    D    E          F    G
sudo ${DIR}/hidapitester --vidpid ${LOG_VID}:${MSE_PID} --usage 0x0202 --usagePage 0xFF43 --open --length 20 --send-output 0x11,0xFF,0x0a,0x1b,${CHANNEL},0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00

exit 0

