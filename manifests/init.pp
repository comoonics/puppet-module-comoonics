class comoonics {
#   $localfiles = false
#   $plymouth = false
#   $debug = false
#   $localclone = false
   notice("com.oonics Module init.pp lsbdistid: ${lsbdistid}..")
   case $operatingsystem {
      centos,redhat,redhatenterpriseserver: { 
        notice("Setting comoonics variables..")
        $comoonicssupported=1
        $comdist="rhel"
        $comdistvera=split($operatingsystemrelease, "[.]")
        $comdistver=$comdistvera[0]
        $comversion="5.0"
        $comlevel="preview"
      }
      suse, sles: { 
        notice("Setting comoonics variables..")
        $comoonicssupported=1
        $comdist="sles"
        $comdistvera=split($operatingsystemrelease, "[.]")
        $comdistver=$comdistvera[0]
        $comversion="5.0"
        $comlevel="preview"
      }
   }
}
