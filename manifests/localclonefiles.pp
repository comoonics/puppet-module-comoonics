define comoonics::localclonefiles($sourcebootdisk, $sourcerootdisk, $destbootdisk, $destrootdisk, $rootfilesystem, $kernelrelease=$kernelrelease, $dtd="/opt/comoonics-csl/xml/comoonics-enterprise-clone.dtd", $defaultsfile="/etc/comoonics/enterprisecopy/defaults.xsl") {
   include comoonics::install::localclone
   notice("sourcerootdisk: $sourcerootdisk, destrootdisk: $destrootdisk, rootfilesystem: $rootfilesystem")
   file {
     $name:
        ensure => present,
        content => template("comoonics/localclone-${rootfilesystem}.xml.erb"),
        require => Class[comoonics::install::localclone],
   }
   file {
     $defaultsfile:
        ensure => present,
        content => template("comoonics/defaults.xsl"),
        require => File[$name],
   }
}
