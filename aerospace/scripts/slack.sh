#!/bin/bash

# Check the number of connected displays
display_count=$(system_profiler SPDisplaysDataType | grep -c "Resolution")

# Move Slack to the appropriate workspace based on the number of displays
if [ "$display_count" -gt 3 ]; then
    move-node-to-workspace 3
else
    move-node-to-workspace S
fi
