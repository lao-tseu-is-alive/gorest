#!/usr/bin/env bash
echo "## USING GO NET/HTTP ##"
go build  ../stdhttp/hellotext.go
./hellotext &
hey -n 1000 -z 15s http://localhost:8080/
pkill hellotext
echo "Summary on my MacBook Air for std net/http:"
echo "  Total:	15.0041 secs"
echo "  Slowest:	0.0705 secs"
echo "  Fastest:	0.0001 secs"
echo "  Average:	0.0025 secs"
echo "  Requests/sec:	19776.6524"
echo "  Total data:	10682316 bytes"
echo "  Size/request:	36 bytes"

echo "---------------------------------------------------------"
echo " Concurrency: 1024 for plaintext"
wrk -H 'Host: localhost' -H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' -H 'Connection: keep-alive' --latency -d 15 -c 1024 --timeout 8 -t 2 http://localhost:8080/
echo "---------------------------------------------------------"
echo " Concurrency: 512 for plaintext"
wrk -H 'Host: localhost' -H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' -H 'Connection: keep-alive' --latency -d 15 -c 512 --timeout 8 -t 2 http://localhost:8080/
echo "---------------------------------------------------------"
echo "Summary on my MacBook Air for stdlib net/http:"
echo "Running 15s test @ http://localhost:8080/"
echo "  2 threads and 512 connections"
echo "  Thread Stats   Avg      Stdev     Max   +/- Stdev"
echo "    Latency    12.46ms    5.53ms  61.40ms   74.17%"
echo "    Req/Sec    17.74k     2.29k   22.84k    67.69%"
echo "  Latency Distribution"
echo "     50%   11.90ms"
echo "     75%   14.95ms"
echo "     90%   19.31ms"
echo "     99%   29.85ms"
echo "  529771 requests in 15.07s, 75.78MB read"
echo "  Socket errors: connect 0, read 97, write 0, timeout 0"
echo "Requests/sec:  35150.60"
echo "Transfer/sec:      5.03MB"
echo "#############################################"
echo "## USING GO FASTHTTP ##"
go build -gcflags='-l=4' ../fasthttp/hellotext.go
./hellotext &
hey -n 1000 -z 15s http://localhost:8080/
pkill hellotext
echo "Summary on my MacBook Air for fasthttp:"
echo "  Total:	15.0020 secs"
echo "  Slowest:	0.0758 secs"
echo "  Fastest:	0.0001 secs"
echo "  Average:	0.0021 secs"
echo "  Requests/sec:	23627.4525"
echo "  Total data:	12760524 bytes"
echo "  Size/request:	36 bytes"

echo "---------------------------------------------------------"
echo " Concurrency: 1024 for plaintext"
wrk -H 'Host: localhost' -H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' -H 'Connection: keep-alive' --latency -d 15 -c 1024 --timeout 8 -t 2 http://localhost:8080/
echo "---------------------------------------------------------"
echo " Concurrency: 512 for plaintext"
wrk -H 'Host: localhost' -H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' -H 'Connection: keep-alive' --latency -d 15 -c 512 --timeout 8 -t 2 http://localhost:8080/
echo "---------------------------------------------------------"
echo "Summary on my MacBook Air for fasthttp:"
echo "Running 15s test @ http://localhost:8080/"
echo "  2 threads and 512 connections"
echo "  Thread Stats   Avg      Stdev     Max   +/- Stdev"
echo "    Latency     7.15ms    3.68ms  75.22ms   83.34%"
echo "    Req/Sec    28.80k     4.76k   43.65k    74.24%"
echo "  Latency Distribution"
echo "     50%    7.02ms"
echo "     75%    8.06ms"
echo "     90%    9.72ms"
echo "     99%   20.65ms"
echo "  857537 requests in 15.03s, 127.58MB read"
echo "Requests/sec:  57042.92"
echo "Transfer/sec:      8.49MB"
echo "#############################################"
echo "## USING GO AERO ##"
go build ../aero/hellotext.go
./hellotext &
hey -n 1000 -z 15s http://localhost:8080/
pkill hellotext
echo "Summary on my MacBook Air for AERO:"
echo "  Total:	15.0063 secs"
echo "  Slowest:	0.0626 secs"
echo "  Fastest:	0.0001 secs"
echo "  Average:	0.0026 secs"
echo "  Requests/sec:	19056.6721"
echo "  Total data:	9151040 bytes"
echo "  Size/request:	32 bytes"
echo "---------------------------------------------------------"
echo " Concurrency: 512 for plaintext"
wrk -H 'Host: localhost' -H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' -H 'Connection: keep-alive' --latency -d 15 -c 512 --timeout 8 -t 2 http://localhost:4000/
echo "Running 15s test @ http://localhost:4000/"
echo "  2 threads and 512 connections"
echo "  Thread Stats   Avg      Stdev     Max   +/- Stdev"
echo "    Latency    11.87ms    5.21ms  54.35ms   71.20%"
echo "    Req/Sec    17.43k     2.46k   24.66k    70.10%"
echo "  Latency Distribution"
echo "     50%   11.57ms"
echo "     75%   14.75ms"
echo "     90%   18.35ms"
echo "     99%   27.04ms"
echo "  520871 requests in 15.09s, 89.91MB read"
echo "  Socket errors: connect 0, read 3, write 0, timeout 0"
echo "Requests/sec:  34506.88"
echo "Transfer/sec:      5.96MB"