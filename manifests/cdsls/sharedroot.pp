class comoonics::cdsls::sharedroot {
  include comoonics::params
  notice("Create inventory..")
  include comoonics::cdsls::install
  include comoonics::mtab
  include comoonics::cdsls::inventory
  include comoonics::cdsls::cdsl_local

  notice("Create CDSLs..")
  $hd_cdsls=[ "/var/tmp", "/var/log", "/var/spool", "/var/account", "/var/cache", "/var/local", "/var/lib/dbus", "/var/lib/dhclient", "/var/lib/logrotate.status", "/etc/blkid", "/etc/sysconfig/network" ]
  comoonics::cdsls::hostdependent {
    $hd_cdsls:
  }
  if $sharedrootnics {
    notice("HD for ${comoonics::params::networkconfigdir}/ifcfg-$sharedrootnics")
    comoonics::cdsls::hostdependent {
      [ "${comoonics::params::networkconfigdir}/ifcfg-$sharedrootnics" ]:
    }
  }
  notice("Create CDPNs: /var/run, /var/lock")
  #TODO: Should only be done for RHEL
  comoonics::cdsls::cdsltabentry {
     "/var/run":
         params=>"__initrd",
  }
  #TODO: Should only be done for RHEL6
  comoonics::cdsls::cdsltabentry {
     "/var/lock":
         params=>"__initrd",
  }
}
