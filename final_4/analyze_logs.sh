#!/bin/bash

count=$(wc -l < access.log)
echo "Общее количество запросов: $count" >> report.txt
unique_ips=$(awk '{print $1}' access.log | sort | uniq | wc -l)
echo "Количество уникальных IP-адресов: $unique_ips" >> report.txt
methods=$(awk '{gsub(/"/, "", $6); count[$6]++} END {for (m in count) print m ": " count[m]}' access.log)
echo "Количество запросов по методам:" >>  report.txt
echo "$methods" >> report.txt
top_url=$(awk '{count[$7]++} END {max=0; for (url in count) if (count[url]>max) {max=count[url]; popular=url} print popular}' access.log)
echo "Самый популярный URL: $top_url" >> report.txt

