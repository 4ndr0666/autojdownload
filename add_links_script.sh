#!/bin/bash

# This script adds links to JDownloader2 by putting linklist files in the watch folder

# Define the path to the folder that JDownloader2 is watching
JDOWNLOADER_WATCH_FOLDER=$1

# Define the path to the folder where the linklist files will be stored
LINKLIST_FOLDER=$2

# Define the name of the linklist file to create
LINKLIST_FILE=$LINKLIST_FOLDER/myLinks.crawljob

# Scrape URLs from the given webpage and output the result to a file
SCRAPED_LINKS=$("$3" "$4")

# Filter out unwanted URLs from the file and output the result to a new file
FILTERED_LINKS=$("$5" "$SCRAPED_LINKS")

# Create the linklist file with the filtered URLs
echo "->NEW ENTRY<-" > "$LINKLIST_FILE"
echo "text=$(echo "$FILTERED_LINKS" | sed -e 's/\\/\\\\/g; s/\$/\\\$/g')" >> "$LINKLIST_FILE"

# Move the linklist file to the watch folder
mv "$LINKLIST_FILE" "$JDOWNLOADER_WATCH_FOLDER"
