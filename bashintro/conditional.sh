#!/bin/bash

for i in {1..10}
do
    if (( i % 2 == 0 )); then
        echo $i
    fi
done

# read -p 'Enter Username: ' UN
# read -p 'Enter Password: ' PW

# if [[ "$UN" == "admin" && "$PW" == "notsosecret" ]]; then
#     echo "Login Successful!"
# else
#     echo "Nice try. Goodbye!"
#     exit 1
# fi

# if [ $N -lt 25 ]; then
#     echo "$N < 25"
# elif [ $N -ge 25 ]; then
#     echo "$N >= 25"
# else
#     echo "What are you doing?"
# fi
