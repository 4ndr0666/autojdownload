#!/bin/bash

# Include the existing url_check function
source /$HOME/autojdownload/url_scraper

output_dir="/4ndr0/home/andro/jdownloader-watch/"

# Call url_scraper and pass the output to the loop
read -p "Enter the forum thread's parent URL: " forum_thread_parent
while read -r thread_url; do
    echo "Processing thread: $thread_url"
    while read -r k2s_url; do
        echo "Found k2s.cc link: $k2s_url"
        echo "$k2s_url" >> "${output_dir}k2s_links.txt"
    done < <(scrape_urls -a "$thread_url" | grep "https://k2s.cc/file/")
done < <(scrape_urls -a "$forum_thread_parent" | grep "https://forum.phun.org/threads/")

# Create a crawljob file for each k2s.cc link
while read -r link; do
    package_name=$(basename "$link")
    crawljob_filename="${output_dir}${package_name}.crawljob"

    cat > "$crawljob_filename" << EOL
->NEW ENTRY<-
   text=$link
   packageName=$package_name
   priority=DEFAULT
   downloadFolder=null
   enabled=null
   autoStart=TRUE
   extractAfterDownload=UNSET
   addOfflineLink=true
   overwritePackagizerEnabled=false
   setBeforePackagizerEnabled=true
   deepAnalyseEnabled=false
EOL
done < "${output_dir}k2s_links.txt"
