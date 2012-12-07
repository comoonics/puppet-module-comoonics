#
class comoonics::install {
   include comoonics
   notice("comoonics::install running comdist: ${comoonics::comdist}, comdistver: ${comoonics::comdistver}, rootfilesystem: ${rootfilesystem}..")
   if $comoonics::comdist and $comoonics::comdistver and $rootfilesystem {
     notice("Installing package comoonics-bootimage-listfiles-${comoonics::comdist}${comoonics::comdistver}-${rootfilesystem} if need be..")
     $corepackages=[ "comoonics-bootimage-listfiles-${comoonics::comdist}${comoonics::comdistver}-${rootfilesystem}" ]
     package { $corepackages:
       ensure => present,
       require => Class["comoonics::repo"],
     }
   }
   include comoonics::install::deps
}
