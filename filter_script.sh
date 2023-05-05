#!/bin/bash

# This script filters out unwanted URLs from the given input file and outputs the result to a new file

# Define the input file name
INPUT_FILE=$1

# Define the output file name
OUTPUT_FILE=$2

# Filter the input file and output the result to the output file
grep -E 'k2s\.cc.*\.mp4$' $INPUT_FILE > $OUTPUT_FILE
