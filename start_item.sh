#!/bin/bash

source func/bash-menu.sh

update_variable(){
    sed -i "s/$1/$2/gi" $user_profile
}

actionA() {
    item_name="Dark ring"
    clear
    echo "Dark ring '+5 streangt'"
    sleep 2s

    search=$(grep "player_health=" "wert.save")
    replace="player_health=${player_health}"
    
    update_variable $search $replace

actionB() {
    item_name="Master key"
    ((dexterity+=5))
    clear
    echo "Master key '+5 dexterity'"
    sleep 2s
    echo "Dexterity: ${dexterity}" 		>> $user_profile
}

actionC() {
    item_name="Holy rune"
    ((intelligence+=5))
    clear
    echo "Holy rune '+5 intelligence'"
    sleep 2s
    echo "Intelligence: ${intelligence}" 	>> $user_profile
    echo_contiue
}

actionD() {
    item_name="1k yers stoune"
    ((education+=4))
    clear
    echo "1k yers stoune '+4 education'"
    sleep 2s
    echo "Education: ${education}" 		>> $user_profile
}

actionF() {
    item_name="Elder Scrool"
    ((faith+=5))
    clear
    echo "Elder Scrool '+5 faith'"
    sleep 2s
    echo "Faith: ${faith}" 		>> $user_profile
}

menuItems=(
    "Dark ring"
    "Master key"
    "Holy rune"
    "1k yers stoune"
    "Elder Scrool"
)

menuPreviewItems=(
    "Dark ring '+5 streangt'"
    "Master key '+5 dexterity'"
    "Holy rune '+5 intelligence'"
    "1k yers stoune '+4 education'"
    "Elder Scrool '+5 faith'"
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
menuHighlight=$DRAW_COL_RED

menuInit
menuLoop