From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: PROBLEM: intel_iommu=on under 4.13 breaks resume from suspend on
	my Thinkpad T560
Date: Thu, 28 Sep 2017 17:00:20 -0700
Message-ID: <20170929000019.GA102630@otc-nc-03>
References: <3fc58417-93ff-f5eb-e9af-57ad378c6241@jouchet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3fc58417-93ff-f5eb-e9af-57ad378c6241-RYxqDi3kOPxGWvitb5QawA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ronan Jouchet <ronan-RYxqDi3kOPxGWvitb5QawA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Ronan

has it worked ever with intel_iommu=on? 

This is on my list to look, but didn't get a chance to look into it. 

I suspect that after suspend, we do save some of the registers that might
loose context. But the driver needs to reinitialize the uarch states
again. for e.g. need to go through the set root table pointer commands
again. 

Although i see some an attempt to save some of the context, but
we aren't performing the ones like iommu_set_root_entry, enable_translation
etc again to reinitialize those states. 

will have someone look into it soon.


Cheers,
Ashok

On Thu, Sep 28, 2017 at 08:24:31PM -0400, Ronan Jouchet wrote:
> [1.] One line summary of the problem:
> 
> intel_iommu=on under 4.13 breaks resume from suspend on my Thinkpad T560
> 
> [2.] Full description of the problem/report:
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=197029
> 
> With intel_iommu=on, on my Thinkpad T560 laptop, suspend does work,
> but pressing on POWER / Enter / whatever key (which under 4.12 used
> to resume the system) doesn't resume.

> 
> Instead, the machine doesn't do anything: system remains suspended,
> the glowing LED keeps glowing, and my only option is to force a
> hard shutdown with a long press on POWER, and start the system again.
> 
> Turning intel_iommu=off from GRUB, I am able to successfully resume
> from suspend, like I used to be able to in 4.12.
> 
> [3.] Keywords (i.e., modules, networking, kernel):
> 
> suspend, resume, power management, laptop, lenovo, ibm, thinkpad, intel
> 
> [4.] Kernel information
> 
> [4.1.] Kernel version (from /proc/version):
> 
> Linux version 4.13.3-1-ARCH (builduser@tobias) (gcc version 7.2.0 (GCC)) #1
> SMP PREEMPT Thu Sep 21 20:33:16 CEST 2017
> 
>   and
> 
> Linux version 4.13.3-1-ARCH (builduser@tobias) (gcc version 7.2.0 (GCC)) #1
> SMP PREEMPT Thu Sep 21 20:33:16 CEST 2017
> 
> This is the official `linux` package currently in Arch's `testing` repo:
> https://www.archlinux.org/packages/testing/x86_64/linux/
> 
> [4.2.] Kernel .config file:
> 
> https://git.archlinux.org/svntogit/packages.git/tree/trunk/config.x86_64?h=packages/linux
> 
> [5.] Most recent kernel version which did not have the bug:
> 
> Official 4.12.13 from
> https://www.archlinux.org/packages/core/x86_64/linux/
> 
> [8.] Environment
> 
> [8.1.] Software (output of the ver_linux script)
> 
> Linux t 4.13.3-1-ARCH #1 SMP PREEMPT Thu Sep 21 20:33:16 CEST 2017 x86_64
> GNU/Linux
> 
> GNU C                   7.2.0
> GNU Make                4.2.1
> Binutils                2.29
> Util-linux              2.30.1
> Mount                   2.30.1
> Module-init-tools       24
> E2fsprogs               1.43.6
> Jfsutils                1.1.15
> Reiserfsprogs           3.6.25
> Xfsprogs                4.12.0
> Pcmciautils             018
> Linux C Library         2.26
> Dynamic linker (ldd)    2.26
> Linux C++ Library       6.0.24
> Procps                  3.3.12
> Net-tools               2.10
> Kbd                     2.0.4
> Console-tools           2.0.4
> Sh-utils                8.28
> Udev                    234
> Wireless-tools          30
> Modules Loaded          ac ac97_bus aesni_intel aes_x86_64 ahci arc4 atkbd
> battery bluetooth btbcm btintel btrtl btusb button cbc cfg80211 coretemp
> crc16 crc32c_intel crc32_pclmul crct10dif_pclmul cryptd crypto_simd drm
> drm_kms_helper e1000e ecdh_generic ecryptfs encrypted_keys evdev ext4
> fb_sys_fops fscrypto fuse ghash_clmulni_intel glue_helper hid hid_generic
> hid_logitech_dj hid_logitech_hidpp i2c_algo_bit i2c_i801 i8042 i915
> input_leds intel_cstate intel_gtt intel_pch_thermal intel_powerclamp
> intel_rapl intel_rapl_perf ip_tables irqbypass iTCO_vendor_support iTCO_wdt
> iwlmvm iwlwifi jbd2 joydev kvm kvm_intel led_class libahci libata libps2
> mac80211 mac_hid mbcache media mei mei_me mei_wdt memstick mmc_core mousedev
> nvram pcbc pci_stub pcspkr pps_core psmouse ptp rfkill rtsx_pci rtsx_pci_ms
> rtsx_pci_sdmmc sch_fq_codel scsi_mod sd_mod serio serio_raw sg shpchp snd
> snd_compress snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi
> snd_hda_codec_realtek snd_hda_core snd_hda_ext_core snd_hda_intel snd_hwdep
> snd_pcm snd_pcm_dmaengine snd_rawmidi snd_seq_device snd_soc_core
> snd_soc_skl snd_soc_skl_ipc snd_soc_sst_dsp snd_soc_sst_ipc
> snd_soc_sst_match snd_timer snd_usb_audio snd_usbmidi_lib soundcore
> syscopyarea sysfillrect sysimgblt thermal thinkpad_acpi tpm tpm_crb tpm_tis
> tpm_tis_core trusted usb_common usbcore usbhid uvcvideo vboxdrv vboxnetadp
> vboxnetflt vboxpci video videobuf2_core videobuf2_memops videobuf2_v4l2
> videobuf2_vmalloc videodev wmi wmi_bmof x86_pkg_temp_thermal xhci_hcd
> xhci_pci x_tables
> 
> [8.2.] Processor information (from /proc/cpuinfo):
> 
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 78
> model name      : Intel(R) Core(TM) i7-6600U CPU @ 2.60GHz
> stepping        : 3
> microcode       : 0xba
> cpu MHz         : 2800.000
> cache size      : 4096 KB
> physical id     : 0
> siblings        : 4
> core id         : 0
> cpu cores       : 2
> apicid          : 0
> initial apicid  : 0
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 22
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64
> monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
> sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
> lahf_lm abm 3dnowprefetch cpuid_fault epb intel_pt tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves
> dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
> bugs            :
> bogomips        : 5618.00
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 39 bits physical, 48 bits virtual
> power management:
> 
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 78
> model name      : Intel(R) Core(TM) i7-6600U CPU @ 2.60GHz
> stepping        : 3
> microcode       : 0xba
> cpu MHz         : 2800.000
> cache size      : 4096 KB
> physical id     : 0
> siblings        : 4
> core id         : 1
> cpu cores       : 2
> apicid          : 2
> initial apicid  : 2
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 22
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64
> monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
> sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
> lahf_lm abm 3dnowprefetch cpuid_fault epb intel_pt tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves
> dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
> bugs            :
> bogomips        : 5619.48
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 39 bits physical, 48 bits virtual
> power management:
> 
> processor       : 2
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 78
> model name      : Intel(R) Core(TM) i7-6600U CPU @ 2.60GHz
> stepping        : 3
> microcode       : 0xba
> cpu MHz         : 2800.000
> cache size      : 4096 KB
> physical id     : 0
> siblings        : 4
> core id         : 0
> cpu cores       : 2
> apicid          : 1
> initial apicid  : 1
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 22
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64
> monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
> sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
> lahf_lm abm 3dnowprefetch cpuid_fault epb intel_pt tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves
> dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
> bugs            :
> bogomips        : 5620.19
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 39 bits physical, 48 bits virtual
> power management:
> 
> processor       : 3
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 78
> model name      : Intel(R) Core(TM) i7-6600U CPU @ 2.60GHz
> stepping        : 3
> microcode       : 0xba
> cpu MHz         : 2800.000
> cache size      : 4096 KB
> physical id     : 0
> siblings        : 4
> core id         : 1
> cpu cores       : 2
> apicid          : 3
> initial apicid  : 3
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 22
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
> pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl
> xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64
> monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
> sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
> lahf_lm abm 3dnowprefetch cpuid_fault epb intel_pt tpr_shadow vnmi
> flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms
> invpcid rtm mpx rdseed adx smap clflushopt xsaveopt xsavec xgetbv1 xsaves
> dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
> bugs            :
> bogomips        : 5619.52
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 39 bits physical, 48 bits virtual
> power management:
> 
> [8.3.] Module information (from /proc/modules):
> 
> ecryptfs 81920 1 - Live 0xffffffffc0d09000
> cbc 16384 0 - Live 0xffffffffc0ca3000
> encrypted_keys 20480 1 ecryptfs, Live 0xffffffffc0ceb000
> trusted 20480 1 encrypted_keys, Live 0xffffffffc091a000
> hid_logitech_hidpp 32768 0 - Live 0xffffffffc0ce2000
> hid_logitech_dj 20480 0 - Live 0xffffffffc0921000
> uvcvideo 86016 0 - Live 0xffffffffc0cf3000
> snd_usb_audio 163840 0 - Live 0xffffffffc0cb9000
> videobuf2_vmalloc 16384 1 uvcvideo, Live 0xffffffffc0cb4000
> snd_usbmidi_lib 28672 1 snd_usb_audio, Live 0xffffffffc0ca8000
> snd_rawmidi 28672 1 snd_usbmidi_lib, Live 0xffffffffc0a7e000
> snd_seq_device 16384 1 snd_rawmidi, Live 0xffffffffc0915000
> videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0xffffffffc08ee000
> videobuf2_v4l2 20480 1 uvcvideo, Live 0xffffffffc08a6000
> videobuf2_core 36864 2 uvcvideo,videobuf2_v4l2, Live 0xffffffffc0a74000
> videodev 155648 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live
> 0xffffffffc0a4d000
> media 32768 2 uvcvideo,videodev, Live 0xffffffffc090c000
> joydev 20480 0 - Live 0xffffffffc0906000
> mousedev 20480 0 - Live 0xffffffffc08a0000
> snd_hda_codec_hdmi 49152 1 - Live 0xffffffffc0799000
> snd_hda_codec_realtek 77824 1 - Live 0xffffffffc0a39000
> snd_hda_codec_generic 69632 1 snd_hda_codec_realtek, Live 0xffffffffc088e000
> arc4 16384 2 - Live 0xffffffffc07d6000
> snd_soc_skl 73728 0 - Live 0xffffffffc08f3000
> snd_soc_skl_ipc 45056 1 snd_soc_skl, Live 0xffffffffc08e2000
> snd_soc_sst_ipc 16384 1 snd_soc_skl_ipc, Live 0xffffffffc0826000
> snd_soc_sst_dsp 24576 1 snd_soc_skl_ipc, Live 0xffffffffc0874000
> snd_hda_ext_core 20480 1 snd_soc_skl, Live 0xffffffffc081c000
> snd_soc_sst_match 16384 1 snd_soc_skl, Live 0xffffffffc0558000
> snd_soc_core 192512 1 snd_soc_skl, Live 0xffffffffc08b2000
> snd_compress 20480 1 snd_soc_core, Live 0xffffffffc07d0000
> snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0xffffffffc07cb000
> ac97_bus 16384 1 snd_soc_core, Live 0xffffffffc07a8000
> intel_rapl 20480 0 - Live 0xffffffffc08ac000
> x86_pkg_temp_thermal 16384 0 - Live 0xffffffffc0883000
> intel_powerclamp 16384 0 - Live 0xffffffffc07ba000
> coretemp 16384 0 - Live 0xffffffffc07b1000
> kvm_intel 192512 0 - Live 0xffffffffc0a09000
> iwlmvm 299008 0 - Live 0xffffffffc0e40000
> i915 1683456 51 - Live 0xffffffffc0b07000
> kvm 516096 1 kvm_intel, Live 0xffffffffc0a88000
> mac80211 688128 1 iwlmvm, Live 0xffffffffc0960000
> irqbypass 16384 1 kvm, Live 0xffffffffc087e000
> crct10dif_pclmul 16384 0 - Live 0xffffffffc0889000
> crc32_pclmul 16384 0 - Live 0xffffffffc0674000
> crc32c_intel 24576 0 - Live 0xffffffffc07c4000
> ghash_clmulni_intel 16384 0 - Live 0xffffffffc07bf000
> iTCO_wdt 16384 0 - Live 0xffffffffc0516000
> iwlwifi 212992 1 iwlmvm, Live 0xffffffffc092b000
> iTCO_vendor_support 16384 1 iTCO_wdt, Live 0xffffffffc05f8000
> mei_wdt 16384 0 - Live 0xffffffffc05ee000
> pcbc 16384 0 - Live 0xffffffffc059e000
> drm_kms_helper 131072 1 i915, Live 0xffffffffc06f4000
> wmi_bmof 16384 0 - Live 0xffffffffc05b2000
> snd_hda_intel 36864 6 - Live 0xffffffffc069f000
> aesni_intel 184320 50733 - Live 0xffffffffc0846000
> aes_x86_64 20480 1 aesni_intel, Live 0xffffffffc066e000
> crypto_simd 16384 1 aesni_intel, Live 0xffffffffc05b7000
> glue_helper 16384 1 aesni_intel, Live 0xffffffffc05f3000
> cryptd 20480 25369 ghash_clmulni_intel,aesni_intel,crypto_simd, Live
> 0xffffffffc0500000
> e1000e 225280 0 - Live 0xffffffffc07e4000
> snd_hda_codec 106496 4
> snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,
> Live 0xffffffffc082b000
> intel_cstate 16384 0 - Live 0xffffffffc051b000
> evdev 24576 33 - Live 0xffffffffc07dd000
> cfg80211 532480 3 iwlmvm,mac80211,iwlwifi, Live 0xffffffffc0716000
> drm 303104 10 i915,drm_kms_helper, Live 0xffffffffc06a9000
> intel_rapl_perf 16384 0 - Live 0xffffffffc060e000
> snd_hda_core 65536 7 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_soc_skl,snd_hda_ext_core,snd_hda_intel,snd_hda_codec,
> Live 0xffffffffc068e000
> snd_hwdep 20480 2 snd_usb_audio,snd_hda_codec, Live 0xffffffffc0529000
> intel_gtt 20480 1 i915, Live 0xffffffffc0520000
> rtsx_pci_ms 20480 0 - Live 0xffffffffc0684000
> input_leds 16384 0 - Live 0xffffffffc067f000
> ptp 20480 1 e1000e, Live 0xffffffffc0679000
> syscopyarea 16384 1 drm_kms_helper, Live 0xffffffffc05fd000
> sysfillrect 16384 1 drm_kms_helper, Live 0xffffffffc05db000
> snd_pcm 86016 9 snd_usb_audio,snd_hda_codec_hdmi,snd_soc_skl,snd_hda_ext_core,snd_soc_core,snd_pcm_dmaengine,snd_hda_intel,snd_hda_codec,snd_hda_core,
> Live 0xffffffffc0658000
> psmouse 135168 0 - Live 0xffffffffc0636000
> memstick 16384 1 rtsx_pci_ms, Live 0xffffffffc05e9000
> sysimgblt 16384 1 drm_kms_helper, Live 0xffffffffc05e4000
> pcspkr 16384 0 - Live 0xffffffffc0590000
> mac_hid 16384 0 - Live 0xffffffffc05a3000
> fuse 94208 7 - Live 0xffffffffc061e000
> pps_core 20480 1 ptp, Live 0xffffffffc04b1000
> fb_sys_fops 16384 1 drm_kms_helper, Live 0xffffffffc0572000
> i2c_i801 24576 0 - Live 0xffffffffc0613000
> snd_timer 28672 1 snd_pcm, Live 0xffffffffc0606000
> mei_me 36864 1 - Live 0xffffffffc05a8000
> mei 81920 3 mei_wdt,mei_me, Live 0xffffffffc05c1000
> i2c_algo_bit 16384 1 i915, Live 0xffffffffc05bc000
> shpchp 32768 0 - Live 0xffffffffc0595000
> intel_pch_thermal 16384 0 - Live 0xffffffffc0531000
> thermal 20480 0 - Live 0xffffffffc0561000
> thinkpad_acpi 77824 1 - Live 0xffffffffc057c000
> nvram 16384 1 thinkpad_acpi, Live 0xffffffffc0577000
> snd 73728 27 snd_usb_audio,snd_usbmidi_lib,snd_rawmidi,snd_seq_device,snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_soc_core,snd_compress,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer,thinkpad_acpi,
> Live 0xffffffffc0545000
> wmi 20480 1 wmi_bmof, Live 0xffffffffc053b000
> tpm_crb 16384 0 - Live 0xffffffffc0536000
> soundcore 16384 1 snd, Live 0xffffffffc0511000
> tpm_tis 16384 0 - Live 0xffffffffc0508000
> led_class 16384 3 iwlmvm,input_leds,thinkpad_acpi, Live 0xffffffffc04a6000
> battery 20480 0 - Live 0xffffffffc04ab000
> ac 16384 0 - Live 0xffffffffc05d6000
> video 36864 2 i915,thinkpad_acpi, Live 0xffffffffc0568000
> button 16384 1 i915, Live 0xffffffffc04c3000
> tpm_tis_core 20480 1 tpm_tis, Live 0xffffffffc03fb000
> tpm 49152 4 trusted,tpm_crb,tpm_tis,tpm_tis_core, Live 0xffffffffc04d3000
> hid_generic 16384 0 - Live 0xffffffffc03f1000
> usbhid 45056 0 - Live 0xffffffffc049a000
> hid 114688 4 hid_logitech_hidpp,hid_logitech_dj,hid_generic,usbhid, Live
> 0xffffffffc04e3000
> btusb 40960 0 - Live 0xffffffffc04c8000
> btrtl 16384 1 btusb, Live 0xffffffffc04be000
> btbcm 16384 1 btusb, Live 0xffffffffc04b9000
> btintel 16384 1 btusb, Live 0xffffffffc03f6000
> bluetooth 479232 4 btusb,btrtl,btbcm,btintel, Live 0xffffffffc0424000
> ecdh_generic 24576 1 bluetooth, Live 0xffffffffc0401000
> rfkill 20480 7 cfg80211,thinkpad_acpi,bluetooth, Live 0xffffffffc025e000
> sch_fq_codel 20480 6 - Live 0xffffffffc041e000
> vboxnetflt 28672 0 - Live 0xffffffffc0412000 (O)
> vboxnetadp 28672 0 - Live 0xffffffffc040a000 (O)
> pci_stub 16384 1 - Live 0xffffffffc020f000
> vboxpci 24576 0 - Live 0xffffffffc02cc000 (O)
> vboxdrv 385024 3 vboxnetflt,vboxnetadp,vboxpci, Live 0xffffffffc0392000 (O)
> sg 36864 0 - Live 0xffffffffc02a1000
> ip_tables 24576 0 - Live 0xffffffffc0257000
> x_tables 32768 1 ip_tables, Live 0xffffffffc0298000
> ext4 557056 1 - Live 0xffffffffc0309000
> crc16 16384 2 bluetooth,ext4, Live 0xffffffffc0214000
> mbcache 16384 1 ext4, Live 0xffffffffc017b000
> jbd2 90112 1 ext4, Live 0xffffffffc02f2000
> fscrypto 24576 1 ext4, Live 0xffffffffc01da000
> sd_mod 49152 5 - Live 0xffffffffc01cd000
> rtsx_pci_sdmmc 24576 0 - Live 0xffffffffc0208000
> mmc_core 122880 1 rtsx_pci_sdmmc, Live 0xffffffffc02d3000
> serio_raw 16384 0 - Live 0xffffffffc0176000
> atkbd 24576 0 - Live 0xffffffffc018e000
> libps2 16384 2 psmouse,atkbd, Live 0xffffffffc0189000
> ahci 36864 4 - Live 0xffffffffc02c2000
> libahci 28672 1 ahci, Live 0xffffffffc02b6000
> xhci_pci 16384 0 - Live 0xffffffffc02ad000
> libata 208896 2 ahci,libahci, Live 0xffffffffc0264000
> xhci_hcd 188416 1 xhci_pci, Live 0xffffffffc0228000
> rtsx_pci 49152 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0xffffffffc021b000
> scsi_mod 155648 3 sg,sd_mod,libata, Live 0xffffffffc01e1000
> usbcore 208896 7
> uvcvideo,snd_usb_audio,snd_usbmidi_lib,usbhid,btusb,xhci_pci,xhci_hcd, Live
> 0xffffffffc0199000
> usb_common 16384 1 usbcore, Live 0xffffffffc0171000
> i8042 24576 0 - Live 0xffffffffc0182000
> serio 20480 7 psmouse,serio_raw,atkbd,i8042, Live 0xffffffffc0167000
> 
> [8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> 
> /proc/ioports:
> 
> 0000-0000 : PCI Bus 0000:00
>   0000-0000 : dma1
>   0000-0000 : pic1
>   0000-0000 : timer0
>   0000-0000 : timer1
>   0000-0000 : keyboard
>   0000-0000 : PNP0800:00
>   0000-0000 : PNP0C09:00
>     0000-0000 : EC data
>   0000-0000 : keyboard
>   0000-0000 : PNP0C09:00
>     0000-0000 : EC cmd
>   0000-0000 : rtc0
>   0000-0000 : dma page reg
>   0000-0000 : pic2
>   0000-0000 : dma2
>   0000-0000 : fpu
>   0000-0000 : vesafb
>   0000-0000 : iTCO_wdt
>     0000-0000 : iTCO_wdt
>   0000-0000 : pnp 00:01
>   0000-0000 : pnp 00:01
>   0000-0000 : pnp 00:01
>   0000-0000 : pnp 00:01
>   0000-0000 : pnp 00:01
>   0000-0000 : pnp 00:01
>   0000-0000 : pnp 00:01
>   0000-0000 : pnp 00:01
> 0000-0000 : PCI conf1
> 0000-0000 : PCI Bus 0000:00
>   0000-0000 : pnp 00:01
>   0000-0000 : pnp 00:01
>     0000-0000 : pnp 00:01
>   0000-0000 : pnp 00:01
>     0000-0000 : ACPI PM1a_EVT_BLK
>     0000-0000 : ACPI PM1a_CNT_BLK
>     0000-0000 : ACPI PM_TMR
>     0000-0000 : ACPI CPU throttle
>     0000-0000 : iTCO_wdt
>       0000-0000 : iTCO_wdt
>     0000-0000 : ACPI PM2_CNT_BLK
>     0000-0000 : pnp 00:05
>     0000-0000 : ACPI GPE0_BLK
>   0000-0000 : 0000:00:02.0
>   0000-0000 : 0000:00:17.0
>     0000-0000 : ahci
>   0000-0000 : 0000:00:17.0
>     0000-0000 : ahci
>   0000-0000 : 0000:00:17.0
>     0000-0000 : ahci
>   0000-0000 : 0000:00:1f.4
>     0000-0000 : i801_smbus
>   0000-0000 : pnp 00:07
> 
> /proc/iomem:
> 
> 00000000-00000000 : Reserved
> 00000000-00000000 : System RAM
> 00000000-00000000 : Reserved
> 00000000-00000000 : PCI Bus 0000:00
> 00000000-00000000 : Video ROM
> 00000000-00000000 : pnp 00:00
> 00000000-00000000 : pnp 00:00
> 00000000-00000000 : pnp 00:00
> 00000000-00000000 : pnp 00:00
> 00000000-00000000 : Reserved
>   00000000-00000000 : System ROM
> 00000000-00000000 : System RAM
> 00000000-00000000 : Reserved
> 00000000-00000000 : ACPI Non-volatile Storage
> 00000000-00000000 : Reserved
> 00000000-00000000 : ACPI Non-volatile Storage
> 00000000-00000000 : Reserved
> 00000000-00000000 : ACPI Non-volatile Storage
> 00000000-00000000 : ACPI Tables
> 00000000-00000000 : Reserved
>   00000000-00000000 : MSFT0101:00
>     00000000-00000000 : MSFT0101:00
>     00000000-00000000 : MSFT0101:00
> 00000000-00000000 : Reserved
>   00000000-00000000 : Graphics Stolen Memory
> 00000000-00000000 : PCI Bus 0000:00
>   00000000-00000000 : 0000:00:02.0
>   00000000-00000000 : 0000:00:02.0
>   00000000-00000000 : PCI Bus 0000:04
>     00000000-00000000 : 0000:04:00.0
>       00000000-00000000 : iwlwifi
>   00000000-00000000 : PCI Bus 0000:02
>     00000000-00000000 : 0000:02:00.0
>       00000000-00000000 : rtsx_pci
>   00000000-00000000 : 0000:00:1f.6
>     00000000-00000000 : e1000e
>   00000000-00000000 : 0000:00:14.0
>     00000000-00000000 : xhci-hcd
>   00000000-00000000 : 0000:00:1f.3
>     00000000-00000000 : ICH HD audio
>   00000000-00000000 : 0000:00:1f.3
>     00000000-00000000 : ICH HD audio
>   00000000-00000000 : 0000:00:1f.2
>   00000000-00000000 : 0000:00:17.0
>     00000000-00000000 : ahci
>   00000000-00000000 : 0000:00:08.0
>   00000000-00000000 : 0000:00:14.2
>     00000000-00000000 : Intel PCH thermal driver
>   00000000-00000000 : 0000:00:16.0
>     00000000-00000000 : mei_me
>   00000000-00000000 : 0000:00:17.0
>     00000000-00000000 : ahci
>   00000000-00000000 : 0000:00:1f.4
>   00000000-00000000 : 0000:00:17.0
>     00000000-00000000 : ahci
>   00000000-00000000 : pnp 00:01
>   00000000-00000000 : PCI MMCONFIG 0000 [bus 00-3f]
>     00000000-00000000 : Reserved
>       00000000-00000000 : pnp 00:01
>   00000000-00000000 : Reserved
>     00000000-00000000 : pnp 00:06
>     00000000-00000000 : pnp 00:06
>     00000000-00000000 : pnp 00:06
>       00000000-00000000 : iTCO_wdt
>         00000000-00000000 : iTCO_wdt
>     00000000-00000000 : pnp 00:06
>     00000000-00000000 : pnp 00:06
>     00000000-00000000 : pnp 00:06
>     00000000-00000000 : pnp 00:06
>   00000000-00000000 : pnp 00:01
> 00000000-00000000 : Reserved
>   00000000-00000000 : IOAPIC 0
> 00000000-00000000 : Reserved
>   00000000-00000000 : HPET 0
>     00000000-00000000 : PNP0103:00
> 00000000-00000000 : Reserved
>   00000000-00000000 : pnp 00:01
>   00000000-00000000 : pnp 00:01
>   00000000-00000000 : pnp 00:01
> 00000000-00000000 : pnp 00:01
> 00000000-00000000 : MSFT0101:00
>   00000000-00000000 : MSFT0101:00
> 00000000-00000000 : Reserved
> 00000000-00000000 : dmar0
> 00000000-00000000 : dmar1
> 00000000-00000000 : Local APIC
>   00000000-00000000 : Reserved
> 00000000-00000000 : Reserved
> 00000000-00000000 : System RAM
>   00000000-00000000 : Kernel code
>   00000000-00000000 : Kernel data
>   00000000-00000000 : Kernel bss
> 00000000-00000000 : RAM buffer
> 
> [8.5.] PCI information ('lspci -vvv' as root)
> 
> 00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen
> Core Processor Host Bridge/DRAM Registers (rev 08)
>         Subsystem: Lenovo Device 2231
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR- INTx-
>         Latency: 0
>         Capabilities: [e0] Vendor Specific Information: Len=10 <?>
>         Kernel driver in use: skl_uncore
> 
> 00:02.0 VGA compatible controller: Intel Corporation HD Graphics 520 (rev
> 07) (prog-if 00 [VGA controller])
>         Subsystem: Lenovo Device 2231
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 128
>         Region 0: Memory at e0000000 (64-bit, non-prefetchable) [size=16M]
>         Region 2: Memory at c0000000 (64-bit, prefetchable) [size=512M]
>         Region 4: I/O ports at e000 [size=64]
>         [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
>         Capabilities: [40] Vendor Specific Information: Len=0c <?>
>         Capabilities: [70] Express (v2) Root Complex Integrated Endpoint,
> MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0
>                         ExtTag- RBE+
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
> TransPend-
>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis-,
> LTR-, OBFF Not Supported
>                 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,
> LTR-, OBFF Disabled
>                 AtomicOpsCtl: ReqEn-
>         Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
>                 Address: fee00018  Data: 0000
>         Capabilities: [d0] Power Management version 2
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [100 v1] Process Address Space ID (PASID)
>                 PASIDCap: Exec+ Priv-, Max PASID Width: 14
>                 PASIDCtl: Enable- Exec- Priv-
>         Capabilities: [200 v1] Address Translation Service (ATS)
>                 ATSCap: Invalidate Queue Depth: 00
>                 ATSCtl: Enable-, Smallest Translation Unit: 00
>         Capabilities: [300 v1] Page Request Interface (PRI)
>                 PRICtl: Enable- Reset-
>                 PRISta: RF- UPRGI- Stopped-
>                 Page Request Capacity: 00008000, Page Request Allocation:
> 00000000
>         Kernel driver in use: i915
>         Kernel modules: i915
> 
> 00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5
> / 6th/7th Gen Core Processor Gaussian Mixture Model
>         Subsystem: Lenovo Device 2231
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 255
>         Region 0: Memory at e124a000 (64-bit, non-prefetchable) [size=4K]
>         Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
>                 Address: 00000000  Data: 0000
>         Capabilities: [dc] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [f0] PCI Advanced Features
>                 AFCap: TP+ FLR+
>                 AFCtrl: FLR-
>                 AFStatus: TP-
> 
> 00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI
> Controller (rev 21) (prog-if 30 [XHCI])
>         Subsystem: Lenovo Device 2231
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 123
>         Region 0: Memory at e1220000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [70] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
>                 Address: 00000000fee00258  Data: 0000
>         Kernel driver in use: xhci_hcd
>         Kernel modules: xhci_pci
> 
> 00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP
> Thermal subsystem (rev 21)
>         Subsystem: Lenovo Device 2231
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin C routed to IRQ 18
>         Region 0: Memory at e124b000 (64-bit, non-prefetchable) [size=4K]
>         Capabilities: [50] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>                 Address: 00000000  Data: 0000
>         Kernel driver in use: intel_pch_thermal
>         Kernel modules: intel_pch_thermal
> 
> 00:16.0 Communication controller: Intel Corporation Sunrise Point-LP CSME
> HECI #1 (rev 21)
>         Subsystem: Lenovo Device 2231
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 125
>         Region 0: Memory at e124c000 (64-bit, non-prefetchable) [size=4K]
>         Capabilities: [50] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee00298  Data: 0000
>         Kernel driver in use: mei_me
>         Kernel modules: mei_me
> 
> 00:17.0 SATA controller: Intel Corporation Sunrise Point-LP SATA Controller
> [AHCI mode] (rev 21) (prog-if 01 [AHCI 1.0])
>         Subsystem: Lenovo Device 2231
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 124
>         Region 0: Memory at e1248000 (32-bit, non-prefetchable) [size=8K]
>         Region 1: Memory at e124f000 (32-bit, non-prefetchable) [size=256]
>         Region 2: I/O ports at e080 [size=8]
>         Region 3: I/O ports at e088 [size=4]
>         Region 4: I/O ports at e060 [size=32]
>         Region 5: Memory at e124d000 (32-bit, non-prefetchable) [size=2K]
>         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>                 Address: fee00278  Data: 0000
>         Capabilities: [70] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
>         Kernel driver in use: ahci
>         Kernel modules: ahci
> 
> 00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port
> #1 (rev f1) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 16
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>         I/O behind bridge: 0000f000-00000fff [empty]
>         Memory behind bridge: e1100000-e11fffff [size=1M]
>         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> [empty]
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0
>                         ExtTag- RBE+
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                 LnkCap: Port #1, Speed 8GT/s, Width x1, ASPM L1, Exit
> Latency L0s <1us, L1 <16us
>                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive+ BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surprise-
>                         Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power-
> Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>                         Changed: MRL- PresDet- LinkState+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
> OBFF Not Supported ARIFwd+
>                 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,
> LTR+, OBFF Disabled ARIFwd-
>                 AtomicOpsCtl: ReqEn- EgressBlck-
>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-
> SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>                 Address: 00000000  Data: 0000
>         Capabilities: [90] Subsystem: Lenovo Device 2231
>         Capabilities: [a0] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn-
>         Capabilities: [140 v1] Access Control Services
>                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
> UpstreamFwd- EgressCtrl- DirectTrans-
>                 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir-
> UpstreamFwd- EgressCtrl- DirectTrans-
>         Capabilities: [200 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>                           PortCommonModeRestoreTime=40us
> PortTPowerOnTime=44us
>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                            T_CommonMode=60us LTR1.2_Threshold=163840ns
>                 L1SubCtl2: T_PwrOn=60us
>         Capabilities: [220 v1] #19
>         Kernel driver in use: pcieport
>         Kernel modules: shpchp
> 
> 00:1c.2 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port
> #3 (rev f1) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin C routed to IRQ 18
>         Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>         I/O behind bridge: 0000f000-00000fff [empty]
>         Memory behind bridge: e1000000-e10fffff [size=1M]
>         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> [empty]
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0
>                         ExtTag- RBE+
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                 LnkCap: Port #3, Speed 8GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s <1us, L1 <16us
>                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive+ BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
> Surprise-
>                         Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
> HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power-
> Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
> Interlock-
>                         Changed: MRL- PresDet- LinkState+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
> CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR+,
> OBFF Not Supported ARIFwd+
>                 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,
> LTR+, OBFF Disabled ARIFwd-
>                 AtomicOpsCtl: ReqEn- EgressBlck-
>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance-
> SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
>                 Address: 00000000  Data: 0000
>         Capabilities: [90] Subsystem: Lenovo Device 2231
>         Capabilities: [a0] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt+
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn-
>         Capabilities: [140 v1] Access Control Services
>                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
> UpstreamFwd- EgressCtrl- DirectTrans-
>                 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir-
> UpstreamFwd- EgressCtrl- DirectTrans-
>         Capabilities: [200 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>                           PortCommonModeRestoreTime=40us
> PortTPowerOnTime=44us
>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                            T_CommonMode=40us LTR1.2_Threshold=163840ns
>                 L1SubCtl2: T_PwrOn=44us
>         Capabilities: [220 v1] #19
>         Kernel driver in use: pcieport
>         Kernel modules: shpchp
> 
> 00:1f.0 ISA bridge: Intel Corporation Sunrise Point-LP LPC Controller (rev
> 21)
>         Subsystem: Lenovo Device 2231
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
> 
> 00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
>         Subsystem: Lenovo Device 2231
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Region 0: Memory at e1244000 (32-bit, non-prefetchable) [size=16K]
>         Kernel driver in use: intel_pmc_core
> 
> 00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
>         Subsystem: Lenovo Device 2231
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 64
>         Interrupt: pin A routed to IRQ 126
>         Region 0: Memory at e1240000 (64-bit, non-prefetchable) [size=16K]
>         Region 4: Memory at e1230000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [50] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee002b8  Data: 0000
>         Kernel driver in use: snd_hda_intel
>         Kernel modules: snd_hda_intel, snd_soc_skl
> 
> 00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
>         Subsystem: Lenovo Device 2231
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at e124e000 (64-bit, non-prefetchable) [size=256]
>         Region 4: I/O ports at efa0 [size=32]
>         Kernel driver in use: i801_smbus
>         Kernel modules: i2c_i801
> 
> 00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection I219-LM
> (rev 21)
>         Subsystem: Lenovo Device 2233
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 129
>         Region 0: Memory at e1200000 (32-bit, non-prefetchable) [size=128K]
>         Capabilities: [c8] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee002f8  Data: 0000
>         Capabilities: [e0] PCI Advanced Features
>                 AFCap: TP+ FLR+
>                 AFCtrl: FLR-
>                 AFStatus: TP-
>         Kernel driver in use: e1000e
>         Kernel modules: e1000e
> 
> 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A PCI
> Express Card Reader (rev 01)
>         Subsystem: Lenovo Device 2233
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 122
>         Region 0: Memory at e1100000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee00238  Data: 0000
>         Capabilities: [70] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> SlotPowerLimit 10.000W
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
> Latency L0s unlimited, L1 <64us
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis+,
> LTR+, OBFF Via message/WAKE#
>                 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,
> LTR+, OBFF Disabled
>                 AtomicOpsCtl: ReqEn-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
> SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+
> ChkEn-
>         Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
>         Capabilities: [150 v1] Latency Tolerance Reporting
>                 Max snoop latency: 3145728ns
>                 Max no snoop latency: 3145728ns
>         Capabilities: [158 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>                           PortCommonModeRestoreTime=60us
> PortTPowerOnTime=60us
>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                            T_CommonMode=0us LTR1.2_Threshold=163840ns
>                 L1SubCtl2: T_PwrOn=60us
>         Kernel driver in use: rtsx_pci
>         Kernel modules: rtsx_pci
> 
> 04:00.0 Network controller: Intel Corporation Wireless 8260 (rev 3a)
>         Subsystem: Intel Corporation Device 1130
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 127
>         Region 0: Memory at e1000000 (64-bit, non-prefetchable) [size=8K]
>         Capabilities: [c8] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee002d8  Data: 0000
>         Capabilities: [40] Express (v2) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <512ns, L1 unlimited
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> SlotPowerLimit 0.000W
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
> FLReset-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
> TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L1, Exit
> Latency L0s <4us, L1 <8us
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range B, TimeoutDis+, LTR+,
> OBFF Via WAKE#
>                 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis-,
> LTR+, OBFF Disabled
>                 AtomicOpsCtl: ReqEn-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
> SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -3.5dB,
> EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap-
> ChkEn-
>         Capabilities: [140 v1] Device Serial Number 44-85-00-ff-ff-c8-79-d1
>         Capabilities: [14c v1] Latency Tolerance Reporting
>                 Max snoop latency: 3145728ns
>                 Max no snoop latency: 3145728ns
>         Capabilities: [154 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> L1_PM_Substates+
>                           PortCommonModeRestoreTime=30us
> PortTPowerOnTime=18us
>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                            T_CommonMode=0us LTR1.2_Threshold=163840ns
>                 L1SubCtl2: T_PwrOn=44us
>         Kernel driver in use: iwlwifi
>         Kernel modules: iwlwifi
> 
> [8.6.] SCSI information (from /proc/scsi/scsi)
> 
> Attached devices:
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: ATA      Model: Samsung SSD 850  Rev: 2B6Q
>   Type:   Direct-Access                    ANSI  SCSI revision: 05
> 
> [X. Other notes]
> 
> X.1. this is my first kernel bug report. I'm doing my best
>      to follow the guidelines, but may be imprecise or missing
>      debug info. Please ask if this is the case. Thanks.
>      I remain available for follow-up and testing.
> 
> X.2. This is a follow-up to downstream discussion:
>      - Arch bbs talk: https://bbs.archlinux.org/viewtopic.php?pid=1737688
>      - Arch bug: https://bugs.archlinux.org/task/55705
> 
> X.3. Over at the Arch bbs, someone suggested I try
>      `intel_iommu=igfx_off` rather than full `intel_iommu=off`.
>      It's not enough; even with `intel_iommu=igfx_off`,
>      resume is broken.
> 
>      Same person on Arch bbs suggested my bug might be related to
>      https://bugs.freedesktop.org/show_bug.cgi?id=89360
> 
> X.4. Several reports of the same problem on Reddit:
> 
> https://www.reddit.com/r/archlinux/comments/72z2rv/linux_41331_is_in_core/dnmjaeo/
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
