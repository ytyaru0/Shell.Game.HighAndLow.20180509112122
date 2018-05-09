# できない
CountDown(){
    GetCurPos
    GetCurRow
    GetCurCol
    count=$1
    cols=`tput cols`
    #while [ 0 -lt $count ] ; do
    #    PrintChars " " $cols
    #    tput cuu 1
    #    tput cub $cols
    #    echo -n "$count"
    #    sleep 1
    #    ((count--))
    #done
}
PrintChars(){ printf %${2}s | tr ' ' "$1"; }
# `row;col`の文字列
GetCurPos(){
    echo -en "\E[6n"
    read -sdR CURPOS
    CURPOS=${CURPOS#*[}
    echo $CURPOS
    #echo "row="`tput line`",col="`tput col`
}
GetCurRow(){
    local pos=`GetCurPos`
    rowcol=${path/;/ };
    echo "${rowcol[0]}"
}
GetCurCol(){
    local pos=`GetCurPos`
    rowcol=${path/;/ };
    echo "${rowcol[1]}"
}
CountDown 10
