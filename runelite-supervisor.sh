#!/bin/bash


java_is_running() {
    {
        ps -ef | grep -v 'ps -ef'           \
               | head -n -4                 \
               | grep -i java &>/dev/null
    }
    return $!
}


circuit_breaker_loop() {
    SLEEP_TIME="${1:-1}"
    TOLERANCE="${2:-3}"
    broken=0
    while true; do

        if ! java_is_running; then
            (( broken++ ))
            echo -e "\n\n =================== NOT RUNNING: $broken\n\n"
        else
            broken=0
        fi

        if [ "$broken" -ge "$TOLERANCE" ]; then
            echo -e "\n\n BROKE: $broken \n\n"
            echo -e "TOLERANCE: $TOLERANCE"
            echo -e "\n\n\n"
            break
        fi

        sleep "$SLEEP_TIME"
    done
}


supervise_java_process() {
    circuit_breaker_loop 0.5 20
}


start_runelite() {
    java -jar RuneLite.jar
}


main() {
    start_runelite
    supervise_java_process
}


[[ ${BASH_SOURCE[0]} == "$0" ]] && main $@
