#!/bin/bash

source bash-menu.sh

echo_contiue(){
    echo -n "Press enter to continue ... "
}

select_class(){
    while true; do
    read -p "Select this class? [y\N]" yn
    case $yn in
        [Yy]* ) echo "Select ${class_name}" 
                echo "class='${class_name}'"                            >> $user_profile
                echo "player_health=${health}" 	                        >> $user_profile
                echo "player_physical_damage=${player_physical_damage}" >> $user_profile
                echo "player_magic_damage=${player_magic_damage}"       >> $user_profile
                echo "player_heal=${player_heal}"                       >> $user_profile
                sleep 0.5s
                break;;
        [Nn]* ) menuLoop;;
        * ) echo "Please answer yes or no.";;
    esac
done
}

show_stats(){
    echo "Class -> "            $class_name
    echo "Health -> "           $health 
    echo "Physical damage -> "  $player_physical_damage
    echo "Magic damage -> "     $player_magic_damage
    echo "Heal-> "              $player_heal
    echo "" 
}


damage_info(){
    echo "IIINNNFFFFOOOO"
    level=10
    level_sceil=$[$level/2]
    phisical_damage=$[$player_physical_damage*$level_sceil]
    magic_damage=$[$player_magic_damage*$level_sceil]
    heal=$[$player_magic_damage+$player_heal/$level_sceil]

    sleep 0.5s
    echo "Level -> "            $level
    echo "Sceil -> "            $level_sceil
    echo "Phisical damage -> "  $phisical_damage
    echo "Magic damage -> "     $magic_damage
    echo "Heal -> "             $player_heal
    echo ""
}

actionA() {
    class_name="Mage"
    health=100 
    player_physical_damage=10
    player_magic_damage=15

    player_heal=2

    show_stats
    damage_info
    select_class
    echo_contiue
}

actionB() {
    class_name="Knight"
    health=150
    player_physical_damage=15
    player_magic_damage=10

    player_heal=0

    show_stats
    damage_info
    select_class
    echo_contiue
}

actionC() {
    class_name="Thif"
    health=50
    player_physical_damage=5 
    player_magic_damage=10

    player_heal=1

    show_stats
    damage_info
    select_class
    echo_contiue
}

actionD() {
    class_name="War"
    health=150 
    player_physical_damage=15
    player_magic_damage=5

    player_heal=1

    show_stats
    damage_info
    select_class
    echo_contiue
}

actionF() {
    class_name="Prist"
    health=100 
    player_physical_damage=5
    player_magic_damage=15

    player_heal=5

    show_stats
    damage_info
    select_class
    echo_contiue
}
actionX() {
    echo -e "Exit ..."
    exit 0;
}

menuItems=(
    "Mage"
    "Knight"
    "Thif"
    "War"
    "Prist"
    "[Exit]"
)

menuPreviewItems=(
    "Battle Frost Mage. Power-> Magic "
    "Glory knight. Power-> Phis. damage and zahita"
    "3п"
    "4t"
    "5y"
    "[quit]"
)

## Menu Item Actions
menuActions=(
    actionA
    actionB
    actionC
    actionD    
    actionF
    actionX
)

## Override some menu defaults
menuTitle=" Show stats of classes: "
menuFooter=" Enter=Select, Navigate via Up/Down/First number/letter"
menuWidth=60
menuLeft=25
menuHighlight=$DRAW_COL_GREEN

menuInit
menuLoop
