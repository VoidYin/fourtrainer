#!/bin/bash

#set -xu

randomfor(){
       (( number1 = RANDOM % 1000 ))
       (( number2 = RANDOM % 1000 ))
       (( oper = RANDOM % 4 ))
       case $oper in
       0)
               (( rightans = number1 + number2 ))
               operchar='+'
       ;;
       1)
               (( rightans = number1 - number2 ))
               operchar='-'
       ;;
       2)
               (( rightans = number1 * number2 ))
               operchar='*'
       ;;
       3)
               until (( number2 != 0 )); do
                       number2=$RANDOM
               done
               (( rightans = number1 / number2 ))
               operchar='/'
       ;;
       esac

       echo "${number1} ${operchar} ${number2} = ?"
       read answer
       until (( answer == rightans )); do
               read -p "回答错误，请继续输入" answer
       done
       echo "回答正确，答案：${rightans}"

}

while true; do
       randomfor
done


