# Hello World Text Response
### Results with physical client machine and server over real cable network
### I took the best results over 4 runs

```bash
hey -z 15s -n 1000  http://192.168.50.31:8080/plaintext -H 'Host: localhost' -H 'Connection: keep-alive'
```
| Framework   | Requests/sec | Average[secs] | Slowest |Fastest |
| ------------|-----------: | -----:| -----:| -----:|
| GO net/http | 136'974  | 0.0007 | 0.0102 | 0.0001
| GO simple01 | 132'035  | 0.0007 | 0.0091 | 0.0001
| GO FastHttp | 156'139  | 0.0007 | 0.0195 | 0.0000
| Go Aero     | 135'030  | 0.0007 | 0.0112 | 0.0001
| Go Gin      | 134'959  | 0.0007 | 0.0089 | 0.0001
---------------------------------------------------------
```bash
wrk --latency -t 10 -c 512 -d15s http://192.168.50.31:8080/plaintext -H 'Host: localhost' -H 'Connection: keep-alive'
```
Running 15s test @ http://192.168.50.31:8080/plaintext 10 threads and 512 connections

| Framework   | Requests/sec | Latency Avg | Stdev | Max |
| ------------|-----------: | -----:| -----:| -----:|
| Go net/http | 215'813 |  2.62ms  |  2.02ms |  44.21ms
| Go simple01 | 208'190 |  3.04ms  |  7.07ms | 214.42ms
| Go FastHttp | 293'116 |  3.00ms  | 12.88ms | 210.22ms
| Go Aero     | 229'245 |  2.93ms  |  8.27ms | 213.57ms
| Go Gin      | 219'055 |  2.56ms  |  1.91ms |  30.55ms
---------------------------------------------------------
