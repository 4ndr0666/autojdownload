#!/bin/bash

# This script scrapes URLs from a given webpage and outputs the result to a file

# Define the URL to scrape
URL=$1

# Define the output file name
OUTPUT_FILE=$2

# Scrape the URLs and output the result to the file
lynx -dump -listonly $URL | awk '/http/{print $2}' > $OUTPUT_FILE
