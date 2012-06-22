define comoonics::mkinitrd($force=true, $initrd_prefix="initrd_sr-", $initrd_suffix=".img", $initrddir="/boot") {
   include comoonics
   if $force {
      $createdfiles="$initrddir/${initrd_prefix}${name}${initrd_suffix}"
   }
   notice("Createing initrd $initrddir/${initrd_prefix}${name}${initrd_suffix} for kernel $name. Createfiles $createdfiles")
   exec {
      "mkinitrd $initrddir/${initrd_prefix}${name}${initrd_suffix} ${name}":
         path => [ "/opt/atix/comoonics-bootimage", "/bin", "/usr/bin", "/sbin", "/usr/sbin" ],
         creates => $createdfiles,
         require => Class["comoonics::install"],
   }
}
