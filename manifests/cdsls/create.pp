define comoonics::cdsls::create($hostdependent) {
   $hostdependentparam=$hostdependent? {
      true => "--hostdependent",
      false => "--shared",
   }
   exec {
     "com-mkcdsl $hostdependentparam $name":
        unless => "test ! -e $name || com-cdslinvadm --getcdsl $name",
        path => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
        require => [ Class["comoonics::cdsls::inventory"], ],
   }
}
