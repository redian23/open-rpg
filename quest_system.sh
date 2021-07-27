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

check_data_folder(){
    echo -e "List of quest folders"
    quest_folder_list=$(ls -1p `pwd`/data/quests/)
    menu_from_array $quest_folder_list
    quest_menu=$selected_item_in_menu
    echo -e $quest_menu
}

check_data_folder 

QUEST_CREATER(){
    create_quest_file(){
        if [ "$quest_menu" == "main_quests/" ];then
            echo "Set Name fo new Main Quest "
            #user input 
            read main_quest_name 
            quest_file=`pwd`/data/quests/$quest_menu/${main_quest_name}.qst
            echo -e "Quest Name: ${main_quest_name}" > $quest_file
        else   
            echo "Set Name fo new Side Quest "
            #user input 
            read side_quest_name 
            quest_file=`pwd`/data/quests/$quest_menu/${side_quest_name}.qst
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
        list_of_location=("Furgus" "Asminia" "Kubanat" "Red Mounting" "Flat ground" "Gosinalia" "Ackrita" "Tiandom")
        menu_from_array "${list_of_location[@]}"
        quest_location=$selected_item_in_menu
        echo -e "Quest Location: ${quest_location}" >> $quest_file
    }

    set_storyteller_NPC(){
        echo "Set storyteller_NPC"
        list_of_NPC=("Imperio Hust" "Browar Tutne" "Ruas Boiur" "Kranassa Wics" "Tiara Fubiam" "Rybnik Shaer" "Fungrah Hugun" "Dirna Viofia")
        menu_from_array "${list_of_NPC[@]}"
        quest_storyteller_NPC=$selected_item_in_menu
        echo -e "Quest storyteller NPC: ${quest_storyteller_NPC}" >> $quest_file
    }

    set_quest_target(){
        if [ $quest_type == "Buttle" ];then
            echo "Set quest targer"
            list_of_enemies=$(ls -1p `pwd`/data/enemies/)
            echo -e "List of enemies"
            menu_from_array $list_of_enemies
            quest_target=$selected_item_in_menu
            echo -e "Quest target: ${quest_target}" >> $quest_file
        else

        fi
    }

    set_type_of_quest(){
        echo -e "Select:"
        select opt in "Buttle" "Find"; 
        do
            case $opt in
            "Buttle")
                quest_type="Buttle"
                echo -e "Quest type: ${quest_type}" >> $quest_file
                ;;
            "Find")
                quest_type="Find"
                echo -e "Quest type: ${quest_type}" >> $quest_file
                ;;
            *) 
                echo "invalid option $REPLY"
                ;;
            esac
        done    
    }

    set_quest_target_number(){
        echo "Set quest numder of targer"
        while :
        do
            read target_number 
            set_quest_diff
        done
        echo -e "Quest number of target: ${target_number}" >> $quest_file
    }

    set_quest_diff(){
    if [ "$target_number" -eq "0" ];then
    echo "0x43ax zero_pointer_exception_Kurwa"
        elif [ "$target_number" -lt "5" ];then
            quest_diff="Easy"
            break;
            elif [ "$target_number" -lt "10" ];then
                quest_diff="Medium"
                break;
                elif [ "$target_number" -lt "15" ];then
                    quest_diff="Hard"
                    break;
                else
                    echo "Are you sure that so ${target_number} number is normal?"
    fi
    echo -e "Quest diff: ${quest_diff}" >> $quest_file
    }

    set_quest_award(){
        echo "Set quest award"
        #select list on items or GOLD 
        echo -e "Select:"
        select opt in "Item" "Gold"; 
        do
            case $opt in
            "Item")
                quest_award="Item bla-bla-bla"
                #index item
                echo -e "Quest award: ${quest_award}" >> $quest_file
                ;;
            "Gold")
                quest_award="100500 old gold"
                #size gold
                echo -e "Quest award: ${quest_award}" >> $quest_file
                ;;
            *) 
                echo "invalid option $REPLY"
                ;;
            esac
        done    
    }

    set_quest_keeper_covenant(){
        echo "Set quest keeper covenant"
        list_of_covenant=("Aster" "Bordi" "Tensai" "Kerassa" "Mebius" "WarLang" "Ezers" "Kirma")
        menu_from_array "${list_of_covenant[@]}"
        quest_keeper_covenant=$selected_item_in_menu
        echo -e "Quest discription: ${quest_keeper_covenant}" >> $quest_file
    }
    
    add_more_quest(){
        echo "Want to create more quests?"
        select opt in "Yes" "NO"; 
        do
            case $opt in
            "Yes")
                QUEST_CREATER
                ;;
            "No")
                exit 0
                ;;
            *) 
                echo "invalid option $REPLY"
                ;;
            esac
        done   
        
    }

    create_quest_file
    set_quest_discription
    set_location
    set_storyteller_NPC
    set_type_of_quest

    set_quest_target_number
    set_quest_keeper_covenant
    add_more_quest
}

if [[ "$1" == --create ]]; then 
QUEST_CREATER 
fi

