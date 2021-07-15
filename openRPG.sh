#!/bin/bash

work_path=$(echo -e `pwd`)
version=0.0.5

##################################################################

if [[ "${1}" == "--debug" ]]; then
    function debug {
        echo "$1" >&2
    }
else
    function debug {
        :
    }
fi

if [ -d "$work_path/saves/" ] 
then
    echo #no_effect
else
    mkdir $work_path/saves/
fi

start_menu(){
echo -e "Select:"
select opt in "New Game" "Load Game"; 
do
    case $opt in
    "New Game")
        create_character
        break
        ;;
    "Load Game")
        if [[ ! -z $(ls -A "$work_path/saves/") ]]; then
            list_save_files=($(ls $work_path/saves/ | awk {'print $1'}))
            menu_from_array "${list_save_files[@]}"
            user_profile=${work_path}/saves/${save_file_name}
            break
        else
            echo "Saves on found! Please, create character"
            sleep 2s
            create_character
            break
        fi
        ;;
    *) 
        echo "invalid option $REPLY"
        ;;
    esac
done
}

create_character(){
    echo -e "Create new character"
    echo -e "Input your name:"

    read -r input
    user_profile=${work_path}/saves/${input}.save
    echo '#!/bin/bash' > $user_profile
    echo "player_name=${input}" >> $user_profile
    echo "Writed to file: " $user_profile
    sleep 1.5s

    echo -e "Seclect your class:"
    sleep 1s
    source classes.sh

    # echo -e "Select start gift" 
    # sleep 1s
    # source start_item.sh


    echo -e "You are ready to ..." 
    sleep 1s
    source story_line.sh
}

menu_from_array (){
select item; 
do
    if [ 1 -le "$REPLY" ] && [ "$REPLY" -le $# ];then
        echo "The selected is $item"
        save_file_name=${item}
        break;
    else
        echo "Wrong selection: Select any number from 1-$#"
    fi
done
}

##############################################################

echo -e "Welcome openRPG"
echo -e "Created by Redian23"
echo -e "Version ${version}"
echo ""

start_menu

printf '%s\n' "scenario teleport" | awk '{ print toupper($0) }'
echo -ne "\r *" 
sleep 0.5s
echo -ne "\r \t*" 
sleep 0.5s
echo -ne "\r \t*\t*"
sleep 0.5s
echo -ne "\r \t*\t*\t*"
sleep 0.5s
echo -ne "\r \t*\t*\t*\t*"
sleep 0.5s
echo ""

echo -e "First Battle  ..." 
sleep 1s

#init first enemy 
enemy_profile_name=boar
enemy_profile=${work_path}/enemies/${enemy_profile_name}.file


debug $user_profile && sleep 1s
debug $enemy_profile && sleep 1s


source battle.sh $user_profile $enemy_profile 

echo -e "Coming Soon ..."

### 
# stage 1 
# stage 2
# stage 3
# final
# final boss
