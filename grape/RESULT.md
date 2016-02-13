# Result

## System Hardware

### Database

* Server on Ali High IO
* 2 CORE, 4 GB RAM, 500GB Yun SSD

### Web Server

* Server on Ali High IO
* 2 CORE, 4 GB RAM, 500GB Yun SSD

### Client Server

* Server on Ali normal IO

## Test Results:

### Running with puma

* db pool = max t = min t = max conn = 400
* Test config: `wrk -t50 -c400 -d10`
* Result:
**  sleep(0.2) 950+
**  sql_sleep(0.2) 750
**  insert 350+

Increasing db max conn to 800 and no difference.
Increasing thread number makes no difference. Rps even drops at some config.
Haven't run test under other configurations.

### Running with thin (multi-thread)

To be tested...
