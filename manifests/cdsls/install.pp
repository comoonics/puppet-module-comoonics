class comoonics::cdsls::install {
   include comoonics::repo
   package {
     "comoonics-cdsl-py":
        ensure => "installed",
        require => Class["comoonics::repo"],
   }
}
