class comoonics::mtab {
   file {
     "/etc/mtab":
        ensure => link,
        target => "/proc/mounts",
   }
}
