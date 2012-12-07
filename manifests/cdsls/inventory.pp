class comoonics::cdsls::inventory {
  include comoonics::cdsls::params 
   
  notice("maxnodes: $maxnodes.")
  exec {
     $maxnodes? { 
        /.+/ => "com-cdslinvadm create --maxnodeidnum=$maxnodes",
        default => "com-cdslinvadm create",
     }:
        path => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
        creates => "/.cdsl_inventory.xml",
        require => [ Class["comoonics::cdsls::install"], ],
        logoutput => "on_failure",
        tries => 3,
        try_sleep => 3,
  }
}
