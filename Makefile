name = cis-rhel8
image ?= geerlingguy/docker-centos8-ansible:latest
options = --name $(name) --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro --volume=$(shell pwd):/etc/ansible/roles/cis-rhel8:ro
command ?= docker

all: create test

clean:
	- $(command) rm -f $(name)

create: clean
	$(command) run $(options) $(image)

test:
	$(command) exec --tty $(name) env TERM=xterm ansible-playbook /etc/ansible/roles/cis-rhel8/tests/test.yml
