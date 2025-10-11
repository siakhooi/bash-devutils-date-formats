clean:
	rm -rf target *.deb *.sha256sum *.sha512sum *.rpm ~/rpmbuild
build-deb:
	./scripts/build-deb.sh
build-rpm:
	scripts/build-rpms.sh
set-version:
	scripts/set-version.sh
commit:
	scripts/git-commit-and-push.sh
release:
	scripts/create-release.sh
all-deb: clean set-version build-deb
all-rpm: clean set-version build-rpm

test-man:
	pandoc src/md/siakhooi-devutils-date-formats.1.md -s -t man | man -l -

delete-tags:
	git tag --delete 1.0.0
	git push --delete origin 1.0.0

terminalizer:
	terminalizer render docs/terminalizer-date-formats.yml

rpmsetup:
	rpmdev-setuptree
	mkdir -p src/RPMS
	rpmdev-newspec siakhooi-devutils-date-formats

rpmlint:
	cp src/RPMS/siakhooi-devutils-date-formats.spec ~/rpmbuild/SPECS
	rpmlint ~/rpmbuild/SPECS/siakhooi-devutils-date-formats.spec

rpmbuild:
	rpmbuild -bb -vv ~/rpmbuild/SPECS/siakhooi-devutils-date-formats.spec

tree:
	tree ~/rpmbuild/
	rpm -ql ~/rpmbuild/RPMS/noarch/siakhooi-devutils-date-formats-1.0.2-1.fc40.noarch.rpm
rpm-i:
	rpm -i -vv ~/rpmbuild/RPMS/noarch/siakhooi-devutils-date-formats-1.0.2-1.fc40.noarch.rpm
rpm-e:
	rpm -e -vv siakhooi-devutils-date-formats
