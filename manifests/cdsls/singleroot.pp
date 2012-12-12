class comoonics::cdsls::singleroot {
  include comoonics::params
  notice("Create inventory..")
  include comoonics::cdsls::install

  include comoonics::cdsls::inventory
  include comoonics::cdsls::cdsl_local

  notice("Create CDSLs..")
  $hd_cdsls=[ ]
  comoonics::cdsls::hostdependent {
    $hd_cdsls:
  }
}
