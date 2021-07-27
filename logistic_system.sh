#!/bin/bash
work_path=$(echo -e `pwd`)

user_profile=$work_path/saves/red.save
source $user_profile

update_variable(){
    sed -i "s/$1/$2/gi" $user_profile
}

list_of_location=("Furgus" "Asminia" "Kubanat" "Red Mounting" "Flat ground" "Gosinalia" "Ackrita" "Tiandom")

# Теорию графов я не учил так что мне "вдоль ноги" 
# я логист. Я не хочу ничего знать, я хочу кратчайший путь  
show_current_location(){
    echo $player_current_location
}

show_specific_location(){
    for ((i = $1 ; i < $1+1 ; i++)); do
        echo "Location $i: ${list_of_location[${i}]}"
    done
}

show_all_locations(){
    array_length=${#list_of_location[@]}
    for ((i = 0 ; i < $array_length ; i++)); do
        echo "Location $i: ${list_of_location[${i}]}"
    done
}

check_player_location(){
    echo "Start location ${list_of_location[0]}"
    
    if [ "$player_current_location" == "${list_of_location[0]}" ];then
        echo "Player on statr location "${list_of_location[0]}""
    else
        echo "Player on $player_current_location"
    fi
}

write_on_file_locat_index(){
    array_length=${#list_of_location[@]}
    path_of_locations_file=`pwd`/data
    for ((i = 0 ; i < $array_length ; i++)); do
        echo "index_$i"="'${list_of_location[${i}]}'" >> $path_of_locations_file/location.lc
    done
}
path_of_locations_file=`pwd`/data
source $path_of_locations_file/location.lc


travel_logic(){
    intermediate_location=""
    # Location 0: Furgus 
    if [[ "$initial_location" == "$index_0" && "$final_location" == "$index_1" || "$initial_location" == "$index_0" && "$final_location" == "$index_4" ]];
        then
            traveler_permission_true="true"  
        elif [[ "$initial_location" == "$index_0" && "$final_location" == "$index_0" ]];
        then
            echo "You You are currently here!"
        else
            traveler_permission_false="false"  
    fi
    
    #Location 1: Asminia 
    if [[ "$initial_location" == "$index_1" && "$final_location" == "$index_0" || "$initial_location" == "$index_1" && "$final_location" == "$index_2" || "$initial_location" == "$index_1" && "$final_location" == "$index_5" ]];
        then
            traveler_permission_true="true"  
        elif [[ "$initial_location" == "$index_1" && "$final_location" == "$index_1" ]];
        then
            echo "You You are currently here!"
        else
            traveler_permission_false="false"  
    fi
    
    #3 Location 2: Kubanat 
    if [[ "$initial_location" == "$index_2" && "$final_location" == "$index_1" || "$initial_location" == "$index_2" && "$final_location" == "$index_3" || "$initial_location" == "$index_2" && "$final_location" == "$index_6" ]];
        then
            traveler_permission_true="true"  
        elif [[ "$initial_location" == "$index_2" && "$final_location" == "$index_2" ]];
        then
            echo "You You are currently here!"
        else
            traveler_permission_false="false"  
    fi

    #4 Location 3: Red_Mounting
    if [[ "$initial_location" == "$index_3" && "$final_location" == "$index_2" || "$initial_location" == "$index_3" && "$final_location" == "$index_6" || "$initial_location" == "$index_3" && "$final_location" == "$index_7" ]];
        then
            traveler_permission_true="true"  
        elif [[ "$initial_location" == "$index_3" && "$final_location" == "$index_3" ]];
        then
            echo "You You are currently here!"
        else
            traveler_permission_false="false"  
    fi

    #5 Location 4: Flat_ground
    if [[ "$initial_location" == "$index_4" && "$final_location" == "$index_0" ]];
        then
            traveler_permission_true="true"  
        elif [[ "$initial_location" == "$index_4" && "$final_location" == "$index_4" ]];
        then
            echo "You You are currently here!"
        else
            traveler_permission_false="false"  
    fi

    #6 Location 5: Gosinalia
    if [[ "$initial_location" == "$index_5" && "$final_location" == "$index_1" ]];
        then
            traveler_permission_true="true"  
        elif [[ "$initial_location" == "$index_5" && "$final_location" == "$index_5" ]];
        then
            echo "You You are currently here!"
        else
            traveler_permission_false="false"  
    fi

    #7 Location 6: Ackrita
    if [[ "$initial_location" == "$index_6" && "$final_location" == "$index_2" || "$initial_location" == "$index_6" && "$final_location" == "$index_3" ]];
        then
            traveler_permission="true"
        elif [[ "$initial_location" == "$index_6" && "$final_location" == "$index_6" ]];
        then
            echo "You You are currently here!"
        else
            traveler_permission="false"
    fi

    #8 Location 7: Tiandom
    if [[ "$initial_location" == "$index_7" && "$final_location" == "$index_3" ]];
        then
            traveler_permission="true"
        elif [[ "$initial_location" == "$index_7" && "$final_location" == "$index_7" ]];
        then
            echo "You You are currently here!"
        else
            traveler_permission_false="false"  
    fi
}

travel_proccess(){
initial_location=$player_current_location
final_location=$index_1

travel_logic 
if [ "$traveler_permission_true" == "true" ];then
    echo "Pl now $player_current_location"
    echo "Flyyyyy"
        search=$(grep "player_current_location=" "$user_profile")
        replace="player_current_location=${final_location}"
        update_variable $search $replace
        player_current_location=$final_location

    echo "Pl now $player_current_location"
else
    echo "V $final_location ne letim Pokashto ha-ha"
fi
}

travel_proccess 
