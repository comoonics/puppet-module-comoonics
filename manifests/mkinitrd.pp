define comoonics::mkinitrd($bootdevice, $bootfstype, $bootdir="/boot", $force=true, $initrd_prefix="initrd_sr-", $initrd_suffix=".img", $initrddir="/boot") {
   include comoonics
   if $force {
      $createdfiles="$initrddir/${initrd_prefix}${name}${initrd_suffix}"
   }
   notice("Createing initrd $initrddir/${initrd_prefix}${name}${initrd_suffix} for kernel $name. Createfiles $createdfiles")
   if $bootdevice {
     mount {
       "$bootdir":
         device => $bootdevice,
         ensure => "mounted",
         fstype => $bootfstype, 
     } 
   }      
   exec {
      "mkinitrd $initrddir/${initrd_prefix}${name}${initrd_suffix} ${name}":
         path => [ "/opt/atix/comoonics-bootimage", "/bin", "/usr/bin", "/sbin", "/usr/sbin" ],
         creates => $createdfiles,
         require => $bootdevice? {
           /.+/ => [ Class["comoonics::install"], Mount["$bootdir"], Class["comoonics::install::deps"] ],
           default => [ Class["comoonics::install"], Class["comoonics::install::deps"] ],
         }
   }
}
