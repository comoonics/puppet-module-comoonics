class comoonics::yumrepo {
   notice("com.oonics Module yumrepo.pp..")
   if $comoonics::comoonicssupported and $comoonics::comdist and $comoonics::comdistver {
      notice("Creating com.oonics yum repository..")
      exec {
         "rpm --import http://archiv-server.gallien.atix/dist-mirrors/comoonics/comoonics-RPM-GPG.key":
             unless => "rpm -qa gpg* | grep -i f08cace8",
             path => [ "/usr/bin", "/bin" ],
             logoutput => on_failure,
      }
      yumrepo {
         "comoonics-preview-noarch":
             baseurl => "http://archiv-server.gallien.atix/dist-mirrors/comoonics/${comoonics::comversion}/${comoonics::comlevel}/${comoonics::comdist}${comoonics::comdistver}/RPMS/noarch",
             descr => "com.oonics ${comoonics::comversion} internal noarch ${comoonics::comlevel} channel",
             enabled => 1,
      }
      yumrepo {
         "comoonics-addons-noarch":
             baseurl => "http://archiv-server.gallien.atix/dist-mirrors/comoonics/${comoonics::comversion}/addons/${comoonics::comdist}${comoonics::comdistver}/RPMS/noarch",
             descr => "com.oonics addons ${comoonics::comversion} internal noarch ${comoonics::comlevel} channel",
             enabled => 1,
             gpgcheck => 1,
      }
   }
}
