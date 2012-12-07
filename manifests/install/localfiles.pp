class comoonics::install::localfiles {
   include comoonics::install
   $packages = [ "comoonics-bootimage-extras-localconfigs", ]
   notice("comoonics::install-localfiles running comdist: ${comoonics::comdist}, comdistver: ${comoonics::comdistver}, rootfilesystem: ${rootfilesystem}..")
   if $comoonics::comdist and $comoonics::comdistver and $rootfilesystem {
     notice("Installing package $packages")
     package {
        $packages:
           ensure => present,
           require => Class["comoonics::repo"],
     }
   }
}
