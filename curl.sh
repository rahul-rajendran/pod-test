#/bin/sh

oc get pods -o wide --all-namespaces | grep -v Completed > runningpods

while read line
do

    IP=$(echo $line | awk '{print $7}')
    #echo "ip is $IP"
    curlIP=$(curl http://${IP}:8080 2>&1 > /dev/null)

    if [[ $curlIP == *"No route to host"* ]]; then
       echo "$line"
    fi

    sleep 2

done < runningpods
