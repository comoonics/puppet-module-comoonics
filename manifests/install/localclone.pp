class comoonics::install::localclone {
   include comoonics::install
   notice("running comdist: ${comoonics::comdist}, comdistver: ${comoonics::comdistver}, rootfilesystem: ${rootfilesystem}..")
   if $comoonics::comdist and $comoonics::comdistver and $rootfilesystem {
     $packages = [ "comoonics-ec-py", "comoonics-cs-xsl-ec" ]
     package {
        $packages:
           ensure => present,
           require => Class["comoonics::repo"],
     }
   }
}
