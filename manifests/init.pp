notice("com.oonics Module init.pp..")
class comoonics {
   $localfiles = false
   $plymouth = false
   $debug = false
   notice("com.oonics Module init.pp lsbdistid: ${lsbdistid}..")
   case $operatingsystem {
      centos,redhat,redhatenterpriseserver: { 
        notice("Setting comoonics variables..")
        $comoonicssupported=1
        $comdist="rhel"
        $comdistvera=split($operatingsystemrelease, "[.]")
        $comdistver=$comdistvera[0]
        $comversion="5.0"
        $comlevel="preview"
      }
      suse, sles: { 
        notice("Setting comoonics variables..")
        $comoonicssupported=1
        $comdist="sles"
        $comdistvera=split($operatingsystemrelease, "[.]")
        $comdistver=$comdistvera[0]
        $comversion="5.0"
        $comlevel="preview"
      }
   }
   if $localfiles {
      include comoonics::install-localfiles
   }
   if $plymouth {
      include comoonics::install-plymouth
   }
   if $debug {
      include comoonics::install-debugfiles
   }
}

define comoonics::create($rootdevice, $grubdefault=false, $localfiles=true, $plymouth=true, $mkinitrd=true, $grub=true, $debugfiles=false) {
  notice("comoonics::create: BEGIN")
  include comoonics
  include comoonics::repo, comoonics::install
  
  if $localfiles {
     notice("comoonics::create: install comoonics::install-localfiles")
     include comoonics::install-localfiles
  }
  if $plymouth {
     include comoonics::install-plymouth
  }
  if $debugfiles {
     include comoonics::install-debugfiles
  }
  if $mkinitrd {
     notice("comoonics::create: Create mkinitrd $kernelrelease")
     comoonics::mkinitrd{
        $kernelrelease:
     }
  }   
  if $grub {
      comoonics::grubentry{
         $name:
             rootdevice=>$rootdevice,
             grubdefault=>$grubdefault,
             initrd_prefix=>$initrd_prefix,
             initrd_suffix=>$initrd_suffix,
             tag => [ "comoonics" ]
      }
  }
  notice("comoonics::create: END")
}
