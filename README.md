# Dendra Compose

Docker Compose files for installing and running the Dendra software stack. Does not support scaling or MongoDB replica sets.


## Prerequisites

Latest Docker and Docker Compose.

### Install Docker

1. For CentOS, see [Get Docker CE for CentOS](https://docs.docker.com/install/linux/docker-ce/centos/) and follow the instructions under "Install Docker CE".

2. Once completed, go to [Post-installation steps for Linux](https://docs.docker.com/install/linux/linux-postinstall/).

### Install Docker Compose

See [Install Docker Compose](https://docs.docker.com/compose/install/) and follow the instructions under "Install Compose on Linux systems".


## Dendra installation

SHH into the server instance as yourself (e.g. `user1`). You must be a 'sudoer' to continue.

1. Create the `dendra` group and user.

	```
	$ sudo groupadd --gid 2000 dendra
	$ sudo useradd -rm --uid 2000 --gid 2000 dendra
	```

2. Switch to the `dendra` user and prepare the `Deploy` directory.

	```
	$ sudo su -s /bin/bash dendra
	
	
	# Create Deploy directory
	dendra:~$ cd ~ && mkdir Deploy && cd Deploy
	```

3. Clone the Docker Compose repository.

	```
	dendra:~/Deploy$ git clone https://github.com/DendraScience/dendra-compose.git
	
	Cloning into 'dendra-compose'...
	remote: Counting objects: 37, done.
	remote: Compressing objects: 100% (27/27), done.
	remote: Total 37 (delta 7), reused 37 (delta 7), pack-reused 0
	Unpacking objects: 100% (37/37), done.
	Checking connectivity... done.
	
	# Change directory
	dendra:~/Deploy$ cd dendra-compose
	```

4. Choose a deployment configuration.

	```
	# Example: for staging...
	dendra:~/Deploy/dendra-compose$ cd staging
	```

5. Create an `.env` file based on the defaults. Skip this step if you already have an existing `.env` file that you want to use. Use your favorite editor to modify the settings.

	```
	dendra:~/Deploy/dendra-compose/staging$ cp sample.env .env
	dendra:~/Deploy/dendra-compose/staging$ nano .env
	```
	
	While preparing the configuration, it's key that you:
	
	* Generate a new secret for the `WEB_API_SECRET` variable. See `tools/keygen.js`.
	* Generate passwords for the `MONGO_ADMIN_PASS` and `MONGO_DB_PASS` variables.
	* Determine passwords for the `LEGACY_MYSQL_URL` and `UCNRS_GOES_DDS_PASS` variables.
	* Determine where to place all data files on the host. For example, attached storage may be mounted at `/vol_b`.

6. Prepare the data directories on the host.

	```
	# Exit the dendra session
	dendra:~/Deploy/dendra-compose/staging$ exit
	
	# Create the directories (example)
	$ sudo mkdir -p /vol_b/dendra/aggregate/db \
	&& sudo mkdir -p /vol_b/dendra/aggregate/json \
	&& sudo mkdir -p /vol_b/dendra/archive/json \
	&& sudo mkdir -p /vol_b/dendra/influxdb/default \
	&& sudo mkdir -p /vol_b/dendra/influxdb/erczo \
	&& sudo mkdir -p /vol_b/dendra/influxdb/ucnrs \
	&& sudo mkdir -p /vol_b/dendra/kapacitor \
	&& sudo mkdir -p /vol_b/dendra/mongo/db \
	&& sudo mkdir -p /vol_b/dendra/stan \
	&& sudo mkdir -p /vol_b/dendra/worker/aggregate-1 \
	&& sudo mkdir -p /vol_b/dendra/worker/aggregate-2 \
	&& sudo mkdir -p /vol_b/dendra/worker/archive \
	&& sudo mkdir -p /vol_b/dendra/worker/dpe-erczo \
	&& sudo mkdir -p /vol_b/dendra/worker/dpe-ucnrs \
	&& sudo mkdir -p /vol_b/dendra/worker/import-erczo \
	&& sudo mkdir -p /vol_b/dendra/worker/import-ucnrs

	# Change ownership
	$ sudo chown -R dendra:dendra /vol_b/dendra
	```

7. Switch to the `dendra` user and start the containers.

	```
	$ sudo su -s /bin/bash dendra
	
	dendra:~$ cd ~/Deploy/dendra-compose/staging
	
	# NOTE: Add -d to run as detached
	dendra:~$ docker-compose up
	```

8. Use the `den` and `den-worker` command line tools to load metadata and worker state respectively (see below). Otherwise, the system will do nothing.


## Worker configuration

Dendra workers are simple Node.js services that perform specific tasks on a scheduled interval (heartbeat).

Tasks are performed by the Dendra module [@dendra-science/task-machine](https://github.com/DendraScience/task-machine), which operates in a manner akin to a state machine.

A configured, running instance of a state machine in a worker is called an agent.

The `den-worker` CLI can be used to interact with individual worker's HTTP API; and can be used to inspect model state and manage saved state (i.e. configuration) for each agent.

In some environments, the HTTP API of workers may be secluded behind a firewall. To use the CLI, you may need to do port forwarding via SSH, then configure the CLI against a 'local' environment.

```
# Example, for staging...
ssh -N -p 22 user1@dendra.science -L 8088:localhost:8088
```


## Reference

[nodejs/docker-node: Official Docker Image for Node.js](https://github.com/nodejs/docker-node)

[Node Best Practices](https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md)

[Get Docker CE for CentOS | Docker Documentation](https://docs.docker.com/install/linux/docker-ce/centos/)

[Installing Docker CE on CentOS 7 - Vultr.com](https://www.vultr.com/docs/installing-docker-ce-on-centos-7)

[How To Install and Use Docker on CentOS 7 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-centos-7)

[Install Docker and Learn Basic Container Manipulation in CentOS and RHEL 7/6 - Part 1](https://www.tecmint.com/install-docker-and-learn-containers-in-centos-rhel-7-6/)

[How to install and setup Docker on RHEL 7/CentOS 7 - nixCraft](https://www.cyberciti.biz/faq/install-use-setup-docker-on-rhel7-centos7-linux/)

[Compose file version 2 reference | Docker Documentation](https://docs.docker.com/compose/compose-file/compose-file-v2/)


## Snippets

```
# Clone this repo
git clone https://github.com/DendraScience/dendra-compose.git

# Fetch latest repo changes
git fetch origin && git reset --hard origin/master && git clean -f -d
```
