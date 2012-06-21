define comoonics::mkinitrd($kernel=$kernelrelease, $force=true, $initrd_prefix="initrd_sr-", $initrd_suffix=".img", $initrddir="/boot") {
   include comoonics
   if $force {
      $createdfiles="$initrddir/${initrd_prefix}${kernel}${initrd_suffix}"
   }
   notice("Createing initrd $initrddir/${initrd_prefix}${kernel}${initrd_suffix} for kernel $kernel. Force $force")
   exec {
      "mkinitrd $initrddir/${initrd_prefix}${kernel}${initrd_suffix} ${kernel}":
         path => [ "/opt/atix/comoonics-bootimage", "/bin", "/usr/bin", "/sbin", "/usr/sbin" ],
         creates => $createdfiles,
         requires => Class["comoonics::install"],
   }
}
