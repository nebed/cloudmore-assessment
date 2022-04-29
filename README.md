# cloudmore-assessment

## Task 1

### Tools Used
 - Terraform = v1.1.8
 - Ansible = 2.11.2

### How to Install
 - `git clone https://github.com/nebed/cloudmore-assessment`
 - `cd cloudmore-assessment/terraform`
 - `terraform init`
 - `terraform apply`

### Package Configuration
 - Docker
 - Docker Compose
 - Prometheus - Container [Visit](http://40.122.71.123:9090)
 - Node Exporter - Container [Visit](http://40.122.71.123:9100)
 - Grafana - Container [Visit](http://40.122.71.123:3000)

A vm was created in Azure with terraform, with a public IP and security group to allow access to monitoring applications only. Ansible was used to configure the vm and install and configure the necessary packages.
Then a bash script is being used to pull the temperature from [OpenWeather API](https://openweathermap.org/api)
and is written to a file which is then scraped by the Node Exporter Textfile Collector

A cronjob is configured to run the temperature bash script every 2 minutes.

Dashboard Link [Tallinn Temperature](http://40.122.71.123:3000/d/oxCoOlQ7z/monitor-tallinn-temperature?orgId=1)

<img width="1392" alt="image" src="https://user-images.githubusercontent.com/22051438/165899184-5690d41a-3b3e-4c13-a18c-d1f2df89190f.png">


## Task 2

### Part One - using Exec builtin command

Each time we perform an activity that requires terminating a pod, kubernetes sends a SIGTERM to all the containers in the pod to try to terminate them gracefully, before finally removing the pod. 
In our current configuration, because the application entrypoint is a bash script and is called as a shell script, it will run as a child process of the shell. The downside of this is the shell will not forward signals to the child processes and will not be able to handle the SIGTERM.
To get around this we can call the script with the "exec" command, which will tell the shell to replace itself with the application process. we need to call the code like this `exec /my-application-script.sh` and it will receive signals directly from kubernetes.

### Part Two - ReadinessProbe and PreStop lifecycle

Implementing the `exec` command to run the application can in some cases cause the SIGTERM to violenty kill the process without gracefully shutting down as the signal is sent directly to the process. To avoid this, we can add a PreStop lifecyclye hook, which we can use to configure commands to run, before killing the pod, ensuring that application is not killed abruptly and existing connections to it are terminated gracefully and can be reestablished in a different pod. 
Also When the pod is created and is registered as running, if we do not make sure that it can process traffic before kubernetes marks it as ready. it would receive traffic prematurely and traffic would not be processed. to do this we can configure a "ReadinessProbe" where we can run commands to make sure the application can process traffic properly. which when the pod passes this check it will be marked as ready to process traffic. to avoid the situation where traffic is forwarded to the pod prematurely causing some downtime.
