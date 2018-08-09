#!/usr/bin/env bash
DATE=`date -u`
echo "## TESTING GO NET/HTTP ##"
go build  ../stdhttp/hellotext_stdhttp.go
./hellotext_stdhttp &
echo "# ${DATE} hey Bench plaintext on GO NET/HTTP #" > hello_hey_go_nethttp.txt
echo "---------------------------------------------" >> hello_hey_go_nethttp.txt
hey -n 1000 -z 15s http://localhost:8080/plaintext >> hello_hey_go_nethttp.txt
echo "---------------------------------------------" >> hello_hey_go_nethttp.txt
echo "# ${DATE} wrk Bench plaintext on GO NET/HTTP #" > hello_wrk_go_nethttp.txt
echo "---------------------------------------------" >> hello_wrk_go_nethttp.txt
wrk -H 'Host: localhost' -H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' -H 'Connection: keep-alive' --latency -d 15 -c 512 --timeout 8 -t 2 http://localhost:8080/plaintext >> hello_wrk_go_nethttp.txt
echo "---------------------------------------------" >> hello_wrk_go_nethttp.txt
pkill hellotext_stdhttp
echo "#############################################"
echo "## TESTING GO FASTHTTP ##"
go build -gcflags='-l=4' ../fasthttp/hellotext_fasthttp.go
./hellotext_fasthttp &
echo "# ${DATE} hey Bench plaintext on GO FASTHTTP #" > hello_hey_go_fasthttp.txt
echo "---------------------------------------------" >> hello_hey_go_fasthttp.txt
hey -n 1000 -z 15s http://localhost:8080/plaintext >> hello_hey_go_fasthttp.txt
echo "---------------------------------------------" >> hello_hey_go_fasthttp.txt
echo "# ${DATE} wrk Bench plaintext on GO FASTHTTP #" > hello_wrk_go_fasthttp.txt
echo "---------------------------------------------" >> hello_wrk_go_fasthttp.txt
wrk -H 'Host: localhost' -H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' -H 'Connection: keep-alive' --latency -d 15 -c 512 --timeout 8 -t 2 http://localhost:8080/plaintext >> hello_wrk_go_fasthttp.txt
echo "---------------------------------------------" >> hello_wrk_go_fasthttp.txt
pkill hellotext_fasthttp
echo "#############################################"
echo "## USING GO AERO ##"
go build ../aero/hellotext_aero.go
./hellotext_aero &
echo "# ${DATE} hey Bench plaintext on GO AERO #" > hello_hey_go_aero.txt
echo "---------------------------------------------" >> hello_hey_go_aero.txt
hey -n 1000 -z 15s http://localhost:8080/plaintext >> hello_hey_go_aero.txt
echo "---------------------------------------------" >> hello_hey_go_aero.txt
echo "# ${DATE} wrk Bench plaintext on GO FASTHTTP #" > hello_wrk_go_aero.txt
echo "---------------------------------------------" >> hello_wrk_go_aero.txt
wrk -H 'Host: localhost' -H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' -H 'Connection: keep-alive' --latency -d 15 -c 512 --timeout 8 -t 2 http://localhost:8080/plaintext >> hello_wrk_go_aero.txt
echo "---------------------------------------------" >> hello_wrk_go_aero.txt
pkill hellotext_aero
echo "#############################################"
echo "## USING GO GIN ##"
go build ../gin/hellotext_gin.go
./hellotext_gin &
echo "# ${DATE} hey Bench plaintext on GO GIN #" > hello_hey_go_gin.txt
echo "---------------------------------------------" >> hello_hey_go_gin.txt
hey -n 1000 -z 15s http://localhost:8080/plaintext >> hello_hey_go_gin.txt
echo "---------------------------------------------" >> hello_hey_go_gin.txt
echo "# ${DATE} wrk Bench plaintext on GO GIN     #" > hello_wrk_go_gin.txt
echo "---------------------------------------------" >> hello_wrk_go_gin.txt
wrk -H 'Host: localhost' -H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' -H 'Connection: keep-alive' --latency -d 15 -c 512 --timeout 8 -t 2 http://localhost:8080/plaintext >> hello_wrk_go_gin.txt
echo "---------------------------------------------" >> hello_wrk_go_gin.txt
pkill hellotext_gin
