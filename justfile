clean:
	rm -rf target *.deb *.sha256sum *.sha512sum *.rpm ~/rpmbuild
shellcheck:
	scripts/shellcheck.sh
build-deb:
	./scripts/build-deb.sh
build-rpm:
	scripts/build-rpms.sh
set-version:
	scripts/set-version.sh
release:
	scripts/create-release.sh
all-deb: clean set-version build-deb
all-rpm: clean set-version build-rpm

test-man:
	pandoc src/md/siakhooi-date-formats.1.md -s -t man | man -l -

terminalizer:
	terminalizer render docs/terminalizer-date-formats.yml

root := justfile_directory()

docker-build-rpm:
	docker run --rm -v {{ root }}:/workspaces docker.io/siakhooi/devcontainer:rpm44 scripts/build-rpms.sh
docker-build-deb:
	docker run --rm -v {{ root }}:/workspaces docker.io/siakhooi/devcontainer:deb2604 scripts/build-deb.sh

all: clean set-version shellcheck docker-build-deb docker-build-rpm
