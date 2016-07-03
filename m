From: sunnydrake <sunnydrake7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Regression] Amd-Vi + ivrs_ioapic cause kernel oops (4.4, 4.7 fail 3.9
	works)
Date: Sun, 3 Jul 2016 03:59:14 +0300
Message-ID: <57786362.1010702@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8142148186637650999=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a multi-part message in MIME format.
--===============8142148186637650999==
Content-Type: multipart/alternative;
 boundary="------------000502060306050302080400"

This is a multi-part message in MIME format.
--------------000502060306050302080400
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

[description]
working in kernel 3.9
Oops in current 4.4.0-28,4.7.0-040700rc5
kernel options ivrs_ioapic[7]=00:14.0  ivrs_ioapic[8]=00:00.1 workaround 
to fix ivrs table
cause kernel Oops on boot

[bug]
oops:
short oops text
AMD-Vi: Completion_wait loop timed Out
BUG: unable to handle kernel NULL pointer dereference at 000..03e
... irq_pm_install_action+0x1c/0xd0
full oops image text
http://img.ctrlv.in/img/16/07/03/577863055370c.jpg

[additional info]
dmesg|grep AMD-Vi without ivrs_ioapic[8]=00:00.1
[    0.108566] AMD-Vi: Using IVHD type 0x10
[    0.108630] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: 3e info 1300
[    0.108671] AMD-Vi:        mmio-addr: 00000000feb20000
[    0.108750] AMD-Vi:   DEV_SELECT_RANGE_START     devid: 00:00.0 flags: 00
[    0.108792] AMD-Vi:   DEV_RANGE_END         devid: 00:00.2
[    0.108834] AMD-Vi:   DEV_SELECT             devid: 00:02.0 flags: 00
[    0.108875] AMD-Vi:   DEV_SELECT_RANGE_START     devid: 01:00.0 flags: 00
[    0.108917] AMD-Vi:   DEV_RANGE_END         devid: 01:00.1
[    0.108958] AMD-Vi:   DEV_SELECT             devid: 00:04.0 flags: 00
[    0.108999] AMD-Vi:   DEV_SELECT             devid: 02:00.0 flags: 00
[    0.109041] AMD-Vi:   DEV_SELECT             devid: 00:07.0 flags: 00
[    0.109082] AMD-Vi:   DEV_SELECT             devid: 03:00.0 flags: 00
[    0.109124] AMD-Vi:   DEV_SELECT             devid: 00:11.0 flags: 00
[    0.109166] AMD-Vi:   DEV_SELECT_RANGE_START     devid: 00:12.0 flags: 00
[    0.109207] AMD-Vi:   DEV_RANGE_END         devid: 00:12.2
[    0.109249] AMD-Vi:   DEV_SELECT_RANGE_START     devid: 00:13.0 flags: 00
[    0.114267] AMD-Vi:   DEV_RANGE_END         devid: 00:13.2
[    0.114308] AMD-Vi:   DEV_SELECT             devid: 00:14.0 flags: d7
[    0.114348] AMD-Vi:   DEV_SELECT             devid: 00:14.2 flags: 00
[    0.114389] AMD-Vi:   DEV_SELECT             devid: 00:14.3 flags: 00
[    0.114429] AMD-Vi:   DEV_SELECT             devid: 00:14.4 flags: 00
[    0.114471] AMD-Vi:   DEV_ALIAS_RANGE         devid: 04:00.0 flags: 
00 devid_to: 00:14.4
[    0.114519] AMD-Vi:   DEV_RANGE_END         devid: 04:1f.7
[    0.114564] AMD-Vi:   DEV_SELECT             devid: 00:14.5 flags: 00
[    0.114605] AMD-Vi:   DEV_SELECT             devid: 00:15.0 flags: 00
[    0.114645] AMD-Vi:   DEV_SELECT_RANGE_START     devid: 05:00.0 flags: 00
[    0.114687] AMD-Vi:   DEV_RANGE_END         devid: 05:00.1
[    0.114728] AMD-Vi:   DEV_SELECT_RANGE_START     devid: 00:16.0 flags: 00
[    0.114768] AMD-Vi:   DEV_RANGE_END         devid: 00:16.2
[    0.114840] AMD-Vi:   DEV_SPECIAL(IOAPIC[0])        devid: 00:14.0
[    0.114885] AMD-Vi:   DEV_SPECIAL(HPET[0])        devid: 00:14.0
[    0.114927] AMD-Vi:   DEV_SPECIAL(IOAPIC[255])        devid: 00:00.1
[    0.114969] AMD-Vi: IOAPIC[8] not in IVRS table
[    0.115010] AMD-Vi: Disabling interrupt remapping
[    2.994584] AMD-Vi: Completion-Wait loop timed out
[    3.103059] AMD-Vi: Completion-Wait loop timed out
[    3.103145] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    3.103279] AMD-Vi: Lazy IO/TLB flushing enabled
[    3.993134] AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=05:00.0 
address=0x000000044c6464a0]
[    3.993213] AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=05:00.0 
address=0x000000044c6464c0]
[    5.100622] AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=05:00.0 
address=0x000000044c646500]

[software&hw]
Kernel Version:
Linux version 4.7.0-040700rc5-generic (kernel@tangerine) (gcc version 
5.4.0 20160609 (Ubuntu 5.4.0-4ubuntu1) )
#201606262232 SMP Mon Jun 27 02:34:07 UTC 2016
Environment:
Description:    Ubuntu 16.04 LTS
Release:    16.04
Software :
Linux main 4.7.0-040700rc5-generic #201606262232 SMP Mon Jun 27 02:34:07 
UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

GNU C            5.3.1
GNU Make        4.1
Binutils        2.26
Util-linux        2.27.1
Mount            2.27.1
Module-init-tools    22
E2fsprogs        1.42.13
Pcmciautils        018
PPP            2.4.7
Linux C Library        2.23
Dynamic linker (ldd)    2.23
Linux C++ Library    6.0.21
Procps            3.3.10
Net-tools        1.60
Kbd            1.15.5
Console-tools        1.15.5
Sh-utils        8.25
Udev            229
Wireless-tools        30
Modules Loaded        ablk_helper acpi_cpufreq aesni_intel aes_x86_64 
ahci ansi_cprng asus_wmi autofs4 binfmt_misc bridge button crc16 
crc32c_intel crc32_pclmul crct10dif_pclmul cryptd dm_mod drbg drm 
drm_kms_helper ebtable_filter ebtables eeepc_wmi ehci_hcd ehci_pci evdev 
ext4 fam15h_power fjes fuse gf128mul ghash_clmulni_intel glue_helper hid 
hid_generic hmac i2c_algo_bit i2c_piix4 ip6table_filter ip6_tables 
iptable_filter iptable_mangle iptable_nat ip_tables ipt_MASQUERADE 
ipt_REJECT irqbypass jbd2 joydev k10temp kvm kvm_amd libahci libata llc 
lp lrw mbcache media mii nf_conntrack nf_conntrack_ipv4 nf_defrag_ipv4 
nf_nat nf_nat_ipv4 nf_nat_masquerade_ipv4 nf_reject_ipv4 ohci_hcd 
ohci_pci parport parport_pc ppdev psmouse r8169 radeon rfkill scsi_mod 
sd_mod serio_raw sg shpchp snd snd_hda_codec snd_hda_codec_generic 
snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_core snd_hda_intel 
snd_hwdep snd_pcm snd_rawmidi snd_seq snd_seq_device snd_seq_midi 
snd_seq_midi_event snd_timer snd_usb_audio snd_usbmidi_lib soundcore 
sparse_keymap stp tpm tpm_tis ttm tun usb_common usbcore usbhid uvcvideo 
vfio vfio_iommu_type1 vfio_pci vfio_virqfd video videobuf2_core 
videobuf2_memops videobuf2_v4l2 videobuf2_vmalloc videodev wmi xhci_hcd 
xhci_pci x_tables xt_CHECKSUM xt_conntrack xt_multiport xt_tcpudp
Processor information:
processor    : 0
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 1
model name    : AMD FX(tm)-6100 Six-Core Processor
stepping    : 2
microcode    : 0x6000629
cpu MHz        : 1400.000
cache size    : 2048 KB
physical id    : 0
siblings    : 6
core id        : 0
cpu cores    : 3
apicid        : 16
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid 
aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 
popcnt aes xsave avx lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a 
misalignsse 3dnowprefetch osvw ibs xop skinit wdt lwp fma4 nodeid_msr 
topoext perfctr_core perfctr_nb cpb hw_pstate vmmcall arat npt lbrv 
svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists 
pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg
bogomips    : 6621.82
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb

processor    : 1
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 1
model name    : AMD FX(tm)-6100 Six-Core Processor
stepping    : 2
microcode    : 0x6000629
cpu MHz        : 1400.000
cache size    : 2048 KB
physical id    : 0
siblings    : 6
core id        : 0
cpu cores    : 3
apicid        : 17
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid 
aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 
popcnt aes xsave avx lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a 
misalignsse 3dnowprefetch osvw ibs xop skinit wdt lwp fma4 nodeid_msr 
topoext perfctr_core perfctr_nb cpb hw_pstate vmmcall arat npt lbrv 
svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists 
pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg
bogomips    : 6621.69
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb

processor    : 2
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 1
model name    : AMD FX(tm)-6100 Six-Core Processor
stepping    : 2
microcode    : 0x6000629
cpu MHz        : 1400.000
cache size    : 2048 KB
physical id    : 0
siblings    : 6
core id        : 1
cpu cores    : 3
apicid        : 18
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid 
aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 
popcnt aes xsave avx lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a 
misalignsse 3dnowprefetch osvw ibs xop skinit wdt lwp fma4 nodeid_msr 
topoext perfctr_core perfctr_nb cpb hw_pstate vmmcall arat npt lbrv 
svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists 
pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg
bogomips    : 6621.72
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb

processor    : 3
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 1
model name    : AMD FX(tm)-6100 Six-Core Processor
stepping    : 2
microcode    : 0x6000629
cpu MHz        : 1400.000
cache size    : 2048 KB
physical id    : 0
siblings    : 6
core id        : 1
cpu cores    : 3
apicid        : 19
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid 
aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 
popcnt aes xsave avx lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a 
misalignsse 3dnowprefetch osvw ibs xop skinit wdt lwp fma4 nodeid_msr 
topoext perfctr_core perfctr_nb cpb hw_pstate vmmcall arat npt lbrv 
svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists 
pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg
bogomips    : 6621.71
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb

processor    : 4
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 1
model name    : AMD FX(tm)-6100 Six-Core Processor
stepping    : 2
microcode    : 0x6000629
cpu MHz        : 1800.000
cache size    : 2048 KB
physical id    : 0
siblings    : 6
core id        : 2
cpu cores    : 3
apicid        : 20
initial apicid    : 4
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid 
aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 
popcnt aes xsave avx lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a 
misalignsse 3dnowprefetch osvw ibs xop skinit wdt lwp fma4 nodeid_msr 
topoext perfctr_core perfctr_nb cpb hw_pstate vmmcall arat npt lbrv 
svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists 
pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg
bogomips    : 6621.76
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb

processor    : 5
vendor_id    : AuthenticAMD
cpu family    : 21
model        : 1
model name    : AMD FX(tm)-6100 Six-Core Processor
stepping    : 2
microcode    : 0x6000629
cpu MHz        : 1400.000
cache size    : 2048 KB
physical id    : 0
siblings    : 6
core id        : 2
cpu cores    : 3
apicid        : 21
initial apicid    : 5
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt 
pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid 
aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 
popcnt aes xsave avx lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a 
misalignsse 3dnowprefetch osvw ibs xop skinit wdt lwp fma4 nodeid_msr 
topoext perfctr_core perfctr_nb cpb hw_pstate vmmcall arat npt lbrv 
svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists 
pausefilter pfthreshold
bugs        : fxsave_leak sysret_ss_attrs null_seg
bogomips    : 6621.78
TLB size    : 1536 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb
Module information:
xt_CHECKSUM 16384 1 - Live 0x0000000000000000
iptable_mangle 16384 1 - Live 0x0000000000000000
xt_conntrack 16384 1 - Live 0x0000000000000000
ipt_REJECT 16384 2 - Live 0x0000000000000000
nf_reject_ipv4 16384 1 ipt_REJECT, Live 0x0000000000000000
xt_tcpudp 16384 6 - Live 0x0000000000000000
tun 28672 1 - Live 0x0000000000000000
bridge 126976 0 - Live 0x0000000000000000
stp 16384 1 bridge, Live 0x0000000000000000
llc 16384 2 bridge,stp, Live 0x0000000000000000
ebtable_filter 16384 0 - Live 0x0000000000000000
ebtables 36864 1 ebtable_filter, Live 0x0000000000000000
ip6table_filter 16384 0 - Live 0x0000000000000000
ip6_tables 24576 1 ip6table_filter, Live 0x0000000000000000
fuse 98304 2 - Live 0x0000000000000000
ipt_MASQUERADE 16384 6 - Live 0x0000000000000000
nf_nat_masquerade_ipv4 16384 1 ipt_MASQUERADE, Live 0x0000000000000000
iptable_nat 16384 1 - Live 0x0000000000000000
nf_conntrack_ipv4 20480 2 - Live 0x0000000000000000
nf_defrag_ipv4 16384 1 nf_conntrack_ipv4, Live 0x0000000000000000
nf_nat_ipv4 16384 1 iptable_nat, Live 0x0000000000000000
nf_nat 24576 2 nf_nat_masquerade_ipv4,nf_nat_ipv4, Live 0x0000000000000000
nf_conntrack 114688 5 
xt_conntrack,nf_nat_masquerade_ipv4,nf_conntrack_ipv4,nf_nat_ipv4,nf_nat, Live 
0x0000000000000000
xt_multiport 16384 5 - Live 0x0000000000000000
iptable_filter 16384 1 - Live 0x0000000000000000
ip_tables 24576 3 iptable_mangle,iptable_nat,iptable_filter, Live 
0x0000000000000000
x_tables 36864 12 
xt_CHECKSUM,iptable_mangle,xt_conntrack,ipt_REJECT,xt_tcpudp,ebtables,ip6table_filter,ip6_tables,ipt_MASQUERADE,xt_multiport,iptable_filter,ip_tables, 
Live 0x0000000000000000
binfmt_misc 20480 1 - Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
snd_hda_codec_realtek 86016 1 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
snd_hda_codec_generic 69632 1 snd_hda_codec_realtek, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
hmac 16384 1 - Live 0x0000000000000000
drbg 24576 1 - Live 0x0000000000000000
ansi_cprng 16384 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 45056 1 - Live 0x0000000000000000
videobuf2_v4l2 24576 1 uvcvideo, Live 0x0000000000000000
videobuf2_core 36864 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
videodev 167936 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live 
0x0000000000000000
aesni_intel 167936 0 - Live 0x0000000000000000
snd_hda_intel 36864 7 - Live 0x0000000000000000
snd_hda_codec 131072 4 
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel, 
Live 0x0000000000000000
snd_usb_audio 176128 3 - Live 0x0000000000000000
snd_hda_core 81920 5 
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, 
Live 0x0000000000000000
snd_usbmidi_lib 28672 1 snd_usb_audio, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
snd_hwdep 16384 2 snd_hda_codec,snd_usb_audio, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
media 32768 2 uvcvideo,videodev, Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
snd_pcm 106496 6 
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_usb_audio,snd_hda_core, 
Live 0x0000000000000000
snd_rawmidi 32768 2 snd_usbmidi_lib,snd_seq_midi, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
snd_seq 65536 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
eeepc_wmi 16384 0 - Live 0x0000000000000000
asus_wmi 28672 1 eeepc_wmi, Live 0x0000000000000000
sparse_keymap 16384 1 asus_wmi, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
kvm_amd 73728 0 - Live 0x0000000000000000
rfkill 24576 3 asus_wmi, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
video 40960 1 asus_wmi, Live 0x0000000000000000
snd 81920 32 
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_usb_audio,snd_usbmidi_lib,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
cryptd 20480 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 
0x0000000000000000
kvm 565248 1 kvm_amd, Live 0x0000000000000000
fam15h_power 16384 0 - Live 0x0000000000000000
k10temp 16384 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
i2c_piix4 24576 0 - Live 0x0000000000000000
evdev 24576 30 - Live 0x0000000000000000
acpi_cpufreq 20480 0 - Live 0x0000000000000000
sg 32768 0 - Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
tpm_tis 20480 0 - Live 0x0000000000000000
tpm 45056 1 tpm_tis, Live 0x0000000000000000
parport_pc 28672 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
ext4 589824 2 - Live 0x0000000000000000
crc16 16384 1 ext4, Live 0x0000000000000000
jbd2 106496 1 ext4, Live 0x0000000000000000
mbcache 16384 3 ext4, Live 0x0000000000000000
dm_mod 106496 7 - Live 0x0000000000000000
vfio_pci 40960 0 - Live 0x0000000000000000
irqbypass 16384 2 kvm,vfio_pci, Live 0x0000000000000000
vfio_virqfd 16384 1 vfio_pci, Live 0x0000000000000000
vfio_iommu_type1 20480 0 - Live 0x0000000000000000
vfio 28672 2 vfio_pci,vfio_iommu_type1, Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 49152 0 - Live 0x0000000000000000
hid 114688 2 hid_generic,usbhid, Live 0x0000000000000000
sd_mod 45056 6 - Live 0x0000000000000000
ohci_pci 16384 0 - Live 0x0000000000000000
radeon 1495040 3 - Live 0x0000000000000000
xhci_pci 16384 0 - Live 0x0000000000000000
crc32c_intel 24576 0 - Live 0x0000000000000000
xhci_hcd 172032 1 xhci_pci, Live 0x0000000000000000
psmouse 126976 0 - Live 0x0000000000000000
ohci_hcd 49152 1 ohci_pci, Live 0x0000000000000000
ehci_pci 16384 0 - Live 0x0000000000000000
ahci 36864 7 - Live 0x0000000000000000
i2c_algo_bit 16384 1 radeon, Live 0x0000000000000000
ehci_hcd 77824 1 ehci_pci, Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
ttm 94208 1 radeon, Live 0x0000000000000000
libata 241664 2 ahci,libahci, Live 0x0000000000000000
drm_kms_helper 143360 1 radeon, Live 0x0000000000000000
usbcore 237568 11 
uvcvideo,snd_usb_audio,snd_usbmidi_lib,usbhid,ohci_pci,xhci_pci,xhci_hcd,ohci_hcd,ehci_pci,ehci_hcd, 
Live 0x0000000000000000
drm 352256 6 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
scsi_mod 225280 3 sg,sd_mod,libata, Live 0x0000000000000000
r8169 81920 0 - Live 0x0000000000000000
usb_common 16384 1 usbcore, Live 0x0000000000000000
mii 16384 1 r8169, Live 0x0000000000000000
wmi 16384 1 asus_wmi, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
button 16384 0 - Live 0x0000000000000000
Loaded driver and hardware information :
ioports
0000-0000 : PCI Bus 0000:00
   0000-0000 : dma1
   0000-0000 : pic1
   0000-0000 : timer0
   0000-0000 : timer1
   0000-0000 : keyboard
   0000-0000 : PNP0800:00
   0000-0000 : PNP0C09:00
     0000-0000 : EC data
   0000-0000 : keyboard
   0000-0000 : PNP0C09:00
     0000-0000 : EC cmd
   0000-0000 : rtc0
   0000-0000 : dma page reg
   0000-0000 : pic2
   0000-0000 : dma2
   0000-0000 : PNP0C04:00
     0000-0000 : fpu
   0000-0000 : pnp 00:02
0000-0000 : PCI Bus 0000:00
   0000-0000 : vga+
0000-0000 : PCI Bus 0000:00
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:04
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
     0000-0000 : ACPI PM1a_EVT_BLK
     0000-0000 : ACPI PM1a_CNT_BLK
     0000-0000 : ACPI PM_TMR
     0000-0000 : ACPI CPU throttle
     0000-0000 : ACPI GPE0_BLK
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : piix4_smbus
   0000-0000 : pnp 00:01
     0000-0000 : piix4_smbus
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
   0000-0000 : pnp 00:01
     0000-0000 : smba_idx
   0000-0000 : pnp 00:01
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
   0000-0000 : PCI Bus 0000:05
     0000-0000 : 0000:05:00.0
   0000-0000 : PCI Bus 0000:04
     0000-0000 : 0000:04:06.0
       0000-0000 : r8169
   0000-0000 : PCI Bus 0000:02
     0000-0000 : 0000:02:00.0
       0000-0000 : r8169
   0000-0000 : PCI Bus 0000:01
     0000-0000 : 0000:01:00.0
   0000-0000 : 0000:00:11.0
     0000-0000 : ahci
   0000-0000 : 0000:00:11.0
     0000-0000 : ahci
   0000-0000 : 0000:00:11.0
     0000-0000 : ahci
   0000-0000 : 0000:00:11.0
     0000-0000 : ahci
   0000-0000 : 0000:00:11.0
     0000-0000 : ahci
   0000-0000 : pnp 00:01
iomem
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : Video ROM
00000000-00000000 : reserved
   00000000-00000000 : System ROM
00000000-00000000 : System RAM
   00000000-00000000 : Kernel code
   00000000-00000000 : Kernel data
   00000000-00000000 : Kernel bss
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : ACPI Tables
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : reserved
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : reserved
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : reserved
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : reserved
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : PCI Bus 0000:05
     00000000-00000000 : 0000:05:00.0
     00000000-00000000 : 0000:05:00.0
   00000000-00000000 : PCI Bus 0000:01
     00000000-00000000 : 0000:01:00.0
   00000000-00000000 : PCI Bus 0000:02
     00000000-00000000 : 0000:02:00.0
       00000000-00000000 : r8169
     00000000-00000000 : 0000:02:00.0
       00000000-00000000 : r8169
   00000000-00000000 : PCI MMCONFIG 0000 [bus 00-ff]
     00000000-00000000 : pnp 00:00
   00000000-00000000 : reserved
   00000000-00000000 : PCI Bus 0000:05
     00000000-00000000 : 0000:05:00.0
     00000000-00000000 : 0000:05:00.0
     00000000-00000000 : 0000:05:00.1
   00000000-00000000 : PCI Bus 0000:04
     00000000-00000000 : 0000:04:06.0
     00000000-00000000 : 0000:04:06.0
       00000000-00000000 : r8169
   00000000-00000000 : PCI Bus 0000:03
     00000000-00000000 : 0000:03:00.0
       00000000-00000000 : xhci-hcd
   00000000-00000000 : PCI Bus 0000:01
     00000000-00000000 : 0000:01:00.0
     00000000-00000000 : 0000:01:00.1
       00000000-00000000 : ICH HD audio
   00000000-00000000 : 0000:00:14.2
     00000000-00000000 : ICH HD audio
   00000000-00000000 : 0000:00:16.2
     00000000-00000000 : ehci_hcd
   00000000-00000000 : 0000:00:16.0
     00000000-00000000 : ohci_hcd
   00000000-00000000 : 0000:00:14.5
     00000000-00000000 : ohci_hcd
   00000000-00000000 : 0000:00:13.2
     00000000-00000000 : ehci_hcd
   00000000-00000000 : 0000:00:13.0
     00000000-00000000 : ohci_hcd
   00000000-00000000 : 0000:00:12.2
     00000000-00000000 : ehci_hcd
   00000000-00000000 : 0000:00:12.0
     00000000-00000000 : ohci_hcd
   00000000-00000000 : 0000:00:11.0
     00000000-00000000 : ahci
   00000000-00000000 : amd_iommu
   00000000-00000000 : reserved
     00000000-00000000 : IOAPIC 0
   00000000-00000000 : reserved
     00000000-00000000 : pnp 00:01
   00000000-00000000 : reserved
     00000000-00000000 : IOAPIC 1
   00000000-00000000 : reserved
     00000000-00000000 : HPET 0
       00000000-00000000 : PNP0103:00
   00000000-00000000 : reserved
     00000000-00000000 : pnp 00:01
   00000000-00000000 : reserved
     00000000-00000000 : pnp 00:01
   00000000-00000000 : Local APIC
     00000000-00000000 : pnp 00:01
   00000000-00000000 : reserved
     00000000-00000000 : pnp 00:01
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer
PCI information:
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to 
PCI bridge (external gfx0 port B) (rev 02)
     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to PCI 
bridge (external gfx0 port B)
     Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
     Capabilities: [f0] HyperTransport: MSI Mapping Enable+ Fixed+
     Capabilities: [c4] HyperTransport: Slave or Primary Interface
         Command: BaseUnitID=0 UnitCnt=20 MastHost- DefDir- DUL-
         Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- 
<CRCErr=0 IsocEn- LSEn- ExtCTL- 64b+
         Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit 
DwFcInEn- LWO=16bit DwFcOutEn-
         Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ 
<CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
         Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit 
DwFcInEn- LWO=8bit DwFcOutEn-
         Revision ID: 3.00
         Link Frequency 0: [d]
         Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
         Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+ 500MHz- 
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
         Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD-
         Link Frequency 1: 200MHz
         Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
         Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 
600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
         Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE- CRCFE- 
SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
         Prefetchable memory behind bridge Upper: 00-00
         Bus Number: 00
     Capabilities: [40] HyperTransport: Retry Mode
     Capabilities: [54] HyperTransport: UnitID Clumping
     Capabilities: [9c] HyperTransport: #1a
     Capabilities: [70] MSI: Enable- Count=1/4 Maskable- 64bit-
         Address: 00000000  Data: 0000

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory 
Management Unit (IOMMU)
     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory 
Management Unit (IOMMU)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin A routed to IRQ 26
     Capabilities: [40] Secure device <?>
     Capabilities: [54] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee3f00c  Data: 41e1
     Capabilities: [64] HyperTransport: MSI Mapping Enable+ Fixed+

00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to 
PCI bridge (PCI express gpp port B) (prog-if 00 [Normal decode])
     DeviceName:  Onboard IGD
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 27
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: 0000e000-0000efff
     Memory behind bridge: fea00000-feafffff
     Prefetchable memory behind bridge: 00000000c0000000-00000000cfffffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit 
Latency L0s <1us, L1 <8us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt+
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #2, PowerLimit 75.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible+
         RootCap: CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, 
OBFF Not Supported ARIFwd+
         DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. 
[AMD/ATI] RD890 PCI to PCI bridge (PCI express gpp port B)
     Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
     Capabilities: [190 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to 
PCI bridge (PCI express gpp port D) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 27
     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
     I/O behind bridge: 0000d000-0000dfff
     Memory behind bridge: fff00000-000fffff
     Prefetchable memory behind bridge: 00000000d0000000-00000000d00fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 5GT/s, Width x2, ASPM L0s L1, Exit 
Latency L0s <1us, L1 <8us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #4, PowerLimit 75.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible+
         RootCap: CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, 
OBFF Not Supported ARIFwd+
         DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. 
[AMD/ATI] RD890 PCI to PCI bridge (PCI express gpp port D)
     Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
     Capabilities: [190 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI to 
PCI bridge (PCI express gpp port G) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 24
     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: fe900000-fe9fffff
     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <1us, L1 <8us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt+
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #7, PowerLimit 75.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible+
         RootCap: CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, 
OBFF Not Supported ARIFwd+
         DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. 
[AMD/ATI] RD890 PCI to PCI bridge (PCI express gpp port G)
     Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
     Capabilities: [190 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans+
         ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl- DirectTrans-
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40) (prog-if 01 [AHCI 
1.0])
     Subsystem: ASUSTeK Computer Inc. SB7x0/SB8x0/SB9x0 SATA Controller 
[AHCI mode]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 32
     Interrupt: pin A routed to IRQ 19
     Region 0: I/O ports at f040 [size=8]
     Region 1: I/O ports at f030 [size=4]
     Region 2: I/O ports at f020 [size=8]
     Region 3: I/O ports at f010 [size=4]
     Region 4: I/O ports at f000 [size=16]
     Region 5: Memory at feb0b000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [70] SATA HBA v1.0 InCfgSpace
     Capabilities: [a4] PCI Advanced Features
         AFCap: TP+ FLR+
         AFCtrl: FLR-
         AFStatus: TP+
     Kernel driver in use: ahci
     Kernel modules: ahci

00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 
USB OHCI0 Controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 32, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 18
     Region 0: Memory at feb0a000 (32-bit, non-prefetchable) [size=4K]
     Kernel driver in use: ohci-pci
     Kernel modules: ohci_pci

00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 
USB EHCI Controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 32, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 17
     Region 0: Memory at feb09000 (32-bit, non-prefetchable) [size=256]
     Capabilities: [c0] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Bridge: PM- B3+
     Capabilities: [e4] Debug port: BAR=1 offset=00e0
     Kernel driver in use: ehci-pci
     Kernel modules: ehci_pci

00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 
USB OHCI0 Controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 32, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 20
     Region 0: Memory at feb08000 (32-bit, non-prefetchable) [size=4K]
     Kernel driver in use: ohci-pci
     Kernel modules: ohci_pci

00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 
USB EHCI Controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 32, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 21
     Region 0: Memory at feb07000 (32-bit, non-prefetchable) [size=256]
     Capabilities: [c0] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Bridge: PM- B3+
     Capabilities: [e4] Debug port: BAR=1 offset=00e0
     Kernel driver in use: ehci-pci
     Kernel modules: ehci_pci

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus 
Controller (rev 42)
     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus 
Controller
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Kernel driver in use: piix4_smbus
     Kernel modules: i2c_piix4, sp5100_tco

00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 
Azalia (Intel HDA) (rev 40)
     Subsystem: ASUSTeK Computer Inc. SBx00 Azalia (Intel HDA)
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 32, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 16
     Region 0: Memory at feb00000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: snd_hda_intel
     Kernel modules: snd_hda_intel

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 LPC host controller (rev 40)
     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 
LPC host controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0

00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI to 
PCI Bridge (rev 40) (prog-if 01 [Subtractive decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 64
     Bus: primary=00, secondary=04, subordinate=04, sec-latency=64
     I/O behind bridge: 0000c000-0000cfff
     Memory behind bridge: fe800000-fe8fffff
     Prefetchable memory behind bridge: fff00000-000fffff
     Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:14.5 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 USB OHCI2 Controller (prog-if 10 [OHCI])
     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 
USB OHCI2 Controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 32, Cache Line Size: 64 bytes
     Interrupt: pin C routed to IRQ 18
     Region 0: Memory at feb06000 (32-bit, non-prefetchable) [size=4K]
     Kernel driver in use: ohci-pci
     Kernel modules: ohci_pci

00:15.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] 
SB700/SB800/SB900 PCI to PCI bridge (PCIE port 0) (prog-if 00 [Normal 
decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 16
     Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
     I/O behind bridge: 0000b000-0000bfff
     Memory behind bridge: fe700000-fe7fffff
     Prefetchable memory behind bridge: 00000000a0000000-00000000b01fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Root Port (Slot-), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0
             ExtTag+ RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 5GT/s, Width x4, ASPM L0s L1, Exit 
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible+
         RootCap: CRSVisible+
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, 
OBFF Not Supported ARIFwd-
         DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd-
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. 
[AMD/ATI] SB700/SB800/SB900 PCI to PCI bridge (PCIE port 0)
     Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
     Kernel driver in use: pcieport
     Kernel modules: shpchp

00:16.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 
USB OHCI0 Controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 32, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 22
     Region 0: Memory at feb05000 (32-bit, non-prefetchable) [size=4K]
     Kernel driver in use: ohci-pci
     Kernel modules: ohci_pci

00:16.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] 
SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
     Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 
USB EHCI Controller
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 32, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 23
     Region 0: Memory at feb04000 (32-bit, non-prefetchable) [size=256]
     Capabilities: [c0] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Bridge: PM- B3+
     Capabilities: [e4] Debug port: BAR=1 offset=00e0
     Kernel driver in use: ehci-pci
     Kernel modules: ehci_pci

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h 
Processor Function 0
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Capabilities: [80] HyperTransport: Host or Secondary Interface
         Command: WarmRst+ DblEnd- DevNum=0 ChainSide- HostHide+ Slave- 
<EOCErr- DUL-
         Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- 
<CRCErr=0 IsocEn- LSEn+ ExtCTL- 64b+
         Link Config: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut- LWI=16bit 
DwFcInEn- LWO=16bit DwFcOutEn-
         Revision ID: 3.00
         Link Frequency: [d]
         Link Error: <Prot- <Ovfl- <EOC- CTLTm-
         Link Frequency Capability: 200MHz+ 300MHz- 400MHz+ 500MHz- 
600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
         Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA+ UIDRD- 
ExtRS- UCnfE-

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h 
Processor Function 1
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h 
Processor Function 2
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h 
Processor Function 3
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Capabilities: [f0] Secure device <?>
     Kernel driver in use: k10temp
     Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h 
Processor Function 4
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Kernel driver in use: fam15h_power
     Kernel modules: fam15h_power

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h 
Processor Function 5
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-

01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] Turks PRO [Radeon HD 6570/7570/8550] (prog-if 00 [VGA controller])
     Subsystem: XFX Pine Group Inc. Turks PRO [Radeon HD 6570/7570/8550]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 39
     Region 0: Memory at c0000000 (64-bit, prefetchable) [size=256M]
     Region 2: Memory at fea20000 (64-bit, non-prefetchable) [size=128K]
     Region 4: I/O ports at e000 [size=256]
     Expansion ROM at 000c0000 [disabled] [size=128K]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, 
L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit 
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, 
OBFF Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee1000c  Data: 4183
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
     Capabilities: [150 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Kernel driver in use: radeon
     Kernel modules: radeon

01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] 
Turks/Whistler HDMI Audio [Radeon HD 6000 Series]
     Subsystem: XFX Pine Group Inc. Turks/Whistler HDMI Audio [Radeon HD 
6000 Series]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 41
     Region 0: Memory at fea40000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, 
L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exit 
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, 
OBFF Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee3e00c  Data: 41d3
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
     Capabilities: [150 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Kernel driver in use: snd_hda_intel
     Kernel modules: snd_hda_intel

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
     Subsystem: ASUSTeK Computer Inc. P8P67 and other motherboards
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 29
     Region 0: I/O ports at d000 [size=256]
     Region 2: Memory at d0004000 (64-bit, prefetchable) [size=4K]
     Region 4: Memory at d0000000 (64-bit, prefetchable) [size=16K]
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0200c  Data: 4162
     Capabilities: [70] Express (v2) Endpoint, MSI 01
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 4096 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s unlimited, L1 <64us
             ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, 
OBFF Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
         LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
         Vector table: BAR=4 offset=00000000
         PBA: BAR=4 offset=00000800
     Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Input/output error
         Not readable
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Capabilities: [140 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
     Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
     Kernel driver in use: r8169
     Kernel modules: r8169

03:00.0 USB controller: ASMedia Technology Inc. ASM1042 SuperSpeed USB 
Host Controller (prog-if 30 [XHCI])
     Subsystem: ASUSTeK Computer Inc. P8B WS Motherboard
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 30
     Region 0: Memory at fe900000 (64-bit, non-prefetchable) [size=32K]
     Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [68] MSI-X: Enable+ Count=8 Masked-
         Vector table: BAR=0 offset=00002000
         PBA: BAR=0 offset=00002080
     Capabilities: [78] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [80] Express (v2) Legacy Endpoint, MSI 00
         DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <2us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s unlimited, L1 unlimited
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, 
OBFF Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
     Kernel driver in use: xhci_hcd
     Kernel modules: xhci_pci

04:06.0 Ethernet controller: D-Link System Inc DGE-528T Gigabit Ethernet 
Adapter (rev 10)
     Subsystem: D-Link System Inc DGE-528T Gigabit Ethernet Adapter
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 64 (8000ns min, 16000ns max), Cache Line Size: 32 bytes
     Interrupt: pin A routed to IRQ 21
     Region 0: I/O ports at c000 [size=256]
     Region 1: Memory at fe820000 (32-bit, non-prefetchable) [size=256]
     Expansion ROM at fe800000 [disabled] [size=128K]
     Capabilities: [dc] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Kernel driver in use: r8169
     Kernel modules: r8169

05:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] Tonga PRO [Radeon R9 285/380] (rev f1) (prog-if 00 [VGA 
controller])
     Subsystem: Micro-Star International Co., Ltd. [MSI] Tonga PRO 
[Radeon R9 285/380]
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin A routed to IRQ 10
     Region 0: Memory at a0000000 (64-bit, prefetchable) [disabled] 
[size=256M]
     Region 2: Memory at b0000000 (64-bit, prefetchable) [disabled] 
[size=2M]
     Region 4: I/O ports at b000 [disabled] [size=256]
     Region 5: Memory at fe700000 (32-bit, non-prefetchable) [disabled] 
[size=256K]
     Expansion ROM at fe740000 [disabled] [size=128K]
     Capabilities: [48] Vendor Specific Information: Len=08 <?>
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
         Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, 
L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit 
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, 
OBFF Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Capabilities: [200 v1] #15
     Capabilities: [270 v1] #19
     Capabilities: [2b0 v1] Address Translation Service (ATS)
         ATSCap:    Invalidate Queue Depth: 00
         ATSCtl:    Enable+, Smallest Translation Unit: 00
     Capabilities: [2c0 v1] #13
     Capabilities: [2d0 v1] #1b
     Capabilities: [328 v1] Alternative Routing-ID Interpretation (ARI)
         ARICap:    MFVC- ACS-, Next Function: 1
         ARICtl:    MFVC- ACS-, Function Group: 0
     Kernel driver in use: vfio-pci
     Kernel modules: amdgpu

05:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Tonga HDMI 
Audio [Radeon R9 285/380]
     Subsystem: Micro-Star International Co., Ltd. [MSI] Tonga HDMI 
Audio [Radeon R9 285/380]
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin B routed to IRQ 7
     Region 0: Memory at fe760000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [48] Vendor Specific Information: Len=08 <?>
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, 
L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit 
Latency L0s <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 5GT/s, Width x4, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, 
OBFF Not Supported
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
         LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
              EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
     Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
     Capabilities: [150 v2] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
     Capabilities: [328 v1] Alternative Routing-ID Interpretation (ARI)
         ARICap:    MFVC- ACS-, Next Function: 0
         ARICtl:    MFVC- ACS-, Function Group: 0
     Kernel driver in use: vfio-pci
     Kernel modules: snd_hda_intel






--------------000502060306050302080400
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
    <span style=3D"color: rgb(51, 51, 51); font-family: monospace;
      font-size: 12px; font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: 18px;
      orphans: auto; text-align: left; text-indent: 0px; text-transform:
      none; white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; display: inline !important; float:
      none; background-color: rgb(255, 255, 255);">[description]<br>
      working in kernel 3.9</span><br style=3D"color: rgb(51, 51, 51);
      font-family: monospace; font-size: 12px; font-style: normal;
      font-variant: normal; font-weight: normal; letter-spacing: normal;
      line-height: 18px; orphans: auto; text-align: left; text-indent:
      0px; text-transform: none; white-space: normal; widows: 1;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255);">
    <span style=3D"color: rgb(51, 51, 51); font-family: monospace;
      font-size: 12px; font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: 18px;
      orphans: auto; text-align: left; text-indent: 0px; text-transform:
      none; white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; display: inline !important; float:
      none; background-color: rgb(255, 255, 255);">Oops in current
      4.4.0-28,4.7.0-040700rc5</span><br style=3D"color: rgb(51, 51, 51);
      font-family: monospace; font-size: 12px; font-style: normal;
      font-variant: normal; font-weight: normal; letter-spacing: normal;
      line-height: 18px; orphans: auto; text-align: left; text-indent:
      0px; text-transform: none; white-space: normal; widows: 1;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255);">
    <span style=3D"color: rgb(51, 51, 51); font-family: monospace;
      font-size: 12px; font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: 18px;
      orphans: auto; text-align: left; text-indent: 0px; text-transform:
      none; white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; display: inline !important; float:
      none; background-color: rgb(255, 255, 255);">kernel options
      ivrs_ioapic[7]=3D00:14.0=C2=A0 ivrs_ioapic[8]=3D00:00.1 workaround =
to fix
      ivrs table</span><br style=3D"color: rgb(51, 51, 51); font-family:
      monospace; font-size: 12px; font-style: normal; font-variant:
      normal; font-weight: normal; letter-spacing: normal; line-height:
      18px; orphans: auto; text-align: left; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 1;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255);">
    <span style=3D"color: rgb(51, 51, 51); font-family: monospace;
      font-size: 12px; font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: 18px;
      orphans: auto; text-align: left; text-indent: 0px; text-transform:
      none; white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; display: inline !important; float:
      none; background-color: rgb(255, 255, 255);">cause kernel Oops on
      boot<br>
      <br>
      [bug]<br>
      oops:<br>
      short </span><span style=3D"color: rgb(51, 51, 51); font-family:
      monospace; font-size: 12px; font-style: normal; font-variant:
      normal; font-weight: normal; letter-spacing: normal; line-height:
      18px; orphans: auto; text-align: left; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 1;
      word-spacing: 0px; -webkit-text-stroke-width: 0px; display: inline
      !important; float: none; background-color: rgb(255, 255, 255);">oop=
s

      text<br>
      AMD-Vi: Completion_wait loop timed Out<br>
    </span><span style=3D"color: rgb(51, 51, 51); font-family: monospace;
      font-size: 12px; font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: 18px;
      orphans: auto; text-align: left; text-indent: 0px; text-transform:
      none; white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; display: inline !important; float:
      none; background-color: rgb(255, 255, 255);">BUG: unable to handle
      kernel NULL pointer dereference at 000..03e</span><br
      style=3D"color: rgb(51, 51, 51); font-family: monospace; font-size:
      12px; font-style: normal; font-variant: normal; font-weight:
      normal; letter-spacing: normal; line-height: 18px; orphans: auto;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">
    <span style=3D"color: rgb(51, 51, 51); font-family: monospace;
      font-size: 12px; font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: 18px;
      orphans: auto; text-align: left; text-indent: 0px; text-transform:
      none; white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; display: inline !important; float:
      none; background-color: rgb(255, 255, 255);">... irq_pm_</span><spa=
n
      style=3D"color: rgb(51, 51, 51); font-family: monospace; font-size:
      12px; font-style: normal; font-variant: normal; font-weight:
      normal; letter-spacing: normal; line-height: 18px; orphans: auto;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; display: inline !important; float:
      none; background-color: rgb(255, 255, 255);">install_</span><span
      style=3D"color: rgb(51, 51, 51); font-family: monospace; font-size:
      12px; font-style: normal; font-variant: normal; font-weight:
      normal; letter-spacing: normal; line-height: 18px; orphans: auto;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; display: inline !important; float:
      none; background-color: rgb(255, 255, 255);">action+</span><span
      style=3D"color: rgb(51, 51, 51); font-family: monospace; font-size:
      12px; font-style: normal; font-variant: normal; font-weight:
      normal; letter-spacing: normal; line-height: 18px; orphans: auto;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; display: inline !important; float:
      none; background-color: rgb(255, 255, 255);">0x1c/0xd0</span><wbr
      style=3D"color: rgb(51, 51, 51); font-family: monospace; font-size:
      12px; font-style: normal; font-variant: normal; font-weight:
      normal; letter-spacing: normal; line-height: 18px; orphans: auto;
      text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);"><wbr style=3D"color: rgb(51, 51, 51); font-family: monospace=
;
      font-size: 12px; font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: 18px;
      orphans: auto; text-align: left; text-indent: 0px; text-transform:
      none; white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);"><wbr style=3D"color: rgb(51, 51, 51); font-family: monospace=
;
      font-size: 12px; font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: 18px;
      orphans: auto; text-align: left; text-indent: 0px; text-transform:
      none; white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);"><br>
    full oops image text<br>
    <a class=3D"moz-txt-link-freetext" href=3D"http://img.ctrlv.in/img/16=
/07/03/577863055370c.jpg">http://img.ctrlv.in/img/16/07/03/577863055370c.=
jpg</a><br>
    <br>
    [additional info]<br>
    dmesg|grep AMD-Vi without ivrs_ioapic[8]=3D00:00.1<br>
    [=C2=A0=C2=A0=C2=A0 0.108566] AMD-Vi: Using IVHD type 0x10<br>
    [=C2=A0=C2=A0=C2=A0 0.108630] AMD-Vi: device: 00:00.2 cap: 0040 seg: =
0 flags: 3e
    info 1300<br>
    [=C2=A0=C2=A0=C2=A0 0.108671] AMD-Vi:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mmio-addr: 00000000feb20000<br>
    [=C2=A0=C2=A0=C2=A0 0.108750] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT_RANGE_ST=
ART=C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:00.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.108792] AMD-Vi:=C2=A0=C2=A0 DEV_RANGE_END=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:00.2<br>
    [=C2=A0=C2=A0=C2=A0 0.108834] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:02.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.108875] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT_RANGE_ST=
ART=C2=A0=C2=A0=C2=A0 =C2=A0devid: 01:00.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.108917] AMD-Vi:=C2=A0=C2=A0 DEV_RANGE_END=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 01:00.1<br>
    [=C2=A0=C2=A0=C2=A0 0.108958] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:04.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.108999] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 02:00.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.109041] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:07.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.109082] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 03:00.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.109124] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:11.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.109166] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT_RANGE_ST=
ART=C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:12.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.109207] AMD-Vi:=C2=A0=C2=A0 DEV_RANGE_END=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:12.2<br>
    [=C2=A0=C2=A0=C2=A0 0.109249] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT_RANGE_ST=
ART=C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:13.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.114267] AMD-Vi:=C2=A0=C2=A0 DEV_RANGE_END=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:13.2<br>
    [=C2=A0=C2=A0=C2=A0 0.114308] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:14.0
    flags: d7<br>
    [=C2=A0=C2=A0=C2=A0 0.114348] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:14.2
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.114389] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:14.3
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.114429] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:14.4
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.114471] AMD-Vi:=C2=A0=C2=A0 DEV_ALIAS_RANGE=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 04:00.0
    flags: 00 devid_to: 00:14.4<br>
    [=C2=A0=C2=A0=C2=A0 0.114519] AMD-Vi:=C2=A0=C2=A0 DEV_RANGE_END=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 04:1f.7<br>
    [=C2=A0=C2=A0=C2=A0 0.114564] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:14.5
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.114605] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:15.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.114645] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT_RANGE_ST=
ART=C2=A0=C2=A0=C2=A0 =C2=A0devid: 05:00.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.114687] AMD-Vi:=C2=A0=C2=A0 DEV_RANGE_END=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 05:00.1<br>
    [=C2=A0=C2=A0=C2=A0 0.114728] AMD-Vi:=C2=A0=C2=A0 DEV_SELECT_RANGE_ST=
ART=C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:16.0
    flags: 00<br>
    [=C2=A0=C2=A0=C2=A0 0.114768] AMD-Vi:=C2=A0=C2=A0 DEV_RANGE_END=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0devid: 00:16.2<br>
    [=C2=A0=C2=A0=C2=A0 0.114840] AMD-Vi:=C2=A0=C2=A0 DEV_SPECIAL(IOAPIC[=
0])=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 devid:
    00:14.0<br>
    [=C2=A0=C2=A0=C2=A0 0.114885] AMD-Vi:=C2=A0=C2=A0 DEV_SPECIAL(HPET[0]=
)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 devid: 00:14.0<br>
    [=C2=A0=C2=A0=C2=A0 0.114927] AMD-Vi:=C2=A0=C2=A0 DEV_SPECIAL(IOAPIC[=
255])=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 devid:
    00:00.1<br>
    [=C2=A0=C2=A0=C2=A0 0.114969] AMD-Vi: IOAPIC[8] not in IVRS table<br>
    [=C2=A0=C2=A0=C2=A0 0.115010] AMD-Vi: Disabling interrupt remapping<b=
r>
    [=C2=A0=C2=A0=C2=A0 2.994584] AMD-Vi: Completion-Wait loop timed out<=
br>
    [=C2=A0=C2=A0=C2=A0 3.103059] AMD-Vi: Completion-Wait loop timed out<=
br>
    [=C2=A0=C2=A0=C2=A0 3.103145] AMD-Vi: Found IOMMU at 0000:00:00.2 cap=
 0x40<br>
    [=C2=A0=C2=A0=C2=A0 3.103279] AMD-Vi: Lazy IO/TLB flushing enabled<br=
>
    [=C2=A0=C2=A0=C2=A0 3.993134] AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
    device=3D05:00.0 address=3D0x000000044c6464a0]<br>
    [=C2=A0=C2=A0=C2=A0 3.993213] AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
    device=3D05:00.0 address=3D0x000000044c6464c0]<br>
    [=C2=A0=C2=A0=C2=A0 5.100622] AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
    device=3D05:00.0 address=3D0x000000044c646500]<br>
    <br>
    [software&amp;hw]<br>
    <span style=3D"color: rgb(51, 51, 51); font-family: monospace;
      font-size: 12px; font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: 18px;
      orphans: auto; text-align: left; text-indent: 0px; text-transform:
      none; white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; display: inline !important; float:
      none; background-color: rgb(255, 255, 255);">Kernel Version:<br>
      Linux version 4.7.0-040700rc5-generic (kernel@tangerine) (gcc
      version 5.4.0 20160609 (Ubuntu 5.4.0-4ubuntu1) ) <br>
    </span><span style=3D"color: rgb(51, 51, 51); font-family: monospace;
      font-size: 12px; font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: 18px;
      orphans: auto; text-align: left; text-indent: 0px; text-transform:
      none; white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; display: inline !important; float:
      none; background-color: rgb(255, 255, 255);">#201606262232 SMP Mon
      Jun 27 02:34:07 UTC 2016<br>
      Environment:<br>
    </span><span style=3D"color: rgb(51, 51, 51); font-family: monospace;
      font-size: 12px; font-style: normal; font-variant: normal;
      font-weight: normal; letter-spacing: normal; line-height: 18px;
      orphans: auto; text-align: left; text-indent: 0px; text-transform:
      none; white-space: normal; widows: 1; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; display: inline !important; float:
      none; background-color: rgb(255, 255, 255);">
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Du=
tf-8">
      Description:=C2=A0=C2=A0=C2=A0 Ubuntu 16.04 LTS<br>
      Release:=C2=A0=C2=A0=C2=A0 16.04<br>
      Software :<br>
      Linux main 4.7.0-040700rc5-generic #201606262232 SMP Mon Jun 27
      02:34:07 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux<br>
      =C2=A0<br>
      GNU C=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 5.3.1=
<br>
      GNU Make=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 4.1<br>
      Binutils=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 2.26<br>
      Util-linux=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 2.27.1<br>
      Mount=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 2.27.=
1<br>
      Module-init-tools=C2=A0=C2=A0=C2=A0 22<br>
      E2fsprogs=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 1.42.13<br>
      Pcmciautils=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 018<br>
      PPP=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 2.4.7<b=
r>
      Linux C Library=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 2.23<br>
      Dynamic linker (ldd)=C2=A0=C2=A0=C2=A0 2.23<br>
      Linux C++ Library=C2=A0=C2=A0=C2=A0 6.0.21<br>
      Procps=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 3.3.=
10<br>
      Net-tools=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 1.60<br>
      Kbd=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 1.15.5<=
br>
      Console-tools=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 1.15.5<br>
      Sh-utils=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 8.25<br>
      Udev=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 229<br=
>
      Wireless-tools=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 30<br>
      Modules Loaded=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ablk_helper acp=
i_cpufreq aesni_intel
      aes_x86_64 ahci ansi_cprng asus_wmi autofs4 binfmt_misc bridge
      button crc16 crc32c_intel crc32_pclmul crct10dif_pclmul cryptd
      dm_mod drbg drm drm_kms_helper ebtable_filter ebtables eeepc_wmi
      ehci_hcd ehci_pci evdev ext4 fam15h_power fjes fuse gf128mul
      ghash_clmulni_intel glue_helper hid hid_generic hmac i2c_algo_bit
      i2c_piix4 ip6table_filter ip6_tables iptable_filter iptable_mangle
      iptable_nat ip_tables ipt_MASQUERADE ipt_REJECT irqbypass jbd2
      joydev k10temp kvm kvm_amd libahci libata llc lp lrw mbcache media
      mii nf_conntrack nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat
      nf_nat_ipv4 nf_nat_masquerade_ipv4 nf_reject_ipv4 ohci_hcd
      ohci_pci parport parport_pc ppdev psmouse r8169 radeon rfkill
      scsi_mod sd_mod serio_raw sg shpchp snd snd_hda_codec
      snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_codec_realtek
      snd_hda_core snd_hda_intel snd_hwdep snd_pcm snd_rawmidi snd_seq
      snd_seq_device snd_seq_midi snd_seq_midi_event snd_timer
      snd_usb_audio snd_usbmidi_lib soundcore sparse_keymap stp tpm
      tpm_tis ttm tun usb_common usbcore usbhid uvcvideo vfio
      vfio_iommu_type1 vfio_pci vfio_virqfd video videobuf2_core
      videobuf2_memops videobuf2_v4l2 videobuf2_vmalloc videodev wmi
      xhci_hcd xhci_pci x_tables xt_CHECKSUM xt_conntrack xt_multiport
      xt_tcpudp<br>
      Processor information:<br>
      processor=C2=A0=C2=A0=C2=A0 : 0<br>
      vendor_id=C2=A0=C2=A0=C2=A0 : AuthenticAMD<br>
      cpu family=C2=A0=C2=A0=C2=A0 : 21<br>
      model=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1<br>
      model name=C2=A0=C2=A0=C2=A0 : AMD FX(tm)-6100 Six-Core Processor<b=
r>
      stepping=C2=A0=C2=A0=C2=A0 : 2<br>
      microcode=C2=A0=C2=A0=C2=A0 : 0x6000629<br>
      cpu MHz=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1400.000<br>
      cache size=C2=A0=C2=A0=C2=A0 : 2048 KB<br>
      physical id=C2=A0=C2=A0=C2=A0 : 0<br>
      siblings=C2=A0=C2=A0=C2=A0 : 6<br>
      core id=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 0<br>
      cpu cores=C2=A0=C2=A0=C2=A0 : 3<br>
      apicid=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 16<br>
      initial apicid=C2=A0=C2=A0=C2=A0 : 0<br>
      fpu=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : yes<br>
      fpu_exception=C2=A0=C2=A0=C2=A0 : yes<br>
      cpuid level=C2=A0=C2=A0=C2=A0 : 13<br>
      wp=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : yes<br>
      flags=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : fpu vme de pse tsc msr=
 pae mce cx8 apic sep mtrr
      pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx
      mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl
      nonstop_tsc extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor
      ssse3 cx16 sse4_1 sse4_2 popcnt aes xsave avx lahf_lm cmp_legacy
      svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw
      ibs xop skinit wdt lwp fma4 nodeid_msr topoext perfctr_core
      perfctr_nb cpb hw_pstate vmmcall arat npt lbrv svm_lock nrip_save
      tsc_scale vmcb_clean flushbyasid decodeassists pausefilter
      pfthreshold<br>
      bugs=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : fxsave_leak sysret_ss_a=
ttrs null_seg<br>
      bogomips=C2=A0=C2=A0=C2=A0 : 6621.82<br>
      TLB size=C2=A0=C2=A0=C2=A0 : 1536 4K pages<br>
      clflush size=C2=A0=C2=A0=C2=A0 : 64<br>
      cache_alignment=C2=A0=C2=A0=C2=A0 : 64<br>
      address sizes=C2=A0=C2=A0=C2=A0 : 48 bits physical, 48 bits virtual=
<br>
      power management: ts ttp tm 100mhzsteps hwpstate cpb<br>
      <br>
      processor=C2=A0=C2=A0=C2=A0 : 1<br>
      vendor_id=C2=A0=C2=A0=C2=A0 : AuthenticAMD<br>
      cpu family=C2=A0=C2=A0=C2=A0 : 21<br>
      model=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1<br>
      model name=C2=A0=C2=A0=C2=A0 : AMD FX(tm)-6100 Six-Core Processor<b=
r>
      stepping=C2=A0=C2=A0=C2=A0 : 2<br>
      microcode=C2=A0=C2=A0=C2=A0 : 0x6000629<br>
      cpu MHz=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1400.000<br>
      cache size=C2=A0=C2=A0=C2=A0 : 2048 KB<br>
      physical id=C2=A0=C2=A0=C2=A0 : 0<br>
      siblings=C2=A0=C2=A0=C2=A0 : 6<br>
      core id=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 0<br>
      cpu cores=C2=A0=C2=A0=C2=A0 : 3<br>
      apicid=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 17<br>
      initial apicid=C2=A0=C2=A0=C2=A0 : 1<br>
      fpu=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : yes<br>
      fpu_exception=C2=A0=C2=A0=C2=A0 : yes<br>
      cpuid level=C2=A0=C2=A0=C2=A0 : 13<br>
      wp=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : yes<br>
      flags=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : fpu vme de pse tsc msr=
 pae mce cx8 apic sep mtrr
      pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx
      mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl
      nonstop_tsc extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor
      ssse3 cx16 sse4_1 sse4_2 popcnt aes xsave avx lahf_lm cmp_legacy
      svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw
      ibs xop skinit wdt lwp fma4 nodeid_msr topoext perfctr_core
      perfctr_nb cpb hw_pstate vmmcall arat npt lbrv svm_lock nrip_save
      tsc_scale vmcb_clean flushbyasid decodeassists pausefilter
      pfthreshold<br>
      bugs=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : fxsave_leak sysret_ss_a=
ttrs null_seg<br>
      bogomips=C2=A0=C2=A0=C2=A0 : 6621.69<br>
      TLB size=C2=A0=C2=A0=C2=A0 : 1536 4K pages<br>
      clflush size=C2=A0=C2=A0=C2=A0 : 64<br>
      cache_alignment=C2=A0=C2=A0=C2=A0 : 64<br>
      address sizes=C2=A0=C2=A0=C2=A0 : 48 bits physical, 48 bits virtual=
<br>
      power management: ts ttp tm 100mhzsteps hwpstate cpb<br>
      <br>
      processor=C2=A0=C2=A0=C2=A0 : 2<br>
      vendor_id=C2=A0=C2=A0=C2=A0 : AuthenticAMD<br>
      cpu family=C2=A0=C2=A0=C2=A0 : 21<br>
      model=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1<br>
      model name=C2=A0=C2=A0=C2=A0 : AMD FX(tm)-6100 Six-Core Processor<b=
r>
      stepping=C2=A0=C2=A0=C2=A0 : 2<br>
      microcode=C2=A0=C2=A0=C2=A0 : 0x6000629<br>
      cpu MHz=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1400.000<br>
      cache size=C2=A0=C2=A0=C2=A0 : 2048 KB<br>
      physical id=C2=A0=C2=A0=C2=A0 : 0<br>
      siblings=C2=A0=C2=A0=C2=A0 : 6<br>
      core id=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1<br>
      cpu cores=C2=A0=C2=A0=C2=A0 : 3<br>
      apicid=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 18<br>
      initial apicid=C2=A0=C2=A0=C2=A0 : 2<br>
      fpu=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : yes<br>
      fpu_exception=C2=A0=C2=A0=C2=A0 : yes<br>
      cpuid level=C2=A0=C2=A0=C2=A0 : 13<br>
      wp=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : yes<br>
      flags=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : fpu vme de pse tsc msr=
 pae mce cx8 apic sep mtrr
      pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx
      mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl
      nonstop_tsc extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor
      ssse3 cx16 sse4_1 sse4_2 popcnt aes xsave avx lahf_lm cmp_legacy
      svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw
      ibs xop skinit wdt lwp fma4 nodeid_msr topoext perfctr_core
      perfctr_nb cpb hw_pstate vmmcall arat npt lbrv svm_lock nrip_save
      tsc_scale vmcb_clean flushbyasid decodeassists pausefilter
      pfthreshold<br>
      bugs=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : fxsave_leak sysret_ss_a=
ttrs null_seg<br>
      bogomips=C2=A0=C2=A0=C2=A0 : 6621.72<br>
      TLB size=C2=A0=C2=A0=C2=A0 : 1536 4K pages<br>
      clflush size=C2=A0=C2=A0=C2=A0 : 64<br>
      cache_alignment=C2=A0=C2=A0=C2=A0 : 64<br>
      address sizes=C2=A0=C2=A0=C2=A0 : 48 bits physical, 48 bits virtual=
<br>
      power management: ts ttp tm 100mhzsteps hwpstate cpb<br>
      <br>
      processor=C2=A0=C2=A0=C2=A0 : 3<br>
      vendor_id=C2=A0=C2=A0=C2=A0 : AuthenticAMD<br>
      cpu family=C2=A0=C2=A0=C2=A0 : 21<br>
      model=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1<br>
      model name=C2=A0=C2=A0=C2=A0 : AMD FX(tm)-6100 Six-Core Processor<b=
r>
      stepping=C2=A0=C2=A0=C2=A0 : 2<br>
      microcode=C2=A0=C2=A0=C2=A0 : 0x6000629<br>
      cpu MHz=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1400.000<br>
      cache size=C2=A0=C2=A0=C2=A0 : 2048 KB<br>
      physical id=C2=A0=C2=A0=C2=A0 : 0<br>
      siblings=C2=A0=C2=A0=C2=A0 : 6<br>
      core id=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1<br>
      cpu cores=C2=A0=C2=A0=C2=A0 : 3<br>
      apicid=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 19<br>
      initial apicid=C2=A0=C2=A0=C2=A0 : 3<br>
      fpu=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : yes<br>
      fpu_exception=C2=A0=C2=A0=C2=A0 : yes<br>
      cpuid level=C2=A0=C2=A0=C2=A0 : 13<br>
      wp=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : yes<br>
      flags=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : fpu vme de pse tsc msr=
 pae mce cx8 apic sep mtrr
      pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx
      mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl
      nonstop_tsc extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor
      ssse3 cx16 sse4_1 sse4_2 popcnt aes xsave avx lahf_lm cmp_legacy
      svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw
      ibs xop skinit wdt lwp fma4 nodeid_msr topoext perfctr_core
      perfctr_nb cpb hw_pstate vmmcall arat npt lbrv svm_lock nrip_save
      tsc_scale vmcb_clean flushbyasid decodeassists pausefilter
      pfthreshold<br>
      bugs=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : fxsave_leak sysret_ss_a=
ttrs null_seg<br>
      bogomips=C2=A0=C2=A0=C2=A0 : 6621.71<br>
      TLB size=C2=A0=C2=A0=C2=A0 : 1536 4K pages<br>
      clflush size=C2=A0=C2=A0=C2=A0 : 64<br>
      cache_alignment=C2=A0=C2=A0=C2=A0 : 64<br>
      address sizes=C2=A0=C2=A0=C2=A0 : 48 bits physical, 48 bits virtual=
<br>
      power management: ts ttp tm 100mhzsteps hwpstate cpb<br>
      <br>
      processor=C2=A0=C2=A0=C2=A0 : 4<br>
      vendor_id=C2=A0=C2=A0=C2=A0 : AuthenticAMD<br>
      cpu family=C2=A0=C2=A0=C2=A0 : 21<br>
      model=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1<br>
      model name=C2=A0=C2=A0=C2=A0 : AMD FX(tm)-6100 Six-Core Processor<b=
r>
      stepping=C2=A0=C2=A0=C2=A0 : 2<br>
      microcode=C2=A0=C2=A0=C2=A0 : 0x6000629<br>
      cpu MHz=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1800.000<br>
      cache size=C2=A0=C2=A0=C2=A0 : 2048 KB<br>
      physical id=C2=A0=C2=A0=C2=A0 : 0<br>
      siblings=C2=A0=C2=A0=C2=A0 : 6<br>
      core id=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 2<br>
      cpu cores=C2=A0=C2=A0=C2=A0 : 3<br>
      apicid=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 20<br>
      initial apicid=C2=A0=C2=A0=C2=A0 : 4<br>
      fpu=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : yes<br>
      fpu_exception=C2=A0=C2=A0=C2=A0 : yes<br>
      cpuid level=C2=A0=C2=A0=C2=A0 : 13<br>
      wp=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : yes<br>
      flags=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : fpu vme de pse tsc msr=
 pae mce cx8 apic sep mtrr
      pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx
      mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl
      nonstop_tsc extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor
      ssse3 cx16 sse4_1 sse4_2 popcnt aes xsave avx lahf_lm cmp_legacy
      svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw
      ibs xop skinit wdt lwp fma4 nodeid_msr topoext perfctr_core
      perfctr_nb cpb hw_pstate vmmcall arat npt lbrv svm_lock nrip_save
      tsc_scale vmcb_clean flushbyasid decodeassists pausefilter
      pfthreshold<br>
      bugs=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : fxsave_leak sysret_ss_a=
ttrs null_seg<br>
      bogomips=C2=A0=C2=A0=C2=A0 : 6621.76<br>
      TLB size=C2=A0=C2=A0=C2=A0 : 1536 4K pages<br>
      clflush size=C2=A0=C2=A0=C2=A0 : 64<br>
      cache_alignment=C2=A0=C2=A0=C2=A0 : 64<br>
      address sizes=C2=A0=C2=A0=C2=A0 : 48 bits physical, 48 bits virtual=
<br>
      power management: ts ttp tm 100mhzsteps hwpstate cpb<br>
      <br>
      processor=C2=A0=C2=A0=C2=A0 : 5<br>
      vendor_id=C2=A0=C2=A0=C2=A0 : AuthenticAMD<br>
      cpu family=C2=A0=C2=A0=C2=A0 : 21<br>
      model=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1<br>
      model name=C2=A0=C2=A0=C2=A0 : AMD FX(tm)-6100 Six-Core Processor<b=
r>
      stepping=C2=A0=C2=A0=C2=A0 : 2<br>
      microcode=C2=A0=C2=A0=C2=A0 : 0x6000629<br>
      cpu MHz=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 1400.000<br>
      cache size=C2=A0=C2=A0=C2=A0 : 2048 KB<br>
      physical id=C2=A0=C2=A0=C2=A0 : 0<br>
      siblings=C2=A0=C2=A0=C2=A0 : 6<br>
      core id=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 2<br>
      cpu cores=C2=A0=C2=A0=C2=A0 : 3<br>
      apicid=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : 21<br>
      initial apicid=C2=A0=C2=A0=C2=A0 : 5<br>
      fpu=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : yes<br>
      fpu_exception=C2=A0=C2=A0=C2=A0 : yes<br>
      cpuid level=C2=A0=C2=A0=C2=A0 : 13<br>
      wp=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : yes<br>
      flags=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : fpu vme de pse tsc msr=
 pae mce cx8 apic sep mtrr
      pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx
      mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl
      nonstop_tsc extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor
      ssse3 cx16 sse4_1 sse4_2 popcnt aes xsave avx lahf_lm cmp_legacy
      svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw
      ibs xop skinit wdt lwp fma4 nodeid_msr topoext perfctr_core
      perfctr_nb cpb hw_pstate vmmcall arat npt lbrv svm_lock nrip_save
      tsc_scale vmcb_clean flushbyasid decodeassists pausefilter
      pfthreshold<br>
      bugs=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 : fxsave_leak sysret_ss_a=
ttrs null_seg<br>
      bogomips=C2=A0=C2=A0=C2=A0 : 6621.78<br>
      TLB size=C2=A0=C2=A0=C2=A0 : 1536 4K pages<br>
      clflush size=C2=A0=C2=A0=C2=A0 : 64<br>
      cache_alignment=C2=A0=C2=A0=C2=A0 : 64<br>
      address sizes=C2=A0=C2=A0=C2=A0 : 48 bits physical, 48 bits virtual=
<br>
      power management: ts ttp tm 100mhzsteps hwpstate cpb<br>
      Module information:<br>
      xt_CHECKSUM 16384 1 - Live 0x0000000000000000<br>
      iptable_mangle 16384 1 - Live 0x0000000000000000<br>
      xt_conntrack 16384 1 - Live 0x0000000000000000<br>
      ipt_REJECT 16384 2 - Live 0x0000000000000000<br>
      nf_reject_ipv4 16384 1 ipt_REJECT, Live 0x0000000000000000<br>
      xt_tcpudp 16384 6 - Live 0x0000000000000000<br>
      tun 28672 1 - Live 0x0000000000000000<br>
      bridge 126976 0 - Live 0x0000000000000000<br>
      stp 16384 1 bridge, Live 0x0000000000000000<br>
      llc 16384 2 bridge,stp, Live 0x0000000000000000<br>
      ebtable_filter 16384 0 - Live 0x0000000000000000<br>
      ebtables 36864 1 ebtable_filter, Live 0x0000000000000000<br>
      ip6table_filter 16384 0 - Live 0x0000000000000000<br>
      ip6_tables 24576 1 ip6table_filter, Live 0x0000000000000000<br>
      fuse 98304 2 - Live 0x0000000000000000<br>
      ipt_MASQUERADE 16384 6 - Live 0x0000000000000000<br>
      nf_nat_masquerade_ipv4 16384 1 ipt_MASQUERADE, Live
      0x0000000000000000<br>
      iptable_nat 16384 1 - Live 0x0000000000000000<br>
      nf_conntrack_ipv4 20480 2 - Live 0x0000000000000000<br>
      nf_defrag_ipv4 16384 1 nf_conntrack_ipv4, Live 0x0000000000000000<b=
r>
      nf_nat_ipv4 16384 1 iptable_nat, Live 0x0000000000000000<br>
      nf_nat 24576 2 nf_nat_masquerade_ipv4,nf_nat_ipv4, Live
      0x0000000000000000<br>
      nf_conntrack 114688 5
      xt_conntrack,nf_nat_masquerade_ipv4,nf_conntrack_ipv4,nf_nat_ipv4,n=
f_nat,

      Live 0x0000000000000000<br>
      xt_multiport 16384 5 - Live 0x0000000000000000<br>
      iptable_filter 16384 1 - Live 0x0000000000000000<br>
      ip_tables 24576 3 iptable_mangle,iptable_nat,iptable_filter, Live
      0x0000000000000000<br>
      x_tables 36864 12
      xt_CHECKSUM,iptable_mangle,xt_conntrack,ipt_REJECT,xt_tcpudp,ebtabl=
es,ip6table_filter,ip6_tables,ipt_MASQUERADE,xt_multiport,iptable_filter,=
ip_tables,

      Live 0x0000000000000000<br>
      binfmt_misc 20480 1 - Live 0x0000000000000000<br>
      crct10dif_pclmul 16384 0 - Live 0x0000000000000000<br>
      uvcvideo 90112 0 - Live 0x0000000000000000<br>
      snd_hda_codec_realtek 86016 1 - Live 0x0000000000000000<br>
      videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000<br>
      crc32_pclmul 16384 0 - Live 0x0000000000000000<br>
      snd_hda_codec_generic 69632 1 snd_hda_codec_realtek, Live
      0x0000000000000000<br>
      videobuf2_memops 16384 1 videobuf2_vmalloc, Live
      0x0000000000000000<br>
      ghash_clmulni_intel 16384 0 - Live 0x0000000000000000<br>
      hmac 16384 1 - Live 0x0000000000000000<br>
      drbg 24576 1 - Live 0x0000000000000000<br>
      ansi_cprng 16384 0 - Live 0x0000000000000000<br>
      snd_hda_codec_hdmi 45056 1 - Live 0x0000000000000000<br>
      videobuf2_v4l2 24576 1 uvcvideo, Live 0x0000000000000000<br>
      videobuf2_core 36864 2 uvcvideo,videobuf2_v4l2, Live
      0x0000000000000000<br>
      videodev 167936 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live
      0x0000000000000000<br>
      aesni_intel 167936 0 - Live 0x0000000000000000<br>
      snd_hda_intel 36864 7 - Live 0x0000000000000000<br>
      snd_hda_codec 131072 4
      snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_=
hda_intel,

      Live 0x0000000000000000<br>
      snd_usb_audio 176128 3 - Live 0x0000000000000000<br>
      snd_hda_core 81920 5
      snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_=
hda_intel,snd_hda_codec,

      Live 0x0000000000000000<br>
      snd_usbmidi_lib 28672 1 snd_usb_audio, Live 0x0000000000000000<br>
      joydev 20480 0 - Live 0x0000000000000000<br>
      snd_hwdep 16384 2 snd_hda_codec,snd_usb_audio, Live
      0x0000000000000000<br>
      snd_seq_midi 16384 0 - Live 0x0000000000000000<br>
      media 32768 2 uvcvideo,videodev, Live 0x0000000000000000<br>
      snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000<br=
>
      aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000<br>
      snd_pcm 106496 6
      snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_usb_audio,snd_hd=
a_core,

      Live 0x0000000000000000<br>
      snd_rawmidi 32768 2 snd_usbmidi_lib,snd_seq_midi, Live
      0x0000000000000000<br>
      lrw 16384 1 aesni_intel, Live 0x0000000000000000<br>
      snd_seq 65536 2 snd_seq_midi,snd_seq_midi_event, Live
      0x0000000000000000<br>
      eeepc_wmi 16384 0 - Live 0x0000000000000000<br>
      asus_wmi 28672 1 eeepc_wmi, Live 0x0000000000000000<br>
      sparse_keymap 16384 1 asus_wmi, Live 0x0000000000000000<br>
      gf128mul 16384 1 lrw, Live 0x0000000000000000<br>
      snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
      0x0000000000000000<br>
      glue_helper 16384 1 aesni_intel, Live 0x0000000000000000<br>
      kvm_amd 73728 0 - Live 0x0000000000000000<br>
      rfkill 24576 3 asus_wmi, Live 0x0000000000000000<br>
      snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000<br>
      ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000<br>
      video 40960 1 asus_wmi, Live 0x0000000000000000<br>
      snd 81920 32
      snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_=
hda_intel,snd_hda_codec,snd_usb_audio,snd_usbmidi_lib,snd_hwdep,snd_pcm,s=
nd_rawmidi,snd_seq,snd_seq_device,snd_timer,

      Live 0x0000000000000000<br>
      cryptd 20480 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
      0x0000000000000000<br>
      kvm 565248 1 kvm_amd, Live 0x0000000000000000<br>
      fam15h_power 16384 0 - Live 0x0000000000000000<br>
      k10temp 16384 0 - Live 0x0000000000000000<br>
      soundcore 16384 1 snd, Live 0x0000000000000000<br>
      serio_raw 16384 0 - Live 0x0000000000000000<br>
      i2c_piix4 24576 0 - Live 0x0000000000000000<br>
      evdev 24576 30 - Live 0x0000000000000000<br>
      acpi_cpufreq 20480 0 - Live 0x0000000000000000<br>
      sg 32768 0 - Live 0x0000000000000000<br>
      shpchp 36864 0 - Live 0x0000000000000000<br>
      tpm_tis 20480 0 - Live 0x0000000000000000<br>
      tpm 45056 1 tpm_tis, Live 0x0000000000000000<br>
      parport_pc 28672 0 - Live 0x0000000000000000<br>
      ppdev 20480 0 - Live 0x0000000000000000<br>
      lp 20480 0 - Live 0x0000000000000000<br>
      parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000<br>
      autofs4 40960 2 - Live 0x0000000000000000<br>
      ext4 589824 2 - Live 0x0000000000000000<br>
      crc16 16384 1 ext4, Live 0x0000000000000000<br>
      jbd2 106496 1 ext4, Live 0x0000000000000000<br>
      mbcache 16384 3 ext4, Live 0x0000000000000000<br>
      dm_mod 106496 7 - Live 0x0000000000000000<br>
      vfio_pci 40960 0 - Live 0x0000000000000000<br>
      irqbypass 16384 2 kvm,vfio_pci, Live 0x0000000000000000<br>
      vfio_virqfd 16384 1 vfio_pci, Live 0x0000000000000000<br>
      vfio_iommu_type1 20480 0 - Live 0x0000000000000000<br>
      vfio 28672 2 vfio_pci,vfio_iommu_type1, Live 0x0000000000000000<br>
      hid_generic 16384 0 - Live 0x0000000000000000<br>
      usbhid 49152 0 - Live 0x0000000000000000<br>
      hid 114688 2 hid_generic,usbhid, Live 0x0000000000000000<br>
      sd_mod 45056 6 - Live 0x0000000000000000<br>
      ohci_pci 16384 0 - Live 0x0000000000000000<br>
      radeon 1495040 3 - Live 0x0000000000000000<br>
      xhci_pci 16384 0 - Live 0x0000000000000000<br>
      crc32c_intel 24576 0 - Live 0x0000000000000000<br>
      xhci_hcd 172032 1 xhci_pci, Live 0x0000000000000000<br>
      psmouse 126976 0 - Live 0x0000000000000000<br>
      ohci_hcd 49152 1 ohci_pci, Live 0x0000000000000000<br>
      ehci_pci 16384 0 - Live 0x0000000000000000<br>
      ahci 36864 7 - Live 0x0000000000000000<br>
      i2c_algo_bit 16384 1 radeon, Live 0x0000000000000000<br>
      ehci_hcd 77824 1 ehci_pci, Live 0x0000000000000000<br>
      libahci 32768 1 ahci, Live 0x0000000000000000<br>
      ttm 94208 1 radeon, Live 0x0000000000000000<br>
      libata 241664 2 ahci,libahci, Live 0x0000000000000000<br>
      drm_kms_helper 143360 1 radeon, Live 0x0000000000000000<br>
      usbcore 237568 11
      uvcvideo,snd_usb_audio,snd_usbmidi_lib,usbhid,ohci_pci,xhci_pci,xhc=
i_hcd,ohci_hcd,ehci_pci,ehci_hcd,

      Live 0x0000000000000000<br>
      drm 352256 6 radeon,ttm,drm_kms_helper, Live 0x0000000000000000<br>
      scsi_mod 225280 3 sg,sd_mod,libata, Live 0x0000000000000000<br>
      r8169 81920 0 - Live 0x0000000000000000<br>
      usb_common 16384 1 usbcore, Live 0x0000000000000000<br>
      mii 16384 1 r8169, Live 0x0000000000000000<br>
      wmi 16384 1 asus_wmi, Live 0x0000000000000000<br>
      fjes 28672 0 - Live 0x0000000000000000<br>
      button 16384 0 - Live 0x0000000000000000<br>
      Loaded driver and hardware information :<br>
      ioports<br>
      0000-0000 : PCI Bus 0000:00<br>
      =C2=A0 0000-0000 : dma1<br>
      =C2=A0 0000-0000 : pic1<br>
      =C2=A0 0000-0000 : timer0<br>
      =C2=A0 0000-0000 : timer1<br>
      =C2=A0 0000-0000 : keyboard<br>
      =C2=A0 0000-0000 : PNP0800:00<br>
      =C2=A0 0000-0000 : PNP0C09:00<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : EC data<br>
      =C2=A0 0000-0000 : keyboard<br>
      =C2=A0 0000-0000 : PNP0C09:00<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : EC cmd<br>
      =C2=A0 0000-0000 : rtc0<br>
      =C2=A0 0000-0000 : dma page reg<br>
      =C2=A0 0000-0000 : pic2<br>
      =C2=A0 0000-0000 : dma2<br>
      =C2=A0 0000-0000 : PNP0C04:00<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : fpu<br>
      =C2=A0 0000-0000 : pnp 00:02<br>
      0000-0000 : PCI Bus 0000:00<br>
      =C2=A0 0000-0000 : vga+<br>
      0000-0000 : PCI Bus 0000:00<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : pnp 00:04<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : ACPI PM1a_EVT_BLK<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : ACPI PM1a_CNT_BLK<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : ACPI PM_TMR<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : ACPI CPU throttle<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : ACPI GPE0_BLK<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : piix4_smbus<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : piix4_smbus<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : smba_idx<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      0000-0000 : PCI conf1<br>
      0000-0000 : PCI Bus 0000:00<br>
      =C2=A0 0000-0000 : PCI Bus 0000:05<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : 0000:05:00.0<br>
      =C2=A0 0000-0000 : PCI Bus 0000:04<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : 0000:04:06.0<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000-0000 : r8169<br>
      =C2=A0 0000-0000 : PCI Bus 0000:02<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : 0000:02:00.0<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000-0000 : r8169<br>
      =C2=A0 0000-0000 : PCI Bus 0000:01<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : 0000:01:00.0<br>
      =C2=A0 0000-0000 : 0000:00:11.0<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : ahci<br>
      =C2=A0 0000-0000 : 0000:00:11.0<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : ahci<br>
      =C2=A0 0000-0000 : 0000:00:11.0<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : ahci<br>
      =C2=A0 0000-0000 : 0000:00:11.0<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : ahci<br>
      =C2=A0 0000-0000 : 0000:00:11.0<br>
      =C2=A0=C2=A0=C2=A0 0000-0000 : ahci<br>
      =C2=A0 0000-0000 : pnp 00:01<br>
      iomem<br>
      00000000-00000000 : reserved<br>
      00000000-00000000 : System RAM<br>
      00000000-00000000 : reserved<br>
      00000000-00000000 : PCI Bus 0000:00<br>
      00000000-00000000 : PCI Bus 0000:00<br>
      =C2=A0 00000000-00000000 : Video ROM<br>
      00000000-00000000 : reserved<br>
      =C2=A0 00000000-00000000 : System ROM<br>
      00000000-00000000 : System RAM<br>
      =C2=A0 00000000-00000000 : Kernel code<br>
      =C2=A0 00000000-00000000 : Kernel data<br>
      =C2=A0 00000000-00000000 : Kernel bss<br>
      00000000-00000000 : ACPI Non-volatile Storage<br>
      00000000-00000000 : ACPI Tables<br>
      00000000-00000000 : ACPI Non-volatile Storage<br>
      00000000-00000000 : reserved<br>
      00000000-00000000 : ACPI Non-volatile Storage<br>
      00000000-00000000 : reserved<br>
      00000000-00000000 : ACPI Non-volatile Storage<br>
      00000000-00000000 : reserved<br>
      00000000-00000000 : ACPI Non-volatile Storage<br>
      00000000-00000000 : reserved<br>
      00000000-00000000 : ACPI Non-volatile Storage<br>
      00000000-00000000 : System RAM<br>
      00000000-00000000 : RAM buffer<br>
      00000000-00000000 : PCI Bus 0000:00<br>
      =C2=A0 00000000-00000000 : PCI Bus 0000:05<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:05:00.0<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:05:00.0<br>
      =C2=A0 00000000-00000000 : PCI Bus 0000:01<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:01:00.0<br>
      =C2=A0 00000000-00000000 : PCI Bus 0000:02<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:02:00.0<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : r8169<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:02:00.0<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : r8169<br>
      =C2=A0 00000000-00000000 : PCI MMCONFIG 0000 [bus 00-ff]<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : pnp 00:00<br>
      =C2=A0 00000000-00000000 : reserved<br>
      =C2=A0 00000000-00000000 : PCI Bus 0000:05<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:05:00.0<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:05:00.0<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:05:00.1<br>
      =C2=A0 00000000-00000000 : PCI Bus 0000:04<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:04:06.0<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:04:06.0<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : r8169<br>
      =C2=A0 00000000-00000000 : PCI Bus 0000:03<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:03:00.0<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : xhci-hcd<br>
      =C2=A0 00000000-00000000 : PCI Bus 0000:01<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:01:00.0<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : 0000:01:00.1<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : ICH HD audio<br>
      =C2=A0 00000000-00000000 : 0000:00:14.2<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : ICH HD audio<br>
      =C2=A0 00000000-00000000 : 0000:00:16.2<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : ehci_hcd<br>
      =C2=A0 00000000-00000000 : 0000:00:16.0<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : ohci_hcd<br>
      =C2=A0 00000000-00000000 : 0000:00:14.5<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : ohci_hcd<br>
      =C2=A0 00000000-00000000 : 0000:00:13.2<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : ehci_hcd<br>
      =C2=A0 00000000-00000000 : 0000:00:13.0<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : ohci_hcd<br>
      =C2=A0 00000000-00000000 : 0000:00:12.2<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : ehci_hcd<br>
      =C2=A0 00000000-00000000 : 0000:00:12.0<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : ohci_hcd<br>
      =C2=A0 00000000-00000000 : 0000:00:11.0<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : ahci<br>
      =C2=A0 00000000-00000000 : amd_iommu<br>
      =C2=A0 00000000-00000000 : reserved<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : IOAPIC 0<br>
      =C2=A0 00000000-00000000 : reserved<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : pnp 00:01<br>
      =C2=A0 00000000-00000000 : reserved<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : IOAPIC 1<br>
      =C2=A0 00000000-00000000 : reserved<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : HPET 0<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000-00000000 : PNP0103:00<br>
      =C2=A0 00000000-00000000 : reserved<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : pnp 00:01<br>
      =C2=A0 00000000-00000000 : reserved<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : pnp 00:01<br>
      =C2=A0 00000000-00000000 : Local APIC<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : pnp 00:01<br>
      =C2=A0 00000000-00000000 : reserved<br>
      =C2=A0=C2=A0=C2=A0 00000000-00000000 : pnp 00:01<br>
      00000000-00000000 : System RAM<br>
      00000000-00000000 : RAM buffer<br>
      PCI information:<br>
      00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890
      PCI to PCI bridge (external gfx0 port B) (rev 02)<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI=
] RD890 PCI to
      PCI bridge (external gfx0 port B)<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort+ &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [f0] HyperTransport: MSI Mapping E=
nable+ Fixed+<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [c4] HyperTransport: Slave or Prim=
ary Interface<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Command: BaseUnitID=3D0 UnitC=
nt=3D20 MastHost- DefDir- DUL-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Control 0: CFlE- CST- CF=
E- &lt;LkFail- Init+ EOC-
      TXO- &lt;CRCErr=3D0 IsocEn- LSEn- ExtCTL- 64b+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Config 0: MLWI=3D16bit D=
wFcIn- MLWO=3D16bit DwFcOut-
      LWI=3D16bit DwFcInEn- LWO=3D16bit DwFcOutEn-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Control 1: CFlE- CST- CF=
E- &lt;LkFail+ Init- EOC+
      TXO+ &lt;CRCErr=3D0 IsocEn- LSEn- ExtCTL- 64b-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Config 1: MLWI=3D8bit Dw=
FcIn- MLWO=3D8bit DwFcOut-
      LWI=3D8bit DwFcInEn- LWO=3D8bit DwFcOutEn-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Revision ID: 3.00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Frequency 0: [d]<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Error 0: &lt;Prot- &lt;O=
vfl- &lt;EOC- CTLTm-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Frequency Capability 0: =
200MHz+ 300MHz- 400MHz+
      500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Feature Capability: IsocFC+ L=
DTSTOP+ CRCTM- ECTLT- 64bA+
      UIDRD-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Frequency 1: 200MHz<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Error 1: &lt;Prot- &lt;O=
vfl- &lt;EOC- CTLTm-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Frequency Capability 1: =
200MHz- 300MHz- 400MHz-
      500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Error Handling: PFlE- OFlE- P=
FE- OFE- EOCFE- RFE- CRCFE-
      SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Prefetchable memory behind br=
idge Upper: 00-00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Bus Number: 00<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [40] HyperTransport: Retry Mode<br=
>
      =C2=A0=C2=A0=C2=A0 Capabilities: [54] HyperTransport: UnitID Clumpi=
ng<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [9c] HyperTransport: #1a<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [70] MSI: Enable- Count=3D1/4 Mask=
able- 64bit-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Address: 00000000=C2=A0 Data:=
 0000<br>
      <br>
      00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O
      Memory Management Unit (IOMMU)<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI=
] RD990 I/O
      Memory Management Unit (IOMMU)<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx+<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 26<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [40] Secure device &lt;?&gt;<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [54] MSI: Enable+ Count=3D1/1 Mask=
able- 64bit+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Address: 00000000fee3f00c=C2=A0=
 Data: 41e1<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [64] HyperTransport: MSI Mapping E=
nable+ Fixed+<br>
      <br>
      00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890
      PCI to PCI bridge (PCI express gpp port B) (prog-if 00 [Normal
      decode])<br>
      =C2=A0=C2=A0=C2=A0 DeviceName:=C2=A0 Onboard IGD<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 0, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 27<br>
      =C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D01, subordinate=3D=
01, sec-latency=3D0<br>
      =C2=A0=C2=A0=C2=A0 I/O behind bridge: 0000e000-0000efff<br>
      =C2=A0=C2=A0=C2=A0 Memory behind bridge: fea00000-feafffff<br>
      =C2=A0=C2=A0=C2=A0 Prefetchable memory behind bridge:
      00000000c0000000-00000000cfffffff<br>
      =C2=A0=C2=A0=C2=A0 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort+ &lt;SERR- &lt;PERR-<br>
      =C2=A0=C2=A0=C2=A0 BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- &gt=
;Reset-
      FastB2B-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 PriDiscTmr- SecDiscTmr- DiscT=
mrStat- DiscTmrSERREn-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [50] Power Management version 3<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1- D2- A=
uxCurrent=3D0mA
      PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [58] Express (v2) Root Port (Slot+=
), MSI 00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap:=C2=A0=C2=A0=C2=A0 Max=
Payload 128 bytes, PhantFunc 0<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtTag+ RB=
E+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl:=C2=A0=C2=A0=C2=A0 Rep=
ort errors: Correctable- Non-Fatal- Fatal-
      Unsupported-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RlxdOrd- E=
xtTag- PhantFunc- AuxPwr- NoSnoop+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 MaxPayload=
 128 bytes, MaxReadReq 128 bytes<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevSta:=C2=A0=C2=A0=C2=A0 Cor=
rErr- UncorrErr- FatalErr- UnsuppReq-
      AuxPwr- TransPend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCap:=C2=A0=C2=A0=C2=A0 Por=
t #0, Speed 5GT/s, Width x16, ASPM L0s L1,
      Exit Latency L0s &lt;1us, L1 &lt;8us<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ClockPM- S=
urprise- LLActRep+ BwNot+ ASPMOptComp-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl:=C2=A0=C2=A0=C2=A0 ASP=
M Disabled; RCB 64 bytes Disabled- CommClk+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtSynch- =
ClockPM- AutWidDis- BWInt- AutBWInt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta:=C2=A0=C2=A0=C2=A0 Spe=
ed 5GT/s, Width x16, TrErr- Train- SlotClk+
      DLActive+ BWMgmt+ ABWMgmt+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 SltCap:=C2=A0=C2=A0=C2=A0 Att=
nBtn- PwrCtrl- MRL- AttnInd- PwrInd-
      HotPlug- Surprise-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Slot #2, P=
owerLimit 75.000W; Interlock- NoCompl+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 SltCtl:=C2=A0=C2=A0=C2=A0 Ena=
ble: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
      HPIrq- LinkChg-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Control: A=
ttnInd Unknown, PwrInd Unknown, Power-
      Interlock-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 SltSta:=C2=A0=C2=A0=C2=A0 Sta=
tus: AttnBtn- PowerFlt- MRL- CmdCplt-
      PresDet+ Interlock-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Changed: M=
RL- PresDet+ LinkState+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RootCtl: ErrCorrectable- ErrN=
on-Fatal- ErrFatal-
      PMEIntEna- CRSVisible+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RootCap: CRSVisible+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RootSta: PME ReqID 0000, PMES=
tatus- PMEPending-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: =
Range ABCD, TimeoutDis+,
      LTR-, OBFF Not Supported ARIFwd+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: =
65ms to 210ms, TimeoutDis-,
      LTR-, OBFF Disabled ARIFwd-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 5=
GT/s, EnterCompliance-
      SpeedDis-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Tran=
smit Margin: Normal Operating Range,
      EnterModifiedCompliance- ComplianceSOS-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Comp=
liance De-emphasis: -6dB<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis =
Level: -3.5dB,
      EqualizationComplete-, EqualizationPhase1-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Equa=
lizationPhase2-, EqualizationPhase3-,
      LinkEqualizationRequest-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [a0] MSI: Enable- Count=3D1/1 Mask=
able- 64bit-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Address: 00000000=C2=A0 Data:=
 0000<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [b0] Subsystem: Advanced Micro Dev=
ices, Inc.
      [AMD/ATI] RD890 PCI to PCI bridge (PCI express gpp port B)<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [b8] HyperTransport: MSI Mapping E=
nable+ Fixed+<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Vendor Specific Informati=
on: ID=3D0001
      Rev=3D1 Len=3D010 &lt;?&gt;<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [190 v1] Access Control Services<b=
r>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ACSCap:=C2=A0=C2=A0=C2=A0 Src=
Valid+ TransBlk+ ReqRedir+ CmpltRedir+
      UpstreamFwd+ EgressCtrl- DirectTrans+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ACSCtl:=C2=A0=C2=A0=C2=A0 Src=
Valid+ TransBlk- ReqRedir+ CmpltRedir+
      UpstreamFwd+ EgressCtrl- DirectTrans-<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: shpchp<br>
      <br>
      00:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890
      PCI to PCI bridge (PCI express gpp port D) (prog-if 00 [Normal
      decode])<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 0, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 27<br>
      =C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D02, subordinate=3D=
02, sec-latency=3D0<br>
      =C2=A0=C2=A0=C2=A0 I/O behind bridge: 0000d000-0000dfff<br>
      =C2=A0=C2=A0=C2=A0 Memory behind bridge: fff00000-000fffff<br>
      =C2=A0=C2=A0=C2=A0 Prefetchable memory behind bridge:
      00000000d0000000-00000000d00fffff<br>
      =C2=A0=C2=A0=C2=A0 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort+ &lt;SERR- &lt;PERR-<br>
      =C2=A0=C2=A0=C2=A0 BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- &gt=
;Reset-
      FastB2B-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 PriDiscTmr- SecDiscTmr- DiscT=
mrStat- DiscTmrSERREn-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [50] Power Management version 3<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1- D2- A=
uxCurrent=3D0mA
      PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [58] Express (v2) Root Port (Slot+=
), MSI 00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap:=C2=A0=C2=A0=C2=A0 Max=
Payload 128 bytes, PhantFunc 0<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtTag+ RB=
E+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl:=C2=A0=C2=A0=C2=A0 Rep=
ort errors: Correctable- Non-Fatal- Fatal-
      Unsupported-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RlxdOrd- E=
xtTag- PhantFunc- AuxPwr- NoSnoop+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 MaxPayload=
 128 bytes, MaxReadReq 128 bytes<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevSta:=C2=A0=C2=A0=C2=A0 Cor=
rErr- UncorrErr- FatalErr- UnsuppReq-
      AuxPwr- TransPend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCap:=C2=A0=C2=A0=C2=A0 Por=
t #0, Speed 5GT/s, Width x2, ASPM L0s L1,
      Exit Latency L0s &lt;1us, L1 &lt;8us<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ClockPM- S=
urprise- LLActRep+ BwNot+ ASPMOptComp-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl:=C2=A0=C2=A0=C2=A0 ASP=
M Disabled; RCB 64 bytes Disabled- CommClk+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtSynch- =
ClockPM- AutWidDis- BWInt- AutBWInt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta:=C2=A0=C2=A0=C2=A0 Spe=
ed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
      DLActive+ BWMgmt+ ABWMgmt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 SltCap:=C2=A0=C2=A0=C2=A0 Att=
nBtn- PwrCtrl- MRL- AttnInd- PwrInd-
      HotPlug- Surprise-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Slot #4, P=
owerLimit 75.000W; Interlock- NoCompl+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 SltCtl:=C2=A0=C2=A0=C2=A0 Ena=
ble: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
      HPIrq- LinkChg-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Control: A=
ttnInd Unknown, PwrInd Unknown, Power-
      Interlock-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 SltSta:=C2=A0=C2=A0=C2=A0 Sta=
tus: AttnBtn- PowerFlt- MRL- CmdCplt-
      PresDet+ Interlock-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Changed: M=
RL- PresDet+ LinkState+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RootCtl: ErrCorrectable- ErrN=
on-Fatal- ErrFatal-
      PMEIntEna- CRSVisible+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RootCap: CRSVisible+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RootSta: PME ReqID 0000, PMES=
tatus- PMEPending-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: =
Range ABCD, TimeoutDis+,
      LTR-, OBFF Not Supported ARIFwd+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: =
65ms to 210ms, TimeoutDis-,
      LTR-, OBFF Disabled ARIFwd-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 5=
GT/s, EnterCompliance-
      SpeedDis-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Tran=
smit Margin: Normal Operating Range,
      EnterModifiedCompliance- ComplianceSOS-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Comp=
liance De-emphasis: -6dB<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis =
Level: -3.5dB,
      EqualizationComplete-, EqualizationPhase1-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Equa=
lizationPhase2-, EqualizationPhase3-,
      LinkEqualizationRequest-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [a0] MSI: Enable- Count=3D1/1 Mask=
able- 64bit-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Address: 00000000=C2=A0 Data:=
 0000<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [b0] Subsystem: Advanced Micro Dev=
ices, Inc.
      [AMD/ATI] RD890 PCI to PCI bridge (PCI express gpp port D)<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [b8] HyperTransport: MSI Mapping E=
nable+ Fixed+<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Vendor Specific Informati=
on: ID=3D0001
      Rev=3D1 Len=3D010 &lt;?&gt;<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [190 v1] Access Control Services<b=
r>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ACSCap:=C2=A0=C2=A0=C2=A0 Src=
Valid+ TransBlk+ ReqRedir+ CmpltRedir+
      UpstreamFwd+ EgressCtrl- DirectTrans+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ACSCtl:=C2=A0=C2=A0=C2=A0 Src=
Valid+ TransBlk- ReqRedir+ CmpltRedir+
      UpstreamFwd+ EgressCtrl- DirectTrans-<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: shpchp<br>
      <br>
      00:07.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890
      PCI to PCI bridge (PCI express gpp port G) (prog-if 00 [Normal
      decode])<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 0, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 24<br>
      =C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D03, subordinate=3D=
03, sec-latency=3D0<br>
      =C2=A0=C2=A0=C2=A0 I/O behind bridge: 0000f000-00000fff<br>
      =C2=A0=C2=A0=C2=A0 Memory behind bridge: fe900000-fe9fffff<br>
      =C2=A0=C2=A0=C2=A0 Prefetchable memory behind bridge:
      00000000fff00000-00000000000fffff<br>
      =C2=A0=C2=A0=C2=A0 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort+ &lt;SERR- &lt;PERR-<br>
      =C2=A0=C2=A0=C2=A0 BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- &gt=
;Reset-
      FastB2B-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 PriDiscTmr- SecDiscTmr- DiscT=
mrStat- DiscTmrSERREn-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [50] Power Management version 3<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1- D2- A=
uxCurrent=3D0mA
      PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [58] Express (v2) Root Port (Slot+=
), MSI 00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap:=C2=A0=C2=A0=C2=A0 Max=
Payload 128 bytes, PhantFunc 0<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtTag+ RB=
E+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl:=C2=A0=C2=A0=C2=A0 Rep=
ort errors: Correctable- Non-Fatal- Fatal-
      Unsupported-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RlxdOrd- E=
xtTag- PhantFunc- AuxPwr- NoSnoop+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 MaxPayload=
 128 bytes, MaxReadReq 128 bytes<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevSta:=C2=A0=C2=A0=C2=A0 Cor=
rErr- UncorrErr- FatalErr- UnsuppReq-
      AuxPwr- TransPend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCap:=C2=A0=C2=A0=C2=A0 Por=
t #3, Speed 5GT/s, Width x1, ASPM L0s L1,
      Exit Latency L0s &lt;1us, L1 &lt;8us<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ClockPM- S=
urprise- LLActRep+ BwNot+ ASPMOptComp-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl:=C2=A0=C2=A0=C2=A0 ASP=
M Disabled; RCB 64 bytes Disabled- CommClk+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtSynch- =
ClockPM- AutWidDis- BWInt- AutBWInt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta:=C2=A0=C2=A0=C2=A0 Spe=
ed 5GT/s, Width x1, TrErr- Train- SlotClk+
      DLActive+ BWMgmt+ ABWMgmt+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 SltCap:=C2=A0=C2=A0=C2=A0 Att=
nBtn- PwrCtrl- MRL- AttnInd- PwrInd-
      HotPlug- Surprise-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Slot #7, P=
owerLimit 75.000W; Interlock- NoCompl+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 SltCtl:=C2=A0=C2=A0=C2=A0 Ena=
ble: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
      HPIrq- LinkChg-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Control: A=
ttnInd Unknown, PwrInd Unknown, Power-
      Interlock-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 SltSta:=C2=A0=C2=A0=C2=A0 Sta=
tus: AttnBtn- PowerFlt- MRL- CmdCplt-
      PresDet+ Interlock-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Changed: M=
RL- PresDet+ LinkState+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RootCtl: ErrCorrectable- ErrN=
on-Fatal- ErrFatal-
      PMEIntEna- CRSVisible+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RootCap: CRSVisible+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RootSta: PME ReqID 0000, PMES=
tatus- PMEPending-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: =
Range ABCD, TimeoutDis+,
      LTR-, OBFF Not Supported ARIFwd+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: =
65ms to 210ms, TimeoutDis-,
      LTR-, OBFF Disabled ARIFwd-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 5=
GT/s, EnterCompliance-
      SpeedDis-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Tran=
smit Margin: Normal Operating Range,
      EnterModifiedCompliance- ComplianceSOS-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Comp=
liance De-emphasis: -6dB<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis =
Level: -3.5dB,
      EqualizationComplete-, EqualizationPhase1-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Equa=
lizationPhase2-, EqualizationPhase3-,
      LinkEqualizationRequest-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [a0] MSI: Enable- Count=3D1/1 Mask=
able- 64bit-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Address: 00000000=C2=A0 Data:=
 0000<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [b0] Subsystem: Advanced Micro Dev=
ices, Inc.
      [AMD/ATI] RD890 PCI to PCI bridge (PCI express gpp port G)<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [b8] HyperTransport: MSI Mapping E=
nable+ Fixed+<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Vendor Specific Informati=
on: ID=3D0001
      Rev=3D1 Len=3D010 &lt;?&gt;<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [190 v1] Access Control Services<b=
r>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ACSCap:=C2=A0=C2=A0=C2=A0 Src=
Valid+ TransBlk+ ReqRedir+ CmpltRedir+
      UpstreamFwd+ EgressCtrl- DirectTrans+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ACSCtl:=C2=A0=C2=A0=C2=A0 Src=
Valid+ TransBlk- ReqRedir+ CmpltRedir+
      UpstreamFwd+ EgressCtrl- DirectTrans-<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: shpchp<br>
      <br>
      00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI]
      SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40) (prog-if 01
      [AHCI 1.0])<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: ASUSTeK Computer Inc. SB7x0/SB8x0/SB9=
x0 SATA
      Controller [AHCI mode]<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 32<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 19<br>
      =C2=A0=C2=A0=C2=A0 Region 0: I/O ports at f040 [size=3D8]<br>
      =C2=A0=C2=A0=C2=A0 Region 1: I/O ports at f030 [size=3D4]<br>
      =C2=A0=C2=A0=C2=A0 Region 2: I/O ports at f020 [size=3D8]<br>
      =C2=A0=C2=A0=C2=A0 Region 3: I/O ports at f010 [size=3D4]<br>
      =C2=A0=C2=A0=C2=A0 Region 4: I/O ports at f000 [size=3D16]<br>
      =C2=A0=C2=A0=C2=A0 Region 5: Memory at feb0b000 (32-bit, non-prefet=
chable)
      [size=3D1K]<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [70] SATA HBA v1.0 InCfgSpace<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [a4] PCI Advanced Features<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 AFCap: TP+ FLR+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 AFCtrl: FLR-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 AFStatus: TP+<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: ahci<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: ahci<br>
      <br>
      00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
      SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI=
]
      SB7x0/SB8x0/SB9x0 USB OHCI0 Controller<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 32, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 18<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at feb0a000 (32-bit, non-prefet=
chable)
      [size=3D4K]<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: ohci-pci<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: ohci_pci<br>
      <br>
      00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
      SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI=
]
      SB7x0/SB8x0/SB9x0 USB EHCI Controller<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
+ VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 32, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin B routed to IRQ 17<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at feb09000 (32-bit, non-prefet=
chable)
      [size=3D256]<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [c0] Power Management version 2<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1+ D2+ A=
uxCurrent=3D0mA
      PME(D0+,D1+,D2+,D3hot+,D3cold-)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Bridge: PM- B3+<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [e4] Debug port: BAR=3D1 offset=3D=
00e0<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: ehci-pci<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: ehci_pci<br>
      <br>
      00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
      SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI=
]
      SB7x0/SB8x0/SB9x0 USB OHCI0 Controller<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 32, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 20<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at feb08000 (32-bit, non-prefet=
chable)
      [size=3D4K]<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: ohci-pci<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: ohci_pci<br>
      <br>
      00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
      SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI=
]
      SB7x0/SB8x0/SB9x0 USB EHCI Controller<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
+ VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 32, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin B routed to IRQ 21<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at feb07000 (32-bit, non-prefet=
chable)
      [size=3D256]<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [c0] Power Management version 2<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1+ D2+ A=
uxCurrent=3D0mA
      PME(D0+,D1+,D2+,D3hot+,D3cold-)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Bridge: PM- B3+<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [e4] Debug port: BAR=3D1 offset=3D=
00e0<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: ehci-pci<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: ehci_pci<br>
      <br>
      00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus
      Controller (rev 42)<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI=
] SBx00 SMBus
      Controller<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx+<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: piix4_smbus<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: i2c_piix4, sp5100_tco<br>
      <br>
      00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00
      Azalia (Intel HDA) (rev 40)<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: ASUSTeK Computer Inc. SBx00 Azalia (I=
ntel HDA)<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dslow
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 32, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 16<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at feb00000 (64-bit, non-prefet=
chable)
      [size=3D16K]<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [50] Power Management version 2<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1- D2- A=
uxCurrent=3D55mA
      PME(D0+,D1-,D2-,D3hot+,D3cold+)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: snd_hda_intel<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: snd_hda_intel<br>
      <br>
      00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI]
      SB7x0/SB8x0/SB9x0 LPC host controller (rev 40)<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI=
]
      SB7x0/SB8x0/SB9x0 LPC host controller<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 0<br>
      <br>
      00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00
      PCI to PCI Bridge (rev 40) (prog-if 01 [Subtractive decode])<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop+
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 64<br>
      =C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D04, subordinate=3D=
04, sec-latency=3D64<br>
      =C2=A0=C2=A0=C2=A0 I/O behind bridge: 0000c000-0000cfff<br>
      =C2=A0=C2=A0=C2=A0 Memory behind bridge: fe800000-fe8fffff<br>
      =C2=A0=C2=A0=C2=A0 Prefetchable memory behind bridge: fff00000-000f=
ffff<br>
      =C2=A0=C2=A0=C2=A0 Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort+ &lt;SERR- &lt;PERR-<br>
      =C2=A0=C2=A0=C2=A0 BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- &gt=
;Reset-
      FastB2B-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 PriDiscTmr- SecDiscTmr- DiscT=
mrStat- DiscTmrSERREn-<br>
      <br>
      00:14.5 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
      SB7x0/SB8x0/SB9x0 USB OHCI2 Controller (prog-if 10 [OHCI])<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI=
]
      SB7x0/SB8x0/SB9x0 USB OHCI2 Controller<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 32, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin C routed to IRQ 18<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at feb06000 (32-bit, non-prefet=
chable)
      [size=3D4K]<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: ohci-pci<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: ohci_pci<br>
      <br>
      00:15.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
      SB700/SB800/SB900 PCI to PCI bridge (PCIE port 0) (prog-if 00
      [Normal decode])<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 0, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 16<br>
      =C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D05, subordinate=3D=
05, sec-latency=3D0<br>
      =C2=A0=C2=A0=C2=A0 I/O behind bridge: 0000b000-0000bfff<br>
      =C2=A0=C2=A0=C2=A0 Memory behind bridge: fe700000-fe7fffff<br>
      =C2=A0=C2=A0=C2=A0 Prefetchable memory behind bridge:
      00000000a0000000-00000000b01fffff<br>
      =C2=A0=C2=A0=C2=A0 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort+ &lt;SERR- &lt;PERR-<br>
      =C2=A0=C2=A0=C2=A0 BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- &gt=
;Reset-
      FastB2B-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 PriDiscTmr- SecDiscTmr- DiscT=
mrStat- DiscTmrSERREn-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [50] Power Management version 3<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1+ D2+ A=
uxCurrent=3D0mA
      PME(D0-,D1-,D2-,D3hot-,D3cold-)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [58] Express (v2) Root Port (Slot-=
), MSI 00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap:=C2=A0=C2=A0=C2=A0 Max=
Payload 128 bytes, PhantFunc 0<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtTag+ RB=
E+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl:=C2=A0=C2=A0=C2=A0 Rep=
ort errors: Correctable- Non-Fatal- Fatal-
      Unsupported-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RlxdOrd- E=
xtTag- PhantFunc- AuxPwr- NoSnoop+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 MaxPayload=
 128 bytes, MaxReadReq 128 bytes<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevSta:=C2=A0=C2=A0=C2=A0 Cor=
rErr- UncorrErr- FatalErr- UnsuppReq-
      AuxPwr- TransPend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCap:=C2=A0=C2=A0=C2=A0 Por=
t #0, Speed 5GT/s, Width x4, ASPM L0s L1,
      Exit Latency L0s &lt;64ns, L1 &lt;1us<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ClockPM- S=
urprise- LLActRep+ BwNot+ ASPMOptComp-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl:=C2=A0=C2=A0=C2=A0 ASP=
M Disabled; RCB 64 bytes Disabled- CommClk+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtSynch- =
ClockPM- AutWidDis- BWInt- AutBWInt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta:=C2=A0=C2=A0=C2=A0 Spe=
ed 5GT/s, Width x4, TrErr- Train- SlotClk+
      DLActive+ BWMgmt+ ABWMgmt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RootCtl: ErrCorrectable- ErrN=
on-Fatal- ErrFatal-
      PMEIntEna- CRSVisible+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RootCap: CRSVisible+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RootSta: PME ReqID 0000, PMES=
tatus- PMEPending-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: =
Range ABCD, TimeoutDis+,
      LTR-, OBFF Not Supported ARIFwd-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: =
65ms to 210ms, TimeoutDis-,
      LTR-, OBFF Disabled ARIFwd-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 5=
GT/s, EnterCompliance-
      SpeedDis-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Tran=
smit Margin: Normal Operating Range,
      EnterModifiedCompliance- ComplianceSOS-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Comp=
liance De-emphasis: -6dB<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis =
Level: -3.5dB,
      EqualizationComplete-, EqualizationPhase1-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Equa=
lizationPhase2-, EqualizationPhase3-,
      LinkEqualizationRequest-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [a0] MSI: Enable- Count=3D1/1 Mask=
able- 64bit+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Address: 0000000000000000=C2=A0=
 Data: 0000<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [b0] Subsystem: Advanced Micro Dev=
ices, Inc.
      [AMD/ATI] SB700/SB800/SB900 PCI to PCI bridge (PCIE port 0)<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [b8] HyperTransport: MSI Mapping E=
nable+ Fixed+<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Vendor Specific Informati=
on: ID=3D0001
      Rev=3D1 Len=3D010 &lt;?&gt;<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: shpchp<br>
      <br>
      00:16.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
      SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI=
]
      SB7x0/SB8x0/SB9x0 USB OHCI0 Controller<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 32, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 22<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at feb05000 (32-bit, non-prefet=
chable)
      [size=3D4K]<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: ohci-pci<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: ohci_pci<br>
      <br>
      00:16.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
      SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI=
]
      SB7x0/SB8x0/SB9x0 USB EHCI Controller<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
+ VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 32, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin B routed to IRQ 23<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at feb04000 (32-bit, non-prefet=
chable)
      [size=3D256]<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [c0] Power Management version 2<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1+ D2+ A=
uxCurrent=3D0mA
      PME(D0+,D1+,D2+,D3hot+,D3cold-)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Bridge: PM- B3+<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [e4] Debug port: BAR=3D1 offset=3D=
00e0<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: ehci-pci<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: ehci_pci<br>
      <br>
      00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
      Processor Function 0<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [80] HyperTransport: Host or Secon=
dary Interface<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Command: WarmRst+ DblEnd- Dev=
Num=3D0 ChainSide- HostHide+
      Slave- &lt;EOCErr- DUL-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Control: CFlE- CST- CFE-=
 &lt;LkFail- Init+ EOC- TXO-
      &lt;CRCErr=3D0 IsocEn- LSEn+ ExtCTL- 64b+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Config: MLWI=3D16bit DwF=
cIn- MLWO=3D16bit DwFcOut-
      LWI=3D16bit DwFcInEn- LWO=3D16bit DwFcOutEn-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Revision ID: 3.00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Frequency: [d]<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Error: &lt;Prot- &lt;Ovf=
l- &lt;EOC- CTLTm-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Link Frequency Capability: 20=
0MHz+ 300MHz- 400MHz+ 500MHz-
      600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Feature Capability: IsocFC+ L=
DTSTOP+ CRCTM- ECTLT- 64bA+
      UIDRD- ExtRS- UCnfE-<br>
      <br>
      00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
      Processor Function 1<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      <br>
      00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
      Processor Function 2<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      <br>
      00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
      Processor Function 3<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [f0] Secure device &lt;?&gt;<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: k10temp<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: k10temp<br>
      <br>
      00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
      Processor Function 4<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: fam15h_power<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: fam15h_power<br>
      <br>
      00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h
      Processor Function 5<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      <br>
      01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
      [AMD/ATI] Turks PRO [Radeon HD 6570/7570/8550] (prog-if 00 [VGA
      controller])<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: XFX Pine Group Inc. Turks PRO [Radeon=
 HD
      6570/7570/8550]<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx+<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 0, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 39<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at c0000000 (64-bit, prefetchab=
le)
      [size=3D256M]<br>
      =C2=A0=C2=A0=C2=A0 Region 2: Memory at fea20000 (64-bit, non-prefet=
chable)
      [size=3D128K]<br>
      =C2=A0=C2=A0=C2=A0 Region 4: I/O ports at e000 [size=3D256]<br>
      =C2=A0=C2=A0=C2=A0 Expansion ROM at 000c0000 [disabled] [size=3D128=
K]<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [50] Power Management version 3<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1+ D2+ A=
uxCurrent=3D0mA
      PME(D0-,D1-,D2-,D3hot-,D3cold-)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [58] Express (v2) Legacy Endpoint,=
 MSI 00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap:=C2=A0=C2=A0=C2=A0 Max=
Payload 256 bytes, PhantFunc 0, Latency L0s
      &lt;4us, L1 unlimited<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtTag+ At=
tnBtn- AttnInd- PwrInd- RBE+ FLReset-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl:=C2=A0=C2=A0=C2=A0 Rep=
ort errors: Correctable- Non-Fatal- Fatal-
      Unsupported-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RlxdOrd- E=
xtTag- PhantFunc- AuxPwr- NoSnoop+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 MaxPayload=
 128 bytes, MaxReadReq 512 bytes<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevSta:=C2=A0=C2=A0=C2=A0 Cor=
rErr+ UncorrErr- FatalErr- UnsuppReq+
      AuxPwr- TransPend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCap:=C2=A0=C2=A0=C2=A0 Por=
t #0, Speed 5GT/s, Width x16, ASPM L0s L1,
      Exit Latency L0s &lt;64ns, L1 &lt;1us<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ClockPM- S=
urprise- LLActRep- BwNot- ASPMOptComp-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl:=C2=A0=C2=A0=C2=A0 ASP=
M Disabled; RCB 64 bytes Disabled- CommClk+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtSynch- =
ClockPM- AutWidDis- BWInt- AutBWInt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta:=C2=A0=C2=A0=C2=A0 Spe=
ed 5GT/s, Width x16, TrErr- Train- SlotClk+
      DLActive- BWMgmt- ABWMgmt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: =
Not Supported, TimeoutDis-,
      LTR-, OBFF Not Supported<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: =
50us to 50ms, TimeoutDis-,
      LTR-, OBFF Disabled<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 5=
GT/s, EnterCompliance-
      SpeedDis-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Tran=
smit Margin: Normal Operating Range,
      EnterModifiedCompliance- ComplianceSOS-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Comp=
liance De-emphasis: -6dB<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis =
Level: -3.5dB,
      EqualizationComplete-, EqualizationPhase1-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Equa=
lizationPhase2-, EqualizationPhase3-,
      LinkEqualizationRequest-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Mask=
able- 64bit+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Address: 00000000fee1000c=C2=A0=
 Data: 4183<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Vendor Specific Informati=
on: ID=3D0001
      Rev=3D1 Len=3D010 &lt;?&gt;<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [150 v1] Advanced Error Reporting<=
br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UESta:=C2=A0=C2=A0=C2=A0 DLP-=
 SDES- TLP- FCP- CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UEMsk:=C2=A0=C2=A0=C2=A0 DLP-=
 SDES- TLP- FCP- CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UESvrt:=C2=A0=C2=A0=C2=A0 DLP=
+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CESta:=C2=A0=C2=A0=C2=A0 RxEr=
r- BadTLP- BadDLLP- Rollover- Timeout-
      NonFatalErr+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CEMsk:=C2=A0=C2=A0=C2=A0 RxEr=
r- BadTLP- BadDLLP- Rollover- Timeout-
      NonFatalErr+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 AERCap:=C2=A0=C2=A0=C2=A0 Fir=
st Error Pointer: 00, GenCap+ CGenEn-
      ChkCap+ ChkEn-<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: radeon<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: radeon<br>
      <br>
      01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]
      Turks/Whistler HDMI Audio [Radeon HD 6000 Series]<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: XFX Pine Group Inc. Turks/Whistler HD=
MI Audio
      [Radeon HD 6000 Series]<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx+<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 0, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin B routed to IRQ 41<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at fea40000 (64-bit, non-prefet=
chable)
      [size=3D16K]<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [50] Power Management version 3<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1+ D2+ A=
uxCurrent=3D0mA
      PME(D0-,D1-,D2-,D3hot-,D3cold-)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [58] Express (v2) Legacy Endpoint,=
 MSI 00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap:=C2=A0=C2=A0=C2=A0 Max=
Payload 256 bytes, PhantFunc 0, Latency L0s
      &lt;4us, L1 unlimited<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtTag+ At=
tnBtn- AttnInd- PwrInd- RBE+ FLReset-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl:=C2=A0=C2=A0=C2=A0 Rep=
ort errors: Correctable- Non-Fatal- Fatal-
      Unsupported-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RlxdOrd- E=
xtTag- PhantFunc- AuxPwr- NoSnoop+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 MaxPayload=
 128 bytes, MaxReadReq 512 bytes<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevSta:=C2=A0=C2=A0=C2=A0 Cor=
rErr+ UncorrErr- FatalErr- UnsuppReq+
      AuxPwr- TransPend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCap:=C2=A0=C2=A0=C2=A0 Por=
t #0, Speed 5GT/s, Width x16, ASPM L0s L1,
      Exit Latency L0s &lt;64ns, L1 &lt;1us<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ClockPM- S=
urprise- LLActRep- BwNot- ASPMOptComp-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl:=C2=A0=C2=A0=C2=A0 ASP=
M Disabled; RCB 64 bytes Disabled- CommClk+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtSynch- =
ClockPM- AutWidDis- BWInt- AutBWInt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta:=C2=A0=C2=A0=C2=A0 Spe=
ed 5GT/s, Width x16, TrErr- Train- SlotClk+
      DLActive- BWMgmt- ABWMgmt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: =
Not Supported, TimeoutDis-,
      LTR-, OBFF Not Supported<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: =
50us to 50ms, TimeoutDis-,
      LTR-, OBFF Disabled<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis =
Level: -3.5dB,
      EqualizationComplete-, EqualizationPhase1-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Equa=
lizationPhase2-, EqualizationPhase3-,
      LinkEqualizationRequest-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [a0] MSI: Enable+ Count=3D1/1 Mask=
able- 64bit+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Address: 00000000fee3e00c=C2=A0=
 Data: 41d3<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Vendor Specific Informati=
on: ID=3D0001
      Rev=3D1 Len=3D010 &lt;?&gt;<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [150 v1] Advanced Error Reporting<=
br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UESta:=C2=A0=C2=A0=C2=A0 DLP-=
 SDES- TLP- FCP- CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UEMsk:=C2=A0=C2=A0=C2=A0 DLP-=
 SDES- TLP- FCP- CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UESvrt:=C2=A0=C2=A0=C2=A0 DLP=
+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CESta:=C2=A0=C2=A0=C2=A0 RxEr=
r- BadTLP- BadDLLP- Rollover- Timeout-
      NonFatalErr+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CEMsk:=C2=A0=C2=A0=C2=A0 RxEr=
r- BadTLP- BadDLLP- Rollover- Timeout-
      NonFatalErr+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 AERCap:=C2=A0=C2=A0=C2=A0 Fir=
st Error Pointer: 00, GenCap+ CGenEn-
      ChkCap+ ChkEn-<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: snd_hda_intel<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: snd_hda_intel<br>
      <br>
      02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
      RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)<=
br>
      =C2=A0=C2=A0=C2=A0 Subsystem: ASUSTeK Computer Inc. P8P67 and other=
 motherboards<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx+<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 0, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 29<br>
      =C2=A0=C2=A0=C2=A0 Region 0: I/O ports at d000 [size=3D256]<br>
      =C2=A0=C2=A0=C2=A0 Region 2: Memory at d0004000 (64-bit, prefetchab=
le) [size=3D4K]<br>
      =C2=A0=C2=A0=C2=A0 Region 4: Memory at d0000000 (64-bit, prefetchab=
le) [size=3D16K]<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [40] Power Management version 3<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1+ D2+ A=
uxCurrent=3D375mA
      PME(D0+,D1+,D2+,D3hot+,D3cold+)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst+ PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [50] MSI: Enable+ Count=3D1/1 Mask=
able- 64bit+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Address: 00000000fee0200c=C2=A0=
 Data: 4162<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [70] Express (v2) Endpoint, MSI 01=
<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap:=C2=A0=C2=A0=C2=A0 Max=
Payload 128 bytes, PhantFunc 0, Latency L0s
      &lt;512ns, L1 &lt;64us<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtTag- At=
tnBtn- AttnInd- PwrInd- RBE+ FLReset-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl:=C2=A0=C2=A0=C2=A0 Rep=
ort errors: Correctable- Non-Fatal- Fatal-
      Unsupported-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RlxdOrd- E=
xtTag- PhantFunc- AuxPwr- NoSnoop-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 MaxPayload=
 128 bytes, MaxReadReq 4096 bytes<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevSta:=C2=A0=C2=A0=C2=A0 Cor=
rErr+ UncorrErr- FatalErr- UnsuppReq+
      AuxPwr+ TransPend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCap:=C2=A0=C2=A0=C2=A0 Por=
t #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
      Exit Latency L0s unlimited, L1 &lt;64us<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ClockPM+ S=
urprise- LLActRep- BwNot- ASPMOptComp-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl:=C2=A0=C2=A0=C2=A0 ASP=
M Disabled; RCB 64 bytes Disabled- CommClk+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtSynch- =
ClockPM- AutWidDis- BWInt- AutBWInt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta:=C2=A0=C2=A0=C2=A0 Spe=
ed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
      DLActive- BWMgmt- ABWMgmt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: =
Range ABCD, TimeoutDis+,
      LTR-, OBFF Not Supported<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: =
50us to 50ms, TimeoutDis-,
      LTR-, OBFF Disabled<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 2=
.5GT/s, EnterCompliance-
      SpeedDis-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Tran=
smit Margin: Normal Operating Range,
      EnterModifiedCompliance- ComplianceSOS-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Comp=
liance De-emphasis: -6dB<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis =
Level: -6dB,
      EqualizationComplete-, EqualizationPhase1-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Equa=
lizationPhase2-, EqualizationPhase3-,
      LinkEqualizationRequest-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [b0] MSI-X: Enable- Count=3D4 Mask=
ed-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Vector table: BAR=3D4 offset=3D=
00000000<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 PBA: BAR=3D4 offset=3D0000080=
0<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [d0] Vital Product Data<br>
      pcilib: sysfs_read_vpd: read failed: Input/output error<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Not readable<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Advanced Error Reporting<=
br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UESta:=C2=A0=C2=A0=C2=A0 DLP-=
 SDES- TLP- FCP- CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UEMsk:=C2=A0=C2=A0=C2=A0 DLP-=
 SDES- TLP- FCP- CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UESvrt:=C2=A0=C2=A0=C2=A0 DLP=
+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CESta:=C2=A0=C2=A0=C2=A0 RxEr=
r- BadTLP- BadDLLP- Rollover- Timeout-
      NonFatalErr-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CEMsk:=C2=A0=C2=A0=C2=A0 RxEr=
r- BadTLP- BadDLLP- Rollover- Timeout-
      NonFatalErr+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 AERCap:=C2=A0=C2=A0=C2=A0 Fir=
st Error Pointer: 00, GenCap+ CGenEn-
      ChkCap+ ChkEn-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [140 v1] Virtual Channel<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Caps:=C2=A0=C2=A0=C2=A0 LPEVC=
=3D0 RefClk=3D100ns PATEntryBits=3D1<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Arb:=C2=A0=C2=A0=C2=A0 Fixed-=
 WRR32- WRR64- WRR128-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Ctrl:=C2=A0=C2=A0=C2=A0 ArbSe=
lect=3DFixed<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status:=C2=A0=C2=A0=C2=A0 InP=
rogress-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 VC0:=C2=A0=C2=A0=C2=A0 Caps:=C2=
=A0=C2=A0=C2=A0 PATOffset=3D00 MaxTimeSlots=3D1
      RejSnoopTrans-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Arb:=C2=A0=
=C2=A0=C2=A0 Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Ctrl:=C2=A0=
=C2=A0=C2=A0 Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status:=C2=
=A0=C2=A0=C2=A0 NegoPending- InProgress-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [160 v1] Device Serial Number
      01-00-00-00-68-4c-e0-00<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: r8169<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: r8169<br>
      <br>
      03:00.0 USB controller: ASMedia Technology Inc. ASM1042 SuperSpeed
      USB Host Controller (prog-if 30 [XHCI])<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: ASUSTeK Computer Inc. P8B WS Motherbo=
ard<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx+<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 0, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 30<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at fe900000 (64-bit, non-prefet=
chable)
      [size=3D32K]<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [50] MSI: Enable- Count=3D1/8 Mask=
able- 64bit+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Address: 0000000000000000=C2=A0=
 Data: 0000<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [68] MSI-X: Enable+ Count=3D8 Mask=
ed-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Vector table: BAR=3D0 offset=3D=
00002000<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 PBA: BAR=3D0 offset=3D0000208=
0<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [78] Power Management version 3<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1- D2- A=
uxCurrent=3D55mA
      PME(D0-,D1-,D2-,D3hot+,D3cold+)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [80] Express (v2) Legacy Endpoint,=
 MSI 00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap:=C2=A0=C2=A0=C2=A0 Max=
Payload 512 bytes, PhantFunc 0, Latency L0s
      &lt;64ns, L1 &lt;2us<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtTag- At=
tnBtn- AttnInd- PwrInd- RBE+ FLReset-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl:=C2=A0=C2=A0=C2=A0 Rep=
ort errors: Correctable- Non-Fatal- Fatal-
      Unsupported-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RlxdOrd- E=
xtTag- PhantFunc- AuxPwr- NoSnoop+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 MaxPayload=
 128 bytes, MaxReadReq 512 bytes<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevSta:=C2=A0=C2=A0=C2=A0 Cor=
rErr+ UncorrErr- FatalErr- UnsuppReq-
      AuxPwr- TransPend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCap:=C2=A0=C2=A0=C2=A0 Por=
t #1, Speed 5GT/s, Width x1, ASPM L0s L1,
      Exit Latency L0s unlimited, L1 unlimited<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ClockPM- S=
urprise- LLActRep- BwNot- ASPMOptComp-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl:=C2=A0=C2=A0=C2=A0 ASP=
M Disabled; RCB 64 bytes Disabled- CommClk+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtSynch- =
ClockPM- AutWidDis- BWInt- AutBWInt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta:=C2=A0=C2=A0=C2=A0 Spe=
ed 5GT/s, Width x1, TrErr- Train- SlotClk+
      DLActive- BWMgmt- ABWMgmt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: =
Not Supported, TimeoutDis-,
      LTR-, OBFF Not Supported<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: =
50us to 50ms, TimeoutDis-,
      LTR-, OBFF Disabled<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 5=
GT/s, EnterCompliance-
      SpeedDis-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Tran=
smit Margin: Normal Operating Range,
      EnterModifiedCompliance- ComplianceSOS-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Comp=
liance De-emphasis: -6dB<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis =
Level: -3.5dB,
      EqualizationComplete-, EqualizationPhase1-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Equa=
lizationPhase2-, EqualizationPhase3-,
      LinkEqualizationRequest-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Virtual Channel<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Caps:=C2=A0=C2=A0=C2=A0 LPEVC=
=3D0 RefClk=3D100ns PATEntryBits=3D1<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Arb:=C2=A0=C2=A0=C2=A0 Fixed-=
 WRR32- WRR64- WRR128-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Ctrl:=C2=A0=C2=A0=C2=A0 ArbSe=
lect=3DFixed<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status:=C2=A0=C2=A0=C2=A0 InP=
rogress-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 VC0:=C2=A0=C2=A0=C2=A0 Caps:=C2=
=A0=C2=A0=C2=A0 PATOffset=3D00 MaxTimeSlots=3D1
      RejSnoopTrans-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Arb:=C2=A0=
=C2=A0=C2=A0 Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Ctrl:=C2=A0=
=C2=A0=C2=A0 Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D01<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status:=C2=
=A0=C2=A0=C2=A0 NegoPending- InProgress-<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: xhci_hcd<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: xhci_pci<br>
      <br>
      04:06.0 Ethernet controller: D-Link System Inc DGE-528T Gigabit
      Ethernet Adapter (rev 10)<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: D-Link System Inc DGE-528T Gigabit Et=
hernet Adapter<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
+ VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=
=3Dmedium
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 64 (8000ns min, 16000ns max), Cache Lin=
e Size: 32
      bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 21<br>
      =C2=A0=C2=A0=C2=A0 Region 0: I/O ports at c000 [size=3D256]<br>
      =C2=A0=C2=A0=C2=A0 Region 1: Memory at fe820000 (32-bit, non-prefet=
chable)
      [size=3D256]<br>
      =C2=A0=C2=A0=C2=A0 Expansion ROM at fe800000 [disabled] [size=3D128=
K]<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [dc] Power Management version 2<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1+ D2+ A=
uxCurrent=3D375mA
      PME(D0-,D1+,D2+,D3hot+,D3cold+)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D0 NoSoftRst- PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: r8169<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: r8169<br>
      <br>
      05:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
      [AMD/ATI] Tonga PRO [Radeon R9 285/380] (rev f1) (prog-if 00 [VGA
      controller])<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Micro-Star International Co., Ltd. [M=
SI] Tonga PRO
      [Radeon R9 285/380]<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin A routed to IRQ 10<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at a0000000 (64-bit, prefetchab=
le) [disabled]
      [size=3D256M]<br>
      =C2=A0=C2=A0=C2=A0 Region 2: Memory at b0000000 (64-bit, prefetchab=
le) [disabled]
      [size=3D2M]<br>
      =C2=A0=C2=A0=C2=A0 Region 4: I/O ports at b000 [disabled] [size=3D2=
56]<br>
      =C2=A0=C2=A0=C2=A0 Region 5: Memory at fe700000 (32-bit, non-prefet=
chable)
      [disabled] [size=3D256K]<br>
      =C2=A0=C2=A0=C2=A0 Expansion ROM at fe740000 [disabled] [size=3D128=
K]<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [48] Vendor Specific Information: =
Len=3D08
      &lt;?&gt;<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [50] Power Management version 3<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1+ D2+ A=
uxCurrent=3D0mA
      PME(D0-,D1+,D2+,D3hot+,D3cold+)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D3 NoSoftRst+ PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [58] Express (v2) Legacy Endpoint,=
 MSI 00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap:=C2=A0=C2=A0=C2=A0 Max=
Payload 256 bytes, PhantFunc 0, Latency L0s
      &lt;4us, L1 unlimited<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtTag+ At=
tnBtn- AttnInd- PwrInd- RBE+ FLReset-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl:=C2=A0=C2=A0=C2=A0 Rep=
ort errors: Correctable- Non-Fatal- Fatal-
      Unsupported-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RlxdOrd- E=
xtTag- PhantFunc- AuxPwr- NoSnoop+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 MaxPayload=
 128 bytes, MaxReadReq 512 bytes<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevSta:=C2=A0=C2=A0=C2=A0 Cor=
rErr+ UncorrErr- FatalErr- UnsuppReq+
      AuxPwr- TransPend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCap:=C2=A0=C2=A0=C2=A0 Por=
t #0, Speed 8GT/s, Width x16, ASPM L0s L1,
      Exit Latency L0s &lt;64ns, L1 &lt;1us<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ClockPM- S=
urprise- LLActRep- BwNot- ASPMOptComp+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl:=C2=A0=C2=A0=C2=A0 ASP=
M Disabled; RCB 64 bytes Disabled- CommClk+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtSynch- =
ClockPM- AutWidDis- BWInt- AutBWInt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta:=C2=A0=C2=A0=C2=A0 Spe=
ed 5GT/s, Width x4, TrErr- Train- SlotClk+
      DLActive- BWMgmt- ABWMgmt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: =
Not Supported, TimeoutDis-,
      LTR-, OBFF Not Supported<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: =
50us to 50ms, TimeoutDis-,
      LTR-, OBFF Disabled<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl2: Target Link Speed: 8=
GT/s, EnterCompliance-
      SpeedDis-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Tran=
smit Margin: Normal Operating Range,
      EnterModifiedCompliance- ComplianceSOS-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Comp=
liance De-emphasis: -6dB<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis =
Level: -3.5dB,
      EqualizationComplete-, EqualizationPhase1-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Equa=
lizationPhase2-, EqualizationPhase3-,
      LinkEqualizationRequest-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [a0] MSI: Enable- Count=3D1/1 Mask=
able- 64bit+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Address: 0000000000000000=C2=A0=
 Data: 0000<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Vendor Specific Informati=
on: ID=3D0001
      Rev=3D1 Len=3D010 &lt;?&gt;<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [150 v2] Advanced Error Reporting<=
br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UESta:=C2=A0=C2=A0=C2=A0 DLP-=
 SDES- TLP- FCP- CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UEMsk:=C2=A0=C2=A0=C2=A0 DLP-=
 SDES- TLP- FCP- CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UESvrt:=C2=A0=C2=A0=C2=A0 DLP=
+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CESta:=C2=A0=C2=A0=C2=A0 RxEr=
r- BadTLP- BadDLLP- Rollover- Timeout-
      NonFatalErr+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CEMsk:=C2=A0=C2=A0=C2=A0 RxEr=
r- BadTLP- BadDLLP- Rollover- Timeout-
      NonFatalErr+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 AERCap:=C2=A0=C2=A0=C2=A0 Fir=
st Error Pointer: 00, GenCap+ CGenEn-
      ChkCap+ ChkEn-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [200 v1] #15<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [270 v1] #19<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [2b0 v1] Address Translation Servi=
ce (ATS)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ATSCap:=C2=A0=C2=A0=C2=A0 Inv=
alidate Queue Depth: 00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ATSCtl:=C2=A0=C2=A0=C2=A0 Ena=
ble+, Smallest Translation Unit: 00<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [2c0 v1] #13<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [2d0 v1] #1b<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [328 v1] Alternative Routing-ID In=
terpretation
      (ARI)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ARICap:=C2=A0=C2=A0=C2=A0 MFV=
C- ACS-, Next Function: 1<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ARICtl:=C2=A0=C2=A0=C2=A0 MFV=
C- ACS-, Function Group: 0<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: vfio-pci<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: amdgpu<br>
      <br>
      05:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Tonga
      HDMI Audio [Radeon R9 285/380]<br>
      =C2=A0=C2=A0=C2=A0 Subsystem: Micro-Star International Co., Ltd. [M=
SI] Tonga HDMI
      Audio [Radeon R9 285/380]<br>
      =C2=A0=C2=A0=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV=
- VGASnoop-
      ParErr- Stepping- SERR- FastB2B- DisINTx-<br>
      =C2=A0=C2=A0=C2=A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=
=3Dfast
      &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-<br>
      =C2=A0=C2=A0=C2=A0 Latency: 0, Cache Line Size: 64 bytes<br>
      =C2=A0=C2=A0=C2=A0 Interrupt: pin B routed to IRQ 7<br>
      =C2=A0=C2=A0=C2=A0 Region 0: Memory at fe760000 (64-bit, non-prefet=
chable)
      [size=3D16K]<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [48] Vendor Specific Information: =
Len=3D08
      &lt;?&gt;<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [50] Power Management version 3<br=
>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Flags: PMEClk- DSI- D1+ D2+ A=
uxCurrent=3D0mA
      PME(D0-,D1-,D2-,D3hot-,D3cold-)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Status: D3 NoSoftRst+ PME-Ena=
ble- DSel=3D0 DScale=3D0 PME-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [58] Express (v2) Legacy Endpoint,=
 MSI 00<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap:=C2=A0=C2=A0=C2=A0 Max=
Payload 256 bytes, PhantFunc 0, Latency L0s
      &lt;4us, L1 unlimited<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtTag+ At=
tnBtn- AttnInd- PwrInd- RBE+ FLReset-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl:=C2=A0=C2=A0=C2=A0 Rep=
ort errors: Correctable- Non-Fatal- Fatal-
      Unsupported-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 RlxdOrd- E=
xtTag- PhantFunc- AuxPwr- NoSnoop+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 MaxPayload=
 128 bytes, MaxReadReq 512 bytes<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevSta:=C2=A0=C2=A0=C2=A0 Cor=
rErr+ UncorrErr- FatalErr- UnsuppReq+
      AuxPwr- TransPend-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCap:=C2=A0=C2=A0=C2=A0 Por=
t #0, Speed 8GT/s, Width x16, ASPM L0s L1,
      Exit Latency L0s &lt;64ns, L1 &lt;1us<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ClockPM- S=
urprise- LLActRep- BwNot- ASPMOptComp+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkCtl:=C2=A0=C2=A0=C2=A0 ASP=
M Disabled; RCB 64 bytes Disabled- CommClk+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ExtSynch- =
ClockPM- AutWidDis- BWInt- AutBWInt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta:=C2=A0=C2=A0=C2=A0 Spe=
ed 5GT/s, Width x4, TrErr- Train- SlotClk+
      DLActive- BWMgmt- ABWMgmt-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCap2: Completion Timeout: =
Not Supported, TimeoutDis-,
      LTR-, OBFF Not Supported<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 DevCtl2: Completion Timeout: =
50us to 50ms, TimeoutDis-,
      LTR-, OBFF Disabled<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 LnkSta2: Current De-emphasis =
Level: -3.5dB,
      EqualizationComplete-, EqualizationPhase1-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0Equa=
lizationPhase2-, EqualizationPhase3-,
      LinkEqualizationRequest-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [a0] MSI: Enable- Count=3D1/1 Mask=
able- 64bit+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Address: 0000000000000000=C2=A0=
 Data: 0000<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [100 v1] Vendor Specific Informati=
on: ID=3D0001
      Rev=3D1 Len=3D010 &lt;?&gt;<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [150 v2] Advanced Error Reporting<=
br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UESta:=C2=A0=C2=A0=C2=A0 DLP-=
 SDES- TLP- FCP- CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UEMsk:=C2=A0=C2=A0=C2=A0 DLP-=
 SDES- TLP- FCP- CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 UESvrt:=C2=A0=C2=A0=C2=A0 DLP=
+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
      UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CESta:=C2=A0=C2=A0=C2=A0 RxEr=
r- BadTLP- BadDLLP- Rollover- Timeout-
      NonFatalErr+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CEMsk:=C2=A0=C2=A0=C2=A0 RxEr=
r- BadTLP- BadDLLP- Rollover- Timeout-
      NonFatalErr+<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 AERCap:=C2=A0=C2=A0=C2=A0 Fir=
st Error Pointer: 00, GenCap+ CGenEn-
      ChkCap+ ChkEn-<br>
      =C2=A0=C2=A0=C2=A0 Capabilities: [328 v1] Alternative Routing-ID In=
terpretation
      (ARI)<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ARICap:=C2=A0=C2=A0=C2=A0 MFV=
C- ACS-, Next Function: 0<br>
      =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ARICtl:=C2=A0=C2=A0=C2=A0 MFV=
C- ACS-, Function Group: 0<br>
      =C2=A0=C2=A0=C2=A0 Kernel driver in use: vfio-pci<br>
      =C2=A0=C2=A0=C2=A0 Kernel modules: snd_hda_intel<br>
      <br>
      <br>
    </span><br>
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
    <br>
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
    <br>
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
  </body>
</html>

--------------000502060306050302080400--

--===============8142148186637650999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8142148186637650999==--
