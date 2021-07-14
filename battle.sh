#!/bin/bash
work_path=$(echo -e `pwd`)

enemy_profile=$work_path/enemies/boar.file

source $user_profile
source $enemy_profile

Warning_text=''
Dictor_text=''
Battle_Log=''

#player_health=$player_health
p_protect=0
heal_buttle=5
heal_buttle_size=50

#enemy_health=$enemy_health
e_protect=0

TERN_NAME=''
TERN_INDEX=''

##term_index= 
# `0` - player
# `1`- enemys

display_table(){
clear
echo -e "Tern of $TERN_NAME"
echo -e "tern №$terns"

echo -e "
_________________________________________________________________
|\e[32m${player_name}\t\t\t\e[0m|\e[31m${enemy_name}\t\t\t\t\e[0m|
|Class: $class\t\t\t|Class: None\t\t\t|
|HP: $player_health\t\t\t|HP: $enemy_health\t\t\t|
|Ph_Dam: $player_physical_damage\t\t\t|Ph_Dam: $enemy_physical_damage\t\t\t|
|Mag_Dam: $player_magic_damage\t\t\t|Mag_Dam: $enemy_magic_damage\t\t\t|
|Protect: $p_protect\t\t\t|Protect: $e_protect\t\t\t|
|                               |                               |
|                               |                               |
|_______________________________|_______________________________|
"
echo  'You have : ' $heal_buttle 'hilok'
echo $Battle_Log
echo $Dictor_text
echo $Warning_text
}

## Methods

enemy_attack(){
    e_damage=$(expr $enemy_physical_damage - $p_protect)
    Battle_Log="$enemy_name attack $player_name -${e_damage}HP"
    ((player_health-=$e_damage))
}

player_attack(){
    p_damage=$(expr $player_physical_damage - $e_protect)
    Battle_Log="$player_name attack $enemy_name -${p_damage}HP"
    ((enemy_health-=$p_damage))
}

enemy_defend(){

    if [ $e_protect -ne "5" ];
        then ((e_protect+=1))
    fi
}

player_defend(){

    if [ "$p_protect" -ne "5" ];
        then ((p_protect+=1)) 
    fi
}

player_heal(){
    if [ $heal_buttle -eq "0" ];then
        Warning_text="heal buttles is over (("
    else
        ((heal_buttle-=1))
        ((player_health+=$heal_buttle_size))
        Battle_Log="$player_name heal +${heal_buttle_size}HP"
    fi
}

leave(){
exit 0
}

player_choises(){
stty echo 
echo -e "Select :"
    select opt in "Attack" "Defend" "Heal" "Leave"; 
    do
        case $opt in
        "Attack")
            player_attack
            break
            ;;
        "Defend")
            player_defend
            break
            ;;
        "Heal")
            player_heal
            break
            ;;
        "Leave")
            # if hp < 10% to random %2
            # 1. sucsess leave (battle_stop)
            # 2. fail leave (hp = 0)
            leave 
            break
            ;;
        *) 
            echo "invalid option $REPLY"
            ;;
        esac
    done
}

terns=0 
while :
do
((terns+=1))

    if [ "$player_health" -le "0" ];then
        clear
        echo "$enemy_name WIN"
        break
    fi

    if [ "$enemy_health" -le "0" ];then
        clear
        echo "$player_name WIN"
        break
    fi

    if (( terns %2 )); 
    then
        TERN_NAME=$player_name
        TERN_INDEX=0
        Dictor_text=''
        display_table
        player_choises
    else
        TERN_NAME=$enemy_name
        TERN_INDEX=1
        if (( RANDOM %2 )); 
        then
            Dictor_text="Now $enemy_name attack"
            display_table
            enemy_attack
            sleep 2s
        else
            Dictor_text="Now $enemy_name defends" 
            display_table
            enemy_defend
            sleep 2s
        fi
    fi
done