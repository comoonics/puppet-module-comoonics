class comoonics::install::deps {
  if $rootfilesystem == "nfs" {
     include comoonics::install::depsnfs
  }
}
