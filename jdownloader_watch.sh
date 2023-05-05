#! /bin/bash

# Define the path to the folder that JDownloader2 is watching
JDOWNLOADER_WATCH_FOLDER=/4ndr0/home/andro/jdownloader-watch

# Define the path to the folder where the linklist files will be stored
LINKLIST_FOLDER=/4ndr0/home/andro/linklist

# Define the path to the script for scraping links
SCRAPER_SCRIPT=/4ndr0/home/andro/jdownloaderscripts/scraper_script.sh

# Define the path to the script for filtering links
FILTER_SCRIPT=/4ndr0/home/andro/jdownloaderscripts/filter_script.sh

# Define an array of the web pages to crawl
WEB_PAGES=(
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e103.3565440/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e104.3481140/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e105.3407255/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e106.3333895/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e107.3284770/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e110.3237420/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e111.3165710/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e159.3653380/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e160.3776620/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e165.3151650/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e170.3882385/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e171.4014705/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e176.4270110/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e325.3220095/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e375.3267675/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e76.3183080/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e78.3202675/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e79.3253485/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e80.3302245/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e81.3368640/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e83.3443680/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e84.3521520/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e85.3608315/"
"https://forum.phun.org/threads/k2s-downblouse-loving-kim-e93.3138690/"

# Define the path to the script for adding links to JDownloader2
ADD_LINKS_SCRIPT=/4ndr0/home/andro/jdownloaderscripts/add_links_script.sh

# Loop infinitely
while true; do

    # Wait for 5 seconds before continuing to next iteration
    sleep 5

    # Check if there are any linklist files in the linklist folder
    linklist_files=$(find "$LINKLIST_FOLDER" -maxdepth 1 -type f -name "*.crawljob")

    # If there are linklist files in the linklist folder
    if [[ -n $linklist_files ]]; then

        # Move all the linklist files to the folder that JDownloader2 is watching
        mv "$LINKLIST_FOLDER"/*.crawljob "$JDOWNLOADER_WATCH_FOLDER"

        # Loop through each linklist file in the JDownloader2 watch folder
        for file in "$JDOWNLOADER_WATCH_FOLDER"/*.crawljob; do

            # Scrape the links from the webpage using the scraper script
            scraped_links=$("$SCRAPER_SCRIPT" "$file")

            # Filter the links using the filter script
            filtered_links=$("$FILTER_SCRIPT" "$scraped_links")

            # Add the filtered links to JDownloader2 using the add links script
            "$ADD_LINKS_SCRIPT" "$filtered_links"

            # Move the processed linklist file to a new folder for backup
            mv "$file" "$JDOWNLOADER_WATCH_FOLDER"/processed

        done
    fi
done
