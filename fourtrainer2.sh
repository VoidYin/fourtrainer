
#!/bin/bash

#set -xu

randomfor(){
       (( number1 = $RANDOM % 1000 ))
       (( number2 = $RANDOM % 1000 ))
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
               #(( rightans = number1 / number2 ))
               rightans=`echo "scale=6; ${number1} / ${number2}" | bc`
               operchar='/'
       ;;
       esac

       echo "${number1} ${operchar} ${number2} = ?"

       while true; do

               read answer

               rlt=`bc << eof
define abs(n) {
       if (n < 0) return -n;
       return n;
}
scale=6
if ( ${rightans} != 0 ) {
       abs( ${answer} / ${rightans} - 1 ) < 0.05;
} else {
       ${answer} == ${rightans};
}
eof
`
#上面部分为什么要这么缩进，因为<<的最后一个eof要单独占一行，并且前后不能有任何字符

               (( rlt == 1 )) && break

               echo "回答错误，请继续输入"  

       done

       echo "回答正确，答案：${rightans}"
}

while true; do
       randomfor
       echo "下一题"
done

