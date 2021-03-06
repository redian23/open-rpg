#!/bin/bash

source func/bash-menu.sh

select_class(){
    while true; do
    read -p "Select this class? [y\N]" yn
    case $yn in
        [Yy]* ) echo "Select ${class_name}"
                echo "class='${class_name}'"                            >> $user_profile
                echo "player_health=${health}" 	                        >> $user_profile
                echo "player_mana=${mana}"                              >> $user_profile
                echo "player_stamina=${stamina}" 	                    >> $user_profile
                echo "player_physical_damage=${player_physical_damage}" >> $user_profile
                echo "player_magic_damage=${player_magic_damage}"       >> $user_profile
                echo "player_heal=${player_heal}"                       >> $user_profile
                echo "player_heal_buttles=${little_heal_buttle_quantity}" >> $user_profile
                sleep 0.5s
                break;;
        [Nn]* ) menuLoop;;
        * ) echo "Please answer yes or no.";;
    esac
done
}

show_stats(){
    clear
    echo "Class -> "            $class_name
    echo "Health -> "           $health 
    echo "Physical damage -> "  $player_physical_damage
    echo "Magic damage -> "     $player_magic_damage
    echo "Heal-> "              $player_heal
    echo "" 
}


actionA() {
    class_name="Mage"
    health=100
    mana=150 
    stamina=50
    player_physical_damage=10
    player_magic_damage=15
    player_heal=2
    little_heal_buttle_quantity=3

    show_stats
    select_class
}

actionB() {
    class_name="Knight"
    health=150
    mana=50
    stamina=100
    player_physical_damage=15
    player_magic_damage=10
    player_heal=1
    little_heal_buttle_quantity=3

    show_stats
    select_class
}

actionC() {
    class_name="Thif"
    health=50
    mana=100
    stamina=150 
    player_physical_damage=5 
    player_magic_damage=10
    player_heal=0
    little_heal_buttle_quantity=3

    show_stats
    select_class
}

actionD() {
    class_name="War"
    health=150
    mana=0
    stamina=150 
    player_physical_damage=15
    player_magic_damage=5
    player_heal=0
    little_heal_buttle_quantity=3

    show_stats
    select_class
}

actionF() {
    class_name="Prist"
    health=50
    mana=200
    stamina=50  
    player_physical_damage=5
    player_magic_damage=15
    player_heal=5
    little_heal_buttle_quantity=3

    show_stats
    select_class
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
    "3??"
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
