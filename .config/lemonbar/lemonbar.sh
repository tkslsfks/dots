#!/bin/bash

FONT="MxPlusToshibaSat8x14:size=12"

Memory() {
    free -m | awk '/^Mem:/ {printf "%.1f", $3/1024}'
}

DateTime() {
    date "+%H:%M %d/%m"
}

Volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1
}

mem_cache=""
mem_counter=0

while true; do
    if (( mem_counter >= 15 )); then
        mem_cache=$(Memory)
        mem_counter=0
    fi
    
    echo "%{r}MEM ${mem_cache}gb  |  VOL $(Volume)  |  $(DateTime)  "
    
    ((mem_counter++))
    sleep 0.3
done
