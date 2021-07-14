#!/bin/bash

source bash-menu.sh

echo_contiue(){
    echo -n "Press enter to continue ... "
}

actionA() {
    item_name="Dark ring"
    ((streangt+=5))
    echo "Dark ring '+5 streangt'"
    sleep 2s
    echo "Streangt: ${streangt}" 		>> $user_save_file
    echo_contiue
}

actionB() {
    item_name="Master key"
    ((dexterity+=5))
    echo "Master key '+5 dexterity'"
    sleep 2s
    echo "Dexterity: ${dexterity}" 		>> $user_save_file
    echo_contiue
}

actionC() {
    item_name="Holy rune"
    ((intelligence+=5))
    echo "Holy rune '+5 intelligence'"
    sleep 2s
    echo "Intelligence: ${intelligence}" 	>> $user_save_file
    echo_contiue
}

actionD() {
    item_name="1k yers stoune"
    ((education+=4))
    echo "1k yers stoune '+4 education'"
    sleep 2s
    echo "Education: ${education}" 		>> $user_save_file
    echo_contiue
}

actionF() {
    item_name="Elder Scrool"
    ((faith+=5))
    echo "Elder Scrool '+5 faith'"
    sleep 2s
    echo "Faith: ${faith}" 		>> $user_save_file
    echo_contiue
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
