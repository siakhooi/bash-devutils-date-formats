clean:
	rm -rf target *.deb
build:
	./build.sh

test-man:
	pandoc src/md/siakhooi-devutils-date-formats.1.md -s -t man | man -l -

delete-tags:
	git tag --delete 1.0.0
	git push --delete origin 1.0.0

terminalizer:
	terminalizer render docs/terminalizer-date-formats.yml

docker-ubuntu-bash:
	docker run --rm -it -w /working -v $$(pwd):/working ubuntu bash
#	. in-container-init.sh

docker-debian-bash:
	docker run --rm -it -w /working -v $$(pwd):/working debian bash
#	. in-container-init.sh
