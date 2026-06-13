.PHONY: build shell list-hosts ping preflight check baseline desktop lightdm xsession awesome xresources keyboard browser zram tuning console slim-services run

COMPOSE := docker compose run --rm ansible
PLAYBOOK := ansible/site.yml

build:
	docker compose build

shell:
	$(COMPOSE) bash

list-hosts:
	$(COMPOSE) ansible all --list-hosts

ping:
	$(COMPOSE) ansible eeepc -m ping

preflight:
	$(COMPOSE) ansible-playbook $(PLAYBOOK)

check:
	@if [ -z "$(TAGS)" ]; then echo "Set TAGS, for example: make check TAGS=baseline"; exit 2; fi
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags "$(TAGS)" --check --diff

run:
	@if [ -z "$(TAGS)" ]; then echo "Set TAGS, for example: make run TAGS=baseline"; exit 2; fi
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags "$(TAGS)" --diff

baseline:
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags baseline --diff

desktop:
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags desktop --diff

lightdm:
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags lightdm --diff

xsession:
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags xsession --diff

awesome:
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags awesome --diff

xresources:
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags xresources --diff

keyboard:
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags keyboard --diff

browser:
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags browser --diff

zram:
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags zram --diff

tuning:
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags tuning --diff

console:
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags console --diff

slim-services:
	$(COMPOSE) ansible-playbook $(PLAYBOOK) --tags slim-services --diff

