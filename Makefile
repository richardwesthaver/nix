HOST = zor
BUILD_PATH = /run/current-system

build-zor:
	cp -rf $(HOME)/src/nix/machines/$(HOST)/** /etc/nixos
	sudo nixos-rebuild switch

build-remote:
	for host in $(HOST); do \
	scp -r $(HOME)/src/nix/machines/$$host/** ellis@$$host:/etc/nixos ; \
	ssh -t root@$$host 'sudo nixos-rebuild switch'; \
	done

pull:
	(git pull)
push:
	git add .	\
	git commit -m "Makefile commit $(shell date)" \
	git push

