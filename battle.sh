#!/bin/bash
user_profile=$1
enemy_profile=$2

source $user_profile
source $enemy_profile
source items/buttle.sh

p_emoji=""
p_emoji_t1="༼つಠ益ಠ ༽つ ─=≡ΣO))"
p_emoji_t2="༼^ಠwಠ ༽^"

e_emoji=""
e_emoji_t1="༼つ◕(oo)◕༽つ "
e_emoji_t2="つ༼◕(oo)◕つ༽"

heal_buttle=$little_heal_buttle_quantity
heal_buttle_size=$little_heal_buttle_size

p_protect=0
e_protect=0

TURN_NAME=''
TURN_INDEX=''

function clear(){
    echo -e '\033c'
}

display_table(){
clear
echo -e "Turn №$turns of $TURN_NAME" 
printf "$p_emoji                        $e_emoji
_________________________________________________________________
|\e[42m${player_name} \t\t\t\t\e[0m|\e[41m${enemy_name} \t\t\t\t\e[0m|
|Class: $class \t\t\t|Class: $enemy_class \t\t\t|
|HP: $player_health \t\t\t|HP: $enemy_health \t\t\t|
|MP: $player_mana \t\t\t|MP: $enemy_mana \t\t\t\t|
|SP: $player_stamina \t\t\t|SP: $enemy_stamina \t\t\t|
|Ph_Dam: $player_physical_damage \t\t\t|Ph_Dam: $enemy_physical_damage \t\t\t|
|Mag_Dam: $player_magic_damage \t\t\t|Mag_Dam: $enemy_magic_damage \t\t\t|
|Protect: $p_protect \t\t\t|Protect: $e_protect \t\t\t|
|Heal_buttle: $heal_buttle \t\t|\t\t\t\t|
|_______________________________|_______________________________|
"
echo $Battle_Log 
echo $Dictor_text 
echo $Warning_text 
}

## ##################################################
# player methods

player_physical_attack(){
    if [ "$player_stamina" -le "5" ];then
        player_defend
    else
        if [ $physical_attack_index -eq "0" ];then
            physical_attack_might
        else
            physical_attack_shield
        fi 
    fi
}

physical_attack_might(){
    might_damage=$(expr $player_physical_damage + 10 - $e_protect)
    Battle_Log="$player_name attack $enemy_name -${might_damage}HP"
    ((player_stamina-=10))
    ((enemy_health-=$might_damage))
}

physical_attack_shield(){
    shield_damage=$(expr $player_physical_damage + 5 - $e_protect)
    Battle_Log="$player_name attack $enemy_name -${shield_damage}HP"
    ((player_stamina-=20))
    ((enemy_health-=$shield_damage))
}


player_magic_attack(){
    if [ "$player_mana" -le "5" ];then
        Warning_text="Mana point is over"
    else
        if [ $magic_attack_index -eq "0" ];then
            magic_attack_pyroblast
        else
            magic_attack_frost_straick
        fi 
    fi
}

magic_attack_pyroblast(){
    pyroblast_damage=$(expr $player_magic_damage + 10 - $e_protect)
    Battle_Log="$player_name attack $enemy_name -${pyroblast_damage}HP"
    ((player_mana-=40))
    ((enemy_health-=$pyroblast_damage))
}

magic_attack_frost_straick(){
    frost_straick_damage=$(expr $player_magic_damage + 5 - $e_protect)
    Battle_Log="$player_name attack $enemy_name -${frost_straick_damage}HP"
    ((player_mana-=20))
    ((enemy_health-=$frost_straick_damage))
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

###################################################
# Enemy methods

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

enemy_defend(){
    ((enemy_stamina+=5))
    if [ $e_protect -ne "5" ];
        then ((e_protect+=1))
    fi
    Battle_Log="$enemy_name defend up!"
}

player_choises(){
stty echo 
echo -e "Select :"
    select opt in "Physical Attack" "Magic Attack" "Defend" "Heal" "Leave"; 
    do
        case $opt in
        "Physical Attack")
            clear
            display_table
            select opt in "Attack of Might (-10 Stamina)" "Attack of Shield (-20 Stamina)"; 
            do
                case $opt in
                "Attack of Might (-10 Stamina)")
                    physical_attack_index=0
                    player_physical_attack
                    break
                    ;;
                "Attack of Shield (-20 Stamina)")
                    physical_attack_index=1
                    player_physical_attack
                    break
                    ;;
                *) 
                    echo "invalid option $REPLY"
                    ;;
                esac
            done
            break
            ;;
            "Magic Attack")
            clear
            display_table
            select opt in "PyroBlast (-40 mana)" "Frost straick (-20 mana)"; 
            do
                case $opt in
                "PyroBlast (-40 mana)")
                    magic_attack_index=0
                    player_magic_attack
                    break
                    ;;
                "Frost straick (-20 mana)")
                    magic_attack_index=1
                    player_magic_attack
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
    TURN_NAME=$enemy_name
    TURN_INDEX=1

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

battle_proccess(){
turns=0 
while :
do
((turns+=1))

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
    
    if (( turns %2 )); 
    then
        p_emoji=$p_emoji_t1
        e_emoji=$e_emoji_t1
        TURN_NAME=$player_name
        TURN_INDEX=0
        Dictor_text=''
        display_table
        player_choises
    else
        p_emoji=$p_emoji_t2
        e_emoji=$e_emoji_t2
        enemy_AI
    fi
done
}

battle_proccess