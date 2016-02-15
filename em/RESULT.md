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

### Running with thin

`bundle exec thin start`

* db pool = max t = min t = max conn = 400
* Test config: `wrk -t50 -c400 -d10`
* Result:
**  sleep(0.2) 1470+
**  sql_sleep(0.2) 750
**  insert 350+

* Super great sleep
* average sql(probably due to db capacity)

* Not we didn't use any async db adapter
