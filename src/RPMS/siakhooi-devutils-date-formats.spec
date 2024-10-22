Name:           siakhooi-devutils-date-formats
Version:        1.0.6
Release:        1%{?dist}
Summary:        Several commands to print date with predefined formats.

License:        MIT
URL:            https://github.com/siakhooi/bash-devutils-date-formats
Source0:        https://github.com/siakhooi/%{name}/archive/refs/tags/${version}.tar.gz
BuildArch:      noarch

Requires:       bash

%description
Several commands to print date with predefined formats, from year to nano seconds.

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_mandir}/man1
install -m 0755 usr/bin/* %{buildroot}%{_bindir}
install -m 644 usr/share/man/man1/* %{buildroot}%{_mandir}/man1

%post
ln -s -f %{_mandir}/man1/siakhooi-devutils-date-formats.1.gz %{_mandir}/man1/y2y.1.gz
ln -s -f %{_mandir}/man1/siakhooi-devutils-date-formats.1.gz %{_mandir}/man1/y2m.1.gz
ln -s -f %{_mandir}/man1/siakhooi-devutils-date-formats.1.gz %{_mandir}/man1/y2d.1.gz
ln -s -f %{_mandir}/man1/siakhooi-devutils-date-formats.1.gz %{_mandir}/man1/y2h.1.gz
ln -s -f %{_mandir}/man1/siakhooi-devutils-date-formats.1.gz %{_mandir}/man1/y2M.1.gz
ln -s -f %{_mandir}/man1/siakhooi-devutils-date-formats.1.gz %{_mandir}/man1/y2s.1.gz
ln -s -f %{_mandir}/man1/siakhooi-devutils-date-formats.1.gz %{_mandir}/man1/y2n.1.gz

%postun
%{__rm} -f %{_mandir}/man1/y2y.1.gz
%{__rm} -f %{_mandir}/man1/y2m.1.gz
%{__rm} -f %{_mandir}/man1/y2d.1.gz
%{__rm} -f %{_mandir}/man1/y2h.1.gz
%{__rm} -f %{_mandir}/man1/y2M.1.gz
%{__rm} -f %{_mandir}/man1/y2s.1.gz
%{__rm} -f %{_mandir}/man1/y2n.1.gz

%files
%license LICENSE
%{_bindir}/y2y
%{_bindir}/y2m
%{_bindir}/y2d
%{_bindir}/y2h
%{_bindir}/y2M
%{_bindir}/y2s
%{_bindir}/y2n
%{_mandir}/man1/siakhooi-devutils-date-formats.1.gz

%changelog
* Fri Oct 22 2024 Siak Hooi <siakhooi@gmail.com> - 1.0.6
- fix sha sum path

* Fri Oct 21 2024 Siak Hooi <siakhooi@gmail.com> - 1.0.5
- add sha sums

* Fri Oct 11 2024 Siak Hooi <siakhooi@gmail.com> - 1.0.4
- dummy release

* Fri Oct 11 2024 Siak Hooi <siakhooi@gmail.com> - 1.0.3
- dummy release

* Thu May 18 2023 Siak Hooi <siakhooi@gmail.com> - 1.0.2
- fix file owner and permissions

* Sat Mar 18 2023 Siak Hooi <siakhooi@gmail.com> - 1.0.1
- fix man page

* Tue Feb 14 2023 Siak Hooi <siakhooi@gmail.com> - 1.0.0
- initial version
