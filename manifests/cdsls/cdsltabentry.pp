define comoonics::cdsls::cdsltabentry($hostdependent=true, $ensure="present", $mode="bind", $params="") {
   include comoonics::cdsls
   include comoonics::cdsls::params
   $line="$mode /${comoonics::cdsls::params::clusterdir}/%(nodeid)s/$name $name $params"
   case $ensure {
      default: { err("Unknown ensure for comoonics::cdsls::cdpn value $ensure. Expected: present, absent.") }
      present: { 
         comoonics::cdsls::cdpnprep {
           $name:
              hostdependent => $hostdependent,
         }
         exec {
           "echo '$line' >> ${comoonics::cdsls::params::cdsltabfile}":
              unless => "grep --quiet --fixed-strings --line-regexp '$line' ${comoonics::cdsls::params::cdsltabfile}",
              path => [ "/bin", "/usr/bin" ],
#              require => Comoonics::Cdsls::Cdpnprep[$name],
         }
      }
      absent: { err("absent is not yet implemented. Sorry about that.") }
   }
}
