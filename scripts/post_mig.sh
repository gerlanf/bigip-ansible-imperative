#!/bin/bash
mkdir /var/tmp/$HOSTNAME-POST_Migration
cd /var/tmp/$HOSTNAME-POST_Migration
nice -n 19 qkview -f /var/tmp/$HOSTNAME-POST_Migration/$HOSTNAME.qkview
sleep 1m 
tmsh save sys ucs /var/tmp/$HOSTNAME-POST_Migration/$HOSTNAME
sleep 15s
tmsh save sys config file /var/tmp/$HOSTNAME-POST_Migration/$HOSTNAME no-passphrase 
sleep 15s
echo '##xxxxxxxxxxxxxxxxxxxxxx Pool Status xxxxxxxxxxxxxxxxxxxxxx##' >> $HOSTNAME.TMSH_Output
tmsh -q -c "cd /;show ltm pool recursive field-fmt members "| awk --posix  '/node-name/ {mem=$2} /addr/ {mbrAddr=$2} / port / {mbrPort=$2} /^ {12}status.availability-state/ {avStat=$2} /^ {12}status.enabled-state/ {enstate=$2} /^ {12}pool-name/ {pname=$2} /^ {8}}/ {print pname,mem,mbrAddr,mbrPort,avStat,enstate}' | sort -k 3,4 -k 1,1 >> $HOSTNAME.TMSH_Output
sleep 5s
seq 5 | awk '{printf "\n"}' >> $HOSTNAME.TMSH_Output
echo '##xxxxxxxxxxxxxxxxxxxxxx VIP Status xxxxxxxxxxxxxxxxxxxxxx##' >> $HOSTNAME.TMSH_Output
tmsh -q -c "cd /;show ltm virtual recursive field-fmt" | awk --posix '/ name / {vsName=$2} /destination/ {dest=$2} /^ {4}status.availability-state/ {avStat=$2} /^ {4}status.enabled-state/ {print vsName,dest,avStat,$2}' | sed 's/:/ /' | sort -dk 2,2 -dk 3,3 >> $HOSTNAME.TMSH_Output
sleep 5s
seq 5 | awk '{printf "\n"}' >> $HOSTNAME.TMSH_Output
echo '##xxxxxxxxxxxxxxxxxxxxxx tmsh show ltm virtual field-fmt xxxxxxxxxxxxxxxxxxxxxx##' >> $HOSTNAME.TMSH_Output
tmsh -q -c 'cd /; show ltm virtual field-fmt recursive' >> $HOSTNAME.TMSH_Output
sleep 5s
# seq 5 | awk '{printf "\n"}' >> $HOSTNAME.TMSH_Output
# echo '##xxxxxxxxxxxxxxxxxxxxxx tmsh show sys perf xxxxxxxxxxxxxxxxxxxxxx##' >> $HOSTNAME.TMSH_Output
# tmsh show sys perf >> $HOSTNAME.TMSH_Output
# sleep 5s
# seq 5 | awk '{printf "\n"}' >> $HOSTNAME.TMSH_Output
# echo '##xxxxxxxxxxxxxxxxxxxxxx tmsh show ltm virtual xxxxxxxxxxxxxxxxxxxxxx##' >> $HOSTNAME.TMSH_Output
# tmsh -q -c 'cd /; show ltm virtual recursive'  >> $HOSTNAME.TMSH_Output
# sleep 5s
# seq 5 | awk '{printf "\n"}' >> $HOSTNAME.TMSH_Output
# echo '##xxxxxxxxxxxxxxxxxxxxxx tmsh show ltm pool xxxxxxxxxxxxxxxxxxxxxx##' >> $HOSTNAME.TMSH_Output
# tmsh -q -c 'cd /; show ltm pool recursive' >> $HOSTNAME.TMSH_Output
# sleep 5s
seq 5 | awk '{printf "\n"}' >> $HOSTNAME.TMSH_Output
echo '##xxxxxxxxxxxxxxxxxxxxxx tmsh show ltm rule xxxxxxxxxxxxxxxxxxxxxx##' >> $HOSTNAME.TMSH_Output
tmsh -q -c 'cd /; show ltm rule recursive' >> $HOSTNAME.TMSH_Output
sleep 5s

