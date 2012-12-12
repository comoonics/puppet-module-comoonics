class comoonics::sharedroot {
  include comoonics
  include comoonics::params
  include comoonics::cdsls::sharedroot
  notice("localfiles: $localfiles, plymouth: $plymouth, debug: $debug, localclone: $localclone")
  if $rootfilesystem == "nfs" {
     notice("nfsroot: $nfsroot, nodeid: $nodeid")
     comoonics::tools::fstab {
      "/":
        source => $nfsroot,
        fstype => $rootfilesystem,
        options => "nolock,vers=3,defaults",
     }
     comoonics::create {
      "none":
        rootdevice => $nfsroot,
        localfiles => $localfiles,
        plymouth => $plymouth,
        mkinitrd => true,
        debugfiles => $debug,
        grub => false,
     }
     comoonics::pxeentry {
      "/boot/pxe.$hostname.conf":
          rootpath => $nfsroot,
          rootpathclone => $nfsrootclone,
          nodeid => $nodeid,
     }
  } else {
     if $grub and $bootdevice {
        comoonics::grubentry{
           $name:
             rootdevice=>$rootdevice,
             grubdefault=>$grubdefault,
             initrd_prefix=>$initrd_prefix,
             initrd_suffix=>$initrd_suffix,
        }
     }
  }
}
