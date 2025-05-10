#!/bin/bash

# Infinite loop
while true; do
    # Create a file
    touch my_temp_file.txt
    echo "Created file: my_temp_file.txt"
    
    # Wait for 1 second
    sleep 1
    
    # Delete the file
    rm my_temp_file.txt
    echo "Deleted file: my_temp_file.txt"
    
    # Wait for 1 second before looping again
    sleep 1
done
