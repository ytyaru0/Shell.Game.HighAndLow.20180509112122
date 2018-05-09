#trap "ScreenClear; tput cnorm; tput sgr0; exit 1;" {1,2,3,15}
trap "End; exit 1;" {1,2,3,15}
rows=`tput lines`
cols=`tput cols`
rows=`expr $rows - 1`
End(){ { ScreenClear; tput cnorm; tput sgr0; } }
PrintChars(){ printf %${2}s | tr ' ' "$1"; }
NowLineClear(){
    tput cub $cols
    PrintChars ' ' $cols
}
#LineClear(){ PrintChars " " $cols; }
#OverwriteLastLine(){ tput cub $cols; printf %${cols}s | tr ' ' ' '; printf "$1" }
OverwriteLastLine(){
    tput cub $cols
    printf %${cols}s | tr ' ' ' '
    tput cuu 1
    printf "$1"
}
ScreenClear(){
    tput cup 0 0
    for row in `seq 0 $rows`; do
        #printf %${cols}s | tr ' ' ' '
        PrintChars " " $cols
    done
    tput cup 0 0
}
MaxVal=10
ClearNum=0
RunNum=0
Rate=0
RateImgFig=2
Continuity=0
ScreenHiLo(){
    tput cup 0 0
    local screen=$(cat <<EOS
$Rate% $Continuity ($ClearNum/$RunNum)                                         

  $QVal $AVal

High or Low ? [h/l]:                                                           
EOS
)
    echo -n "$screen"
}
Calc(){
    ((RunNum++))
    #Rate=$(( ( ClearNum * 10000 ) / RunNum ))
    #Rate="${Rate:0:-3}.${Rate:$((${#Rate}-2))}"
    Rate=$(( ( ClearNum * 100 * $((10**(RateImgFig+1))) ) / RunNum ))
    Rate="${Rate:0:$((-1*($RateImgFig+1)))}.${Rate:$((${#Rate}-$RateImgFig))}"
    #Rate=${Rate}
    if [ "Win!" =  "$Result" ]; then
        if [ '+' = "${Continuity:0:1}" ]; then
            #$((${Continuity:1} + 1))
            Continuity="${Continuity:0:1}$((${Continuity:1} + 1))"
        else
            Continuity="+1"
        fi
    elif [ "Lose..." =  "$Result" ]; then
        if [ '-' = "${Continuity:0:1}" ]; then
            Continuity="${Continuity:0:1}$((${Continuity:1} + 1))"
        else
            Continuity="-1"
        fi
    fi
}
# 0..255
#GetRandomValue(){ { return $((RANDOM % $MaxVal)); } }
#GetRandomValue(){ { echo `$((RANDOM % $MaxVal))`; } }
#GetRandomValue(){
#    echo `$((RANDOM % $MaxVal))`
#}
ScreenClear
# 装飾の初期化
tput sgr0
# カーソル非表示
tput civis 
#echo "rows=$rows rows-1=`expr $rows - 1`"
while : ; do
    QVal=`echo $((RANDOM % $MaxVal))`
    ScreenHiLo
    read -n1 input
    AVal=`echo $((RANDOM % $MaxVal))`
    Result="Lose..."
    [ "$input" == 'h' ] && { [ $QVal -le $AVal ] && { ((ClearNum++)); Result="Win!"; } }
    [ "$input" == 'l' ] && { [ $AVal -le $QVal ] && { ((ClearNum++)); Result="Win!"; } }
    [ "$input" == 'q' ] && break
    Calc
    ScreenHiLo
    OverwriteLastLine "$Result  some key press !"
    read -s -n1 -t5
    #NowLineClear
    AVal=`PrintChars " " ${#AVal}`
done

End
# https://qiita.com/onokatio/items/5d282b72ac5565ae4569
# cuu, cud
