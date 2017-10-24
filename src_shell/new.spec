Name:           new
Version:        1.0.0
Release:        0.0
Summary:        This is the rpm package

Group:          Applications/File
License:        GPL
URL:            https://github.com/Juyin
Vendor:     	Juyin
Packager:   	Juyin
Requires:   	bash

%define SERVICE_NAME  new
%define SERVICE_BASE /opt/%{SERVICE_NAME}

%description
 This is the %{SERVICE_NAME} Package


%define distribution %(/usr/lib/rpm/redhat/dist.sh --distnum)
%if %{distribution} == 5
%define CENTOS_REL elf5
%else
%define CENTOS_REL elf6
%endif

%define RELEASE_TIME %(date +"%a %b %d %Y")

%define _rpmfilename %%{NAME}.%%{VERSION}.%%{RELEASE}.%%{ARCH}.%{CENTOS_REL}.rpm

%prep
#安装前执行动作

%post
#安装后执行动作
ln -sf %{SERVICE_BASE}/etc/%{SERVICE_NAME} /etc/init.d/

%preun
#卸载前执行动作
service %{SERVICE_NAME} stop


%files
%defattr(-,root,root,-)
%{SERVICE_BASE}/bin/%{SERVICE_NAME}
%{SERVICE_BASE}/etc/cksum
%{SERVICE_BASE}/etc/%{SERVICE_NAME}
%{SERVICE_BASE}/etc/monitor_%{SERVICE_NAME}.sh
%{SERVICE_BASE}/etc/release_info.txt

%doc
#文档

%changelog
* %{RELEASE_TIME} juyin <juyin2015@qq.com> - 1.0.0
- #txt

