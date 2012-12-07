define comoonics::cdsls::cdpnprep($hostdependent=true) {
   comoonics::cdsls::create {
     $name:
       hostdependent => $hostdependent,
   } 
   file {
     $name:
        ensure => directory,
   }
}
