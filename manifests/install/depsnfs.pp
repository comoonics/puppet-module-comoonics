class comoonics::install::depsnfs {
  package {
    ["rpcbind", "nfs-utils" ]:
       ensure => installed,
  }
}
