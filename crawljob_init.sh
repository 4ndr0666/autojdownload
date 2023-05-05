#! /bin/bash

# define colors and escape sequence
lightgreen='\033[1;32m'
lightred='\033[1;31m'
orange='\033[0;33m'
cyan='\033[0;36m'
wht='\033[0m'
nc='\033[0J'


# scrape_urls() function scrapes urls from given web page using lynx, cut, grep, awk, sed, sort, uniq tools.
# it can scrape domains, relative urls and all urls.
function scrape_urls() {

# check if correct argument has been given or not and print usage
if [ $# -eq 0 ]; then
	echo "Usage: $0 [-d|-r|-a] url" >&2
	echo "	-d	list primary domains of every link" >&2
	echo "	-r	list only relative links to site" >&2
	echo "	-a	list all links" >&2
	exit 1
fi

# check if number of arguments is greater than one, i.e. contains a flag
if [ $# -gt 1 ]; then
	case "$1" in
		-d) lastcmd="cut -d/ -f3|sort|uniq" # cut only relative urls
			shift
			;;
		-r) basedomain="https://$(echo "$2" | cut -d/ -f3)/" # extract relative domains
			lastcmd="grep \"^$basedomain\"|sed \"s|$basedomain||g\"|sort|uniq"
			shift
			;;
		-a) basedomain="https://$(echo "$2" | cut -d/ -f3)/" # extract all urls
			lastcmd="grep -v \"$basedomain\"|sort|uniq"
			shift
			;;
		*) echo -e "${lightred}$0: unknown option specified: $1" >&2 # error on wrong arguments
			exit 1
	esac
else
	lastcmd="sort|uniq" # only one argument, url is given
fi

# lynx scrapes all the urls based on given parameters 
lynx -dump "$1"|\
	sed -n '/^References$/,$p'|\
	grep -E '[[:digit:]]+\.'|\
	awk '{print $2}'|\
	cut -d\? -f1|\
	eval $lastcmd
}

# ...
# end of scrape_urls() function

# url_check() function checks if scraped url are working or not
# curl is used to check the response of the url
function url_check() {

# counters for various types of link
redirected=0
success=0
error=0
total=0

# variables for rich print
if [ "$1" == "-r" ]; then
	lnktp="relative url(s)"
	append="$2/"
elif [ "$1" == "-d" ]; then
	dir="$2"
	shift
fi

# start the folder watch extension of jdownloader2 in the specified directory
"/opt/JDownloader2/JDownloader2" --add-folderwatch "$dir"

exit 0
}
# end of url_check() function
