trap "End; exit 1;" {1,2,3,15}
rows=`tput lines`
cols=`tput cols`
rows=`expr $rows - 1`
End(){ { ScreenClear; tput cnorm; tput sgr0; stty echo 2>/dev/null; } }
PrintChars(){ printf %${2}s | tr ' ' "$1"; }
OverwriteLastLine(){
    tput cub $cols
    printf %${cols}s | tr ' ' ' '
    tput cuu 1
    printf "$1"
}
ScreenClear(){
    tput cup 0 0
    for row in `seq 0 $rows`; do
        PrintChars ' '  $cols
    done
    tput cup 0 0
}
MaxVal=10
ClearNum=0
RunNum=0
Rate=0
RateImgFig=2
Continuity=0
RES_W="WIN!"
RES_L="LOSE..."
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
    if [ 0 -eq $ClearNum ]; then
        Rate=0`PrintChars '0' $RateImgFig`
    else
        Rate=$(( ( ClearNum * 100 * $((10**(RateImgFig))) ) / RunNum ))
    fi
    Rate="${Rate:0:$((-1*($RateImgFig)))}.${Rate:$((${#Rate}-$RateImgFig))}"
    if [ "$RES_W" =  "$Result" ]; then
        if [ '+' = "${Continuity:0:1}" ]; then
            Continuity="${Continuity:0:1}$((${Continuity:1} + 1))"
        else
            Continuity="+1"
        fi
    elif [ "$RES_L" =  "$Result" ]; then
        if [ '-' = "${Continuity:0:1}" ]; then
            Continuity="${Continuity:0:1}$((${Continuity:1} + 1))"
        else
            Continuity="-1"
        fi
    fi
    ScreenHiLo
    OverwriteLastLine "$Result  some key press !"
    read -s -n1 -t7
    AVal=`PrintChars " " ${#AVal}`
}
InputLoop(){
    while : ; do
        read -s -n1 input
        [ 'h' = "$input" -a $QVal -le $AVal ] && { ((ClearNum++)); Result="$RES_W"; }
        [ 'l' = "$input" -a $AVal -le $QVal ] && { ((ClearNum++)); Result="$RES_W"; }
        case "$input" in
            'h' | 'l') break;;
            'q') { End; exit 0; };;
            *) continue;;
        esac
    done
}
ScreenClear
# 装飾の初期化
tput sgr0
# カーソル非表示
tput civis 
#echo "rows=$rows rows-1=`expr $rows - 1`"
while : ; do
    QVal=`echo $((RANDOM % $MaxVal))`
    ScreenHiLo
    AVal=`echo $((RANDOM % $MaxVal))`
    Result="$RES_L"
    InputLoop
    Calc
done
End
