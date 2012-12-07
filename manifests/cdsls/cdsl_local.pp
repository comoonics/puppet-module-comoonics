class comoonics::cdsls::cdsl_local($filesystemmp="") {
   include comoonics::cdsls::params
   comoonics::tools::bindmount {
      "${filesystemmp}/${comoonics::cdsls::params::localdir}":
        sourcepath => "${filesystemmp}/${comoonics::cdsls::params::clusterdir}/$nodeid",
        require => Class["comoonics::cdsls::inventory"],
   }
}
