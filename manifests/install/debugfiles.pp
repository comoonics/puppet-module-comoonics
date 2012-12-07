class comoonics::install::debugfiles {
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
           require => Class["comoonics::install"]
     }
   }
}
