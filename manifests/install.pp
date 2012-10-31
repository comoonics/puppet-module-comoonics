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
       tag => [ "comoonics" ]
     }
   }
}
class comoonics::install-localfiles {
   include comoonics::install
   $packages = [ "comoonics-bootimage-extras-localconfigs", ]
   notice("comoonics::install-localfiles running comdist: ${comoonics::comdist}, comdistver: ${comoonics::comdistver}, rootfilesystem: ${rootfilesystem}..")
   if $comoonics::comdist and $comoonics::comdistver and $rootfilesystem {
     notice("Installing package $packages")
     package {
        $packages:
           ensure => present,
           require => Class["comoonics::repo"],
           tag => [ "comoonics", "comoonics-localfiles" ]
     }
   }
}
class comoonics::install-plymouth {
   include comoonics::install
   $packages = [ "comoonics-bootimage-listfiles-plymouth", ]
   notice("comoonics::install-plymouth running comdist: ${comoonics::comdist}, comdistver: ${comoonics::comdistver}, rootfilesystem: ${rootfilesystem}..")
   if $comoonics::comdist and $comoonics::comdistver and $rootfilesystem {
     notice("Installing package $packages")
     package {
        $packages:
           ensure => present,
           require => Class["comoonics::repo"],
           tag => [ "comoonics", "comoonics-plymouth" ]
     }
   }
}
class comoonics::install-debugfiles {
   include comoonics::install
   notice("comoonics::install-debugfiles running comdist: ${comoonics::comdist}, comdistver: ${comoonics::comdistver}, rootfilesystem: ${rootfilesystem}..")
   if $comoonics::comdist and $comoonics::comdistver and $rootfilesystem {
     notice("Installing debugfiles")
     file {
       "/etc/comoonics/bootimage/post.mkinitrd.d/99-debug-repository.sh":
           owner => "root",
           group => "root",
           mode => 644,
           ensure => present,
           source => "puppet:///modules/comoonics/post.mkinitrd.d/99-debug-repository.sh", 
           tag => [ "comoonics", "comoonics-debug" ]
     }
   }
} 
class comoonics::install-localclone {
   include comoonics::install
   notice("running comdist: ${comoonics::comdist}, comdistver: ${comoonics::comdistver}, rootfilesystem: ${rootfilesystem}..")
   if $comoonics::comdist and $comoonics::comdistver and $rootfilesystem {
     $packages = [ "comoonics-ec-py", "comoonics-cs-xsl-ec" ]
     package {
        $packages:
           ensure => present,
           require => Class["comoonics::repo"],
           tag => [ "comoonics", "comoonics-plymouth" ]
     }
   }  
}
