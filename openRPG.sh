#!/bin/bash
work_path=$(echo -e `pwd`)
user_save_file=''

if [ -d "$work_path/saves/" ] 
then
    echo #no_effect
else
    mkdir $work_path/saves/
fi

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

    echo -e "Select start gift" 
    sleep 1s
    source start_item.sh
}

echo -e "Welcome openRPG"
#select new game or load char

echo -e "Select:"
    select opt in "New Game" "Load Game"; 
    do
        case $opt in
        "New Game")
            create_character
            break
            ;;
        "Load Game")
            ls $work_path/saves/
            read -r save_file_name
            echo "Input file name"
            user_profile=${work_path}/saves/${save_file_name}.save
            break
            ;;
        *) 
            echo "invalid option $REPLY"
            ;;
        esac
    done

echo -e "You are ready to ..." 
sleep 1s
source story_line.sh

echo -e "First Battle  ..." 
sleep 1s

source battle.sh

echo -e "Coming Soon ..."

