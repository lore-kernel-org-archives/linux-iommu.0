From: =?gb2312?B?t7a2rLas?= <fandd-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>
Subject: cpu hot-remove bug
Date: Tue, 16 Jun 2015 04:44:19 +0000
Message-ID: <42BB8332972FC149B81C55A0D41E3A79C0535D@jtjnmailbox06.home.langchao.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: zh-CN
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedeljoro <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: =?gb2312?B?wfWzpMn6?= <liuchangsheng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>, =?gb2312?B?48bP/rfl?= <yanxiaofeng-6gUaA8visnnQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi maintainer,

We found a problem that a panic happen when cpu was hot-removed. We also trace the problem according to the calltrace information. 
An endless loop happen because value head is not equal to value tail forever in the function qi_check_fault( ). 
The location code is as follows: 


do { 
        if (qi->desc_status[head] == QI_IN_USE) 
        qi->desc_status[head] = QI_ABORT; 
        head = (head - 2 + QI_LENGTH) % QI_LENGTH; 
    } while (head != tail); 



Follow is the panic information: 

[root@localhost ~]lscpu 
Architecture: x86_64 
CPU op-mode(s): 32-bit, 64-bit 
Byte Order: Little Endian 
CPU(s): 120 
On-line CPU(s) list: 0-119 
Thread(s) per core: 2 
Core(s) per socket: 15 
Socket(s): 4 
NUMA node(s): 1 
Vendor ID: GenuineIntel 
CPU family: 6 
Model: 62 
Model name: Intel(R) Xeon(R) CPU E7-8880 v2 @ 2.50GHz 
Stepping: 7 
CPU MHz: 2973.535 
BogoMIPS: 5008.11 
Virtualization: VT-x 
L1d cache: 32K 
L1i cache: 32K 
L2 cache: 256K 
L3 cache: 38400K 
NUMA node0 CPU(s): 0-119 
[root@localhost ~]# echo 1 > /sys/firmware/acpi/hotplug/force_remove 
[root@localhost ~]# echo 1 > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0004:01/eject 
[ 138.217913] intel_pstate CPU 15 exiting 
[ 138.249976] kvm: disabling virtualization on CPU15 
[ 138.256008] smpboot: CPU 15 is now offline 
[ 138.364245] intel_pstate CPU 75 exiting 
[ 138.389285] Broke affinity for irq 47 
[ 138.394433] kvm: disabling virtualization on CPU75 
[ 138.400193] smpboot: CPU 75 is now offline 
[ 139.119913] intel_pstate CPU 16 exiting 
[ 139.146122] kvm: disabling virtualization on CPU16 
[ 139.159401] smpboot: CPU 16 is now offline 
[ 139.183872] intel_pstate CPU 76 exiting 
[ 139.215591] kvm: disabling virtualization on CPU76 
[ 139.221226] smpboot: CPU 76 is now offline 
[ 139.971687] intel_pstate CPU 17 exiting 
[ 140.003541] kvm: disabling virtualization on CPU17 
[ 140.009286] smpboot: CPU 17 is now offline 
[ 140.038648] intel_pstate CPU 77 exiting 
[ 140.064705] kvm: disabling virtualization on CPU77 
[ 140.070292] smpboot: CPU 77 is now offline 
[ 140.291735] intel_pstate CPU 18 exiting 
[ 140.306457] kvm: disabling virtualization on CPU18 
[ 140.314712] smpboot: CPU 18 is now offline 
[ 140.343928] intel_pstate CPU 78 exiting 
[ 140.369473] kvm: disabling virtualization on CPU78 
[ 140.378172] smpboot: CPU 78 is now offline 
[ 140.522952] intel_pstate CPU 19 exiting 
[ 140.537781] kvm: disabling virtualization on CPU19 
[ 140.545436] smpboot: CPU 19 is now offline 
[ 140.571167] intel_pstate CPU 79 exiting 
[ 140.591320] kvm: disabling virtualization on CPU79 
[ 140.597138] smpboot: CPU 79 is now offline 
[ 140.735166] intel_pstate CPU 20 exiting 
[ 140.750057] kvm: disabling virtualization on CPU20 
[ 140.755738] smpboot: CPU 20 is now offline 
[ 140.780342] intel_pstate CPU 80 exiting 
[ 140.797354] kvm: disabling virtualization on CPU80 
[ 140.803083] smpboot: CPU 80 is now offline 
[ 140.937355] intel_pstate CPU 21 exiting 
[ 140.955338] kvm: disabling virtualization on CPU21 
[ 140.962774] smpboot: CPU 21 is now offline 
[ 140.985552] intel_pstate CPU 81 exiting 
[ 141.002056] kvm: disabling virtualization on CPU81 
[ 141.007721] smpboot: CPU 81 is now offline 
[ 141.181624] intel_pstate CPU 22 exiting 
[ 141.199390] kvm: disabling virtualization on CPU22 
[ 141.205059] smpboot: CPU 22 is now offline 
[ 141.230659] intel_pstate CPU 82 exiting 
[ 141.250371] kvm: disabling virtualization on CPU82 
[ 141.256080] smpboot: CPU 82 is now offline 
[ 141.405812] intel_pstate CPU 23 exiting 
[ 141.420677] kvm: disabling virtualization on CPU23 
[ 141.426406] smpboot: CPU 23 is now offline 
[ 141.450894] intel_pstate CPU 83 exiting 
[ 141.467542] kvm: disabling virtualization on CPU83 
[ 141.473283] smpboot: CPU 83 is now offline 
[ 141.654099] intel_pstate CPU 24 exiting 
[ 141.669299] kvm: disabling virtualization on CPU24 
[ 141.674959] smpboot: CPU 24 is now offline 
[ 141.701252] intel_pstate CPU 84 exiting 
[ 141.723850] kvm: disabling virtualization on CPU84 
[ 141.732427] smpboot: CPU 84 is now offline 
[ 141.871268] intel_pstate CPU 25 exiting 
[ 141.883049] kvm: disabling virtualization on CPU25 
[ 141.888690] smpboot: CPU 25 is now offline 
[ 141.915392] intel_pstate CPU 85 exiting 
[ 141.935412] kvm: disabling virtualization on CPU85 
[ 141.941056] smpboot: CPU 85 is now offline 
[ 142.102551] intel_pstate CPU 26 exiting 
[ 142.120636] kvm: disabling virtualization on CPU26 
[ 142.129233] smpboot: CPU 26 is now offline 
[ 142.152582] intel_pstate CPU 86 exiting 
[ 142.171197] Broke affinity for irq 27 
[ 142.176406] kvm: disabling virtualization on CPU86 
[ 142.181977] smpboot: CPU 86 is now offline 
[ 142.339730] intel_pstate CPU 27 exiting 
[ 142.354745] kvm: disabling virtualization on CPU27 
[ 142.362048] smpboot: CPU 27 is now offline 
[ 142.387910] intel_pstate CPU 87 exiting 
[ 142.403435] Broke affinity for irq 16 
[ 142.408612] kvm: disabling virtualization on CPU87 
[ 142.414266] smpboot: CPU 87 is now offline 
[ 142.558938] intel_pstate CPU 28 exiting 
[ 142.570570] kvm: disabling virtualization on CPU28 
[ 142.577692] smpboot: CPU 28 is now offline 
[ 142.600045] intel_pstate CPU 88 exiting 
[ 142.615597] Broke affinity for irq 48 
[ 142.620738] kvm: disabling virtualization on CPU88 
[ 142.626425] smpboot: CPU 88 is now offline 
[ 142.765143] intel_pstate CPU 29 exiting 
[ 142.780261] kvm: disabling virtualization on CPU29 
[ 142.788962] smpboot: CPU 29 is now offline 
[ 142.799788] intel_pstate CPU 89 exiting 
[ 142.819354] Broke affinity for irq 40 
[ 142.824553] kvm: disabling virtualization on CPU89 
[ 142.830219] smpboot: CPU 89 is now offline 



[ 149.972781] memory is not present 
[ 149.976493] acpi ACPI0004:01: Still not present 
[ 149.995783] memory is not present 

[root@localhost ~]# 
[ 197.532857] Kernel panic - not syncing: Watchdog detected hard LOCKUP on cpu 64 
[ 197.541032] CPU: 64 PID: 2081 Comm: irqbalance Not tainted 4.1.0-rc1+ #29 
[ 197.561245] 0000000000000000 00000000aa448ad2 ffff88046e205a90 ffffffff816a432a 
[ 197.569555] 0000000000000000 ffffffff818e9f78 ffff88046e205b10 ffffffff8169f1dc 
[ 197.577858] 0000000000000010 ffff88046e205b20 ffff88046e205ac0 00000000aa448ad2 
[ 197.586166] Call Trace: 
[ 197.588896] <NMI> [<ffffffff816a432a>] dump_stack+0x45/0x57 
[ 197.595343] [<ffffffff8169f1dc>] panic+0xd0/0x204 
[ 197.600699] [<ffffffff81134540>] ? restart_watchdog_hrtimer+0x60/0x60 
[ 197.607991] [<ffffffff811345ff>] watchdog_overflow_callback+0xbf/0xc0 
[ 197.615286] [<ffffffff81176bec>] __perf_event_overflow+0x9c/0x250 
[ 197.622182] [<ffffffff811777c4>] perf_event_overflow+0x14/0x20 
[ 197.628799] [<ffffffff81035952>] intel_pmu_handle_irq+0x1f2/0x480 
[ 197.635709] [<ffffffff81319b21>] ? ioremap_page_range+0x281/0x400 
[ 197.642617] [<ffffffff811bf84c>] ? vunmap_page_range+0x1bc/0x2e0 
[ 197.649427] [<ffffffff811bf981>] ? unmap_kernel_range_noflush+0x11/0x20 
[ 197.656915] [<ffffffff813e080a>] ? ghes_copy_tofrom_phys+0x12a/0x210 
[ 197.664104] [<ffffffff813e0990>] ? ghes_read_estatus+0xa0/0x190 
[ 197.670817] [<ffffffff8102bf0b>] perf_event_nmi_handler+0x2b/0x50 
[ 197.677725] [<ffffffff81019130>] nmi_handle+0x90/0x130 
[ 197.683562] [<ffffffff810196ba>] default_do_nmi+0x4a/0x140 
[ 197.689788] [<ffffffff81019838>] do_nmi+0x88/0xc0 
[ 197.695141] [<ffffffff816ade2f>] end_repeat_nmi+0x1e/0x2e 
[ 197.701274] [<ffffffff8144bd87>] ? qi_submit_sync+0x217/0x3f0 
[ 197.707790] [<ffffffff8144bd87>] ? qi_submit_sync+0x217/0x3f0 
[ 197.714308] [<ffffffff8144bd87>] ? qi_submit_sync+0x217/0x3f0 
[ 197.720815] <<EOE>> [<ffffffff814533b2>] modify_irte+0xa2/0xf0 
[ 197.727541] [<ffffffff814537c1>] intel_ioapic_set_affinity+0x141/0x1e0 
[ 197.734933] [<ffffffff81453de0>] set_remapped_irq_affinity+0x20/0x30 
[ 197.742123] [<ffffffff810d6dec>] irq_do_set_affinity+0x1c/0x70 
[ 197.748738] [<ffffffff810d6fd8>] irq_set_affinity_locked+0xa8/0xe0 
[ 197.755732] [<ffffffff810d705a>] __irq_set_affinity+0x4a/0x80 
[ 197.762252] [<ffffffff810db1f9>] write_irq_affinity.isra.3+0x119/0x140 
[ 197.769643] [<ffffffff810db259>] irq_affinity_proc_write+0x19/0x20 
[ 197.776649] [<ffffffff8126525d>] proc_reg_write+0x3d/0x80 
[ 197.782777] [<ffffffff811b8e25>] ? do_mmap_pgoff+0x2f5/0x3c0 
[ 197.789200] [<ffffffff811fa277>] __vfs_write+0x37/0x110 
[ 197.795137] [<ffffffff811fd148>] ? __sb_start_write+0x58/0x110 
[ 197.801753] [<ffffffff812a3133>] ? security_file_permission+0x23/0xa0 
[ 197.809046] [<ffffffff811fa9a9>] vfs_write+0xa9/0x1b0 
[ 197.814796] [<ffffffff8102368c>] ? do_audit_syscall_entry+0x6c/0x70 
[ 197.821887] [<ffffffff811fb855>] SyS_write+0x55/0xd0 
[ 197.827534] [<ffffffff81066cb0>] ? do_page_fault+0x30/0x80 
[ 197.833762] [<ffffffff816abaee>] system_call_fastpath+0x12/0x71 
[ 197.840610] Kernel Offset: disabled 
[ 197.844505] drm_kms_helper: panic occurred, switching back to text console 
[ 197.852238] ------------[ cut here ]------------ 
[ 197.857401] WARNING: CPU: 64 PID: 0 at arch/x86/kernel/smp.c:124 native_smp_send_reschedule+0x5d/0x60() 
[ 197.867895] Modules linked in: xt_CHECKSUM ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT nf_reject_ipv4 nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables ip6table_mangle ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_mangle iptable_security iptable_raw iptable_filter ip_tables sg vfat fat x86_pkg_temp_thermal coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel lrw sb_edac gf128mul iTCO_wdt edac_core iTCO_vendor_support i2c_i801 glue_helper ablk_helper lpc_ich mfd_core pcspkr cryptd ipmi_si ipmi_msghandler shpchp nfsd auth_rpcgss nfs_acl lockd grace uinput sunrpc xfs libcrc32c sd_mod mgag200 syscopyarea sysfillre
 ct sysimgblt i2c_algo_bit drm_kms_helper ttm drm ahci libahci libata i2c_core dm_mirror dm_region_hash dm_log dm_mod 
[ 197.958056] CPU: 64 PID: 0 Comm: swapper/64 Not tainted 4.1.0-rc1+ #29 
[ 197.977976] 0000000000000000 4d09e50dfaab2c41 ffff88046e203d58 ffffffff816a432a 
[ 197.986281] 0000000000000000 0000000000000000 ffff88046e203d98 ffffffff8107b1fa 
[ 197.994585] ffff88046e203d98 0000000000000000 ffff88046d217580 0000000000000040 
[ 198.002892] Call Trace: 
[ 198.005622] <IRQ> [<ffffffff816a432a>] dump_stack+0x45/0x57 
[ 198.012059] [<ffffffff8107b1fa>] warn_slowpath_common+0x8a/0xc0 
[ 198.018771] [<ffffffff8107b32a>] warn_slowpath_null+0x1a/0x20 
[ 198.025288] [<ffffffff8104e96d>] native_smp_send_reschedule+0x5d/0x60 
[ 198.032583] [<ffffffff810ba9b5>] trigger_load_balance+0x145/0x1f0 
[ 198.039490] [<ffffffff810a7ccc>] scheduler_tick+0x9c/0xe0 
[ 198.045612] [<ffffffff810e6a61>] update_process_times+0x51/0x60 
[ 198.052325] [<ffffffff810f6ed5>] tick_sched_handle.isra.18+0x25/0x60 
[ 198.059511] [<ffffffff810f6f54>] tick_sched_timer+0x44/0x80 
[ 198.065834] [<ffffffff810e7777>] __run_hrtimer+0x77/0x1d0 
[ 198.071961] [<ffffffff810f6f10>] ? tick_sched_handle.isra.18+0x60/0x60 
[ 198.079351] [<ffffffff810e7b53>] hrtimer_interrupt+0x103/0x230 
[ 198.085966] [<ffffffff81051729>] local_apic_timer_interrupt+0x39/0x60 
[ 198.093250] [<ffffffff816ae8f5>] smp_apic_timer_interrupt+0x45/0x60 
[ 198.100351] [<ffffffff816ac9be>] apic_timer_interrupt+0x6e/0x80 
[ 198.107050] <EOI> [<ffffffff810b2fc9>] ? pick_next_entity+0xa9/0x190 
[ 198.114358] [<ffffffff810a3dec>] ? finish_task_switch+0x6c/0x1a0 
[ 198.121168] [<ffffffff816a727c>] __schedule+0x2cc/0x910 
[ 198.127102] [<ffffffff816a78f7>] schedule+0x37/0x90 
[ 198.132649] [<ffffffff816a7c2e>] schedule_preempt_disabled+0xe/0x10 
[ 198.139747] [<ffffffff810c0c4b>] cpu_startup_entry+0x1bb/0x480 
[ 198.146360] [<ffffffff810f44fc>] ? clockevents_register_device+0xec/0x1c0 
[ 198.154043] [<ffffffff8104f7b3>] start_secondary+0x173/0x1e0 
[ 198.160463] ---[ end trace a332d23455636d1e ]--- 
[ 198.184372] ------------[ cut here ]------------ 
[ 198.189537] WARNING: CPU: 64 PID: 2081 at kernel/time/timer.c:1096 del_timer_sync+0x36/0x60() 
[ 198.199061] Modules linked in: xt_CHECKSUM ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ipt_REJECT nf_reject_ipv4 nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables ip6table_mangle ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_mangle iptable_security iptable_raw iptable_filter ip_tables sg vfat fat x86_pkg_temp_thermal coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel lrw sb_edac gf128mul iTCO_wdt edac_core iTCO_vendor_support i2c_i801 glue_helper ablk_helper lpc_ich mfd_core pcspkr cryptd ipmi_si ipmi_msghandler shpchp nfsd auth_rpcgss nfs_acl lockd grace uinput sunrpc xfs libcrc32c sd_mod mgag200 syscopyarea sysfillre
 ct sysimgblt i2c_algo_bit drm_kms_helper ttm drm ahci libahci libata i2c_core dm_mirror dm_region_hash dm_log dm_mod 
[ 198.289205] CPU: 64 PID: 2081 Comm: irqbalance Tainted: G W 4.1.0-rc1+ #29 
[ 198.310777] 0000000000000000 00000000aa448ad2 ffff88046e205530 ffffffff816a432a 
[ 198.319082] 0000000000000000 0000000000000000 ffff88046e205570 ffffffff8107b1fa 
[ 198.327387] ffff88046a992910 ffff88046e2055d0 ffff88046e2055d0 00000000fffe6ab5 
[ 198.335691] Call Trace: 
[ 198.338421] <NMI> [<ffffffff816a432a>] dump_stack+0x45/0x57 
[ 198.344850] [<ffffffff8107b1fa>] warn_slowpath_common+0x8a/0xc0 
[ 198.351563] [<ffffffff8107b32a>] warn_slowpath_null+0x1a/0x20 
[ 198.358080] [<ffffffff810e5ba6>] del_timer_sync+0x36/0x60 
[ 198.364209] [<ffffffff816aa886>] schedule_timeout+0x156/0x280 
[ 198.370726] [<ffffffff813193bc>] ? idr_alloc+0x8c/0x100 
[ 198.376663] [<ffffffff810e41c0>] ? internal_add_timer+0xb0/0xb0 
[ 198.383373] [<ffffffff810e6197>] msleep+0x37/0x50 
[ 198.388731] [<ffffffffa01a96ee>] mga_crtc_prepare+0x16e/0x380 [mgag200] 
[ 198.396228] [<ffffffffa0166988>] drm_crtc_helper_set_mode+0x318/0x5a0 [drm_kms_helper] 
[ 198.405181] [<ffffffffa0167a42>] drm_crtc_helper_set_config+0x892/0xab0 [drm_kms_helper] 
[ 198.414342] [<ffffffffa00dc03f>] drm_mode_set_config_internal+0x6f/0x110 [drm] 
[ 198.422518] [<ffffffffa0172538>] restore_fbdev_mode+0xc8/0xf0 [drm_kms_helper] 
[ 198.430691] [<ffffffffa0172705>] drm_fb_helper_force_kernel_mode+0x75/0xb0 [drm_kms_helper] 
[ 198.440125] [<ffffffffa0173409>] drm_fb_helper_panic+0x29/0x30 [drm_kms_helper] 
[ 198.448391] [<ffffffff8109be5e>] notifier_call_chain+0x4e/0x80 
[ 198.455004] [<ffffffff8109beca>] atomic_notifier_call_chain+0x1a/0x20 
[ 198.462298] [<ffffffff8169f209>] panic+0xfd/0x204 
[ 198.467651] [<ffffffff81134540>] ? restart_watchdog_hrtimer+0x60/0x60 
[ 198.474944] [<ffffffff811345ff>] watchdog_overflow_callback+0xbf/0xc0 
[ 198.482237] [<ffffffff81176bec>] __perf_event_overflow+0x9c/0x250 
[ 198.489141] [<ffffffff811777c4>] perf_event_overflow+0x14/0x20 
[ 198.495755] [<ffffffff81035952>] intel_pmu_handle_irq+0x1f2/0x480 
[ 198.502660] [<ffffffff81319b21>] ? ioremap_page_range+0x281/0x400 
[ 198.509566] [<ffffffff811bf84c>] ? vunmap_page_range+0x1bc/0x2e0 
[ 198.516366] [<ffffffff811bf981>] ? unmap_kernel_range_noflush+0x11/0x20 
[ 198.523852] [<ffffffff813e080a>] ? ghes_copy_tofrom_phys+0x12a/0x210 
[ 198.531048] [<ffffffff813e0990>] ? ghes_read_estatus+0xa0/0x190 
[ 198.537758] [<ffffffff8102bf0b>] perf_event_nmi_handler+0x2b/0x50 
[ 198.544663] [<ffffffff81019130>] nmi_handle+0x90/0x130 
[ 198.550499] [<ffffffff810196ba>] default_do_nmi+0x4a/0x140 
[ 198.556724] [<ffffffff81019838>] do_nmi+0x88/0xc0 
[ 198.562077] [<ffffffff816ade2f>] end_repeat_nmi+0x1e/0x2e 
[ 198.568208] [<ffffffff8144bd87>] ? qi_submit_sync+0x217/0x3f0 
[ 198.574724] [<ffffffff8144bd87>] ? qi_submit_sync+0x217/0x3f0 
[ 198.581241] [<ffffffff8144bd87>] ? qi_submit_sync+0x217/0x3f0 
[ 198.587755] <<EOE>> [<ffffffff814533b2>] modify_irte+0xa2/0xf0 
[ 198.594480] [<ffffffff814537c1>] intel_ioapic_set_affinity+0x141/0x1e0 
[ 198.601870] [<ffffffff81453de0>] set_remapped_irq_affinity+0x20/0x30 
[ 198.609066] [<ffffffff810d6dec>] irq_do_set_affinity+0x1c/0x70 
[ 198.615679] [<ffffffff810d6fd8>] irq_set_affinity_locked+0xa8/0xe0 
[ 198.622681] [<ffffffff810d705a>] __irq_set_affinity+0x4a/0x80 
[ 198.629198] [<ffffffff810db1f9>] write_irq_affinity.isra.3+0x119/0x140 
[ 198.636589] [<ffffffff810db259>] irq_affinity_proc_write+0x19/0x20 
[ 198.643590] [<ffffffff8126525d>] proc_reg_write+0x3d/0x80 
[ 198.649716] [<ffffffff811b8e25>] ? do_mmap_pgoff+0x2f5/0x3c0 
[ 198.656136] [<ffffffff811fa277>] __vfs_write+0x37/0x110 
[ 198.662069] [<ffffffff811fd148>] ? __sb_start_write+0x58/0x110 
[ 198.668684] [<ffffffff812a3133>] ? security_file_permission+0x23/0xa0 
[ 198.675978] [<ffffffff811fa9a9>] vfs_write+0xa9/0x1b0 
[ 198.681716] [<ffffffff8102368c>] ? do_audit_syscall_entry+0x6c/0x70 
[ 198.688814] [<ffffffff811fb855>] SyS_write+0x55/0xd0 
[ 198.694456] [<ffffffff81066cb0>] ? do_page_fault+0x30/0x80 
[ 198.700682] [<ffffffff816abaee>] system_call_fastpath+0x12/0x71 
[ 198.707392] ---[ end trace a332d23455636d1f ]--- 
