#!/bin/bash

read -p "Enter your commission amount: " commission

if [ "$commission" -ge 200 ] && [ "$commission" -lt 300 ]; then
    bonus=50
elif [ "$commission" -gt 300 ]; then
    bonus=100
else
    bonus=0
fi

echo -e "Based on your commission your bonus is $ \b$bonus"

exit 0