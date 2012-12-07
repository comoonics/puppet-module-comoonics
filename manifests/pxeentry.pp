define comoonics::pxeentry($rootpath, $rootpathclone, $nodeid, $kernelfile="$pxeclusterdir/vmlinuz-$kernelrelease", $initrdfile="$pxeclusterdir/initrd_sr-$kernelrelease.img", $initrdfailsafefile="$pxeclusterdir/initrd_sr-$kernelrelease.img.failsafe", $link="") {
  notice("rootpath/clone: $rootpath, $rootpathclone, nodeid: $nodeid")
  file {
    $name:
       ensure => present,
       mode => 644,
       content => template("comoonics/pxeentry.conf.erb"),
  }
  if $link {
    file {
      $link:
         ensure => link,
         target => $name,
    }
  }
}
