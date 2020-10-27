#!/bin/bash

get_current_time(){
    now=$(date +"%T")
    hour=${now:0:2}
    minute=${now:3:2}

    if [ $hour -ge "09" ] && [ $hour -lt "12" ]
    then
        echo -n "good morning, worker!"
    elif [ $hour -ge "12" ] && [ $hour -lt "17" ]
    then
        echo -n "good afternoon, worker!"
        if [ $1 == "955" ] && [ $hour == "16" ] && [ $minute -gt "50" ]
        then
            echo -n "time to be rush home, worker!"
        fi
    elif [ $hour -ge "17" ] && [ $hour -le "21" ]
    then
        if [ $1 == "996" ]
        then
            echo -n "good evening, worker!"
            if [ $hour == "20" ] && [ $minute -gt "50" ]
            then
                echo -n "time to be rush home, worker!"
            fi
        else
            echo -n "work overtime, worker?"
        fi
    else
        echo -n "work overtime, worker!"
    fi
}

morning(){

    if [ ! -f "./work_mode" ]
    then
        read -p "please choose your work mode:(996/955) " work_mode
        if [ $work_mode == "996" ] || [ $work_mode == "955" ]
        then
            echo -n $work_mode>work_mode
        else 
            echo -n "not a true worker."
            exit 1
        fi
    fi

    get_current_time $(cat work_mode)
}