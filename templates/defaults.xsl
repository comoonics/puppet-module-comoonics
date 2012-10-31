<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

    <!-- definition off all defaults used by this system. Can be adapted to user needs -->

    <!-- Default logfile to use (everything will be also logged here -->
    <xsl:variable name="logfile">/var/log/com-ec.log</xsl:variable>

    <!-- Default kernel version to use -->
    <xsl:variable name="defaultkernelversion">2.6.9-34.0.1.ELsmp</xsl:variable>

    <!-- Default searchdomainname -->
    <xsl:variable name="defaultdnsdomainname">atix.de</xsl:variable>

    <!-- Default name of the device the root disk resides on -->
    <xsl:variable name="defaultsdisk">/dev/undef</xsl:variable>
    <!-- Default name of the device the root disk will be cloned on -->
    <xsl:variable name="defaultddisk">/dev/undef</xsl:variable>

    <!-- Default name of the device the boot disk resides on -->
    <xsl:variable name="defaultsbootdisk">/dev/undef</xsl:variable>
    <!-- Default name of the device the boot disk will be cloned on -->
    <xsl:variable name="defaultdbootdisk">/dev/undef</xsl:variable>

    <!-- Default partitionnumber of the partition where the boot disk resides on -->
    <xsl:variable name="defaultbootdiskpartno">1</xsl:variable>

    <!-- Default partitionnumber of the partition where the root disk resides on (only for local filesystems)-->
    <xsl:variable name="defaultrootdiskpartno">2</xsl:variable>

    <!-- lvm_prepath: what to prefix to every vgname-lvname combination (might be either /dev/mapper or /dev). defaults to /dev -->
    <xsl:variable name="lvm_prepath">/dev/</xsl:variable>
    <!-- lvm_vglvsep: seperator between every lvmpath with vgname-lvname combination (might be either - or /). defaults to / -->
    <xsl:variable name="lvm_vglvsep">/</xsl:variable>

    <!-- Name of the rootfilesystem volumegroup -->
    <xsl:variable name="defaultvgname">vg_local</xsl:variable>

    <!-- Name of the colume rootfilesystem volumegroup -->
    <xsl:variable name="defaultvgnameC">vg_localC</xsl:variable>

    <!-- Name of the colume rootfilesystem logicalvolume in case of nonsharedroot -->
    <xsl:variable name="defaultlvname_local">lv_root</xsl:variable>
    <!-- Name of the colume rootfilesystem logicalvolume in case of nonsharedroot -->
    <xsl:variable name="defaultlvname_cluster">lv_sharedroot</xsl:variable>

    <!-- default disktype is disk -->
    <xsl:variable name="defaultdisktype">disk</xsl:variable>
    <!-- default prefix initrd name -->
    <xsl:variable name="initrd_prefix">initrd_sr-</xsl:variable>
    <!-- default suffix initrd name -->
    <xsl:variable name="initrd_suffix">.img</xsl:variable>
    
    <!-- Default sourcetype (clone on disk) -->
    <xsl:variable name="defaultsourcetype">disk</xsl:variable>
    <!-- Default destinationtype (clone on disk) -->
    <xsl:variable name="defaultdesttype">disk</xsl:variable>

    <!-- Configurationdirectory for com-ec -->
    <xsl:variable name="defaultconfigdir">etc/comoonics/enterprisecopy</xsl:variable>
    <!-- Temp directory for temporary files -->
    <xsl:variable name="defaulttempdir">/var/lib/com-ec/tmp</xsl:variable>
    <!-- Where should the source be mounted to -->
    <xsl:variable name="defaultsmountpoint">/var/lib/com-ec/source</xsl:variable>
    <!-- Where should the destination be mounted to -->
    <xsl:variable name="defaultdmountpoint">/var/lib/com-ec/dest</xsl:variable>

    <!-- Default lvm copyset name for rootdisk -->
    <xsl:variable name="defaultrootdisklvmcsname">copy-rootdisk-lvm</xsl:variable>
    <!-- Default bootdisk bootsector copyset name -->
    <xsl:variable name="defaultbootbscsname">copy-bootdisk-sector</xsl:variable>
    <!-- Default bootdisk copyset name -->
    <xsl:variable name="defaultbootdiskcsname">copy-bootdisk</xsl:variable>
    <!-- Default rootpartition copyset file -->
    <xsl:variable name="defaultrootdiskcsname">copy-rootdisk</xsl:variable>
    <!-- Default bootdisk filesystem copyset name -->
    <xsl:variable name="defaultbootfscsname">copy-bootdisk-filesystem</xsl:variable>
    <!-- Default rootdisk filesystem copset name -->
    <xsl:variable name="defaultrootfscsname">copy-rootdisk-filesystem</xsl:variable>
    <!-- Default rootdisk filesystem modificationset name -->
    <xsl:variable name="defaultrootfsmsname">modify-rootdisk-filesystem</xsl:variable>
    <!-- Default rootdisk filesystem modificationset name -->
    <xsl:variable name="defaultbootfsmsname">modify-bootdisk-filesystem</xsl:variable>

    <!-- Default filesystem for boot -->
    <xsl:variable name="defaultfsboot">ext3</xsl:variable>
    <!-- Default filesystem for root -->
    <xsl:variable name="defaultfsroot"><%= rootfilesystem %></xsl:variable>
    <!-- Default filesystem for root (local)-->
    <xsl:variable name="defaultfsroot_local"><%= rootfilesystem %></xsl:variable>
    <!-- Default filesystem type for all other filesystems -->
    <xsl:variable name="defaultfstype">gfs</xsl:variable>

    <!-- Default rootdevice id -->
    <xsl:variable name="defaultrootfsid">rootfs</xsl:variable>
    <!-- Default destination bootdevice id -->
    <xsl:variable name="defaultdestbootfsid">destbootfs</xsl:variable>
    <!-- Default destination rootdevice id -->
    <xsl:variable name="defaultdestrootfsid">destrootfs</xsl:variable>
    <!-- Default source bootdevice id -->
    <xsl:variable name="defaultsourcebootfsid">sourcebootfs</xsl:variable>
    <!-- Default rootdevice id -->
    <xsl:variable name="defaultsourcerootfsid">sourcerootfs</xsl:variable>

    <!-- default archive type -->
    <xsl:variable name="defaultarchivetype">file</xsl:variable>
    <!-- default format for archiving -->
    <xsl:variable name="defaultarchiveformat">tar</xsl:variable>
    <!-- default compression for metadata -->
    <xsl:variable name="defaultmetadatacompression">none</xsl:variable>
    <!-- default compression for otherdata -->
    <xsl:variable name="defaultdatacompression">gzip</xsl:variable>

    <!-- Basename of the initrdfile -->
    <xsl:variable name="initrdprefix">initrd_sr-</xsl:variable>
    <!-- Basename of the initrdfile -->
    <xsl:variable name="initrdsuffix">.img</xsl:variable>

    <!-- Characters used to be translated by functions -->
    <xsl:variable name="default_source_transchars">:-=/</xsl:variable>
    <!-- Characters used to overwrite the characters to be translated by functions -->
    <xsl:variable name="default_dest_transchars">____</xsl:variable>

    <!-- Default tmpdir for all tmps needed -->
    <xsl:variable name="default_tmp_dir">/tmp</xsl:variable>
    <!-- Default metadatadir as basedir for all metadata -->
    <xsl:variable name="default_metadata_dir">metadata</xsl:variable>

    <!-- default boot entry in bootloader for localclone. How do we detect a localclone-->
    <xsl:variable name="bootloader-localclone-selector">LocalClone</xsl:variable>
    <!-- default boot entry in bootloader for localclone. How do we detect a sharedroot boot entry -->
    <xsl:variable name="bootloader-boot-selector">SharedRoot</xsl:variable>
    <!-- default boot entry in bootloader for localclone. How do we detect a sharedroot failsave boot entry -->
    <xsl:variable name="bootloader-bootfailsafe-selector">SharedRoot Failsafe</xsl:variable>
	<!-- default cdsl path -->
	<xsl:variable name="cdslpath">.cluster/cdsl</xsl:variable>
    <!-- place to store the repository cache files of comoonics -->
    <xsl:variable name="comoonics_bootimage_cache">/var/cache/comoonics-bootimage</xsl:variable>
    
    <!-- Template called on every new node in masterclone process -->
    <xsl:template name="userDefNewNode">
        <xsl:param name="scluster"/>
        <xsl:param name="cluster"/>
        <xsl:param name="configdir"/>
        <xsl:param name="domain"/>
        <xsl:param name="nodeid"/>
        <xsl:param name="nodename"/>
        <xsl:param name="nodeletter"/>
    </xsl:template>

    <!-- Template called on every existing node in masterclone process -->
    <xsl:template name="userDefExistingNode">
        <xsl:param name="scluster"/>
        <xsl:param name="cluster"/>
        <xsl:param name="configdir"/>
        <xsl:param name="domain"/>
        <xsl:param name="nodeid"/>
        <xsl:param name="nodename"/>
        <xsl:param name="nodeletter"/>
    </xsl:template>

    <xsl:template name="userMastercloneModifyRoot">
        <xsl:param name="scluster"/>
        <xsl:param name="cluster"/>
        <xsl:param name="domain"/>
        <xsl:param name="nodename"/>
        <xsl:param name="configdir"/>
    </xsl:template>

    <!-- Template called for not defined logging -->
    <xsl:template name="userLogging">
        <logging>
            <loggers>
                <logger name="root" handlers="comhandler1,comhandler3" propagate="1">
                    <logger name="com-ec" handlers="comhandler2,comhandler3" propagate="0"/>
                    <logger name="comoonics" handlers="comhandler1,comhandler3" propagate="0"/>
                </logger>
            </loggers>
            <handlers>
                <handler name="comhandler1" class="StreamHandler" formatter="comform01">
                    <properties>
                        <property name="stream">sys.stdout</property>
                    </properties>
                    <args>
                        <arg>sys.stdout</arg>
                    </args>
                </handler>
                <handler name="comhandler2" class="StreamHandler" formatter="comform02">
                    <properties>
                        <property name="stream">sys.stdout</property>
                    </properties>
                    <args>
                        <arg>sys.stdout</arg>
                    </args>
                </handler>
                <handler name="comhandler3" class="FileHandler" formatter="comform02" level="DEBUG">
                    <args>
                        <arg>"<xsl:value-of select="$logfile"/>"</arg>
                        <arg>"a"</arg>
                    </args>
                </handler>
                <!--                <handler name="comhandlerfile1" class="FileHandler" formatter="comform01" level="DEBUG">
                    <args>
                        <arg>"<xsl:value-of select="$logfile"/>"</arg>
                        <arg>"a"</arg>
                    </args>
                </handler>
                <handler name="comhandlerdb" class="DBLogger" formatter="comform01" level="INFO">
                    <args>
                        <arg>"dbhost"</arg>
                        <arg>"username"</arg>
                        <arg>"password"</arg>
                        <arg>"database"</arg>
                    </args>
                </handler>-->
            </handlers>
            <formatters>
                <formatter name="comform01">
                    <format>%(asctime)s %(name)s %(levelname)s %(message)s</format>
                </formatter>
                <formatter name="comform02">
                    <format>-------------------%(name)-7s: %(levelname)-4s %(message)s--------------------</format>
                    <dateformat></dateformat>
                </formatter>
            </formatters>
        </logging>
    </xsl:template>

    <xsl:template name="userStorageProperties">
        <xsl:param name="key1"></xsl:param>
        <xsl:param name="key2"></xsl:param>
        <property name="cmd" value="/home/marc/bin/sssu_las40_x86"/>
    </xsl:template>

    <xsl:template name="userStorageDiskProperties">
        <xsl:param name="type"></xsl:param>
        <xsl:param name="name"></xsl:param>
        <xsl:choose>
            <xsl:when test="$type = 'snapshot'">
                <!-- Fully or demand -->
                <property name="ALLOCATION_POLICY" value="Demand"/>
                <!-- vraid0, vraid1, vraid5 -->
                <property name="Redundancy" value="VRaid5"/>
            </xsl:when>
            <xsl:when test="$type = 'volume'">
                <!-- vraid0, vraid1, vraid5 -->
                <property name="Redundancy" value="VRaid5"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="userStorageMapDiskProperties">
        <xsl:param name="lun"></xsl:param>
        <xsl:param name="name"></xsl:param>
    </xsl:template>

    <!-- Comma delimited list of files, directories to be excluded in any filesystem copyset. --> 
    <xsl:template name="filesystemCopySetExcludes">
        .snapshot, *var/cache/yum/*, *.cdsl.local/*, *var/log/lastlog, *var/log/faillog
    </xsl:template>
</xsl:stylesheet>
