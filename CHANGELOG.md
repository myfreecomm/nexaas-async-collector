### 3.3.1 - 2017-11-23

* Bug fixes
  * Fix bug when trying to download data through browser [#28](https://github.com/myfreecomm/nexaas-async-collector/pull/28)

### 3.3.0 - 2017-07-28

* Feature
  * Allow user to set global/local expiration for generated data [#26](https://github.com/myfreecomm/nexaas-async-collector/pull/26)
* Bug fixes
  * Force UTF-8 encoding when rendering content in view [#27](https://github.com/myfreecomm/nexaas-async-collector/pull/27)

### 3.2.0 - 2017-07-27

* Feature
  * Ruby support for only one version of 2.3.X and add support for ruby 2.4.0 [#22](https://github.com/myfreecomm/nexaas-async-collector/pull/22)
* Bug fixes
  * Use Base64 to avoid encoding convertion error. [#23](https://github.com/myfreecomm/nexaas-async-collector/pull/23)

### 3.1.0 - 2017-07-26

* Feature
  * Add ability to download content in any format [#21](https://github.com/myfreecomm/nexaas-async-collector/pull/21)

### 3.0.1 - 2017-07-20

* Bug fixes
  * Allow multiples collectors in the same page [#19](https://github.com/myfreecomm/nexaas-async-collector/pull/19)
* Enhancements
  * Update Ruby version in README [#16](https://github.com/myfreecomm/nexaas-async-collector/pull/16)

### 3.0.0 - 2017-07-14

* Feature
  * Drop ruby 2.2.x support
  * Add support for sidekiq 5

### 2.0.1 - 2017-07-14

* Bug fixes
  * Fix and replace scoped_id by scope_id

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
