define comoonics::localclone($sourcebootdisk, $sourcerootdisk, $destbootdisk, $destrootdisk, $rootfilesystem, $kernelrelease, $dtd="/opt/comoonics-csl/xml/comoonics-enterprise-clone.dtd") {
   include comoonics::install-localclone
   file {
     "/etc/comoonics/enterprisecopy/localclone.xml":
        ensure => present,
        content => template("comoonics/localclone-${rootfilesystem}.xml.erb"),
   }
   file {
     "/etc/comoonics/enterprisecopy/defaults.xsl":
        ensure => present,
        content => template("comoonics/defaults.xsl"),
   }
}
