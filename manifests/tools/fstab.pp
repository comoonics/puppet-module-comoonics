define comoonics::tools::fstab($source, $fstype, $options="defaults", $ensure="present", $fsck=0, $fsckorder=0, $fstab="/etc/fstab") {
  $line="$source \t$name \t$fstype \t$options \t$fsck \t$fsckorder"
  $linematch="\\s*$source\\s+$name\\s+$fstype\\s+.*$"
  notice("line: $line, linematch: $linematch")
  case $ensure {
    default: { err("No supportet ensure type ($ensure) for fstab entry (supported: present or absent).") }
    present: {
       exec {
         "echo -e '$line' >> '$fstab'":
            unless => "grep --quiet --extended-regexp --line-regexp '$linematch' $fstab",
            path => [ "/bin", "/usr/bin", "/sbin", "/usr/sbin" ],
       }
    }
    absent: {
       exec {
         "grep --invert-match  --line-regexp '$linematch' '$fstab' | tee '${file}' > /dev/null 2>&1":
            onlyif => "grep --quiet --extended-regexp --line-regexp '$linematch' $fstab",
            path => [ "/bin", "/usr/bin", "/sbin", "/usr/sbin" ],
       }
    }
  }
}       
