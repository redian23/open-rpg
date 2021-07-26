#!/bin/bash
work_path=$(echo -e `pwd`)

menu_from_array (){
select item; 
do
    if [ 1 -le "$REPLY" ] && [ "$REPLY" -le $# ];then
        echo "The selected is $item"
        selected_item_in_menu=${item}
        break;
    else
        echo "Wrong selection: Select any number from 1-$#"
    fi
done
}

echo -e "List of quest folders"
quest_folder_list=$(ls -1p `pwd`/data/quests/)
menu_from_array $quest_folder_list
quest_menu=$selected_item_in_menu
echo -e $quest_menu

QUEST_LOGIC(){
    :
}

QUEST_CREATER(){
    create_quest_file(){
        if [ "$quest_menu" == "main_quests/" ];then
            echo "Set Name fo new Main Quest "
            #user input 
            read quest_name 
            quest_file=`pwd`/data/quests/$quest_menu/${quest_name}.qst
            ls -1 `pwd`/data/quests/$quest_menu
            echo -e "Quest Name: ${quest_name}" > $quest_file
        else   
            echo "Set Name fo new Side Quest "
            #user input 
            read side_quest_name 
            quest_file=`pwd`/data/quests/$quest_menu/${quest_name}.qst
            echo -e "Quest Name: ${side_quest_name}" > $quest_file
        fi
    }

    set_quest_discription(){
        echo "Set New quest discription"
        #user input 
        read quest_discription
        echo -e "Quest discription: ${quest_discription}" >> $quest_file
    }
    
    set_location(){
        echo "Set location for main quest"
        #select
        read quest_location
        echo -e "Quest Location: ${quest_location}" >> $quest_file
    }

    set_storyteller_NPC(){
        echo "Set storyteller_NPC"
        #select list on NPC
        read quest_storyteller_NPC
        echo -e "Quest storyteller NPC: ${quest_storyteller_NPC}" >> $quest_file
    }

    set_quest_target(){
        echo "Set quest targer"
        #select list on enemy

        list_of_enemies=$(ls -1p `pwd`/data/enemies/)
        echo -e "List of enemies"
        menu_from_array $list_of_enemies
        quest_target=$selected_item_in_menu
        echo -e "Quest target: ${quest_target}" >> $quest_file
    }

    type_of_quest(){
        :
        #select 
        # 1. Buttle
        # 2. Piece    
    }
    set_quest_target_number(){
        echo "Set quest numder of targer"
        read target_number 
        if [ $target_number -lt "5" ];then
            quest_diff="Easy"
            elif [ $target_number -lt "10" ];then
                quest_diff="Medium"
                elif [ $target_number -lt "15" ];then
                    quest_diff="Hard"
                    elif [ $target_number -le "0" ];then
                            echo "0x43ax zero_pointer_exception_Kyrwa"
                        else
                            echo "Are you sure that so ${target_number} opponents is normal?"
        fi
        echo -e "Quest diff: ${quest_diff}" >> $quest_file
        echo -e "Quest number of target: ${target_number}" >> $quest_file
    }

    # edit number of target
    # edit gift_item 
    # edit covinant

    create_quest_file
    set_quest_discription
    set_location
    set_quest_target
    set_quest_target_number
}

QUEST_CREATER