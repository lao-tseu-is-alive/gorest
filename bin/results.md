# Hello World JSON Response
### Results on my MacBook Air

```bash
hey -n 1000 -z 15s http://localhost:8080/
```
| Framework   | Requests/sec | Average[secs] | Slowest |Fastest |
| ------------|-----------: | -----:| -----:| -----:|
| GO net/http | 19'776   | 0.0025 | 0.0705 | 0.0001
| GO FastHttp | 23'627   | 0.0021 | 0.0758 | 0.0001
| Go Aero     | 19'056   | 0.0026 | 0.0626 | 0.0001

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
| Go Aero     | 34'507  | 11.87ms  | 5.21ms  | 54.35ms
---------------------------------------------------------

#### Latency Distribution

|  Latency |GO net/http|GO FastHttp|GO Aero
| :-------:|-----------:|-----------:|-----------:
|    50%   | 11.90ms | 7.02ms | 11.57ms
|    75%   | 14.95ms | 8.06ms | 14.75ms
|    90%   | 19.31ms | 9.72ms | 18.35ms
|     99%  | 29.85ms | 20.65ms | 27.04ms
