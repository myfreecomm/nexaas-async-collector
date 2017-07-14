### 2.0.0 - 2017-07-14

* Feature
  * Add ActiveSupport instrumentation when starting and finishing job processing [#14](https://github.com/myfreecomm/nexaas-async-collector/pull/14)

### 1.2.2 - 2017-07-13

* Bug fixes
  * Use sidekiq redis connection pool to get/set data [#13](https://github.com/myfreecomm/nexaas-async-collector/pull/13)

### 1.2.1 - 2017-06-28

* Bug fixes
  * Change result rendering order [#11](https://github.com/myfreecomm/nexaas-async-collector/pull/11)
  * Fix helper injection [#12](https://github.com/myfreecomm/nexaas-async-collector/pull/12)

### 1.2.0 - 2017-06-24

* Enhancements
  * Add queue_name configuration [#9](https://github.com/myfreecomm/nexaas-async-collector/pull/9)
  * Relax redis-namespace dependency version [#3](https://github.com/myfreecomm/nexaas-async-collector/pull/3)
* Bug fixes
  * Fix parent_controller config [#7](https://github.com/myfreecomm/nexaas-async-collector/pull/7)
  * Isolate engine namepace and change how the routes are added to the app [#8](https://github.com/myfreecomm/nexaas-async-collector/pull/8)
