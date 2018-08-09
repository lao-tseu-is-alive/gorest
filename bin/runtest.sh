#!/usr/bin/env bash

echo "## USING GO NET/HTTP ##"
go build  ../stdhttp/hellotext.go
./hellotext &
hey -n 1000 -z 15s http://localhost:8080/ > hello_hey_go_nethttp.txt
echo "---------------------------------------------" >> hello_hey_go_nethttp.txt
wrk -H 'Host: localhost' -H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' -H 'Connection: keep-alive' --latency -d 15 -c 512 --timeout 8 -t 2 http://localhost:8080/ > hello_wrk_go_nethttp.txt
echo "---------------------------------------------" >> hello_wrk_go_nethttp.txt
pkill hellotext
echo "#############################################"
echo "## USING GO FASTHTTP ##"
go build -gcflags='-l=4' ../fasthttp/hellotext.go
./hellotext &
hey -n 1000 -z 15s http://localhost:8080/ > hello_hey_go_fasthttp.txt
echo "---------------------------------------------" >> hello_hey_go_fasthttp.txt
wrk -H 'Host: localhost' -H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' -H 'Connection: keep-alive' --latency -d 15 -c 512 --timeout 8 -t 2 http://localhost:8080/ > hello_wrk_go_fasthttp.txt
echo "---------------------------------------------" >> hello_wrk_go_fasthttp.txt
pkill hellotext
echo "#############################################"
echo "## USING GO AERO ##"
go build ../aero/hellotext.go
./hellotext &
hey -n 1000 -z 15s http://localhost:8080/ > hello_hey_go_aero.txt
echo "---------------------------------------------" >> hello_hey_go_aero.txt
wrk -H 'Host: localhost' -H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' -H 'Connection: keep-alive' --latency -d 15 -c 512 --timeout 8 -t 2 http://localhost:8080/ > hello_wrk_go_aero.txt
echo "---------------------------------------------" >> hello_wrk_go_aero.txt
pkill hellotext
