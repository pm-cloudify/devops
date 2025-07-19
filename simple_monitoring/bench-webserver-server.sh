# wrk and ab are good tools to test performance of your web servers (like nginx)
echo "using wrk..."
wrk -t24 -c1000 -d60s "$1"
echo "using apache benchmark..."
ab -n 1000 -c 100 "$1"
