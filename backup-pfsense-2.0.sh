#!/bin/sh

HOST=$1
ACTION=$2
USER='admin'
PASSWORD='pfsense'

URL="https://${HOST}"
BACKUP_URL="${URL}/diag_backup.php"
DIR="/var/backups/pfsense"
COOKIE="/tmp/cookies-${HOST}.txt"

WGET='/usr/bin/wget -q --no-check-certificate'

check_result() {
  if [ ${?} -ne 0 ]; then
    echo "ERROR: $1"
    exit 1
  fi
}

pre (){
  csrf_magic="$($WGET -O- "${URL}" | grep "input type='hidden' name='__csrf_magic'" | sed -e 's/.*value="\(.*\)".*/\1/')"

  $WGET --keep-session-cookies --save-cookies "${COOKIE}" --post-data "login=Login&usernamefld=${USER}&passwordfld=${PASSWORD}&__csrf_magic=${csrf_magic}" ${BACKUP_URL} -O /dev/null
  check_result "ERROR: Could not login to '${HOST}'!"

  # Config seule. Pour pouvoir tracer les modification de config
  $WGET --keep-session-cookies --load-cookies "${COOKIE}" --post-data 'Submit=download&donotbackuprrd=on' ${BACKUP_URL} -O ${DIR}/config-${HOST}.xml
  check_result "Could not download configuration data from '${HOST}'!"

  # La meme chose, avec les données RRD en +
  $WGET --keep-session-cookies --load-cookies "${COOKIE}" --post-data 'Submit=download' ${BACKUP_URL} -O ${DIR}/config-${HOST}+rrd.xml
  check_result "Could not download configuration + rrd data from '${HOST}'!"

  $WGET --load-cookies "${COOKIE}" "${URL}/index.php?logout" -O /dev/null
  check_result "ERROR: Could not logout of '${HOST}'!"

  /bin/rm -f /tmp/cookies-${HOST}.txt

  exit $?
}

post (){
  /bin/rm -f ${DIR}/config-${HOST}*.xml
}

case $ACTION in
  post)
    post
  ;;
  *)
    pre
  ;;
esac
