# Dendra Compose

Docker Compose files for installing and running the Dendra software stack. Does not support scaling or MongoDB replica sets.

TODO: Briefly describe this repo and Project Dendra


## Instructions

1. Install Docker.

2. Create an .env file; use the provided sample.env (.env is excluded from Git).

3. Create a `dendra:dendra` group/user on the host with gid/uid equal to 2000.

	For example:

	```
	$ sudo groupadd --gid 2000 dendra
  	$ sudo useradd -rm --uid 2000 --gid 2000 dendra
  	$ sudo usermod -a -G docker dendra

  	$ sudo su -s /bin/bash dendra
  	$ cd ~ && mkdir Deploy && cd Deploy
  	$ https://github.com/DendraScience/dendra-compose.git
  	```

3. Start the services via `docker-compose up`.


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
