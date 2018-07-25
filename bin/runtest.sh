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
echo "## USING GO FASTHTTP ##"
go build ../fasthttp/hellotext.go
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