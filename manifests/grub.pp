define grub-entry($default=false, $title="com.oonics for $manufacturer ($name)", $initrd_prefix="initrd_sr-", $initrd_suffix=".img", $bootdir="/boot", $grubconf="/etc/grub.conf") {
   augeas {
     "grubentry1"
         context => "/files${grubconf}"
         changes => [ "ins $title before title[0]", "set default 0" ]
   }
}
         
