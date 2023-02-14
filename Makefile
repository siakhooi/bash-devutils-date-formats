clean:
	rm -rf target *.deb
build:
	./build.sh

test-man:
	pandoc src/md/siakhooi-devutils-date-formats.1.md -s -t man | man -l -

delete-tags:
	git tag --delete 1.0.0
	git push --delete origin 1.0.0
