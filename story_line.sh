#!/bin/bash

writing(){
    text=$1; 
    for ((i=0; i<${#text}; i++)); 
    do 
        echo "after 35" | tclsh; 
        printf "${text:$i:1}"; 
    done; 
    echo;
}

clear
echo "Story start to ..."
echo ""

writing "The world of Dark Souls is a world of cycles. Kingdoms rise and fall, ages come and go, and even time can end and restart as the flame fades and is renewed. 
These cycles are linked to the First Flame, a mysterious manifestation of life that divides and defines separate states such as heat and cold, or life and death. 
As the First Flame fades, these differences also begin to fade, such as life and death having little distinction, and humans becoming Undead. 
The onset of an Age of Dark, the time when the First Flame has fully died, is marked by endless nights, rampant undeath, time, space, and reality breaking down, 
lands collapsing and converging on one another, people mutating into monsters, darkness covering the world, and the Gods losing their power. 
To avoid this and prolong the Age of Fire, the bearer of a powerful soul must 'link' themselves to the First Flame, becoming the fuel for another age. 
If this is not done, the First Flame will eventually die, and an Age of Dark will begin." 

# "The powerful Lord Souls were taken from the First Flame, used to defeat the dragons, and then to establish kingdoms. 
# Souls are inextricably (and inexplicably) linked to fire. Souls are life, and life is fire; it stands to reason that souls are fire, as well. 
# Without the First Flame and without souls, there is no life. The bearer of a strong soul, called a Lord, who links themselves to the First Flame, 
# is thus rekindling the flames with their own soul, returning life to it. In the end, one could expect that all souls will have been returned to the First Flame, 
# and the Age of Fire will have effectively ended anyways."

# "It is inevitable that people try to find a way around this, another way to continue the Age of Fire without making sacrifices, but in every case they fail. 
# In the first Age of Fire, the Witch of Izalith attempted to create a duplicate of the First Flame using her witchcraft and a special soul, but failed catastrophically. 
# Instead of making another First Flame, she had created a twisted Flame of Chaos that produced distortions of life, turning herself and all her daughters into demons. 
# These demons were malevolent, and wandered the land. Gwyn gathered up his armies and fought the demons of Chaos, eventually driving them back and shackling the Bed of Chaos 
# to bind them. Knowing that the Age of Fire was nearing its end, under the guidance of the primordial serpent Kingseeker Frampt, 
# Gwyn offered himself to the First Flame to stave off the Dark. As the flames surged with new life, the knights who followed him in were burnt by the flames 
# and now wander the world as the Black Knights, hollow shells of armor who attack indiscriminately."