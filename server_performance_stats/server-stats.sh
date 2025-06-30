#!/bin/bash -
#===============================================================================
#
#          FILE: server-stats.sh
#
#         USAGE: ./server-stats.sh
#
#   DESCRIPTION: This script is use to get a snapshot of current system performance
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Pouya Mohammadi,
#  ORGANIZATION: pm-cloudify
#       CREATED: 06/30/2025 08:43:46 AM
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

# echo "CPU info:"
# echo ""
# lscpu | head -10
# echo ""

echo "CPU utilization :"
echo ""
echo "CPU Usage: "$((100-$(vmstat 1 2|tail -1|awk '{print $15}')))"%"
echo ""

echo "Memory utilization :"
echo ""
free | awk '/^Mem/ {printf("Free: %.2f%%, Used: %.2f%%\n\n", $4/$2*100, $3/$2*100)}'
# free -h
echo ""

echo "Disk utilization :"
echo ""
df -t ext4 | awk '/^\/dev/  {printf("%s - Free: %0.2f%%, Used: %.2f%%\n", $1, $4/$2*100, $3/$2*100)}' 
echo ""

echo "Top 5 CPU intensive process info:"
echo ""
# use htop to watch real-time process and system information
ps -eo pid,pcpu,pmem,user,time,tty --sort -%cpu  | head -6
echo ""

echo "Top 5 Memory intensive process info:"
echo ""
# use vmstat to see more info about virtual memeory
ps -eo pid,pcpu,pmem,user,time,tty --sort -%mem  | head -6
echo ""
