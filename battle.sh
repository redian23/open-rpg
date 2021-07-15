#!/bin/bash
user_profile=$1
enemy_profile=$2

source $user_profile
source $enemy_profile

Warning_text=''
Dictor_text=''
Battle_Log=''

p_protect=0
heal_buttle=3
heal_buttle_size=50

e_protect=0

TERN_NAME=''
TERN_INDEX=''

attack_index=''
##term_index= 
# `0` - player
# `1`- enemys

display_table(){
clear
echo -e "Tern №$terns of $TERN_NAME" 
echo -e "Tern №$terns of $TERN_NAME" >> temp_battle_${enemy_name}.log

echo -e "
_________________________________________________________________
|\e[32m${player_name}\t\t\t\t\e[0m|\e[31m${enemy_name}\t\t\t\t\e[0m|
|Class: $class\t\t\t|Class: $enemy_class\t\t\t|
|HP: $player_health\t\t\t|HP: $enemy_health\t\t\t|
|MP: $player_mana\t\t\t|MP: $enemy_mana\t\t\t\t|
|SP: $player_stamina\t\t\t\t|SP: $enemy_stamina\t\t\t|
|Ph_Dam: $player_physical_damage\t\t\t|Ph_Dam: $enemy_physical_damage\t\t\t|
|Mag_Dam: $player_magic_damage\t\t\t|Mag_Dam: $enemy_magic_damage\t\t\t|
|Protect: $p_protect\t\t\t|Protect: $e_protect\t\t\t|
|_______________________________|_______________________________|"
echo  'You have : ' $heal_buttle 'hilok'
echo $Battle_Log && echo $Battle_Log >> temp_battle_${enemy_name}.log
echo $Dictor_text && echo $Dictor_text >> temp_battle_${enemy_name}.log
echo $Warning_text 
}

## Methods

enemy_attack(){
    e_damage=$(expr $enemy_physical_damage - $p_protect)

    if [ "$enemy_stamina" -le "5" ];then
        enemy_defend
    else
        ((player_health-=$e_damage))
        ((enemy_stamina-=10))
    fi
    
    Battle_Log="$enemy_name attack $player_name -${e_damage}HP"
}

player_attack(){
    if [ $attack_index -eq "0" ];then
        if [ "$player_stamina" -le "5" ];then
            player_defend
        else
            p_damage=$(expr $player_physical_damage - $e_protect)
            Battle_Log="$player_name attack $enemy_name -${p_damage}HP"
            ((player_stamina-=10))
            ((enemy_health-=$p_damage))
        fi
    else
        if [ "$player_mana" -le "5" ];then
            Warning_text="Mana point is over"
        else
            m_damage=$(expr $player_magic_damage - $e_protect)
            Battle_Log="$player_name attack $enemy_name -${m_damage}HP"
            ((player_mana-=10))
            ((enemy_health-=$m_damage))
        fi
    fi
}

enemy_defend(){
    ((enemy_stamina+=5))
    if [ $e_protect -ne "5" ];
        then ((e_protect+=1))
    fi
    Battle_Log="$enemy_name defend up!"
}

player_defend(){
    ((player_stamina+=5))
    if [ "$p_protect" -ne "5" ];
        then ((p_protect+=1)) 
    fi
    Battle_Log="$player_name defend up!"
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
            select opt in "Phys" "Magic"; 
            do
                case $opt in
                "Phys")
                    attack_index=0
                    player_attack
                    break
                    ;;
                "Magic")
                    attack_index=1
                    player_attack
                    break
                    ;;
                *) 
                    echo "invalid option $REPLY"
                    ;;
                esac
            done
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

enemy_AI(){
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
        enemy_AI
    fi
done