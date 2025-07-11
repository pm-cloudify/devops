file_address="$1"

ua=$(awk -F'"' '{ split($NF, arr, " "); print $6 }' "$file_address" | awk '{print $1}')
status=$(awk -F'"' '{ split($NF, arr, " "); print $3 }' "$file_address" | awk ' $1 >= 100 && $1 < 600 {print $1}')
path=$(awk -F'"' '{ split($NF, arr, " "); print $2 }' "$file_address" | awk '{print $2}')

echo "Top IPs with most requests:"
awk '{print $1}' "$file_address" | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "IP: %s - count: %s\n", $2, $1}'
echo ""

echo "Top most requested paths:"
echo "$path" | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "Path: %s - count: %s\n", $2, $1}'
echo ""

echo "Top most response status codes:"
echo "$status" | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "Status code: %s - count: %s\n", $2, $1}'
echo ""

echo "Top most used user agents:"
echo "$ua" | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "Status code: %s - count: %s\n", $2, $1}'
echo ""
