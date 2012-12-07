define comoonics::tools::bindmount($sourcepath, $ensure="present", $type="bind") {
   case $ensure {
      default : { err("Wrong ensure parameter ($ensure) for bind mount. Please either use present or absent.") }
      present:  {
         exec {
            "mount --$type $sourcepath $name":
              path => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
              unless => "test \"$(stat -c %i $sourcepath/.)\" = \"$(stat -c %i $name)\"",
         }
      }
      absent:  {
         exec {
            "umount $name":
              path => [ "/bin", "/sbin", "/usr/bin", "/usr/sbin" ],
              onlyif => "test \"$(stat -c %i $sourcepath/.)\" = \"$(stat -c %i $name)\"",
         }
      }
   }
}
