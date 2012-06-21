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
   include comoonics::yumrepo, comoonics::install
}

define comoonics::create($localfiles=true, $plymouth=true, $mkintrd=true, $grub=true, $debugfiles=false) {
  include comoonics
  
  if $localfiles {
     include comoonics::install-localfiles
  }
  if $plymouth {
     include comoonics::install-plymouth
  }
  if $mkinitrd {
     comoonics::mkinitrd
  }
  if $debugfiles {
     include comoonics::install-debugfiles
  }
}
