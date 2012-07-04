define comoonics::grubentry($rootdevice, $grubdefault=false, $grubtitle="com.oonics for $operatingsystem ($name)", $kernel_prefix="vmlinuz-", $initrd_prefix="initrd_sr-", $initrd_suffix=".img", $bootrootdir="/", $grubconf="") {
   if $grubconf == "" and $comoonics::comdist == "rhel" {
      $mygrubconf="/etc/grub.conf"
   } elsif $grubconf == "" and $comoonics::comdist == "sles" {
      $mygrubconf="/boot/grub/menu.lst"
   } elsif $grubconf != "" {
      $mygrubconf=$grubconf
   }

   if $mygrubconf {
      $defaultchanges = [ "ins title before /files$mygrubconf/title[1]",
                      "set /files$mygrubconf/title[1] \"$grubtitle\"",
                      "set /files$mygrubconf/title[1]/root \"(hd0,0)\"",
                      "set /files$mygrubconf/title[1]/kernel \"${bootrootdir}${kernel_prefix}${name}\"",
                      "set /files$mygrubconf/title[1]/kernel/root \"$rootdevice\"",
                      "set /files$mygrubconf/title[1]/initrd \"${bootrootdir}${initrd_prefix}${name}${initrd_suffix}\"",
      ]
      if $comoonics::comdist == "rhel" {
         $distchanges = [ "set /files$mygrubconf/title[1]/kernel/rhgb ''",
                      "set /files$mygrubconf/title[1]/kernel/quiet ''",
         ]
      } elsif $comoonics::comdist == "sles" {
         $distchanges = [ "set /files$mygrubconf/title[1]/kernel/splash 'silent'",
         ]
      }

      if $grubdefault {
         $morechanges = [ "set /files$mygrubconf/default 0", ]
      }
      augeas {
        "grubentry1":
            context => "/files",
            changes => [ $defaultchanges, $morechanges, $distchanges ],
            onlyif => "get /files$mygrubconf/title[1] != \"${grubtitle}\"",
            tag => [ "comoonics", "comoonics-grub" ]
      }
   }
}
