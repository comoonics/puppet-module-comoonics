notice("com.oonics Module init.pp..")
class comoonics {
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
   }
}

define comoonics::create($localfiles=true, $plymouth=true, $mkinitrd=true, $grub=true, $debugfiles=false) {
  notice("comoonics::create: BEGIN")
  include comoonics::yumrepo, comoonics::install
  include comoonics
  
  if $localfiles {
     notice("comoonics::create: install comoonics::install-localfiles")
     include comoonics::install-localfiles
  }
  if $plymouth {
     include comoonics::install-plymouth
  }
  if $mkinitrd {
     notice("comoonics::create: Create mkinitrd $kernelrelease")
     comoonics::mkinitrd{
        $kernelrelease:
     }
  }
  if $debugfiles {
     include comoonics::install-debugfiles
  }
  notice("comoonics::create: END")
}
