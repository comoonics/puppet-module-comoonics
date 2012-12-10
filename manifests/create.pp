define comoonics::create($rootdevice, $bootdevice="", $bootdir="/boot", $bootfstype="ext3", $grubdefault=false, $localfiles=true, $plymouth=true, $mkinitrd=true, $grub=true, $debugfiles=false) {
  notice("comoonics::create: BEGIN")
  include comoonics
  include comoonics::repo, comoonics::install
  
  if $localfiles {
     notice("comoonics::create: install comoonics::install-localfiles")
     include comoonics::install::localfiles
  }
  if $plymouth {
     include comoonics::install::plymouth
  }
  if $debugfiles {
     include comoonics::install::debugfiles
  }
  if $mkinitrd {
     notice("comoonics::create: Create mkinitrd $kernelrelease")
     comoonics::mkinitrd{
        $kernelrelease:
           bootdevice => $bootdevice,
           bootfstype => $bootfstype,
           bootdir => $bootdir,
     }
  }   
  notice("comoonics::create: END")
}
