# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.27
# 

Name:       harbour-sailtuner

# >> macros
# << macros

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary:    Chromatic tuner
Version:    0.1
Release:    1
Group:      Qt/Qt
License:    GPL
URL:        http://legolas.vefblog.net/
Source0:    %{name}-%{version}.tar.bz2
#Source100:  harbour-saildbmeter.yaml
Requires:   sailfishsilica-qt5 >= 0.10.9
BuildRequires:  pkgconfig(sailfishapp) >= 1.0.2
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(libpulse-simple)
BuildRequires:  pkgconfig(audioresource)
BuildRequires:  desktop-file-utils

%description
Instrumental multi-temperament chromatic tuner

%prep
%setup -q -n %{name}-%{version}

%build

%qtc_qmake5 %{name}.pro

%qtc_make %{?_smp_mflags}

%install
rm -rf %{buildroot}
%qmake5_install

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_bindir}
%{_datadir}/applications/%{name}.desktop
%attr(644,-,-) %{_datadir}/icons/hicolor/86x86/apps/%{name}.png
%attr(644,-,-) %{_datadir}/icons/hicolor/108x108/apps/%{name}.png
%attr(644,-,-) %{_datadir}/icons/hicolor/128x128/apps/%{name}.png
%attr(644,-,-) %{_datadir}/icons/hicolor/256x256/apps/%{name}.png
