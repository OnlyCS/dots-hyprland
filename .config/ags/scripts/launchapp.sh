#!/usr/bin/bash

~/.config/eww/scripts/toggle-powerview.sh --close &

if [[ "$1" == ">"* ]]; then
    args=( $1 )
    if [[ "${args[0]}" == ">music" ]]; then
        scripts/colormanage get
    elif [[ "${args[0]}" == ">load" ]]; then
        scripts/colormanage load "${args[1]}"
    elif [[ "${args[0]}" == ">save" ]]; then
        scripts/colormanage save "${args[1]}"
    elif [[ "${args[0]}" == ">swr" ]]; then # basic rice switching
        ~/.local/bin/switchrice.sh "${args[1]}" "${args[2]}"
    elif [[ "${args[0]}" == ">light" ]]; then
        scripts/togglelight light
    elif [[ "${args[0]}" == ">dark" ]]; then
        scripts/togglelight dark
    elif [[ "${args[0]}" == ">multi" ]]; then
        echo -n 'multi' > 'scripts/workdir/__mode_colors.txt'
    elif [[ "${args[0]}" == ">one" ]]; then
        echo -n 'one' > 'scripts/workdir/__mode_colors.txt'
    elif [[ "${args[0]}" == ">wall" ]]; then
        scripts/colorgen 'images/wallpaper' '[Local wallpaper]' ''
        scripts/colormanage get
    elif [[ "${args[0]}" == ">img" ]]; then
        scripts/switchwall
    elif [[ "${args[0]}" == ">segs" ]]; then
        eww update waifu="$(python3 scripts/waifu-get.py --segs ero)"
    elif [[ "${args[0]}" == ">uwu" ]]; then
        eww update waifu="$(python3 scripts/waifu-get.py)"
    elif [[ "${args[0]}" == ">r" ]]; then
        pkill eww && eww daemon && eww open bar && eww open bgdecor
    elif [[ "${args[0]}" == ">todo" ]]; then
        scripts/todo add "${1#*>todo }"
        eww update todolist="$(cat json/todo.json | gojq -c -M)"
    elif [[ "${args[0]}" == ">raw" ]]; then
        hyprctl keyword input:force_no_accel $(( 1 - $(hyprctl getoption input:force_no_accel -j | gojq '.int') ))
    else
        # notify-send 'eww' 'Invalid command!'
        false
    fi
else 
    cd "$HOME" || exit
    app=$1
    eval "${app%\%*}" &
    pkill launchapp
    exit
fi


