# gorest
just testing various rest api framework, first with a simple hello world

## Hello World JSON Response
### Results on my MacBook Air

```bash
hey -n 1000 -z 15s http://localhost:8080/
```
| Framework   | Requests/sec | Average[secs] | Slowest |Fastest |
| ------------|-----------: | -----:| -----:| -----:|
| GO net/http | 21'248   | 0.0023 | 0.0628 | 0.0001
| GO FastHttp | 24'612   | 0.0020 | 0.0824 | 0.0001
| Go Aero     | 15'155   | 0.0033 | 0.0722 | 0.0001
| Go Gin      | 15'065   | 0.0033 | 0.1167 | 0.0001

---------------------------------------------------------
```bash
wrk  --latency -d 15 -c 512 --timeout 8 -t 2 http://localhost:8080/ \
-H 'Host: localhost' -H 'Connection: keep-alive' \
-H 'Accept: text/plain,text/html;q=0.9,application/xhtml+xml;q=0.9,application/xml;q=0.8,*/*;q=0.7' 

```
| Framework   | Requests/sec | Latency Avg | Stdev | Max |
| ------------|-----------: | -----:| -----:| -----:|
| Go net/http | 35'150  | 12.46ms | 5.53ms  | 61.40ms
| Go FastHttp | 57'043  | 7.15ms  | 3.68ms  | 75.22ms
| Go Aero     | 28'455  | 12.25ms  | 7.67ms  | 102.12ms
| Go Gin      | 37'725  | 11.19ms | 5.92ms  | 115.23ms
---------------------------------------------------------