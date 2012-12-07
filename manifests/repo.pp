class comoonics::repo {
   if $comoonics::comoonicssupported {
      exec {
         "rpm --import ${comoonics::params::repobaseurl}/comoonics-RPM-GPG.key":
             unless => "rpm -qa gpg* | grep -i f08cace8",
             path => [ "/usr/bin", "/bin" ],
             logoutput => on_failure,
      }
      if $comoonics::comdist == "rhel" {
         include comoonics::yumrepo
      } elsif $comoonics::comdist == "sles" {
         include comoonics::zypperrepo
      }
   }
} 
class comoonics::yumrepo {
   include comoonics::params
   notice("Creating com.oonics yum repository..")
   yumrepo {
      "comoonics-preview-noarch":
          baseurl => "${comoonics::params::repobaseurl}/${comoonics::comversion}/${comoonics::comlevel}/${comoonics::comdist}${comoonics::comdistver}/RPMS/noarch",
          descr => "com.oonics ${comoonics::comversion} internal noarch ${comoonics::comlevel} channel",
          enabled => 1,
          gpgcheck => 1,
   }
   yumrepo {
      "comoonics-addons-noarch":
          baseurl => "${comoonics::params::repobaseurl}/${comoonics::comversion}/addons/${comoonics::comdist}${comoonics::comdistver}/RPMS/noarch",
          descr => "com.oonics addons ${comoonics::comversion} internal noarch ${comoonics::comlevel} channel",
          enabled => 1,
          gpgcheck => 1,
   }
}
class comoonics::zypperrepo {
   include comoonics::params
   notice("Creating com.oonics zypper repository..")
   $reponame_preview="comoonics-preview-noarch"
   $reponame_addons="comoonics-addons-noarch"
   $zypperrepopath="/etc/zypp/repos.d"
  
   exec {
      "zypper addrepo --refresh --type=rpm-md ${comoonics::params::repobaseurl}/${comoonics::comversion}/${comoonics::comlevel}/${comoonics::comdist}${comoonics::comdistver}/RPMS/noarch $reponame_preview":
          path => [ "/usr/bin", "/bin" ],
          creates => "$zypperrepopath/${reponame_preview}.repo",
   }
   exec {
      "zypper addrepo --refresh --type=rpm-md ${comoonics::params::repobaseurl}/${comoonics::comversion}/addons/${comoonics::comdist}${comoonics::comdistver}/RPMS/noarch $reponame_addons":
          path => [ "/usr/bin", "/bin" ],
          creates => "$zypperrepopath/${reponame_addons}.repo",
   }
}
