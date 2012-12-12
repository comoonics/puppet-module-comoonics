class comoonics::singleroot {
  include comoonics
  include comoonics::params
  include comoonics::cdsls::singleroot
  $grub=true
  notice("localfiles: $localfiles, plymouth: $plymouth, debug: $debug, localclone: $localclone")

  if $rootfilesystem == "ext3" or $rootfilesystem == "ext4" {
     comoonics::create {
      "none":
        rootdevice => $rootdevice,
        localfiles => $localfiles,
        plymouth => $plymouth,
        mkinitrd => true,
        debugfiles => $debug,
        grub => true,
     }
     comoonics::grubentry{
      $kernelrelease:
       rootdevice=>$rootdevice,
       grubdefault=>true,
       initrd_prefix=>$initrd_prefix,
       initrd_suffix=>$initrd_suffix,
     }
  } else {
     err("Singleroot not supported for the filesystemtype $rootfilesystem.")
  }
}
