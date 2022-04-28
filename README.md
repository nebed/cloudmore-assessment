# cloudmore-assessment

## Task 1

### Tools Used
 - Terraform
 - Ansible

### Package Configuration
 - Docker
 - Docker Compose
 - Prometheus - Container [Visit](http://40.122.71.123:9090)
 - Node Exporter - Container [Visit](http://40.122.71.123:9100)
 - Grafana - Container [Visit](http://40.122.71.123:3000)

A vm was created in Azure with terraform, with a public IP and security group to allow access to monitoring applications only. Ansible was used to configure the vm and install and configure the necessary packages.
Then a bash script is being used to pull the temperature from [OpenWeather API](https://openweathermap.org/api)
and is written to a file which is then scraped by the Node Exporter Textfile Collector

A cronjob is configures to run the temperature bash script every 2 minutes.

Dashboard Link [Tallinn Temperature](http://40.122.71.123:3000/d/oxCoOlQ7z/monitor-tallinn-temperature?orgId=1)

