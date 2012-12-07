class comoonics::install::plymouth {
   include comoonics::install
   $packages = [ "comoonics-bootimage-listfiles-plymouth", ]
   notice("comoonics::install-plymouth running comdist: ${comoonics::comdist}, comdistver: ${comoonics::comdistver}, rootfilesystem: ${rootfilesystem}..")
   if $comoonics::comdist and $comoonics::comdistver and $rootfilesystem {
     notice("Installing package $packages")
     package {
        $packages:
           ensure => present,
           require => Class["comoonics::repo"],
     }
   }
}
