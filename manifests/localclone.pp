class comoonics::localclone {
  include comoonics
  comoonics::localclonefiles {
    "/etc/comoonics/enterprisecopy/localclone.xml":
       sourcebootdisk=>"$nfsroot/boot",
       sourcerootdisk=>"$nfsroot",
       destbootdisk=>"$nfsrootclone/boot",
       destrootdisk=>"$nfsrootclone",
       rootfilesystem=>"$rootfilesystem",
  }
}
