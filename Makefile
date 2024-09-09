clean:
	rm -rf target *.deb *.deb.sha256sum *.deb.sha512sum
build:
	./scripts/build.sh

test-man:
	pandoc src/md/siakhooi-devutils-date-formats.1.md -s -t man | man -l -

delete-tags:
	git tag --delete 1.0.0
	git push --delete origin 1.0.0

terminalizer:
	terminalizer render docs/terminalizer-date-formats.yml
