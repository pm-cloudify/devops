# Use this script to put stress on your machine cpu
# I used this for a 2 core machine.
sudo stress-ng --cpu 2 --timeout 60s

# this is used to put stress on memory
sudo stress --vm 1 --vm-bytes 1G
