#!/bin/bash

## Review the Gparted partition table
# Command (m for help): l
#  1 EFI System                     C12A7328-F81F-11D2-BA4B-00A0C93EC93B
#  2 MBR partition scheme           024DEE41-33E7-11D3-9D69-0008C781F39F
#  3 Intel Fast Flash               D3BFE2DE-3DAF-11DF-BA40-E3A556D89593
#  4 BIOS boot                      21686148-6449-6E6F-744E-656564454649
#  5 Sony boot partition            F4019732-066E-4E12-8273-346C5641494F
#  6 Lenovo boot partition          BFBFAFE7-A34F-448A-9A5B-6213EB736C22
#  7 PowerPC PReP boot              9E1A2D38-C612-4316-AA26-8B49521E5A8B
#  8 ONIE boot                      7412F7D5-A156-4B13-81DC-867174929325
#  9 ONIE config                    D4E6E2CD-4469-46F3-B5CB-1BFF57AFC149
# 10 Microsoft reserved             E3C9E316-0B5C-4DB8-817D-F92DF00215AE
# 11 Microsoft basic data           EBD0A0A2-B9E5-4433-87C0-68B6B72699C7
# 12 Microsoft LDM metadata         5808C8AA-7E8F-42E0-85D2-E1E90434CFB3
# 13 Microsoft LDM data             AF9B60A0-1431-4F62-BC68-3311714A69AD
# 14 Windows recovery environment   DE94BBA4-06D1-4D40-A16A-BFD50179D6AC
# 15 IBM General Parallel Fs        37AFFC90-EF7D-4E96-91C3-2D7AE055B174
# 16 Microsoft Storage Spaces       E75CAF8F-F680-4CEE-AFA3-B001E56EFC2D
# 17 HP-UX data                     75894C1E-3AEB-11D3-B7C1-7B03A0000000
# 18 HP-UX service                  E2A1E728-32E3-11D6-A682-7B03A0000000
# 19 Linux swap                     0657FD6D-A4AB-43C4-84E5-0933C84B4F4F
# 20 Linux filesystem               0FC63DAF-8483-4772-8E79-3D69D8477DE4
# 21 Linux server data              3B8F8425-20E0-4F3B-907F-1A25A76F98E8
# 22 Linux root (x86)               44479540-F297-41B2-9AF7-D131D5F0458A
# 23 Linux root (x86-64)            4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709
# 24 Linux root (Alpha)             6523F8AE-3EB1-4E2A-A05A-18B695AE656F
# 25 Linux root (ARC)               D27F46ED-2919-4CB8-BD25-9531F3C16534
# 26 Linux root (ARM)               69DAD710-2CE4-4E3C-B16C-21A1D49ABED3
# 27 Linux root (ARM-64)            B921B045-1DF0-41C3-AF44-4C6F280D3FAE
# 28 Linux root (IA-64)             993D8D3D-F80E-4225-855A-9DAF8ED7EA97
# 29 Linux root (LoongArch-64)      77055800-792C-4F94-B39A-98C91B762BB6
# 30 Linux root (MIPS-32 LE)        37C58C8A-D913-4156-A25F-48B1B64E07F0
# 31 Linux root (MIPS-64 LE)        700BDA43-7A34-4507-B179-EEB93D7A7CA3
# 32 Linux root (PPC)               1DE3F1EF-FA98-47B5-8DCD-4A860A654D78
# 33 Linux root (PPC64)             912ADE1D-A839-4913-8964-A10EEE08FBD2
# 34 Linux root (PPC64LE)           C31C45E6-3F39-412E-80FB-4809C4980599
# 35 Linux root (RISC-V-32)         60D5A7FE-8E7D-435C-B714-3DD8162144E1
# 36 Linux root (RISC-V-64)         72EC70A6-CF74-40E6-BD49-4BDA08E8F224
# 37 Linux root (S390)              08A7ACEA-624C-4A20-91E8-6E0FA67D23F9
# 38 Linux root (S390X)             5EEAD9A9-FE09-4A1E-A1D7-520D00531306
# 39 Linux root (TILE-Gx)           C50CDD70-3862-4CC3-90E1-809A8C93EE2C
# 40 Linux reserved                 8DA63339-0007-60C0-C436-083AC8230908
# 41 Linux home                     933AC7E1-2EB4-4F13-B844-0E14E2AEF915
# 42 Linux RAID                     A19D880F-05FC-4D3B-A006-743F0F84911E
# 43 Linux LVM                      E6D6D379-F507-44C2-A23C-238F2A3DF928
# 44 Linux variable data            4D21B016-B534-45C2-A9FB-5C16E091FD2D
# 45 Linux temporary data           7EC6F557-3BC5-4ACA-B293-16EF5DF639D1
# 46 Linux /usr (x86)               75250D76-8CC6-458E-BD66-BD47CC81A812
# 47 Linux /usr (x86-64)            8484680C-9521-48C6-9C11-B0720656F69E
# 48 Linux /usr (Alpha)             E18CF08C-33EC-4C0D-8246-C6C6FB3DA024
# 49 Linux /usr (ARC)               7978A683-6316-4922-BBEE-38BFF5A2FECC
# 50 Linux /usr (ARM)               7D0359A3-02B3-4F0A-865C-654403E70625
# 51 Linux /usr (ARM-64)            B0E01050-EE5F-4390-949A-9101B17104E9
# 52 Linux /usr (IA-64)             4301D2A6-4E3B-4B2A-BB94-9E0B2C4225EA
# 53 Linux /usr (LoongArch-64)      E611C702-575C-4CBE-9A46-434FA0BF7E3F
# 54 Linux /usr (MIPS-32 LE)        0F4868E9-9952-4706-979F-3ED3A473E947
# 55 Linux /usr (MIPS-64 LE)        C97C1F32-BA06-40B4-9F22-236061B08AA8
# 56 Linux /usr (PPC)               7D14FEC5-CC71-415D-9D6C-06BF0B3C3EAF
# 57 Linux /usr (PPC64)             2C9739E2-F068-46B3-9FD0-01C5A9AFBCCA
# 58 Linux /usr (PPC64LE)           15BB03AF-77E7-4D4A-B12B-C0D084F7491C
# 59 Linux /usr (RISC-V-32)         B933FB22-5C3F-4F91-AF90-E2BB0FA50702
# 60 Linux /usr (RISC-V-64)         BEAEC34B-8442-439B-A40B-984381ED097D
# 61 Linux /usr (S390)              CD0F869B-D0FB-4CA0-B141-9EA87CC78D66
# 62 Linux /usr (S390X)             8A4F5770-50AA-4ED3-874A-99B710DB6FEA
# 63 Linux /usr (TILE-Gx)           55497029-C7C1-44CC-AA39-815ED1558630
# 64 Linux root verity (x86)        D13C5D3B-B5D1-422A-B29F-9454FDC89D76
# 65 Linux root verity (x86-64)     2C7357ED-EBD2-46D9-AEC1-23D437EC2BF5
# 66 Linux root verity (Alpha)      FC56D9E9-E6E5-4C06-BE32-E74407CE09A5
# 67 Linux root verity (ARC)        24B2D975-0F97-4521-AFA1-CD531E421B8D
# 68 Linux root verity (ARM)        7386CDF2-203C-47A9-A498-F2ECCE45A2D6
# 69 Linux root verity (ARM-64)     DF3300CE-D69F-4C92-978C-9BFB0F38D820
# 70 Linux root verity (IA-64)      86ED10D5-B607-45BB-8957-D350F23D0571
# 71 Linux root verity (LoongArch-64) F3393B22-E9AF-4613-A948-9D3BFBD0C535
# 72 Linux root verity (MIPS-32 LE) D7D150D2-2A04-4A33-8F12-16651205FF7B
# 73 Linux root verity (MIPS-64 LE) 16B417F8-3E06-4F57-8DD2-9B5232F41AA6
# 74 Linux root verity (PPC)        98CFE649-1588-46DC-B2F0-ADD147424925
# 75 Linux root verity (PPC64)      9225A9A3-3C19-4D89-B4F6-EEFF88F17631
# 76 Linux root verity (PPC64LE)    906BD944-4589-4AAE-A4E4-DD983917446A
# 77 Linux root verity (RISC-V-32)  AE0253BE-1167-4007-AC68-43926C14C5DE
# 78 Linux root verity (RISC-V-64)  B6ED5582-440B-4209-B8DA-5FF7C419EA3D
# 79 Linux root verity (S390)       7AC63B47-B25C-463B-8DF8-B4A94E6C90E1
# 80 Linux root verity (S390X)      B325BFBE-C7BE-4AB8-8357-139E652D2F6B
# 81 Linux root verity (TILE-Gx)    966061EC-28E4-4B2E-B4A5-1F0A825A1D84
# 82 Linux /usr verity (x86)        8F461B0D-14EE-4E81-9AA9-049B6FB97ABD
# 83 Linux /usr verity (x86-64)     77FF5F63-E7B6-4633-ACF4-1565B864C0E6
# 84 Linux /usr verity (Alpha)      8CCE0D25-C0D0-4A44-BD87-46331BF1DF67
# 85 Linux /usr verity (ARC)        FCA0598C-D880-4591-8C16-4EDA05C7347C
# 86 Linux /usr verity (ARM)        C215D751-7BCD-4649-BE90-6627490A4C05
# 87 Linux /usr verity (ARM-64)     6E11A4E7-FBCA-4DED-B9E9-E1A512BB664E
# 88 Linux /usr verity (IA-64)      6A491E03-3BE7-4545-8E38-83320E0EA880
# 89 Linux /usr verity (LoongArch-64) F46B2C26-59AE-48F0-9106-C50ED47F673D
# 90 Linux /usr verity (MIPS-32 LE) 46B98D8D-B55C-4E8F-AAB3-37FCA7F80752
# 91 Linux /usr verity (MIPS-64 LE) 3C3D61FE-B5F3-414D-BB71-8739A694A4EF
# 92 Linux /usr verity (PPC)        DF765D00-270E-49E5-BC75-F47BB2118B09
# 93 Linux /usr verity (PPC64)      BDB528A5-A259-475F-A87D-DA53FA736A07
# 94 Linux /usr verity (PPC64LE)    EE2B9983-21E8-4153-86D9-B6901A54D1CE
# 95 Linux /usr verity (RISC-V-32)  CB1EE4E3-8CD0-4136-A0A4-AA61A32E8730
# 96 Linux /usr verity (RISC-V-64)  8F1056BE-9B05-47C4-81D6-BE53128E5B54
# 97 Linux /usr verity (S390)       B663C618-E7BC-4D6D-90AA-11B756BB1797
# 98 Linux /usr verity (S390X)      31741CC4-1A2A-4111-A581-E00B447D2D06
# 99 Linux /usr verity (TILE-Gx)    2FB4BF56-07FA-42DA-8132-6B139F2026AE
#100 Linux root verity sign. (x86)  5996FC05-109C-48DE-808B-23FA0830B676
#101 Linux root verity sign. (x86-64) 41092B05-9FC8-4523-994F-2DEF0408B176
#102 Linux root verity sign. (Alpha) D46495B7-A053-414F-80F7-700C99921EF8
#103 Linux root verity sign. (ARC)  143A70BA-CBD3-4F06-919F-6C05683A78BC
#104 Linux root verity sign. (ARM)  42B0455F-EB11-491D-98D3-56145BA9D037
#105 Linux root verity sign. (ARM-64) 6DB69DE6-29F4-4758-A7A5-962190F00CE3
#106 Linux root verity sign. (IA-64) E98B36EE-32BA-4882-9B12-0CE14655F46A
#107 Linux root verity sign. (LoongArch-64) 5AFB67EB-ECC8-4F85-AE8E-AC1E7C50E7D0
#108 Linux root verity sign. (MIPS-32 LE) C919CC1F-4456-4EFF-918C-F75E94525CA5
#109 Linux root verity sign. (MIPS-64 LE) 904E58EF-5C65-4A31-9C57-6AF5FC7C5DE7
#110 Linux root verity sign. (PPC)  1B31B5AA-ADD9-463A-B2ED-BD467FC857E7
#111 Linux root verity sign. (PPC64) F5E2C20C-45B2-4FFA-BCE9-2A60737E1AAF
#112 Linux root verity sign. (PPC64LE) D4A236E7-E873-4C07-BF1D-BF6CF7F1C3C6
#113 Linux root verity sign. (RISC-V-32) 3A112A75-8729-4380-B4CF-764D79934448
#114 Linux root verity sign. (RISC-V-64) EFE0F087-EA8D-4469-821A-4C2A96A8386A
#115 Linux root verity sign. (S390) 3482388E-4254-435A-A241-766A065F9960
#116 Linux root verity sign. (S390X) C80187A5-73A3-491A-901A-017C3FA953E9
#117 Linux root verity sign. (TILE-Gx) B3671439-97B0-4A53-90F7-2D5A8F3AD47B
#118 Linux /usr verity sign. (x86)  974A71C0-DE41-43C3-BE5D-5C5CCD1AD2C0
#119 Linux /usr verity sign. (x86-64) E7BB33FB-06CF-4E81-8273-E543B413E2E2
#120 Linux /usr verity sign. (Alpha) 5C6E1C76-076A-457A-A0FE-F3B4CD21CE6E
#121 Linux /usr verity sign. (ARC)  94F9A9A1-9971-427A-A400-50CB297F0F35
#122 Linux /usr verity sign. (ARM)  D7FF812F-37D1-4902-A810-D76BA57B975A
#123 Linux /usr verity sign. (ARM-64) C23CE4FF-44BD-4B00-B2D4-B41B3419E02A
#124 Linux /usr verity sign. (IA-64) 8DE58BC2-2A43-460D-B14E-A76E4A17B47F
#125 Linux /usr verity sign. (LoongArch-64) B024F315-D330-444C-8461-44BBDE524E99
#126 Linux /usr verity sign. (MIPS-32 LE) 3E23CA0B-A4BC-4B4E-8087-5AB6A26AA8A9
#127 Linux /usr verity sign. (MIPS-64 LE) F2C2C7EE-ADCC-4351-B5C6-EE9816B66E16
#128 Linux /usr verity sign. (PPC)  7007891D-D371-4A80-86A4-5CB875B9302E
#129 Linux /usr verity sign. (PPC64) 0B888863-D7F8-4D9E-9766-239FCE4D58AF
#130 Linux /usr verity sign. (PPC64LE) C8BFBD1E-268E-4521-8BBA-BF314C399557
#131 Linux /usr verity sign. (RISC-V-32) C3836A13-3137-45BA-B583-B16C50FE5EB4
#132 Linux /usr verity sign. (RISC-V-64) D2F9000A-7A18-453F-B5CD-4D32F77A7B32
#133 Linux /usr verity sign. (S390) 17440E4F-A8D0-467F-A46E-3912AE6EF2C5
#134 Linux /usr verity sign. (S390X) 3F324816-667B-46AE-86EE-9B0C0C6C11B4
#135 Linux /usr verity sign. (TILE-Gx) 4EDE75E2-6CCC-4CC8-B9C7-70334B087510
#136 Linux extended boot            BC13C2FF-59E6-4262-A352-B275FD6F7172
#137 Linux user's home              773f91ef-66d4-49b5-bd83-d683bf40ad16
#138 FreeBSD data                   516E7CB4-6ECF-11D6-8FF8-00022D09712B
#139 FreeBSD boot                   83BD6B9D-7F41-11DC-BE0B-001560B84F0F
#140 FreeBSD swap                   516E7CB5-6ECF-11D6-8FF8-00022D09712B
#141 FreeBSD UFS                    516E7CB6-6ECF-11D6-8FF8-00022D09712B
#142 FreeBSD ZFS                    516E7CBA-6ECF-11D6-8FF8-00022D09712B
#143 FreeBSD Vinum                  516E7CB8-6ECF-11D6-8FF8-00022D09712B
#144 Apple HFS/HFS+                 48465300-0000-11AA-AA11-00306543ECAC
#145 Apple APFS                     7C3457EF-0000-11AA-AA11-00306543ECAC
#146 Apple UFS                      55465300-0000-11AA-AA11-00306543ECAC
#147 Apple RAID                     52414944-0000-11AA-AA11-00306543ECAC
#148 Apple RAID offline             52414944-5F4F-11AA-AA11-00306543ECAC
#149 Apple boot                     426F6F74-0000-11AA-AA11-00306543ECAC
#150 Apple label                    4C616265-6C00-11AA-AA11-00306543ECAC
#151 Apple TV recovery              5265636F-7665-11AA-AA11-00306543ECAC
#152 Apple Core storage             53746F72-6167-11AA-AA11-00306543ECAC
#153 Apple Silicon boot             69646961-6700-11AA-AA11-00306543ECAC
#154 Apple Silicon recovery         52637672-7900-11AA-AA11-00306543ECAC
#155 Solaris boot                   6A82CB45-1DD2-11B2-99A6-080020736631
#156 Solaris root                   6A85CF4D-1DD2-11B2-99A6-080020736631
#157 Solaris /usr & Apple ZFS       6A898CC3-1DD2-11B2-99A6-080020736631
#158 Solaris swap                   6A87C46F-1DD2-11B2-99A6-080020736631
#159 Solaris backup                 6A8B642B-1DD2-11B2-99A6-080020736631
#160 Solaris /var                   6A8EF2E9-1DD2-11B2-99A6-080020736631
#161 Solaris /home                  6A90BA39-1DD2-11B2-99A6-080020736631
#162 Solaris alternate sector       6A9283A5-1DD2-11B2-99A6-080020736631
#163 Solaris reserved 1             6A945A3B-1DD2-11B2-99A6-080020736631
#164 Solaris reserved 2             6A9630D1-1DD2-11B2-99A6-080020736631
#165 Solaris reserved 3             6A980767-1DD2-11B2-99A6-080020736631
#166 Solaris reserved 4             6A96237F-1DD2-11B2-99A6-080020736631
#167 Solaris reserved 5             6A8D2AC7-1DD2-11B2-99A6-080020736631
#168 NetBSD swap                    49F48D32-B10E-11DC-B99B-0019D1879648
#169 NetBSD FFS                     49F48D5A-B10E-11DC-B99B-0019D1879648
#170 NetBSD LFS                     49F48D82-B10E-11DC-B99B-0019D1879648
#171 NetBSD concatenated            2DB519C4-B10F-11DC-B99B-0019D1879648
#172 NetBSD encrypted               2DB519EC-B10F-11DC-B99B-0019D1879648
#173 NetBSD RAID                    49F48DAA-B10E-11DC-B99B-0019D1879648
#174 ChromeOS kernel                FE3A2A5D-4F32-41A7-B725-ACCC3285A309
#175 ChromeOS root fs               3CB8E202-3B7E-47DD-8A3C-7FF2A13CFCEC
#176 ChromeOS reserved              2E0A753D-9E48-43B0-8337-B15192CB1B5E
#177 MidnightBSD data               85D5E45A-237C-11E1-B4B3-E89A8F7FC3A7
#178 MidnightBSD boot               85D5E45E-237C-11E1-B4B3-E89A8F7FC3A7
#179 MidnightBSD swap               85D5E45B-237C-11E1-B4B3-E89A8F7FC3A7
#180 MidnightBSD UFS                0394EF8B-237E-11E1-B4B3-E89A8F7FC3A7
#181 MidnightBSD ZFS                85D5E45D-237C-11E1-B4B3-E89A8F7FC3A7
#182 MidnightBSD Vinum              85D5E45C-237C-11E1-B4B3-E89A8F7FC3A7
#183 Ceph Journal                   45B0969E-9B03-4F30-B4C6-B4B80CEFF106
#184 Ceph Encrypted Journal         45B0969E-9B03-4F30-B4C6-5EC00CEFF106
#185 Ceph OSD                       4FBD7E29-9D25-41B8-AFD0-062C0CEFF05D
#186 Ceph crypt OSD                 4FBD7E29-9D25-41B8-AFD0-5EC00CEFF05D
#187 Ceph disk in creation          89C57F98-2FE5-4DC0-89C1-F3AD0CEFF2BE
#188 Ceph crypt disk in creation    89C57F98-2FE5-4DC0-89C1-5EC00CEFF2BE
#189 VMware VMFS                    AA31E02A-400F-11DB-9590-000C2911D1B8
#190 VMware Diagnostic              9D275380-40AD-11DB-BF97-000C2911D1B8
#191 VMware Virtual SAN             381CFCCC-7288-11E0-92EE-000C2911D0B2
#192 VMware Virsto                  77719A0C-A4A0-11E3-A47E-000C29745A24
#193 VMware Reserved                9198EFFC-31C0-11DB-8F78-000C2911D1B8
#194 OpenBSD data                   824CC7A0-36A8-11E3-890A-952519AD3F61
#195 QNX6 file system               CEF5A9AD-73BC-4601-89F3-CDEEEEE321A1
#196 Plan 9 partition               C91818F9-8025-47AF-89D2-F030D7000C2C
#197 HiFive FSBL                    5B193300-FC78-40CD-8002-E86C45580B47
#198 HiFive BBL                     2E54B353-1271-4842-806F-E436D6AF6985
#199 Haiku BFS                      42465331-3BA3-10F1-802A-4861696B7521
#200 Marvell Armada 3700 Boot partition 6828311A-BA55-42A4-BCDE-A89BB5EDECAE

## constants
PARTITION_SIZE_AUTO="auto"

BOOT_NUM_PART=1
EFI_NUM_PART=2
FS_NUM_PART=3
DATA_NUM_PART=4

BOOT_TYPE_PART=4
EFI_TYPE_PART=1
FS_TYPE_PART=20
DATA_TYPE_PART=21

source ./config_vps.sh

sudo dd if=/dev/zero of=/dev/$HARDWARE_DISK_NAME bs=512 count=1 conv=notrunc

## Create the partition table
# n for new partition
# '' for default value, used for select the beginning of the partition where is possible
# t for change the type of the partition
# w for write the partition table
(
# create a new empty GPT partition table
echo g

# create boot partition
echo n
echo $BOOT_NUM_PART
echo
echo +$HARDWARE_VPS_BOOT_SIZE
echo t
# no need to select the partition number because it's the last one
echo $BOOT_TYPE_PART

# create efi partition
echo n
echo $EFI_NUM_PART
echo
echo +$HARDWARE_EFI_SIZE
echo t
echo $EFI_NUM_PART
echo $EFI_TYPE_PART

# create file system partition
echo n
echo $FS_NUM_PART
echo
echo +$HARDWARE_FS_SIZE
echo t
echo $FS_NUM_PART
echo $FS_TYPE_PART

# create data partition
echo n
echo $DATA_NUM_PART
echo
if [ "$(echo "$HARDWARE_PERSISTENT_SIZE" | tr '[:upper:]' '[:lower:]')" = "$PARTITION_SIZE_AUTO" ]; then
	echo
else
	echo +$HARDWARE_PERSISTENT_SIZE
fi
echo t
echo $DATA_NUM_PART
echo $DATA_TYPE_PART

# write the partition table
echo w

) | sudo fdisk /dev/$HARDWARE_DISK_NAME

## Format partitions
yes n | sudo mkfs.ext4 -L boot /dev/$HARDWARE_DISK_NAME$BOOT_NUM_PART
yes n | sudo mkfs.vfat -F 32 /dev/$HARDWARE_DISK_NAME$EFI_NUM_PART
yes n | sudo mkfs.ext4 -L fs /dev/$HARDWARE_DISK_NAME$FS_NUM_PART
yes n | sudo mkfs.ext4 -L data /dev/$HARDWARE_DISK_NAME$DATA_NUM_PART

./partition_mounter.sh $HARDWARE_DISK_NAME $EFI_NUM_PART $FS_NUM_PART $DATA_NUM_PART

## Prepare partition configuration files
EFI_UUID_PART=$(lsblk -o name,uuid | grep -w $HARDWARE_DISK_NAME$EFI_NUM_PART | sed -e 's/.*'$HARDWARE_DISK_NAME$EFI_NUM_PART' //g')
FS_UUID_PART=$(lsblk -o name,uuid | grep -w $HARDWARE_DISK_NAME$FS_NUM_PART | sed -e 's/.*'$HARDWARE_DISK_NAME$FS_NUM_PART' //g')
DATA_UUID_PART=$(lsblk -o name,uuid | grep -w $HARDWARE_DISK_NAME$DATA_NUM_PART | sed -e 's/.*'$HARDWARE_DISK_NAME$DATA_NUM_PART' //g')

FSTAB_PATH=./resources/fstab
echo "# /etc/fstab: static file system information." > $FSTAB_PATH
echo "UUID=$FS_UUID_PART / ext4 rw,discard,errors=remount-ro,x-systemd.growfs 0 1" >> $FSTAB_PATH
echo "UUID=$DATA_UUID_PART /data ext4 rw,discard 0 2" >> $FSTAB_PATH
echo "UUID=$EFI_UUID_PART /boot/efi vfat defaults 0 0" >> $FSTAB_PATH