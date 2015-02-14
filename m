From: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:406
	__arm_lpae_unmap()
Date: Sun, 15 Feb 2015 07:20:24 +0800
Message-ID: <20150214232024.GA4959@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKP <lkp-JC7UmRfGjtg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git revert-d347efeb16d3d5150cb7f8d50b05f388b572840e-fe4b991dcd84e0104cf2e29223a819335ed048a7

commit fe4b991dcd84e0104cf2e29223a819335ed048a7
Author:     Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
AuthorDate: Mon Nov 17 23:31:12 2014 +0000
Commit:     Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
CommitDate: Mon Jan 19 14:46:44 2015 +0000

    iommu: add self-consistency tests to ARM LPAE IO page table allocator
    
    This patch adds a series of basic self-consistency tests to the ARM LPAE
    IO page table allocator that exercise corner cases in map/unmap, as well
    as testing all valid configurations of pagesize, ias and stage.
    
    Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

===================================================
PARENT COMMIT NOT CLEAN. LOOK OUT FOR WRONG BISECT!
===================================================

Attached dmesg for the parent commit, too, to help confirm whether it is a noise error.

+--------------------------------------------------------------------+------------+------------+------------+
|                                                                    | e1d3c0fd70 | fe4b991dcd | 5df9cec997 |
+--------------------------------------------------------------------+------------+------------+------------+
| boot_successes                                                     | 0          | 0          | 0          |
| boot_failures                                                      | 80         | 20         | 12         |
| Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes   | 31         | 1          |            |
| backtrace:async_run_entry_fn                                       | 7          |            |            |
| backtrace:serio_handle_event                                       | 23         | 1          |            |
| backtrace:do_fork                                                  | 1          |            |            |
| backtrace:kthreadd                                                 | 1          |            |            |
| WARNING:at_net/netlink/genetlink.c:#genl_unbind()                  | 49         | 19         |            |
| backtrace:do_group_exit                                            | 49         | 19         |            |
| backtrace:SyS_exit_group                                           | 49         | 19         |            |
| backtrace:SYSC_socketcall                                          | 19         | 9          |            |
| backtrace:SyS_socketcall                                           | 19         | 9          |            |
| WARNING:at_drivers/iommu/io-pgtable-arm.c:#__arm_lpae_unmap()      | 0          | 20         | 12         |
| WARNING:at_drivers/iommu/io-pgtable-arm.c:#arm_lpae_do_selftests() | 0          | 20         | 12         |
| backtrace:arm_lpae_do_selftests                                    | 0          | 20         | 12         |
| backtrace:kernel_init_freeable                                     | 0          | 20         | 12         |
+--------------------------------------------------------------------+------------+------------+------------+

[    1.206747] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 36
[    1.208654] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS 40
[    1.210010] ------------[ cut here ]------------
[    1.213340] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:406 __arm_lpae_unmap+0xa8/0x321()
[    1.216671] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.19.0-rc4-00003-gfe4b991 #13
[    1.220002] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-20140531_083030-gandalf 04/01/2014
[    1.222875]  00000000 00000000 d3485e08 c1531d71 00000000 d3485e24 c1039f0d 00000196
[    1.227986]  c12e00db d3541ab0 00000000 00000000 d3485e34 c1039faa 00000009 00000000
[    1.231315]  d3485e90 c12e00db 00000080 80000000 d3485ed0 0000000c d3603000 00600000
[    1.234642] Call Trace:
[    1.236674]  [<c1531d71>] dump_stack+0x48/0x60
[    1.240005]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.241548]  [<c12e00db>] ? __arm_lpae_unmap+0xa8/0x321
[    1.243098]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[    1.243337]  [<c12e00db>] __arm_lpae_unmap+0xa8/0x321
[    1.244832]  [<c12dfe9f>] ? arm_lpae_map+0xa4/0xaf
[    1.246670]  [<c12e036f>] arm_lpae_unmap+0x1b/0x35
[    1.250004]  [<c18b8c71>] arm_lpae_do_selftests+0x1e0/0x394
[    1.253337]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.254867]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.256343]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.256670]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.258145]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.260004]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.261530]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.263337]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.266670]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.270003]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.271405]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.272983]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.273345] ---[ end trace f84d29e8c6948694 ]---
[    1.274808] ------------[ cut here ]------------

git bisect start 5df9cec997d8ec7a9906587401d1cdc6548511d6 bfa76d49576599a4b9f9b7a71f23d73d6dcff735 --
git bisect  bad 77246d1c9e1faeb5772f5361d2d7ba8901f80916  # 05:42      0-      1  Merge 'kees/aslr/stack' into devel-roam-rand-201502150502
git bisect good 1261c83ef4f1fc6aa4589dac9dc8ee050b54e0c8  # 05:46     20+     11  0day base guard for 'devel-roam-rand-201502150502'
git bisect good b5596c896580a30afb55d9b449d5c434f2bad9b5  # 05:49     20+      0  Merge 'renesas/devel' into devel-roam-rand-201502150502
git bisect good c5ce28df0e7c01a1de23c36ebdefcd803f2b6cbb  # 05:52     20+     12  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good aa7ed01f93ff7e149cad46f13f66b269d59c9bc0  # 05:54     20+      1  Merge tag 'mmc-v3.20-1' of git://git.linaro.org/people/ulf.hansson/mmc
git bisect good 12df4289ee8e4dccf932b7186b391bb6d2b915fa  # 05:57     20+     20  Merge tag 'ktest-v3.20' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest
git bisect  bad 802ea9d8645d33d24b7b4cd4537c14f3e698bde0  # 06:00      0-     20  Merge tag 'dm-3.20-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm
git bisect  bad a26be149facb22d30cd92cadb26f651d6fe802c9  # 06:03      0-     20  Merge tag 'iommu-updates-v3.20' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
git bisect good 42cf0f203e877cc7e502883d43b3f72149033d86  # 06:06     20+      6  Merge branch 'for-linus' of git://ftp.arm.linux.org.uk/~rmk/linux-arm
git bisect  bad a20cc76b9efae10c20123049df361adcd7f0e0b3  # 06:08      0-      7  Merge branches 'arm/renesas', 'arm/smmu', 'arm/omap', 'ppc/pamu', 'x86/amd' and 'core' into next
git bisect  bad bb590c9011a7c4e195af486438ead666023f96bd  # 06:11      0-     12  iommu/ipmmu-vmsa: Fix IOMMU lookup when multiple IOMMUs are registered
git bisect  bad 16753322983bcca0eca6d81f20d23277df0d6cf7  # 06:14      0-     20  Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
git bisect  bad c896c132b01895fd1445d178e36155b671c6f9ee  # 06:16      0-     18  iommu: io-pgtable-arm: add non-secure quirk
git bisect good e1d3c0fd701df831169b116cd5c5d6203ac07f70  # 06:25     20+     20  iommu: add ARM LPAE page table allocator
git bisect  bad fe4b991dcd84e0104cf2e29223a819335ed048a7  # 06:27      0-      1  iommu: add self-consistency tests to ARM LPAE IO page table allocator
# first bad commit: [fe4b991dcd84e0104cf2e29223a819335ed048a7] iommu: add self-consistency tests to ARM LPAE IO page table allocator
git bisect good e1d3c0fd701df831169b116cd5c5d6203ac07f70  # 06:31     60+     80  iommu: add ARM LPAE page table allocator
# extra tests with DEBUG_INFO
git bisect good fe4b991dcd84e0104cf2e29223a819335ed048a7  # 06:37     60+     60  iommu: add self-consistency tests to ARM LPAE IO page table allocator
# extra tests on HEAD of linux-devel/devel-roam-rand-201502150502
git bisect  bad 5df9cec997d8ec7a9906587401d1cdc6548511d6  # 06:37      0-     12  0day head guard for 'devel-roam-rand-201502150502'
# extra tests on tree/branch linus/master
git bisect  bad d347efeb16d3d5150cb7f8d50b05f388b572840e  # 06:37      0-      2  mutex: remove unused field "name" in debug mode
# extra tests with first bad commit reverted
# extra tests on tree/branch linus/master
git bisect  bad d347efeb16d3d5150cb7f8d50b05f388b572840e  # 06:40      0-      2  mutex: remove unused field "name" in debug mode
# extra tests on tree/branch next/master
git bisect  bad b8acf73194186a5cba86812eb4ba17b897f0e13e  # 06:44      0-     20  Add linux-next specific files for 20150213


This script may reproduce the error.

----------------------------------------------------------------------------
#!/bin/bash

kernel=$1
initrd=yocto-minimal-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/initrd/$initrd

kvm=(
	qemu-system-x86_64
	-cpu kvm64
	-enable-kvm
	-kernel $kernel
	-initrd $initrd
	-m 320
	-smp 1
	-net nic,vlan=1,model=e1000
	-net user,vlan=1
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null 
)

append=(
	hung_task_panic=1
	earlyprintk=ttyS0,115200
	rd.udev.log-priority=err
	systemd.log_target=journal
	systemd.log_level=warning
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	console=ttyS0,115200
	console=tty0
	vga=normal
	root=/dev/ram0
	rw
	drbd.minor_count=8
)

"${kvm[@]}" --append "${append[*]}"
----------------------------------------------------------------------------

Thanks,
Fengguang

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-yocto-client1-20:20150215062606:i386-randconfig-r2-0215:3.19.0-rc4-00003-gfe4b991:13"
Content-Transfer-Encoding: quoted-printable

early console in setup code
early console in decompress_kernel

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.19.0-rc4-00003-gfe4b991 (kbuild@roam) (gcc v=
ersion 4.9.1 (Debian 4.9.1-19) ) #13 SMP Sun Feb 15 06:25:25 CST 2015
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000013fdffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000013fe0000-0x0000000013ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-2014=
0531_083030-gandalf 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x13fe0 max_arch_pfn =3D 0x1000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC =20
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f0ed0-0x000f0edf] mapped at =
[c00f0ed0]
[    0.000000]   mpc: f0ee0-f0fb0
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] initial memory mapped: [mem 0x00000000-0x01dfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x13a00000-0x13bfffff]
[    0.000000]  [mem 0x13a00000-0x13bfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x139fffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x139fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x13c00000-0x13fdffff]
[    0.000000]  [mem 0x13c00000-0x13dfffff] page 2M
[    0.000000]  [mem 0x13e00000-0x13fdffff] page 4k
[    0.000000] BRK [0x0197c000, 0x0197cfff] PGTABLE
[    0.000000] BRK [0x0197d000, 0x0197dfff] PGTABLE
[    0.000000] BRK [0x0197e000, 0x0197efff] PGTABLE
[    0.000000] RAMDISK: [mem 0x13ca5000-0x13fd7fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000F0CF0 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x13FE1854 000034 (v01 BOCHS  BXPCRSDT 00000001 B=
XPC 00000001)
[    0.000000] ACPI: FACP 0x13FE0B37 000074 (v01 BOCHS  BXPCFACP 00000001 B=
XPC 00000001)
[    0.000000] ACPI: DSDT 0x13FE0040 000AF7 (v01 BOCHS  BXPCDSDT 00000001 B=
XPC 00000001)
[    0.000000] ACPI: FACS 0x13FE0000 000040
[    0.000000] ACPI: SSDT 0x13FE0BAB 000BF9 (v01 BOCHS  BXPCSSDT 00000001 B=
XPC 00000001)
[    0.000000] ACPI: APIC 0x13FE17A4 000078 (v01 BOCHS  BXPCAPIC 00000001 B=
XPC 00000001)
[    0.000000] ACPI: HPET 0x13FE181C 000038 (v01 BOCHS  BXPCHPET 00000001 B=
XPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffc000 (        fee00000)
[    0.000000] 319MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 13fe0000
[    0.000000]   low ram: 0 - 13fe0000
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:13fdf001, primary cpu clock
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   Normal   [mem 0x01000000-0x13fdffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009efff]
[    0.000000]   node   0: [mem 0x00100000-0x13fdffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x13fdffff]
[    0.000000] On node 0 totalpages: 81790
[    0.000000] free_area_init_node: node 0, pgdat c187ff80, node_mem_map d3=
a25020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 608 pages used for memmap
[    0.000000]   Normal zone: 77792 pages, LIFO batch:15
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffc000 (        fee00000)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC =
INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC =
INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC =
INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC =
INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC =
INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC =
INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC =
INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC =
INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC =
INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC =
INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC =
INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC =
INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC =
INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC =
INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC =
INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffb000 (fec00000)
[    0.000000] e820: [mem 0x14000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:1 nr_=
node_ids:1
[    0.000000] PERCPU: Embedded 13 pages/cpu @d3a18000 s30144 r0 d23104 u53=
248
[    0.000000] pcpu-alloc: s30144 r0 d23104 u53248 alloc=3D13*4096
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 13a1b680
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 81150
[    0.000000] Kernel command line: hung_task_panic=3D1 earlyprintk=3DttyS0=
,115200 rd.udev.log-priority=3Derr systemd.log_target=3Djournal systemd.log=
_level=3Dwarning debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_s=
tall_timeout=3D100 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oop=
s=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 console=3DttyS0,115200 consol=
e=3Dtty0 vga=3Dnormal  root=3D/dev/ram0 rw link=3D/kbuild-tests/run-queue/k=
vm/i386-randconfig-r2-0215/linux-devel:devel-roam-rand-201502150502:fe4b991=
dcd84e0104cf2e29223a819335ed048a7:bisect-linux-8/.vmlinuz-fe4b991dcd84e0104=
cf2e29223a819335ed048a7-20150215062532-12-client1 branch=3Dlinux-devel/deve=
l-roam-rand-201502150502 BOOT_IMAGE=3D/kernel/i386-randconfig-r2-0215/fe4b9=
91dcd84e0104cf2e29223a819335ed048a7/vmlinuz-3.19.0-rc4-00003-gfe4b991 drbd.=
minor_count=3D8
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[    0.000000] Initializing CPU#0
[    0.000000] Memory: 311052K/327160K available (5346K kernel code, 720K r=
wdata, 2700K rodata, 508K init, 344K bss, 16108K reserved, 0K cma-reserved)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xffd36000 - 0xfffff000   (2852 kB)
[    0.000000]     vmalloc : 0xd47e0000 - 0xffd34000   ( 693 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd3fe0000   ( 319 MB)
[    0.000000]       .init : 0xc1893000 - 0xc1912000   ( 508 kB)
[    0.000000]       .data : 0xc1538e49 - 0xc1891100   (3424 kB)
[    0.000000]       .text : 0xc1000000 - 0xc1538e49   (5347 kB)
[    0.000000] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.000000] SLUB: HWalign=3D128, Order=3D0-3, MinObjects=3D0, CPUs=3D1, =
Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D1
[    0.000000] NR_IRQS:2304 nr_irqs:256 16
[    0.000000] CPU 0 irqstacks, hard=3Dd3410000 soft=3Dd3412000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] bootconsole [earlyser0] disabled
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.19.0-rc4-00003-gfe4b991 (kbuild@roam) (gcc v=
ersion 4.9.1 (Debian 4.9.1-19) ) #13 SMP Sun Feb 15 06:25:25 CST 2015
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000013fdffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000013fe0000-0x0000000013ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-2014=
0531_083030-gandalf 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x13fe0 max_arch_pfn =3D 0x1000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC =20
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f0ed0-0x000f0edf] mapped at =
[c00f0ed0]
[    0.000000]   mpc: f0ee0-f0fb0
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] initial memory mapped: [mem 0x00000000-0x01dfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x13a00000-0x13bfffff]
[    0.000000]  [mem 0x13a00000-0x13bfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x139fffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x139fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x13c00000-0x13fdffff]
[    0.000000]  [mem 0x13c00000-0x13dfffff] page 2M
[    0.000000]  [mem 0x13e00000-0x13fdffff] page 4k
[    0.000000] BRK [0x0197c000, 0x0197cfff] PGTABLE
[    0.000000] BRK [0x0197d000, 0x0197dfff] PGTABLE
[    0.000000] BRK [0x0197e000, 0x0197efff] PGTABLE
[    0.000000] RAMDISK: [mem 0x13ca5000-0x13fd7fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000F0CF0 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x13FE1854 000034 (v01 BOCHS  BXPCRSDT 00000001 B=
XPC 00000001)
[    0.000000] ACPI: FACP 0x13FE0B37 000074 (v01 BOCHS  BXPCFACP 00000001 B=
XPC 00000001)
[    0.000000] ACPI: DSDT 0x13FE0040 000AF7 (v01 BOCHS  BXPCDSDT 00000001 B=
XPC 00000001)
[    0.000000] ACPI: FACS 0x13FE0000 000040
[    0.000000] ACPI: SSDT 0x13FE0BAB 000BF9 (v01 BOCHS  BXPCSSDT 00000001 B=
XPC 00000001)
[    0.000000] ACPI: APIC 0x13FE17A4 000078 (v01 BOCHS  BXPCAPIC 00000001 B=
XPC 00000001)
[    0.000000] ACPI: HPET 0x13FE181C 000038 (v01 BOCHS  BXPCHPET 00000001 B=
XPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffc000 (        fee00000)
[    0.000000] 319MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 13fe0000
[    0.000000]   low ram: 0 - 13fe0000
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:13fdf001, primary cpu clock
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   Normal   [mem 0x01000000-0x13fdffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009efff]
[    0.000000]   node   0: [mem 0x00100000-0x13fdffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x13fdffff]
[    0.000000] On node 0 totalpages: 81790
[    0.000000] free_area_init_node: node 0, pgdat c187ff80, node_mem_map d3=
a25020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 608 pages used for memmap
[    0.000000]   Normal zone: 77792 pages, LIFO batch:15
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffc000 (        fee00000)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC =
INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC =
INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC =
INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC =
INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC =
INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC =
INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC =
INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC =
INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC =
INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC =
INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC =
INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC =
INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC =
INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC =
INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC =
INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffb000 (fec00000)
[    0.000000] e820: [mem 0x14000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:1 nr_=
node_ids:1
[    0.000000] PERCPU: Embedded 13 pages/cpu @d3a18000 s30144 r0 d23104 u53=
248
[    0.000000] pcpu-alloc: s30144 r0 d23104 u53248 alloc=3D13*4096
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 13a1b680
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 81150
[    0.000000] Kernel command line: hung_task_panic=3D1 earlyprintk=3DttyS0=
,115200 rd.udev.log-priority=3Derr systemd.log_target=3Djournal systemd.log=
_level=3Dwarning debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_s=
tall_timeout=3D100 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oop=
s=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 console=3DttyS0,115200 consol=
e=3Dtty0 vga=3Dnormal  root=3D/dev/ram0 rw link=3D/kbuild-tests/run-queue/k=
vm/i386-randconfig-r2-0215/linux-devel:devel-roam-rand-201502150502:fe4b991=
dcd84e0104cf2e29223a819335ed048a7:bisect-linux-8/.vmlinuz-fe4b991dcd84e0104=
cf2e29223a819335ed048a7-20150215062532-12-client1 branch=3Dlinux-devel/deve=
l-roam-rand-201502150502 BOOT_IMAGE=3D/kernel/i386-randconfig-r2-0215/fe4b9=
91dcd84e0104cf2e29223a819335ed048a7/vmlinuz-3.19.0-rc4-00003-gfe4b991 drbd.=
minor_count=3D8
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[    0.000000] Initializing CPU#0
[    0.000000] Memory: 311052K/327160K available (5346K kernel code, 720K r=
wdata, 2700K rodata, 508K init, 344K bss, 16108K reserved, 0K cma-reserved)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xffd36000 - 0xfffff000   (2852 kB)
[    0.000000]     vmalloc : 0xd47e0000 - 0xffd34000   ( 693 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd3fe0000   ( 319 MB)
[    0.000000]       .init : 0xc1893000 - 0xc1912000   ( 508 kB)
[    0.000000]       .data : 0xc1538e49 - 0xc1891100   (3424 kB)
[    0.000000]       .text : 0xc1000000 - 0xc1538e49   (5347 kB)
[    0.000000] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.000000] SLUB: HWalign=3D128, Order=3D0-3, MinObjects=3D0, CPUs=3D1, =
Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D1
[    0.000000] NR_IRQS:2304 nr_irqs:256 16
[    0.000000] CPU 0 irqstacks, hard=3Dd3410000 soft=3Dd3412000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] bootconsole [earlyser0] disabled
[    0.000000] console [ttyS0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Detected 2992.398 MHz processor
[    0.006666] Calibrating delay loop (skipped) preset value.. 5987.16 Bogo=
MIPS (lpj=3D9974660)
[    0.006673] pid_max: default: 32768 minimum: 301
[    0.007715] ACPI: Core revision 20141107
[    0.053724] ACPI: All ACPI Tables successfully acquired
[    0.055292] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.056678] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 by=
tes)
[    0.060735] Initializing cgroup subsys perf_event
[    0.062228] Initializing cgroup subsys debug
[    0.063478] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.063478] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.188734] Freeing SMP alternatives memory: 16K (c1912000 - c1916000)
[    0.193980] Getting VERSION: 1050014
[    0.196678] Getting VERSION: 1050014
[    0.197917] Getting ID: 0
[    0.201739] Getting ID: f000000
[    0.203349] Getting LVT0: 8700
[    0.204508] Getting LVT1: 8400
[    0.205651] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.206772] enabled ExtINT on CPU#0
[    0.210103] ENABLING IO-APIC IRQs
[    0.213355] init IO_APIC IRQs
[    0.214489]  apic 0 pin 0 not connected
[    0.216685] IOAPIC[0]: Set routing entry (0-1 -> 0x31 -> IRQ 1 Mode:0 Ac=
tive:0 Dest:1)
[    0.220028] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    0.223356] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    0.226692] IOAPIC[0]: Set routing entry (0-3 -> 0x33 -> IRQ 3 Mode:0 Ac=
tive:0 Dest:1)
[    0.230025] IOAPIC[0]: Set routing entry (0-4 -> 0x34 -> IRQ 4 Mode:0 Ac=
tive:0 Dest:1)
[    0.233359] IOAPIC[0]: Set routing entry (0-5 -> 0x35 -> IRQ 5 Mode:1 Ac=
tive:0 Dest:1)
[    0.235979] IOAPIC[0]: Set routing entry (0-6 -> 0x36 -> IRQ 6 Mode:0 Ac=
tive:0 Dest:1)
[    0.236691] IOAPIC[0]: Set routing entry (0-7 -> 0x37 -> IRQ 7 Mode:0 Ac=
tive:0 Dest:1)
[    0.240025] IOAPIC[0]: Set routing entry (0-8 -> 0x38 -> IRQ 8 Mode:0 Ac=
tive:0 Dest:1)
[    0.243359] IOAPIC[0]: Set routing entry (0-9 -> 0x39 -> IRQ 9 Mode:1 Ac=
tive:0 Dest:1)
[    0.246692] IOAPIC[0]: Set routing entry (0-10 -> 0x3a -> IRQ 10 Mode:1 =
Active:0 Dest:1)
[    0.250025] IOAPIC[0]: Set routing entry (0-11 -> 0x3b -> IRQ 11 Mode:1 =
Active:0 Dest:1)
[    0.253360] IOAPIC[0]: Set routing entry (0-12 -> 0x3c -> IRQ 12 Mode:0 =
Active:0 Dest:1)
[    0.256692] IOAPIC[0]: Set routing entry (0-13 -> 0x3d -> IRQ 13 Mode:0 =
Active:0 Dest:1)
[    0.260025] IOAPIC[0]: Set routing entry (0-14 -> 0x3e -> IRQ 14 Mode:0 =
Active:0 Dest:1)
[    0.263358] IOAPIC[0]: Set routing entry (0-15 -> 0x3f -> IRQ 15 Mode:0 =
Active:0 Dest:1)
[    0.266687]  apic 0 pin 16 not connected
[    0.268046]  apic 0 pin 17 not connected
[    0.270003]  apic 0 pin 18 not connected
[    0.273336]  apic 0 pin 19 not connected
[    0.276669]  apic 0 pin 20 not connected
[    0.277964]  apic 0 pin 21 not connected
[    0.280003]  apic 0 pin 22 not connected
[    0.283336]  apic 0 pin 23 not connected
[    0.286815] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.290003] smpboot: CPU0: Intel Common KVM processor (fam: 0f, model: 0=
6, stepping: 01)
[    0.296670] Using local APIC timer interrupts.
[    0.296670] calibrating APIC timer ...
[    0.303333] ... lapic delta =3D 6250113
[    0.303333] ... PM-Timer delta =3D 357952
[    0.303333] ... PM-Timer result ok
[    0.303333] ..... delta 6250113
[    0.303333] ..... mult: 268440336
[    0.303333] ..... calibration result: 3333393
[    0.303333] ..... CPU clock speed is 2992.2106 MHz.
[    0.303333] ..... host bus clock speed is 1000.0393 MHz.
[    0.303461] Performance Events: unsupported Netburst CPU model 6 no PMU =
driver, software events only.
[    0.316447] x86: Booted up 1 node, 1 CPUs
[    0.316670] smpboot: Total of 1 processors activated (5987.16 BogoMIPS)
[    0.330257] xor: measuring software checksum speed
[    0.363336]    pIII_sse  :  6903.600 MB/sec
[    0.396669]    prefetch64-sse:  6026.400 MB/sec
[    0.398071] xor: using function: pIII_sse (6903.600 MB/sec)
[    0.400023] prandom: seed boundary self test passed
[    0.403861] prandom: 100 self tests passed
[    0.406690] atomic64_test: passed for i586+ platform with CX8 and with S=
SE
[    0.413722] NET: Registered protocol family 16
[    0.420087] cpuidle: using governor ladder
[    0.423342] cpuidle: using governor menu
[    0.426767] ACPI: bus type PCI registered
[    0.430190] PCI : PCI BIOS area is rw and x. Use pci=3Dnobios if you wan=
t it NX.
[    0.433344] PCI: PCI BIOS revision 2.10 entry at 0xfd456, last bus=3D0
[    0.436669] PCI: Using configuration type 1 for base access
[    0.514785] Running resizable hashtable tests...
[    0.516678]   Adding 2048 keys
[    0.531460]   Traversal complete: counted=3D2048, nelems=3D2048, entries=
=3D2048
[    0.533465]   Table expansion iteration 0...
[    0.536968]   Verifying lookups...
[    0.540116]   Table expansion iteration 1...
[    0.544343]   Verifying lookups...
[    0.550012]   Table expansion iteration 2...
[    0.551846]   Verifying lookups...
[    0.553449]   Table expansion iteration 3...
[    0.557221]   Verifying lookups...
[    0.560130]   Table shrinkage iteration 0...
[    0.563535]   Verifying lookups...
[    0.566781]   Table shrinkage iteration 1...
[    0.570110]   Verifying lookups...
[    0.571416]   Table shrinkage iteration 2...
[    0.573397]   Verifying lookups...
[    0.574736]   Table shrinkage iteration 3...
[    0.576708]   Verifying lookups...
[    0.580178]   Traversal complete: counted=3D2048, nelems=3D2048, entries=
=3D2048
[    0.583336]   Deleting 2048 keys
[    0.653342] raid6: mmxx1     1521 MB/s
[    0.713366] raid6: mmxx2     2376 MB/s
[    0.770040] raid6: sse1x1    1239 MB/s
[    0.826680] raid6: sse1x2    1408 MB/s
[    0.883362] raid6: sse2x1    2007 MB/s
[    0.940007] raid6: sse2x2    2867 MB/s
[    0.941323] raid6: using algorithm sse2x2 (2867 MB/s)
[    0.943337] raid6: using intx1 recovery algorithm
[    0.947537] ACPI: Added _OSI(Module Device)
[    0.949065] ACPI: Added _OSI(Processor Device)
[    0.950002] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.951487] ACPI: Added _OSI(Processor Aggregator Device)
[    0.960420] IOAPIC[0]: Set routing entry (0-9 -> 0x39 -> IRQ 9 Mode:1 Ac=
tive:0 Dest:1)
[    0.977267] ACPI: Interpreter enabled
[    0.978545] ACPI: (supports S0 S5)
[    0.980002] ACPI: Using IOAPIC for interrupt routing
[    0.983355] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    1.060202] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.062033] acpi PNP0A03:00: _OSC: OS supports [Segments]
[    1.063404] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.067509] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    1.070436] PCI host bridge to bus 0000:00
[    1.071829] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.073346] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    1.075123] pci_bus 0000:00: root bus resource [io  0x0d00-0xadff]
[    1.076676] pci_bus 0000:00: root bus resource [io  0xae0f-0xaeff]
[    1.080008] pci_bus 0000:00: root bus resource [io  0xaf20-0xafdf]
[    1.081864] pci_bus 0000:00: root bus resource [io  0xafe4-0xffff]
[    1.083341] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f]
[    1.086675] pci_bus 0000:00: root bus resource [mem 0x14000000-0xfebffff=
f]
[    1.090064] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    1.095195] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    1.098735] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    1.106900] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    1.109558] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    1.110004] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.113336] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    1.115206] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    1.121550] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    1.123893] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX=
4 ACPI
[    1.126396] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX=
4 SMB
[    1.130047] pci 0000:00:02.0: [1013:00b8] type 00 class 0x030000
[    1.133163] pci 0000:00:02.0: reg 0x10: [mem 0xfc000000-0xfdffffff pref]
[    1.134403] pci 0000:00:02.0: reg 0x14: [mem 0xfebf0000-0xfebf0fff]
[    1.142409] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    1.147997] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    1.150888] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    1.153763] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    1.159129] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    1.163699] pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000
[    1.167135] pci 0000:00:04.0: reg 0x10: [mem 0xfebf1000-0xfebf100f]
[    1.174228] pci_bus 0000:00: on NUMA node 0
[    1.181821] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    1.185646] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    1.188963] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    1.192298] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    1.197823] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    1.202257] ACPI: Enabled 16 GPEs in block 00 to 0F
[    1.205436] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS=
 32
[    1.206747] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS=
 36
[    1.208654] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS=
 40
[    1.210010] ------------[ cut here ]------------
[    1.213340] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:406=
 __arm_lpae_unmap+0xa8/0x321()
[    1.216671] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.19.0-rc4-00003-g=
fe4b991 #13
[    1.220002] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.222875]  00000000 00000000 d3485e08 c1531d71 00000000 d3485e24 c1039=
f0d 00000196
[    1.227986]  c12e00db d3541ab0 00000000 00000000 d3485e34 c1039faa 00000=
009 00000000
[    1.231315]  d3485e90 c12e00db 00000080 80000000 d3485ed0 0000000c d3603=
000 00600000
[    1.234642] Call Trace:
[    1.236674]  [<c1531d71>] dump_stack+0x48/0x60
[    1.240005]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.241548]  [<c12e00db>] ? __arm_lpae_unmap+0xa8/0x321
[    1.243098]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[    1.243337]  [<c12e00db>] __arm_lpae_unmap+0xa8/0x321
[    1.244832]  [<c12dfe9f>] ? arm_lpae_map+0xa4/0xaf
[    1.246670]  [<c12e036f>] arm_lpae_unmap+0x1b/0x35
[    1.250004]  [<c18b8c71>] arm_lpae_do_selftests+0x1e0/0x394
[    1.253337]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.254867]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.256343]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.256670]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.258145]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.260004]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.261530]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.263337]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.266670]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.270003]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.271405]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.272983]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.273345] ---[ end trace f84d29e8c6948694 ]---
[    1.274808] ------------[ cut here ]------------
[    1.276670] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:904=
 arm_lpae_do_selftests+0x2c1/0x394()
[    1.280002] selftest: test failed for fmt idx 0
[    1.283336] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    1.286669] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.290002]  00000000 00000000 d3485e64 c1531d71 d3485e90 d3485e80 c1039=
f0d 00000388
[    1.298004]  c18b8d52 d3541af4 00000000 00000000 d3485e98 c1039f6c 00000=
009 d3485e90
[    1.301341]  c175bedd d3485eac d3485f18 c18b8d52 c175bf03 00000388 c175b=
edd 00000000
[    1.304949] Call Trace:
[    1.305980]  [<c1531d71>] dump_stack+0x48/0x60
[    1.306670]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.310004]  [<c18b8d52>] ? arm_lpae_do_selftests+0x2c1/0x394
[    1.311690]  [<c1039f6c>] warn_slowpath_fmt+0x26/0x2a
[    1.313337]  [<c18b8d52>] arm_lpae_do_selftests+0x2c1/0x394
[    1.314927]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.316671]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.318195]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.319708]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.320004]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.323337]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.326671]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.328128]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.330004]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.331626]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.333019]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.333337]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.334747] ---[ end trace f84d29e8c6948695 ]---
[    1.336669] arm-lpae io-pgtable: cfg: pgsize_bitmap 0x40201000, ias 40-b=
it
[    1.340003] arm-lpae io-pgtable: data: 4 levels, 0x10 pgd_size, 12 pg_sh=
ift, 9 bits_per_level, pgd @ d3603000
[    1.343336] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS=
 42
[    1.346688] ------------[ cut here ]------------
[    1.348095] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:406=
 __arm_lpae_unmap+0xa8/0x321()
[    1.350004] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    1.353336] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.356669]  00000000 00000000 d3485e08 c1531d71 00000000 d3485e24 c1039=
f0d 00000196
[    1.360606]  c12e00db d3541260 00000000 00000000 d3485e34 c1039faa 00000=
009 00000000
[    1.366668]  d3485e90 c12e00db 00000080 80000000 d3485ed0 0000000c d3610=
000 00600000
[    1.370002] Call Trace:
[    1.371061]  [<c1531d71>] dump_stack+0x48/0x60
[    1.372521]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.373338]  [<c12e00db>] ? __arm_lpae_unmap+0xa8/0x321
[    1.374912]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[    1.376670]  [<c12e00db>] __arm_lpae_unmap+0xa8/0x321
[    1.380006]  [<c12dfe9f>] ? arm_lpae_map+0xa4/0xaf
[    1.383338]  [<c12e036f>] arm_lpae_unmap+0x1b/0x35
[    1.384894]  [<c18b8c71>] arm_lpae_do_selftests+0x1e0/0x394
[    1.386670]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.388195]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.390003]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.391512]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.393338]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.396670]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.398228]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.400004]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.401710]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.403337]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.406671]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.408420]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.410003] ---[ end trace f84d29e8c6948696 ]---
[    1.411424] ------------[ cut here ]------------
[    1.413337] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:904=
 arm_lpae_do_selftests+0x2c1/0x394()
[    1.416669] selftest: test failed for fmt idx 0
[    1.418157] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    1.420007] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.423336]  00000000 00000000 d3485e64 c1531d71 d3485e90 d3485e80 c1039=
f0d 00000388
[    1.428794]  c18b8d52 d35412a4 00000000 00000000 d3485e98 c1039f6c 00000=
009 d3485e90
[    1.432126]  c175bedd d3485eac d3485f18 c18b8d52 c175bf03 00000388 c175b=
edd 00000000
[    1.435430] Call Trace:
[    1.436673]  [<c1531d71>] dump_stack+0x48/0x60
[    1.438045]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.439581]  [<c18b8d52>] ? arm_lpae_do_selftests+0x2c1/0x394
[    1.440006]  [<c1039f6c>] warn_slowpath_fmt+0x26/0x2a
[    1.441500]  [<c18b8d52>] arm_lpae_do_selftests+0x2c1/0x394
[    1.443337]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.444889]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.446671]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.448194]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.450004]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.451461]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.453339]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.456671]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.458271]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.460004]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.461385]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.463336]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.464724] ---[ end trace f84d29e8c6948697 ]---
[    1.466137] arm-lpae io-pgtable: cfg: pgsize_bitmap 0x40201000, ias 42-b=
it
[    1.466669] arm-lpae io-pgtable: data: 4 levels, 0x40 pgd_size, 12 pg_sh=
ift, 9 bits_per_level, pgd @ d3610000
[    1.470003] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS=
 44
[    1.471884] ------------[ cut here ]------------
[    1.473338] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:406=
 __arm_lpae_unmap+0xa8/0x321()
[    1.476671] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    1.479289] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.480002]  00000000 00000000 d3485e08 c1531d71 00000000 d3485e24 c1039=
f0d 00000196
[    1.484646]  c12e00db d3541980 00000000 00000000 d3485e34 c1039faa 00000=
009 00000000
[    1.490003]  d3485e90 c12e00db 00000080 80000000 d3485ed0 0000000c d3615=
000 00600000
[    1.493934] Call Trace:
[    1.494959]  [<c1531d71>] dump_stack+0x48/0x60
[    1.496671]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.498232]  [<c12e00db>] ? __arm_lpae_unmap+0xa8/0x321
[    1.499756]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[    1.500004]  [<c12e00db>] __arm_lpae_unmap+0xa8/0x321
[    1.501494]  [<c12dfe9f>] ? arm_lpae_map+0xa4/0xaf
[    1.503337]  [<c12e036f>] arm_lpae_unmap+0x1b/0x35
[    1.504771]  [<c18b8c71>] arm_lpae_do_selftests+0x1e0/0x394
[    1.506670]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.508172]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.509675]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.510003]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.511492]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.513339]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.514886]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.516271]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.516670]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.518263]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.520003]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.521577]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.523336] ---[ end trace f84d29e8c6948698 ]---
[    1.524746] ------------[ cut here ]------------
[    1.526671] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:904=
 arm_lpae_do_selftests+0x2c1/0x394()
[    1.530002] selftest: test failed for fmt idx 0
[    1.533336] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    1.536669] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.540002]  00000000 00000000 d3485e64 c1531d71 d3485e90 d3485e80 c1039=
f0d 00000388
[    1.543335]  c18b8d52 d35419c4 00000000 00000000 d3485e98 c1039f6c 00000=
009 d3485e90
[    1.546668]  c175bedd d3485eac d3485f18 c18b8d52 c175bf03 00000388 c175b=
edd 00000000
[    1.550002] Call Trace:
[    1.551030]  [<c1531d71>] dump_stack+0x48/0x60
[    1.553338]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.556670]  [<c18b8d52>] ? arm_lpae_do_selftests+0x2c1/0x394
[    1.558293]  [<c1039f6c>] warn_slowpath_fmt+0x26/0x2a
[    1.560003]  [<c18b8d52>] arm_lpae_do_selftests+0x2c1/0x394
[    1.561599]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.563339]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.564852]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.566397]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.566670]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.568115]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.570003]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.571409]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.573337]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.574939]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.576670]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.578226]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.579651] ---[ end trace f84d29e8c6948699 ]---
[    1.580002] arm-lpae io-pgtable: cfg: pgsize_bitmap 0x40201000, ias 44-b=
it
[    1.581844] arm-lpae io-pgtable: data: 4 levels, 0x100 pgd_size, 12 pg_s=
hift, 9 bits_per_level, pgd @ d3615000
[    1.583336] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x40201000, IAS=
 48
[    1.586687] ------------[ cut here ]------------
[    1.590004] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:406=
 __arm_lpae_unmap+0xa8/0x321()
[    1.593336] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    1.596669] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.600003]  00000000 00000000 d3485e08 c1531d71 00000000 d3485e24 c1039=
f0d 00000196
[    1.604668]  c12e00db d3541390 00000000 00000000 d3485e34 c1039faa 00000=
009 00000000
[    1.607984]  d3485e90 c12e00db 00000080 80000000 d3485ed0 0000000c d361a=
000 00600000
[    1.611318] Call Trace:
[    1.612328]  [<c1531d71>] dump_stack+0x48/0x60
[    1.613337]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.614878]  [<c12e00db>] ? __arm_lpae_unmap+0xa8/0x321
[    1.616670]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[    1.618169]  [<c12e00db>] __arm_lpae_unmap+0xa8/0x321
[    1.620003]  [<c12dfe9f>] ? arm_lpae_map+0xa4/0xaf
[    1.621488]  [<c12e036f>] arm_lpae_unmap+0x1b/0x35
[    1.623340]  [<c18b8c71>] arm_lpae_do_selftests+0x1e0/0x394
[    1.626671]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.628190]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.629683]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.630004]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.631478]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.633337]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.634890]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.636670]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.638228]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.640003]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.641379]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.643337]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.644974] ---[ end trace f84d29e8c694869a ]---
[    1.646400] ------------[ cut here ]------------
[    1.646671] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:904=
 arm_lpae_do_selftests+0x2c1/0x394()
[    1.650002] selftest: test failed for fmt idx 0
[    1.652254] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    1.653336] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.656668]  00000000 00000000 d3485e64 c1531d71 d3485e90 d3485e80 c1039=
f0d 00000388
[    1.662093]  c18b8d52 d35413d4 00000000 00000000 d3485e98 c1039f6c 00000=
009 d3485e90
[    1.665443]  c175bedd d3485eac d3485f18 c18b8d52 c175bf03 00000388 c175b=
edd 00000000
[    1.668769] Call Trace:
[    1.669789]  [<c1531d71>] dump_stack+0x48/0x60
[    1.670004]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.671527]  [<c18b8d52>] ? arm_lpae_do_selftests+0x2c1/0x394
[    1.673337]  [<c1039f6c>] warn_slowpath_fmt+0x26/0x2a
[    1.674837]  [<c18b8d52>] arm_lpae_do_selftests+0x2c1/0x394
[    1.676670]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.678192]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.680003]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.682268]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.683338]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.684772]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.686670]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.688058]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.690004]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.691598]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.693337]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.694894]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.696300] ---[ end trace f84d29e8c694869b ]---
[    1.696669] arm-lpae io-pgtable: cfg: pgsize_bitmap 0x40201000, ias 48-b=
it
[    1.698494] arm-lpae io-pgtable: data: 4 levels, 0x1000 pgd_size, 12 pg_=
shift, 9 bits_per_level, pgd @ d361a000
[    1.700002] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS=
 32
[    1.703524] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS=
 36
[    1.705547] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS=
 40
[    1.706682] ------------[ cut here ]------------
[    1.708085] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:894=
 arm_lpae_do_selftests+0x2c1/0x394()
[    1.710002] selftest: test failed for fmt idx 0
[    1.713337] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    1.716668] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.720002]  00000000 00000000 d3485e64 c1531d71 d3485e90 d3485e80 c1039=
f0d 0000037e
[    1.723335]  c18b8d52 d3541894 00000000 00000000 d3485e98 c1039f6c 00000=
009 d3485e90
[    1.726668]  c175bedd d3485eac d3485f18 c18b8d52 c175bf03 0000037e c175b=
edd 00000000
[    1.730002] Call Trace:
[    1.731053]  [<c1531d71>] dump_stack+0x48/0x60
[    1.732458]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.733337]  [<c18b8d52>] ? arm_lpae_do_selftests+0x2c1/0x394
[    1.734946]  [<c1039f6c>] warn_slowpath_fmt+0x26/0x2a
[    1.736670]  [<c18b8d52>] arm_lpae_do_selftests+0x2c1/0x394
[    1.738242]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.740004]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.742261]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.743337]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.744802]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.746670]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.748213]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.750004]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.751571]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.753337]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.754705]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.756279]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.756669] ---[ end trace f84d29e8c694869c ]---
[    1.758082] arm-lpae io-pgtable: cfg: pgsize_bitmap 0x2004000, ias 40-bit
[    1.760003] arm-lpae io-pgtable: data: 3 levels, 0x80 pgd_size, 14 pg_sh=
ift, 11 bits_per_level, pgd @ d363f000
[    1.763336] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS=
 42
[    1.765223] ------------[ cut here ]------------
[    1.766670] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:894=
 arm_lpae_do_selftests+0x2c1/0x394()
[    1.770002] selftest: test failed for fmt idx 0
[    1.773336] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    1.776669] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.780002]  00000000 00000000 d3485e64 c1531d71 d3485e90 d3485e80 c1039=
f0d 0000037e
[    1.783335]  c18b8d52 d3541504 00000000 00000000 d3485e98 c1039f6c 00000=
009 d3485e90
[    1.786669]  c175bedd d3485eac d3485f18 c18b8d52 c175bf03 0000037e c175b=
edd 00000000
[    1.790002] Call Trace:
[    1.791049]  [<c1531d71>] dump_stack+0x48/0x60
[    1.792490]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.793337]  [<c18b8d52>] ? arm_lpae_do_selftests+0x2c1/0x394
[    1.795016]  [<c1039f6c>] warn_slowpath_fmt+0x26/0x2a
[    1.796670]  [<c18b8d52>] arm_lpae_do_selftests+0x2c1/0x394
[    1.798309]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.800004]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.803337]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.804916]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.806670]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.808166]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.810004]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.811415]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.813337]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.814948]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.816670]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.820003]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.821479] ---[ end trace f84d29e8c694869d ]---
[    1.823336] arm-lpae io-pgtable: cfg: pgsize_bitmap 0x2004000, ias 42-bit
[    1.825153] arm-lpae io-pgtable: data: 3 levels, 0x200 pgd_size, 14 pg_s=
hift, 11 bits_per_level, pgd @ d363e000
[    1.826669] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS=
 44
[    1.830020] ------------[ cut here ]------------
[    1.833337] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:894=
 arm_lpae_do_selftests+0x2c1/0x394()
[    1.836669] selftest: test failed for fmt idx 0
[    1.840003] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    1.843335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.846345]  00000000 00000000 d3485e64 c1531d71 d3485e90 d3485e80 c1039=
f0d 0000037e
[    1.852597]  c18b8d52 d3541764 00000000 00000000 d3485e98 c1039f6c 00000=
009 d3485e90
[    1.855944]  c175bedd d3485eac d3485f18 c18b8d52 c175bf03 0000037e c175b=
edd 00000000
[    1.862488] Call Trace:
[    1.863338]  [<c1531d71>] dump_stack+0x48/0x60
[    1.864790]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.866385]  [<c18b8d52>] ? arm_lpae_do_selftests+0x2c1/0x394
[    1.866670]  [<c1039f6c>] warn_slowpath_fmt+0x26/0x2a
[    1.868167]  [<c18b8d52>] arm_lpae_do_selftests+0x2c1/0x394
[    1.870004]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.871606]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.873337]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.874863]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.876335]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.876670]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.878247]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.880004]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.881641]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.883337]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.884797]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.886670]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.888145] ---[ end trace f84d29e8c694869e ]---
[    1.890003] arm-lpae io-pgtable: cfg: pgsize_bitmap 0x2004000, ias 44-bit
[    1.891832] arm-lpae io-pgtable: data: 3 levels, 0x800 pgd_size, 14 pg_s=
hift, 11 bits_per_level, pgd @ d363d000
[    1.893335] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x02004000, IAS=
 48
[    1.895194] ------------[ cut here ]------------
[    1.896670] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:894=
 arm_lpae_do_selftests+0x2c1/0x394()
[    1.899842] selftest: test failed for fmt idx 0
[    1.900003] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    1.903335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.906668]  00000000 00000000 d3485e64 c1531d71 d3485e90 d3485e80 c1039=
f0d 0000037e
[    1.910607]  c18b8d52 d3541634 00000000 00000000 d3485e98 c1039f6c 00000=
009 d3485e90
[    1.915931]  c175bedd d3485eac d3485f18 c18b8d52 c175bf03 0000037e c175b=
edd 00000000
[    1.919956] Call Trace:
[    1.920004]  [<c1531d71>] dump_stack+0x48/0x60
[    1.921511]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.923337]  [<c18b8d52>] ? arm_lpae_do_selftests+0x2c1/0x394
[    1.924959]  [<c1039f6c>] warn_slowpath_fmt+0x26/0x2a
[    1.926438]  [<c18b8d52>] arm_lpae_do_selftests+0x2c1/0x394
[    1.926670]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    1.928249]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    1.930004]  [<c1893505>] ? repair_env_string+0x12/0x54
[    1.931628]  [<c1893400>] ? do_early_param+0x1e/0x73
[    1.933337]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    1.936670]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    1.938201]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    1.940004]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    1.941630]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    1.943337]  [<c152eae3>] kernel_init+0x8/0xb8
[    1.944818]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    1.946670]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    1.948160] ---[ end trace f84d29e8c694869f ]---
[    1.949657] arm-lpae io-pgtable: cfg: pgsize_bitmap 0x2004000, ias 48-bit
[    1.950003] arm-lpae io-pgtable: data: 4 levels, 0x10 pgd_size, 14 pg_sh=
ift, 11 bits_per_level, pgd @ d363c000
[    1.953335] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS=
 32
[    1.956751] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS=
 36
[    1.959255] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS=
 40
[    1.960668] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS=
 42
[    1.964081] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS=
 44
[    1.966713] ------------[ cut here ]------------
[    1.968127] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:406=
 __arm_lpae_unmap+0xa8/0x321()
[    1.970004] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    1.973335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    1.976668]  00000000 00000000 d3485e08 c1531d71 00000000 d3485e24 c1039=
f0d 00000196
[    1.981311]  c12e00db d3633000 00000000 00000000 d3485e34 c1039faa 00000=
009 00000000
[    1.984657]  d3485e90 c12e00db 00000400 40000000 d3485ed0 00000010 d377f=
000 00600000
[    1.990002] Call Trace:
[    1.991009]  [<c1531d71>] dump_stack+0x48/0x60
[    1.992372]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    1.993337]  [<c12e00db>] ? __arm_lpae_unmap+0xa8/0x321
[    1.994850]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[    1.996670]  [<c12e00db>] __arm_lpae_unmap+0xa8/0x321
[    2.000004]  [<c12dfe9f>] ? arm_lpae_map+0xa4/0xaf
[    2.001466]  [<c12e036f>] arm_lpae_unmap+0x1b/0x35
[    2.003337]  [<c18b8c71>] arm_lpae_do_selftests+0x1e0/0x394
[    2.004926]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    2.006671]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    2.010004]  [<c1893505>] ? repair_env_string+0x12/0x54
[    2.011524]  [<c1893400>] ? do_early_param+0x1e/0x73
[    2.013337]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    2.014784]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    2.016670]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    2.018050]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    2.020003]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    2.021587]  [<c152eae3>] kernel_init+0x8/0xb8
[    2.023337]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    2.026670]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    2.030002] ---[ end trace f84d29e8c69486a0 ]---
[    2.031405] ------------[ cut here ]------------
[    2.033337] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:904=
 arm_lpae_do_selftests+0x2c1/0x394()
[    2.036514] selftest: test failed for fmt idx 0
[    2.036670] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    2.040002] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    2.043335]  00000000 00000000 d3485e64 c1531d71 d3485e90 d3485e80 c1039=
f0d 00000388
[    2.050002]  c18b8d52 d3633044 00000000 00000000 d3485e98 c1039f6c 00000=
009 d3485e90
[    2.053335]  c175bedd d3485eac d3485f18 c18b8d52 c175bf03 00000388 c175b=
edd 00000000
[    2.056668] Call Trace:
[    2.060004]  [<c1531d71>] dump_stack+0x48/0x60
[    2.061382]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    2.063337]  [<c18b8d52>] ? arm_lpae_do_selftests+0x2c1/0x394
[    2.064967]  [<c1039f6c>] warn_slowpath_fmt+0x26/0x2a
[    2.066670]  [<c18b8d52>] arm_lpae_do_selftests+0x2c1/0x394
[    2.068260]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    2.069773]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    2.070003]  [<c1893505>] ? repair_env_string+0x12/0x54
[    2.071515]  [<c1893400>] ? do_early_param+0x1e/0x73
[    2.073338]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    2.076671]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    2.078200]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    2.080004]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    2.081575]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    2.083337]  [<c152eae3>] kernel_init+0x8/0xb8
[    2.084712]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    2.086292]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    2.086669] ---[ end trace f84d29e8c69486a1 ]---
[    2.088073] arm-lpae io-pgtable: cfg: pgsize_bitmap 0x20010000, ias 44-b=
it
[    2.090003] arm-lpae io-pgtable: data: 3 levels, 0x20 pgd_size, 16 pg_sh=
ift, 13 bits_per_level, pgd @ d377f000
[    2.093336] arm-lpae io-pgtable: selftest: pgsize_bitmap 0x20010000, IAS=
 48
[    2.095222] ------------[ cut here ]------------
[    2.096670] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:406=
 __arm_lpae_unmap+0xa8/0x321()
[    2.100003] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    2.102633] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    2.103335]  00000000 00000000 d3485e08 c1531d71 00000000 d3485e24 c1039=
f0d 00000196
[    2.108498]  c12e00db d3633e40 00000000 00000000 d3485e34 c1039faa 00000=
009 00000000
[    2.113933]  d3485e90 c12e00db 00000400 40000000 d3485ed0 00000010 d377e=
000 00600000
[    2.118491] Call Trace:
[    2.119523]  [<c1531d71>] dump_stack+0x48/0x60
[    2.120004]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    2.123337]  [<c12e00db>] ? __arm_lpae_unmap+0xa8/0x321
[    2.124849]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[    2.126670]  [<c12e00db>] __arm_lpae_unmap+0xa8/0x321
[    2.128162]  [<c12dfe9f>] ? arm_lpae_map+0xa4/0xaf
[    2.129613]  [<c12e036f>] arm_lpae_unmap+0x1b/0x35
[    2.130004]  [<c18b8c71>] arm_lpae_do_selftests+0x1e0/0x394
[    2.131602]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    2.133337]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    2.136670]  [<c1893505>] ? repair_env_string+0x12/0x54
[    2.140003]  [<c1893400>] ? do_early_param+0x1e/0x73
[    2.141488]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    2.143337]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    2.144882]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    2.146285]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    2.146670]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    2.150003]  [<c152eae3>] kernel_init+0x8/0xb8
[    2.151379]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    2.152936]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    2.153336] ---[ end trace f84d29e8c69486a2 ]---
[    2.154743] ------------[ cut here ]------------
[    2.156672] WARNING: CPU: 0 PID: 1 at drivers/iommu/io-pgtable-arm.c:904=
 arm_lpae_do_selftests+0x2c1/0x394()
[    2.160002] selftest: test failed for fmt idx 0
[    2.161384] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W      3.19.=
0-rc4-00003-gfe4b991 #13
[    2.163335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    2.166669]  00000000 00000000 d3485e64 c1531d71 d3485e90 d3485e80 c1039=
f0d 00000388
[    2.170595]  c18b8d52 d3633e84 00000000 00000000 d3485e98 c1039f6c 00000=
009 d3485e90
[    2.176669]  c175bedd d3485eac d3485f18 c18b8d52 c175bf03 00000388 c175b=
edd 00000000
[    2.182367] Call Trace:
[    2.183341]  [<c1531d71>] dump_stack+0x48/0x60
[    2.186672]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[    2.188264]  [<c18b8d52>] ? arm_lpae_do_selftests+0x2c1/0x394
[    2.190003]  [<c1039f6c>] warn_slowpath_fmt+0x26/0x2a
[    2.193338]  [<c18b8d52>] arm_lpae_do_selftests+0x2c1/0x394
[    2.194935]  [<c18b8a91>] ? arm_lpae_dump_ops+0x37/0x37
[    2.196671]  [<c1893c4f>] do_one_initcall+0x177/0x18a
[    2.198187]  [<c1893505>] ? repair_env_string+0x12/0x54
[    2.200004]  [<c1893400>] ? do_early_param+0x1e/0x73
[    2.201469]  [<c104b78c>] ? parse_args+0x28b/0x38c
[    2.203337]  [<c18934f3>] ? initcall_blacklist+0x9e/0x9e
[    2.204924]  [<c105dd11>] ? __wake_up+0x32/0x3b
[    2.206670]  [<c1893dc6>] kernel_init_freeable+0x164/0x1e1
[    2.210006]  [<c1893dc6>] ? kernel_init_freeable+0x164/0x1e1
[    2.211659]  [<c152eae3>] kernel_init+0x8/0xb8
[    2.213337]  [<c15375c1>] ret_from_kernel_thread+0x21/0x30
[    2.214904]  [<c152eadb>] ? rest_init+0x6d/0x6d
[    2.216676] ---[ end trace f84d29e8c69486a3 ]---
[    2.220003] arm-lpae io-pgtable: cfg: pgsize_bitmap 0x20010000, ias 48-b=
it
[    2.221892] arm-lpae io-pgtable: data: 3 levels, 0x200 pgd_size, 16 pg_s=
hift, 13 bits_per_level, pgd @ d377e000
[    2.223336] arm-lpae io-pgtable: selftest: completed with 8 PASS 10 FAIL
[    2.226872] vgaarb: setting as boot device: PCI:0000:00:02.0
[    2.228479] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    2.230013] vgaarb: loaded
[    2.231101] vgaarb: bridge control possible 0000:00:02.0
[    2.235708] SCSI subsystem initialized
[    2.237164] pps_core: LinuxPPS API ver. 1 registered
[    2.238649] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    2.240208] EDAC MC: Ver: 3.0.0
[    2.244684] Advanced Linux Sound Architecture Driver Initialized.
[    2.246750] PCI: Using ACPI for IRQ routing
[    2.250007] PCI: pci_cache_line_size set to 64 bytes
[    2.251660] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    2.253354] e820: reserve RAM buffer [mem 0x13fe0000-0x13ffffff]
[    2.258214] Switched to clocksource kvm-clock
[    2.259998] FS-Cache: Loaded
[    2.260306] pnp: PnP ACPI init
[    2.261733] IOAPIC[0]: Set routing entry (0-8 -> 0x38 -> IRQ 8 Mode:0 Ac=
tive:0 Dest:1)
[    2.264447] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    2.266468] IOAPIC[0]: Set routing entry (0-1 -> 0x31 -> IRQ 1 Mode:0 Ac=
tive:0 Dest:1)
[    2.269199] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    2.271167] IOAPIC[0]: Set routing entry (0-12 -> 0x3c -> IRQ 12 Mode:0 =
Active:0 Dest:1)
[    2.273939] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    2.277521] IOAPIC[0]: Set routing entry (0-6 -> 0x36 -> IRQ 6 Mode:0 Ac=
tive:0 Dest:1)
[    2.280152] pnp 00:03: [dma 2]
[    2.281516] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    2.283696] IOAPIC[0]: Set routing entry (0-7 -> 0x37 -> IRQ 7 Mode:0 Ac=
tive:0 Dest:1)
[    2.286382] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    2.288535] IOAPIC[0]: Set routing entry (0-4 -> 0x34 -> IRQ 4 Mode:0 Ac=
tive:0 Dest:1)
[    2.294147] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    2.299095] pnp: PnP ACPI: found 6 devices
[    2.357221] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    2.358838] pci_bus 0000:00: resource 5 [io  0x0d00-0xadff]
[    2.360441] pci_bus 0000:00: resource 6 [io  0xae0f-0xaeff]
[    2.362039] pci_bus 0000:00: resource 7 [io  0xaf20-0xafdf]
[    2.363646] pci_bus 0000:00: resource 8 [io  0xafe4-0xffff]
[    2.365223] pci_bus 0000:00: resource 9 [mem 0x000a0000-0x000bffff]
[    2.369588] pci_bus 0000:00: resource 10 [mem 0x14000000-0xfebfffff]
[    2.371431] NET: Registered protocol family 1
[    2.372849] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    2.374549] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    2.376207] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    2.377970] pci 0000:00:02.0: Video device with shadowed ROM
[    2.379606] PCI: CLS 0 bytes, default 64
[    2.381203] Unpacking initramfs...
[    2.556163] Freeing initrd memory: 3276K (d3ca5000 - d3fd8000)
[    2.559651] Scanning for low memory corruption every 60 seconds
[    2.562970] PCLMULQDQ-NI instructions are not detected.
[    2.564528] The force parameter has not been set to 1. The Iris poweroff=
 handler will not be installed.
[    2.580296] NatSemi SCx200 Driver
[    2.582907] futex hash table entries: 256 (order: 2, 16384 bytes)
[    2.642767] zpool: loaded
[    2.643862] zbud: loaded
[    2.648120] VFS: Disk quotas dquot_6.5.2
[    2.649843] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    2.665429] ntfs: driver 2.1.31 [Flags: R/O].
[    2.668540] fuse init (API version 7.23)
[    2.671837] JFS: nTxBlock =3D 2455, nTxLock =3D 19646
[    2.687763] NILFS version 2 loaded
[    2.691296] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[    2.693735] io scheduler noop registered
[    2.695030] io scheduler deadline registered (default)
[    2.708642] test_string_helpers: Running tests...
[    2.712523] test_firmware: interface ready
[    2.714003] xz_dec_test: module loaded
[    2.715252] xz_dec_test: Create a device node with 'mknod xz_dec_test c =
251 0' and write .xz files to it.
[    2.719414] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[    2.732894] ACPI: Power Button [PWRF]
[    2.736119] r3964: Philips r3964 Driver $Revision: 1.10 $
[    2.743715] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.803681] serial 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 1=
15200) is a 16550A
[    2.819983] lp: driver loaded but no devices found
[    2.821682] Non-volatile memory driver v1.3
[    2.823407] ppdev: user-space parallel port driver
[    2.830943] scx200_gpio: no SCx200 gpio present
[    2.832358] nsc_gpio initializing
[    2.833582] smapi::smapi_init, ERROR invalid usSmapiID
[    2.835111] mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAPI is=
 not available on this machine
[    2.844902] mwave: mwavedd::mwave_init: Error: Failed to initialize boar=
d data
[    2.847267] mwave: mwavedd::mwave_init: Error: Failed to initialize
[    2.848994] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 secon=
ds, margin is 60 seconds).
[    2.852036] parport_pc 00:04: reported by Plug and Play ACPI
[    2.853849] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    2.950751] lp0: using parport0 (interrupt-driven).
[    2.952247] lp0: console ready
[    2.955293] lkdtm: No crash points registered, enable through debugfs
[    2.957436] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Gi=
ometti
[    2.960170] c2port c2port0: C2 port uc added
[    2.961511] c2port c2port0: uc flash has 30 blocks x 512 bytes (15360 by=
tes total)
[    2.974233] Uniform Multi-Platform E-IDE driver
[    2.976389] ide_generic: please use "probe_mask=3D0x3f" module parameter=
 for probing all legacy ISA IDE ports
[    2.979248] ide-gd driver 1.18
[    2.980463] ide-cd driver 5.00
[    2.986209] rdac: device handler registered
[    2.987759] hp_sw: device handler registered
[    2.989123] alua: device handler registered
[    2.991170] st: Version 20101219, fixed bufsize 32768, s/g segs 256
[    3.006081] osst :I: Tape driver with OnStream support version 0.99.4
[    3.006081] osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
[    3.017884] scsi_debug: host protection
[    3.024416] scsi host0: scsi_debug, version 1.85 [20141022], dev_size_mb=
=3D8, opts=3D0x0
[    3.050501] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       01=
84 PQ: 0 ANSI: 6
[    3.055216] Rounding down aligned max_sectors from 4294967295 to 4294967=
288
[    3.057981] HSI/SSI char device loaded
[    3.060363] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    3.064247] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.065977] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.198362] mousedev: PS/2 mouse device common for all mice
[    3.200631] sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.38 MB/8.=
00 MiB)
[    3.219409] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    3.223676] apanel: Fujitsu BIOS signature 'FJKEYINF' not found...
[    3.226309] ideapad_slidebar: DMI does not match
[    3.228170] i2c-parport: adapter type unspecified
[    3.230516] IR NEC protocol handler initialized
[    3.245006] IR RC6 protocol handler initialized
[    3.246443] IR JVC protocol handler initialized
[    3.254913] IR Sony protocol handler initialized
[    3.256354] IR SANYO protocol handler initialized
[    3.257830] IR Sharp protocol handler initialized
[    3.259387] Registered IR keymap rc-empty
[    3.281783] input: rc-core loopback device as /devices/virtual/rc/rc0/in=
put4
[    3.283973] rc0: rc-core loopback device as /devices/virtual/rc/rc0
[    3.287981] smssdio: Siano SMS1xxx SDIO driver
[    3.289396] smssdio: Copyright Pierre Ossman
[    3.290921] pps_ldisc: PPS line discipline registered
[    3.292491] Driver for 1-wire Dallas network protocol.
[    3.294368] DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
[    3.296154] 1-Wire driver for the DS2760 battery monitor chip - (c) 2004=
-2005, Szabolcs Gyurko
[    3.308079] power_supply test_ac: uevent
[    3.309381] power_supply test_ac: POWER_SUPPLY_NAME=3Dtest_ac
[    3.311011] power_supply test_ac: prop ONLINE=3D1
[    3.312474] power_supply test_ac: power_supply_changed
[    3.319339] power_supply test_battery: uevent
[    3.320728] power_supply test_battery: POWER_SUPPLY_NAME=3Dtest_battery
[    3.322462] power_supply test_battery: prop STATUS=3DDischarging
[    3.324147] power_supply test_battery: prop CHARGE_TYPE=3DFast
[    3.325767] power_supply test_battery: prop HEALTH=3DGood
[    3.327314] power_supply test_battery: prop PRESENT=3D1
[    3.328856] power_supply test_battery: prop TECHNOLOGY=3DLi-ion
[    3.330551] power_supply test_battery: prop CHARGE_FULL_DESIGN=3D100
[    3.345315] power_supply test_battery: prop CHARGE_FULL=3D100
[    3.346956] power_supply test_battery: prop CHARGE_NOW=3D50
[    3.348524] power_supply test_battery: prop CAPACITY=3D50
[    3.350099] power_supply test_battery: prop CAPACITY_LEVEL=3DNormal
[    3.351792] power_supply test_battery: prop TIME_TO_EMPTY_AVG=3D3600
[    3.353500] power_supply test_battery: prop TIME_TO_FULL_NOW=3D3600
[    3.355201] power_supply test_battery: prop MODEL_NAME=3DTest battery
[    3.368011] power_supply test_battery: prop MANUFACTURER=3DLinux
[    3.369676] power_supply test_battery: prop SERIAL_NUMBER=3D3.19.0-rc4-0=
0003-gfe4b991
[    3.372238] power_supply test_battery: prop TEMP=3D26
[    3.373904] power_supply test_battery: prop VOLTAGE_NOW=3D3300
[    3.376198] power_supply test_battery: power_supply_changed
[    3.378098] power_supply test_usb: uevent
[    3.379425] power_supply test_usb: POWER_SUPPLY_NAME=3Dtest_usb
[    3.395198] power_supply test_usb: prop ONLINE=3D1
[    3.396693] power_supply test_usb: power_supply_changed
[    3.413126] f71882fg: Not a Fintek device
[    3.414515] f71882fg: Not a Fintek device
[    3.421149] pc87360: PC8736x not detected, module not inserted
[    3.423177] sch56xx_common: Unsupported device id: 0xff
[    3.424785] sch56xx_common: Unsupported device id: 0xff
[    3.442014] acquirewdt: WDT driver for Acquire single board computer ini=
tialising
[    3.444784] acquirewdt: I/O address 0x0043 already in use
[    3.452439] acquirewdt: probe of acquirewdt failed with error -5
[    3.454302] advantechwdt: WDT driver for Advantech single board computer=
 initialising
[    3.457271] advantechwdt: initialized. timeout=3D60 sec (nowayout=3D1)
[    3.459158] ib700wdt: WDT driver for IB700 single board computer initial=
ising
[    3.480657] ib700wdt: START method I/O 443 is not available
[    3.482340] ib700wdt: probe of ib700wdt failed with error -5
[    3.499888] wafer5823wdt: WDT driver for Wafer 5823 single board compute=
r initialising
[    3.502485] wafer5823wdt: I/O address 0x0443 already in use
[    3.504244] it87_wdt: no device
[    3.505497] pc87413_wdt: Version 1.1 at io 0x2E
[    3.506972] pc87413_wdt: cannot register miscdev on minor=3D130 (err=3D-=
16)
[    3.520877] sbc60xxwdt: I/O address 0x0443 already in use
[    3.522488] sbc8360: failed to register misc device
[    3.524150] sbc7240_wdt: I/O address 0x0443 already in use
[    3.525754] cpu5wdt: misc_register failed
[    3.527252] w83877f_wdt: I/O address 0x0443 already in use
[    3.528853] machzwd: MachZ ZF-Logic Watchdog driver initializing
[    3.548868] machzwd: no ZF-Logic found
[    3.550219] sbc_epx_c3: cannot register miscdev on minor=3D130 (err=3D-1=
6)
[    3.552407] watchdog: Software Watchdog: cannot register miscdev on mino=
r=3D130 (err=3D-16).
[    3.554984] watchdog: Software Watchdog: a legacy watchdog module is pro=
bably present.
[    3.566843] softdog: Software Watchdog Timer: 0.08 initialized. soft_nob=
oot=3D0 soft_margin=3D60 sec soft_panic=3D0 (nowayout=3D1)
[    3.582515] device-mapper: uevent: version 1.0.3
[    3.584967] device-mapper: ioctl: 4.29.0-ioctl (2014-10-28) initialised:=
 dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    3.588859] power_supply test_ac: power_supply_changed_work
[    3.590462] power_supply test_ac: power_supply_update_gen_leds 1
[    3.598182] power_supply test_ac: uevent
[    3.599467] power_supply test_ac: POWER_SUPPLY_NAME=3Dtest_ac
[    3.601102] power_supply test_ac: prop ONLINE=3D1
[    3.602529] power_supply test_battery: power_supply_changed_work
[    3.604225] power_supply test_battery: power_supply_update_bat_leds 2
[    3.606129] power_supply test_battery: uevent
[    3.607515] power_supply test_battery: POWER_SUPPLY_NAME=3Dtest_battery
[    3.609280] power_supply test_battery: prop STATUS=3DDischarging
[    3.632052] power_supply test_battery: prop CHARGE_TYPE=3DFast
[    3.633688] power_supply test_battery: prop HEALTH=3DGood
[    3.635215] power_supply test_battery: prop PRESENT=3D1
[    3.654858] power_supply test_battery: prop TECHNOLOGY=3DLi-ion
[    3.656487] power_supply test_battery: prop CHARGE_FULL_DESIGN=3D100
[    3.658209] power_supply test_battery: prop CHARGE_FULL=3D100
[    3.659802] power_supply test_battery: prop CHARGE_NOW=3D50
[    3.661371] power_supply test_battery: prop CAPACITY=3D50
[    3.680987] power_supply test_battery: prop CAPACITY_LEVEL=3DNormal
[    3.682749] power_supply test_battery: prop TIME_TO_EMPTY_AVG=3D3600
[    3.684497] power_supply test_battery: prop TIME_TO_FULL_NOW=3D3600
[    3.686238] power_supply test_battery: prop MODEL_NAME=3DTest battery
[    3.688021] power_supply test_battery: prop MANUFACTURER=3DLinux
[    3.704844] power_supply test_battery: prop SERIAL_NUMBER=3D3.19.0-rc4-0=
0003-gfe4b991
[    3.707364] power_supply test_battery: prop TEMP=3D26
[    3.708878] power_supply test_battery: prop VOLTAGE_NOW=3D3300
[    3.710523] device-mapper: multipath: version 1.7.0 loaded
[    3.712144] device-mapper: multipath round-robin: version 1.0.0 loaded
[    3.731075] device-mapper: multipath service-time: version 0.2.0 loaded
[    3.732987] Driver 'mmcblk' needs updating - please use bus_type methods
[    3.735055] sdhci: Secure Digital Host Controller Interface driver
[    3.736828] sdhci: Copyright(c) Pierre Ossman
[    3.738206] wbsd: Winbond W83L51xD SD/MMC card interface driver
[    3.750939] wbsd: Copyright(c) Pierre Ossman
[    3.753932] ledtrig-cpu: registered to indicate activity on CPUs
[    3.759687] power_supply test_usb: power_supply_changed_work
[    3.768597] power_supply test_usb: power_supply_update_gen_leds 1
[    3.770300] power_supply test_usb: uevent
[    3.771595] power_supply test_usb: POWER_SUPPLY_NAME=3Dtest_usb
[    3.773214] power_supply test_usb: prop ONLINE=3D1
[    3.775296] tsc: Refined TSC clocksource calibration: 2992.397 MHz
[    3.777232] sd 0:0:0:0: [sda] Write Protect is off
[    3.778693] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 08
[    3.810044] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 supports DPO and FUA
[    3.850043]  sda: unknown partition table
[    3.877378] panel: driver version 0.9.5 registered on parport0 (io=3D0x3=
78).
[    3.879742] input: Speakup as /devices/virtual/input/input6
[    3.882183] initialized device: /dev/synth, node (MAJOR 10, MINOR 25)
[    3.897147] speakup 3.1.6: initialized
[    3.898447] synth name on entry is: (null)
[    3.900840] logger: created 256K log 'log_main'
[    3.902483] logger: created 256K log 'log_events'
[    3.904164] logger: created 256K log 'log_radio'
[    3.906494] logger: created 256K log 'log_system'
[    3.921793] FPGA DOWNLOAD --->
[    3.923008] FPGA image file name: xlinx_fpga_firmware.bit
[    3.924905] GPIO INIT FAIL!!
[    3.926995]  fake-fmc-carrier: mezzanine 0
[    3.928354]       Manufacturer: fake-vendor
[    3.929724]       Product name: fake-design-for-testing
[    3.931490] fmc fake-design-for-testing-f001: Driver has no ID: matches =
all
[    3.933475] fmc_trivial: probe of fake-design-for-testing-f001 failed wi=
th error -95
[    3.936054] fmc fake-design-for-testing-f001: Driver has no ID: matches =
all
[    3.938005] fmc_write_eeprom fake-design-for-testing-f001: fmc_write_eep=
rom: no busid passed, refusing all cards
[    3.941110] fmc fake-design-for-testing-f001: Driver has no ID: matches =
all
[    3.943236] fmc_chardev fake-design-for-testing-f001: Created misc devic=
e "fake-design-for-testing-f001"
[    3.959437] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.976940] ... APIC ID:      00000000 (0)
[    3.978317] ... APIC VERSION: 01050014
[    3.979603] 000000000000000000000000000000000000000000000000000000000000=
0000
[    3.980017] 000000000e20000000000000000000000000000000000000000000000000=
0000
[    3.980017] 000000000000000000000000000000000000000000000000000000000000=
8000
[    3.980017]=20
[    3.992304] number of MP IRQ sources: 15.
[    3.993642] number of IO-APIC #0 registers: 24.
[    3.995033] testing the IO APIC.......................
[    3.996572] IO APIC #0......
[    3.997706] .... register #00: 00000000
[    3.998979] .......    : physical APIC id: 00
[    4.000357] .......    : Delivery Type: 0
[    4.001997] .......    : LTS          : 0
[    4.003294] .... register #01: 00170011
[    4.004575] .......     : max redirection entries: 17
[    4.006802] .......     : PRQ implemented: 0
[    4.008151] .......     : IO APIC version: 11
[    4.009844] .... register #02: 00000000
[    4.011168] .......     : arbitration: 00
[    4.012662] .... IRQ redirection table:
[    4.013958] 1    0    0   0   0    0    0    00
[    4.015425] 0    0    0   0   0    1    1    31
[    4.016868] 0    0    0   0   0    1    1    30
[    4.018535] 0    0    0   0   0    1    1    33
[    4.019973] 1    0    0   0   0    1    1    34
[    4.021399] 1    1    0   0   0    1    1    35
[    4.022894] 0    0    0   0   0    1    1    36
[    4.032536] 0    0    0   0   0    1    1    37
[    4.034010] 0    0    0   0   0    1    1    38
[    4.037460] 0    1    0   0   0    1    1    39
[    4.039173] 1    1    0   0   0    1    1    3A
[    4.040604] 1    1    0   0   0    1    1    3B
[    4.042188] 0    0    0   0   0    1    1    3C
[    4.043637] 0    0    0   0   0    1    1    3D
[    4.045278] 0    0    0   0   0    1    1    3E
[    4.046881] 0    0    0   0   0    1    1    3F
[    4.048865] 1    0    0   0   0    0    0    00
[    4.050328] 1    0    0   0   0    0    0    00
[    4.051834] 1    0    0   0   0    0    0    00
[    4.053252] 1    0    0   0   0    0    0    00
[    4.054703] 1    0    0   0   0    0    0    00
[    4.056183] 1    0    0   0   0    0    0    00
[    4.057626] 1    0    0   0   0    0    0    00
[    4.059103] 1    0    0   0   0    0    0    00
[    4.060514] IRQ to pin mappings:
[    4.063190] IRQ0 -> 0:2
[    4.064472] IRQ1 -> 0:1
[    4.078564] IRQ3 -> 0:3
[    4.079843] IRQ4 -> 0:4
[    4.081126] IRQ5 -> 0:5
[    4.082390] IRQ6 -> 0:6
[    4.083684] IRQ7 -> 0:7
[    4.084948] IRQ8 -> 0:8
[    4.086221] IRQ9 -> 0:9
[    4.105547] IRQ10 -> 0:10
[    4.106877] IRQ11 -> 0:11
[    4.108173] IRQ12 -> 0:12
[    4.109466] IRQ13 -> 0:13
[    4.110788] IRQ14 -> 0:14
[    4.112091] IRQ15 -> 0:15
[    4.113401] .................................... done.
[    4.134081] Using IPI No-Shortcut mode
[    4.141398] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/=
i8042/serio1/input/input5
[    4.161540] Btrfs loaded, debug=3Don, assert=3Don, integrity-checker=3Don
[    4.176420] BTRFS: selftest: Running btrfs free space cache tests
[    4.178188] BTRFS: selftest: Running extent only tests
[    4.179752] BTRFS: selftest: Running bitmap only tests
[    4.181316] BTRFS: selftest: Running bitmap and extent tests
[    4.183025] BTRFS: selftest: Running space stealing from bitmap to extent
[    4.185171] BTRFS: selftest: Free space cache tests finished
[    4.186822] BTRFS: selftest: Running extent buffer operation tests
[    4.188061] BTRFS: selftest: Running btrfs_split_item tests
[    4.203420] BTRFS: selftest: Running find delalloc tests
[    4.295110] BTRFS: selftest: Running btrfs_get_extent tests
[    4.298175] BTRFS: selftest: Running hole first btrfs_get_extent test
[    4.300159] BTRFS: selftest: Running qgroup tests
[    4.314715] BTRFS: selftest: Qgroup basic add
[    4.316135] BTRFS: selftest: Qgroup multiple refs test
[    4.319691] ALSA device list:
[    4.321163]   No soundcards found.
[    4.323378] Freeing unused kernel memory: 508K (c1893000 - c1912000)
[    4.325273] Write protecting the kernel text: 5348k
[    4.326923] Write protecting the kernel read-only data: 2704k
[    4.346650] NX-protecting the kernel data: 4892k
[    4.482281] power_supply test_ac: uevent
[    4.483799] power_supply test_ac: POWER_SUPPLY_NAME=3Dtest_ac
[    4.485407] power_supply test_ac: prop ONLINE=3D1
[    4.486928] power_supply test_battery: uevent
[    4.488288] power_supply test_battery: POWER_SUPPLY_NAME=3Dtest_battery
[    4.490542] power_supply test_battery: prop STATUS=3DDischarging
[    4.492201] power_supply test_battery: prop CHARGE_TYPE=3DFast
[    4.493888] power_supply test_battery: prop HEALTH=3DGood
[    4.495421] power_supply test_battery: prop PRESENT=3D1
[    4.496996] power_supply test_battery: prop TECHNOLOGY=3DLi-ion
[    4.498637] power_supply test_battery: prop CHARGE_FULL_DESIGN=3D100
[    4.500395] power_supply test_battery: prop CHARGE_FULL=3D100
[    4.502002] power_supply test_battery: prop CHARGE_NOW=3D50
[    4.503576] power_supply test_battery: prop CAPACITY=3D50
[    4.505112] power_supply test_battery: prop CAPACITY_LEVEL=3DNormal
[    4.506853] power_supply test_battery: prop TIME_TO_EMPTY_AVG=3D3600
[    4.508560] power_supply test_battery: prop TIME_TO_FULL_NOW=3D3600
[    4.510272] power_supply test_battery: prop MODEL_NAME=3DTest battery
[    4.512003] power_supply test_battery: prop MANUFACTURER=3DLinux
[    4.513665] power_supply test_battery: prop SERIAL_NUMBER=3D3.19.0-rc4-0=
0003-gfe4b991
[    4.516093] power_supply test_battery: prop TEMP=3D26
[    4.517576] power_supply test_battery: prop VOLTAGE_NOW=3D3300
[    4.519278] power_supply test_usb: uevent
[    4.521092] power_supply test_usb: POWER_SUPPLY_NAME=3Dtest_usb
[    4.522750] power_supply test_usb: prop ONLINE=3D1
Kernel tests: Boot OK!
[    5.475706] random: trinity urandom read with 5 bits of entropy available
[   15.546261] sock: process `trinity-main' is using obsolete setsockopt SO=
_BSDCOMPAT
[   15.646623] ------------[ cut here ]------------
[   15.648518] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   15.651624] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   15.663265] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   15.666318]  00000000 00000000 d14cbd88 c1531d71 00000000 d14cbda4 c1039=
f0d 0000040d
[   15.669820]  c15298ba c196a9c0 00000001 00000002 d14cbdb4 c1039faa 00000=
009 00000000
[   15.673276]  d14cbdcc c15298ba c187e800 c27b12c0 00000001 00000002 d14cb=
de4 c1527e4e
[   15.676802] Call Trace:
[   15.677820]  [<c1531d71>] dump_stack+0x48/0x60
[   15.679207]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   15.680811]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   15.682305]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   15.683906]  [<c15298ba>] genl_unbind+0x85/0x8b
[   15.685296]  [<c1527e4e>] netlink_setsockopt+0x11f/0x19f
[   15.687007]  [<c150257b>] SYSC_setsockopt+0x57/0x79
[   15.688465]  [<c150471e>] SYSC_socketcall+0x2b4/0x38c
[   15.689972]  [<c10d9424>] ? simple_write_end+0x9a/0xa4
[   15.691543]  [<c1095190>] ? generic_perform_write+0xc4/0x163
[   15.693155]  [<c10951ed>] ? generic_perform_write+0x121/0x163
[   15.694840]  [<c10d22c4>] ? file_update_time+0x25/0x89
[   15.696354]  [<c10953b0>] ? __generic_file_write_iter+0x181/0x1bb
[   15.698082]  [<c1053d07>] ? __might_sleep+0x96/0x9e
[   15.699533]  [<c1095420>] ? generic_file_write_iter+0x36/0xb8
[   15.701182]  [<c10c2c7f>] ? __sb_end_write+0x21/0x52
[   15.702725]  [<c10c02c3>] ? file_end_write+0x1f/0x21
[   15.704203]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   15.705588]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   15.707105]  [<c150481d>] SyS_socketcall+0xe/0x10
[   15.708531]  [<c1537745>] syscall_call+0x7/0x7
[   15.709920] ---[ end trace f84d29e8c69486a5 ]---
[   17.191159] Bits 55-60 of /proc/PID/pagemap entries are about to stop be=
ing page-shift some time soon. See the linux/Documentation/vm/pagemap.txt f=
or details.
[   17.286551] ------------[ cut here ]------------
[   17.288110] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   17.291089] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   17.293821] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   17.296801]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   17.311371]  c15298ba c196a9c0 00000001 c27b0f1c d14cbec8 c1039faa 00000=
009 00000000
[   17.314821]  d14cbee0 c15298ba c187e800 c27b0e10 00000001 c27b0f1c d14cb=
f00 c152826b
[   17.318268] Call Trace:
[   17.339392]  [<c1531d71>] dump_stack+0x48/0x60
[   17.340817]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   17.342365]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   17.343822]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   17.345312]  [<c15298ba>] genl_unbind+0x85/0x8b
[   17.346907]  [<c152826b>] netlink_release+0x23e/0x254
[   17.348536]  [<c150329b>] sock_release+0x10/0x5b
[   17.349992]  [<c15032f1>] sock_close+0xb/0xf
[   17.351379]  [<c10c1621>] __fput+0xd0/0x15c
[   17.360792]  [<c10c16d3>] ____fput+0x8/0xa
[   17.362120]  [<c104adc8>] task_work_run+0x7c/0xa2
[   17.363577]  [<c103ba25>] do_exit+0x2f1/0x735
[   17.364953]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   17.366373]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   17.367839]  [<c103bec4>] do_group_exit+0x34/0x90
[   17.384495]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   17.386059]  [<c1537745>] syscall_call+0x7/0x7
[   17.387501]  [<c1530000>] ? pfn_pte+0xb/0x33
[   17.388872] ---[ end trace f84d29e8c69486a6 ]---
[   17.390302] ------------[ cut here ]------------
[   17.391731] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   17.403777] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   17.406491] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   17.409507]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   17.428275]  c15298ba c196a9c0 00000004 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   17.432867]  d14cbee0 c15298ba c187e800 c27b0e10 00000004 c27b0f1c d14cb=
f00 c152826b
[   17.436339] Call Trace:
[   17.437378]  [<c1531d71>] dump_stack+0x48/0x60
[   17.438812]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   17.440367]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   17.441807]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   17.443307]  [<c15298ba>] genl_unbind+0x85/0x8b
[   17.453832]  [<c152826b>] netlink_release+0x23e/0x254
[   17.455454]  [<c150329b>] sock_release+0x10/0x5b
[   17.457021]  [<c15032f1>] sock_close+0xb/0xf
[   17.458445]  [<c10c1621>] __fput+0xd0/0x15c
[   17.468945]  [<c10c16d3>] ____fput+0x8/0xa
[   17.470303]  [<c104adc8>] task_work_run+0x7c/0xa2
[   17.471753]  [<c103ba25>] do_exit+0x2f1/0x735
[   17.473201]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   17.474751]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   17.476286]  [<c103bec4>] do_group_exit+0x34/0x90
[   17.490453]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   17.491944]  [<c1537745>] syscall_call+0x7/0x7
[   17.493398]  [<c1530000>] ? pfn_pte+0xb/0x33
[   17.494866] ---[ end trace f84d29e8c69486a7 ]---
[   17.496327] ------------[ cut here ]------------
[   17.497787] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   17.500726] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   17.516631] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   17.528363]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   17.531844]  c15298ba c196a9c0 00000005 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   17.535327]  d14cbee0 c15298ba c187e800 c27b0e10 00000005 c27b0f1c d14cb=
f00 c152826b
[   17.548803] Call Trace:
[   17.549836]  [<c1531d71>] dump_stack+0x48/0x60
[   17.551237]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   17.552796]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   17.554270]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   17.566427]  [<c15298ba>] genl_unbind+0x85/0x8b
[   17.567854]  [<c152826b>] netlink_release+0x23e/0x254
[   17.582426]  [<c150329b>] sock_release+0x10/0x5b
[   17.583889]  [<c15032f1>] sock_close+0xb/0xf
[   17.585243]  [<c10c1621>] __fput+0xd0/0x15c
[   17.586584]  [<c10c16d3>] ____fput+0x8/0xa
[   17.587938]  [<c104adc8>] task_work_run+0x7c/0xa2
[   17.589372]  [<c103ba25>] do_exit+0x2f1/0x735
[   17.590778]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   17.593475]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   17.594901]  [<c103bec4>] do_group_exit+0x34/0x90
[   17.596331]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   17.597815]  [<c1537745>] syscall_call+0x7/0x7
[   17.599200]  [<c1530000>] ? pfn_pte+0xb/0x33
[   17.600601] ---[ end trace f84d29e8c69486a8 ]---
[   17.602038] ------------[ cut here ]------------
[   17.603470] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   17.617664] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   17.642272] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   17.645185]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   17.648833]  c15298ba c196a9c0 00000006 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   17.669432]  d14cbee0 c15298ba c187e800 c27b0e10 00000006 c27b0f1c d14cb=
f00 c152826b
[   17.672976] Call Trace:
[   17.674025]  [<c1531d71>] dump_stack+0x48/0x60
[   17.675484]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   17.677102]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   17.678551]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   17.680087]  [<c15298ba>] genl_unbind+0x85/0x8b
[   17.681505]  [<c152826b>] netlink_release+0x23e/0x254
[   17.700176]  [<c150329b>] sock_release+0x10/0x5b
[   17.701602]  [<c15032f1>] sock_close+0xb/0xf
[   17.702971]  [<c10c1621>] __fput+0xd0/0x15c
[   17.704329]  [<c10c16d3>] ____fput+0x8/0xa
[   17.705685]  [<c104adc8>] task_work_run+0x7c/0xa2
[   17.707148]  [<c103ba25>] do_exit+0x2f1/0x735
[   17.708533]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   17.709952]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   17.711381]  [<c103bec4>] do_group_exit+0x34/0x90
[   17.712856]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   17.714317]  [<c1537745>] syscall_call+0x7/0x7
[   17.715725]  [<c1530000>] ? pfn_pte+0xb/0x33
[   17.717096] ---[ end trace f84d29e8c69486a9 ]---
[   17.731640] ------------[ cut here ]------------
[   17.733082] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   17.736020] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   17.752808] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   17.755762]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   17.759269]  c15298ba c196a9c0 00000007 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   17.762738]  d14cbee0 c15298ba c187e800 c27b0e10 00000007 c27b0f1c d14cb=
f00 c152826b
[   17.766192] Call Trace:
[   17.767238]  [<c1531d71>] dump_stack+0x48/0x60
[   17.781775]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   17.783324]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   17.784784]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   17.786288]  [<c15298ba>] genl_unbind+0x85/0x8b
[   17.787726]  [<c152826b>] netlink_release+0x23e/0x254
[   17.789226]  [<c150329b>] sock_release+0x10/0x5b
[   17.790675]  [<c15032f1>] sock_close+0xb/0xf
[   17.792038]  [<c10c1621>] __fput+0xd0/0x15c
[   17.793397]  [<c10c16d3>] ____fput+0x8/0xa
[   17.811845]  [<c104adc8>] task_work_run+0x7c/0xa2
[   17.813293]  [<c103ba25>] do_exit+0x2f1/0x735
[   17.814698]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   17.816139]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   17.817555]  [<c103bec4>] do_group_exit+0x34/0x90
[   17.819001]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   17.820468]  [<c1537745>] syscall_call+0x7/0x7
[   17.821877]  [<c1530000>] ? pfn_pte+0xb/0x33
[   17.823235] ---[ end trace f84d29e8c69486aa ]---
[   17.824687] ------------[ cut here ]------------
[   17.826112] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   17.842130] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   17.844874] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   17.847875]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   17.851318]  c15298ba c196a9c0 00000008 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   17.867861]  d14cbee0 c15298ba c187e800 c27b0e10 00000008 c27b0f1c d14cb=
f00 c152826b
[   17.871362] Call Trace:
[   17.872393]  [<c1531d71>] dump_stack+0x48/0x60
[   17.873810]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   17.875363]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   17.876834]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   17.888590]  [<c15298ba>] genl_unbind+0x85/0x8b
[   17.890039]  [<c152826b>] netlink_release+0x23e/0x254
[   17.891530]  [<c150329b>] sock_release+0x10/0x5b
[   17.892955]  [<c15032f1>] sock_close+0xb/0xf
[   17.894321]  [<c10c1621>] __fput+0xd0/0x15c
[   17.895666]  [<c10c16d3>] ____fput+0x8/0xa
[   17.906062]  [<c104adc8>] task_work_run+0x7c/0xa2
[   17.907637]  [<c103ba25>] do_exit+0x2f1/0x735
[   17.909066]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   17.910590]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   17.928117]  [<c103bec4>] do_group_exit+0x34/0x90
[   17.929575]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   17.931059]  [<c1537745>] syscall_call+0x7/0x7
[   17.932443]  [<c1530000>] ? pfn_pte+0xb/0x33
[   17.933827] ---[ end trace f84d29e8c69486ab ]---
[   17.936332] ------------[ cut here ]------------
[   17.937792] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   17.940728] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   17.943452] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   17.959463]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   17.962940]  c15298ba c196a9c0 00000009 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   17.966386]  d14cbee0 c15298ba c187e800 c27b0e10 00000009 c27b0f1c d14cb=
f00 c152826b
[   17.978897] Call Trace:
[   17.979932]  [<c1531d71>] dump_stack+0x48/0x60
[   17.981344]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   17.982915]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   17.984372]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   17.985890]  [<c15298ba>] genl_unbind+0x85/0x8b
[   17.987314]  [<c152826b>] netlink_release+0x23e/0x254
[   17.988825]  [<c150329b>] sock_release+0x10/0x5b
[   17.990261]  [<c15032f1>] sock_close+0xb/0xf
[   18.004680]  [<c10c1621>] __fput+0xd0/0x15c
[   18.006021]  [<c10c16d3>] ____fput+0x8/0xa
[   18.007366]  [<c104adc8>] task_work_run+0x7c/0xa2
[   18.008818]  [<c103ba25>] do_exit+0x2f1/0x735
[   18.010215]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   18.011635]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   18.013042]  [<c103bec4>] do_group_exit+0x34/0x90
[   18.014495]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   18.015960]  [<c1537745>] syscall_call+0x7/0x7
[   18.017376]  [<c1530000>] ? pfn_pte+0xb/0x33
[   18.028899] ---[ end trace f84d29e8c69486ac ]---
[   18.030338] ------------[ cut here ]------------
[   18.031766] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   18.034707] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   18.037453] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   18.040380]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   18.056932]  c15298ba c196a9c0 0000000a 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   18.060462]  d14cbee0 c15298ba c187e800 c27b0e10 0000000a c27b0f1c d14cb=
f00 c152826b
[   18.063959] Call Trace:
[   18.065002]  [<c1531d71>] dump_stack+0x48/0x60
[   18.066396]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   18.081011]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   18.082444]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   18.083977]  [<c15298ba>] genl_unbind+0x85/0x8b
[   18.085385]  [<c152826b>] netlink_release+0x23e/0x254
[   18.086918]  [<c150329b>] sock_release+0x10/0x5b
[   18.088346]  [<c15032f1>] sock_close+0xb/0xf
[   18.089737]  [<c10c1621>] __fput+0xd0/0x15c
[   18.091106]  [<c10c16d3>] ____fput+0x8/0xa
[   18.105502]  [<c104adc8>] task_work_run+0x7c/0xa2
[   18.106988]  [<c103ba25>] do_exit+0x2f1/0x735
[   18.108375]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   18.109804]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   18.111234]  [<c103bec4>] do_group_exit+0x34/0x90
[   18.112671]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   18.114138]  [<c1537745>] syscall_call+0x7/0x7
[   18.115530]  [<c1530000>] ? pfn_pte+0xb/0x33
[   18.116915] ---[ end trace f84d29e8c69486ad ]---
[   18.141451] ------------[ cut here ]------------
[   18.142907] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   18.145829] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   18.148542] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   18.151454]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   18.154954]  c15298ba c196a9c0 0000000c 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   18.158389]  d14cbee0 c15298ba c187e800 c27b0e10 0000000c c27b0f1c d14cb=
f00 c152826b
[   18.161855] Call Trace:
[   18.162878]  [<c1531d71>] dump_stack+0x48/0x60
[   18.164284]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   18.178873]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   18.180353]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   18.181952]  [<c15298ba>] genl_unbind+0x85/0x8b
[   18.183364]  [<c152826b>] netlink_release+0x23e/0x254
[   18.204964]  [<c150329b>] sock_release+0x10/0x5b
[   18.206404]  [<c15032f1>] sock_close+0xb/0xf
[   18.207788]  [<c10c1621>] __fput+0xd0/0x15c
[   18.209121]  [<c10c16d3>] ____fput+0x8/0xa
[   18.210448]  [<c104adc8>] task_work_run+0x7c/0xa2
[   18.211918]  [<c103ba25>] do_exit+0x2f1/0x735
[   18.213293]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   18.232790]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   18.234253]  [<c103bec4>] do_group_exit+0x34/0x90
[   18.235732]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   18.237189]  [<c1537745>] syscall_call+0x7/0x7
[   18.238575]  [<c1530000>] ? pfn_pte+0xb/0x33
[   18.239940] ---[ end trace f84d29e8c69486ae ]---
[   18.254407] ------------[ cut here ]------------
[   18.255841] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   18.258770] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   18.261493] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   18.264393]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   18.280999]  c15298ba c196a9c0 0000000d 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   18.284431]  d14cbee0 c15298ba c187e800 c27b0e10 0000000d c27b0f1c d14cb=
f00 c152826b
[   18.287901] Call Trace:
[   18.288927]  [<c1531d71>] dump_stack+0x48/0x60
[   18.290327]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   18.304927]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   18.306369]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   18.307891]  [<c15298ba>] genl_unbind+0x85/0x8b
[   18.309298]  [<c152826b>] netlink_release+0x23e/0x254
[   18.310821]  [<c150329b>] sock_release+0x10/0x5b
[   18.312241]  [<c15032f1>] sock_close+0xb/0xf
[   18.313602]  [<c10c1621>] __fput+0xd0/0x15c
[   18.314956]  [<c10c16d3>] ____fput+0x8/0xa
[   18.316289]  [<c104adc8>] task_work_run+0x7c/0xa2
[   18.330782]  [<c103ba25>] do_exit+0x2f1/0x735
[   18.332157]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   18.333581]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   18.335005]  [<c103bec4>] do_group_exit+0x34/0x90
[   18.336448]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   18.337927]  [<c1537745>] syscall_call+0x7/0x7
[   18.339308]  [<c1530000>] ? pfn_pte+0xb/0x33
[   18.340686] ---[ end trace f84d29e8c69486af ]---
[   18.342103] ------------[ cut here ]------------
[   18.343521] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   18.356517] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   18.359267] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   18.362206]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   18.365674]  c15298ba c196a9c0 0000000e 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   18.382177]  d14cbee0 c15298ba c187e800 c27b0e10 0000000e c27b0f1c d14cb=
f00 c152826b
[   18.385633] Call Trace:
[   18.386656]  [<c1531d71>] dump_stack+0x48/0x60
[   18.388058]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   18.389593]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   18.391050]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   18.405596]  [<c15298ba>] genl_unbind+0x85/0x8b
[   18.407029]  [<c152826b>] netlink_release+0x23e/0x254
[   18.408540]  [<c150329b>] sock_release+0x10/0x5b
[   18.410006]  [<c15032f1>] sock_close+0xb/0xf
[   18.411416]  [<c10c1621>] __fput+0xd0/0x15c
[   18.412773]  [<c10c16d3>] ____fput+0x8/0xa
[   18.414111]  [<c104adc8>] task_work_run+0x7c/0xa2
[   18.415549]  [<c103ba25>] do_exit+0x2f1/0x735
[   18.416943]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   18.431413]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   18.432833]  [<c103bec4>] do_group_exit+0x34/0x90
[   18.434287]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   18.435748]  [<c1537745>] syscall_call+0x7/0x7
[   18.437157]  [<c1530000>] ? pfn_pte+0xb/0x33
[   18.438509] ---[ end trace f84d29e8c69486b0 ]---
[   18.439943] ------------[ cut here ]------------
[   18.441378] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   18.454340] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   18.457132] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   18.460062]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   18.463496]  c15298ba c196a9c0 0000000f 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   18.479990]  d14cbee0 c15298ba c187e800 c27b0e10 0000000f c27b0f1c d14cb=
f00 c152826b
[   18.483447] Call Trace:
[   18.484474]  [<c1531d71>] dump_stack+0x48/0x60
[   18.485874]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   18.487432]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   18.509918]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   18.511422]  [<c15298ba>] genl_unbind+0x85/0x8b
[   18.512833]  [<c152826b>] netlink_release+0x23e/0x254
[   18.514333]  [<c150329b>] sock_release+0x10/0x5b
[   18.515760]  [<c15032f1>] sock_close+0xb/0xf
[   18.517124]  [<c10c1621>] __fput+0xd0/0x15c
[   18.536513]  [<c10c16d3>] ____fput+0x8/0xa
[   18.537880]  [<c104adc8>] task_work_run+0x7c/0xa2
[   18.539307]  [<c103ba25>] do_exit+0x2f1/0x735
[   18.540698]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   18.542094]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   18.543505]  [<c103bec4>] do_group_exit+0x34/0x90
[   18.568669]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   18.570140]  [<c1537745>] syscall_call+0x7/0x7
[   18.571527]  [<c1530000>] ? pfn_pte+0xb/0x33
[   18.572889] ---[ end trace f84d29e8c69486b1 ]---
[   18.574316] ------------[ cut here ]------------
[   18.575749] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   18.578650] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   18.594400] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   18.597309]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   18.600785]  c15298ba c196a9c0 00000011 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   18.604220]  d14cbee0 c15298ba c187e800 c27b0e10 00000011 c27b0f1c d14cb=
f00 c152826b
[   18.607673] Call Trace:
[   18.617607]  [<c1531d71>] dump_stack+0x48/0x60
[   18.619015]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   18.632543]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   18.634022]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   18.635516]  [<c15298ba>] genl_unbind+0x85/0x8b
[   18.636977]  [<c152826b>] netlink_release+0x23e/0x254
[   18.638476]  [<c150329b>] sock_release+0x10/0x5b
[   18.639909]  [<c15032f1>] sock_close+0xb/0xf
[   18.641285]  [<c10c1621>] __fput+0xd0/0x15c
[   18.642632]  [<c10c16d3>] ____fput+0x8/0xa
[   18.643961]  [<c104adc8>] task_work_run+0x7c/0xa2
[   18.660445]  [<c103ba25>] do_exit+0x2f1/0x735
[   18.661841]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   18.663245]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   18.664674]  [<c103bec4>] do_group_exit+0x34/0x90
[   18.666117]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   18.667594]  [<c1537745>] syscall_call+0x7/0x7
[   18.682034]  [<c1530000>] ? pfn_pte+0xb/0x33
[   18.683396] ---[ end trace f84d29e8c69486b2 ]---
[   18.684821] ------------[ cut here ]------------
[   18.686269] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   18.689189] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   18.693532] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   18.696446]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   18.699962]  c15298ba c196a9c0 00000012 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   18.703581]  d14cbee0 c15298ba c187e800 c27b0e10 00000012 c27b0f1c d14cb=
f00 c152826b
[   18.726542] Call Trace:
[   18.727584]  [<c1531d71>] dump_stack+0x48/0x60
[   18.728979]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   18.730522]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   18.731967]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   18.733462]  [<c15298ba>] genl_unbind+0x85/0x8b
[   18.734870]  [<c152826b>] netlink_release+0x23e/0x254
[   18.749418]  [<c150329b>] sock_release+0x10/0x5b
[   18.750866]  [<c15032f1>] sock_close+0xb/0xf
[   18.752220]  [<c10c1621>] __fput+0xd0/0x15c
[   18.753571]  [<c10c16d3>] ____fput+0x8/0xa
[   18.754906]  [<c104adc8>] task_work_run+0x7c/0xa2
[   18.756331]  [<c103ba25>] do_exit+0x2f1/0x735
[   18.757722]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   18.759120]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   18.760527]  [<c103bec4>] do_group_exit+0x34/0x90
[   18.775015]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   18.776469]  [<c1537745>] syscall_call+0x7/0x7
[   18.777886]  [<c1530000>] ? pfn_pte+0xb/0x33
[   18.779243] ---[ end trace f84d29e8c69486b3 ]---
[   18.780696] ------------[ cut here ]------------
[   18.782108] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   18.791897] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   18.807664] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   18.823590]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   18.827088]  c15298ba c196a9c0 00000013 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   18.830541]  d14cbee0 c15298ba c187e800 c27b0e10 00000013 c27b0f1c d14cb=
f00 c152826b
[   18.833996] Call Trace:
[   18.835021]  [<c1531d71>] dump_stack+0x48/0x60
[   18.849457]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   18.851044]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   18.852468]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   18.853998]  [<c15298ba>] genl_unbind+0x85/0x8b
[   18.855392]  [<c152826b>] netlink_release+0x23e/0x254
[   18.856911]  [<c150329b>] sock_release+0x10/0x5b
[   18.858316]  [<c15032f1>] sock_close+0xb/0xf
[   18.859680]  [<c10c1621>] __fput+0xd0/0x15c
[   18.861025]  [<c10c16d3>] ____fput+0x8/0xa
[   18.875387]  [<c104adc8>] task_work_run+0x7c/0xa2
[   18.876880]  [<c103ba25>] do_exit+0x2f1/0x735
[   18.878271]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   18.881210]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   18.882639]  [<c103bec4>] do_group_exit+0x34/0x90
[   18.884089]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   18.885535]  [<c1537745>] syscall_call+0x7/0x7
[   18.886952]  [<c1530000>] ? pfn_pte+0xb/0x33
[   18.888305] ---[ end trace f84d29e8c69486b4 ]---
[   18.902784] ------------[ cut here ]------------
[   18.904220] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   18.907144] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   18.909869] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   18.912793]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   18.916239]  c15298ba c196a9c0 00000014 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   18.919697]  d14cbee0 c15298ba c187e800 c27b0e10 00000014 c27b0f1c d14cb=
f00 c152826b
[   18.936185] Call Trace:
[   18.937222]  [<c1531d71>] dump_stack+0x48/0x60
[   18.938603]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   18.940209]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   18.941653]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   18.943155]  [<c15298ba>] genl_unbind+0x85/0x8b
[   18.944565]  [<c152826b>] netlink_release+0x23e/0x254
[   18.946066]  [<c150329b>] sock_release+0x10/0x5b
[   18.947512]  [<c15032f1>] sock_close+0xb/0xf
[   18.961912]  [<c10c1621>] __fput+0xd0/0x15c
[   18.963254]  [<c10c16d3>] ____fput+0x8/0xa
[   18.964592]  [<c104adc8>] task_work_run+0x7c/0xa2
[   18.966037]  [<c103ba25>] do_exit+0x2f1/0x735
[   18.967424]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   18.968838]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   18.970256]  [<c103bec4>] do_group_exit+0x34/0x90
[   18.971697]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   18.973138]  [<c1537745>] syscall_call+0x7/0x7
[   18.974532]  [<c1530000>] ? pfn_pte+0xb/0x33
[   18.994934] ---[ end trace f84d29e8c69486b5 ]---
[   18.996346] ------------[ cut here ]------------
[   18.997777] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   19.000673] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   19.003380] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   19.006265]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   19.022772]  c15298ba c196a9c0 00000015 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   19.026199]  d14cbee0 c15298ba c187e800 c27b0e10 00000015 c27b0f1c d14cb=
f00 c152826b
[   19.029641] Call Trace:
[   19.030677]  [<c1531d71>] dump_stack+0x48/0x60
[   19.032050]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   19.033598]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   19.035039]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   19.049583]  [<c15298ba>] genl_unbind+0x85/0x8b
[   19.051015]  [<c152826b>] netlink_release+0x23e/0x254
[   19.052507]  [<c150329b>] sock_release+0x10/0x5b
[   19.053935]  [<c15032f1>] sock_close+0xb/0xf
[   19.055285]  [<c10c1621>] __fput+0xd0/0x15c
[   19.056634]  [<c10c16d3>] ____fput+0x8/0xa
[   19.057967]  [<c104adc8>] task_work_run+0x7c/0xa2
[   19.059393]  [<c103ba25>] do_exit+0x2f1/0x735
[   19.060787]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   19.075227]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   19.076640]  [<c103bec4>] do_group_exit+0x34/0x90
[   19.078085]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   19.079530]  [<c1537745>] syscall_call+0x7/0x7
[   19.080947]  [<c1530000>] ? pfn_pte+0xb/0x33
[   19.082296] ---[ end trace f84d29e8c69486b6 ]---
[   19.083743] ------------[ cut here ]------------
[   19.085156] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   19.094124] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   19.096864] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   19.099782]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   19.103237]  c15298ba c196a9c0 00000016 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   19.119736]  d14cbee0 c15298ba c187e800 c27b0e10 00000016 c27b0f1c d14cb=
f00 c152826b
[   19.123189] Call Trace:
[   19.124229]  [<c1531d71>] dump_stack+0x48/0x60
[   19.125632]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   19.127194]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   19.128632]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   19.130144]  [<c15298ba>] genl_unbind+0x85/0x8b
[   19.131540]  [<c152826b>] netlink_release+0x23e/0x254
[   19.149094]  [<c150329b>] sock_release+0x10/0x5b
[   19.150529]  [<c15032f1>] sock_close+0xb/0xf
[   19.151898]  [<c10c1621>] __fput+0xd0/0x15c
[   19.153232]  [<c10c16d3>] ____fput+0x8/0xa
[   19.167606]  [<c104adc8>] task_work_run+0x7c/0xa2
[   19.169051]  [<c103ba25>] do_exit+0x2f1/0x735
[   19.170428]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   19.171847]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   19.173244]  [<c103bec4>] do_group_exit+0x34/0x90
[   19.174707]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   19.176161]  [<c1537745>] syscall_call+0x7/0x7
[   19.177558]  [<c1530000>] ? pfn_pte+0xb/0x33
[   19.178926] ---[ end trace f84d29e8c69486b7 ]---
[   19.193384] ------------[ cut here ]------------
[   19.194823] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   19.197748] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   19.200477] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   19.203394]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   19.219880]  c15298ba c196a9c0 00000017 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   19.223309]  d14cbee0 c15298ba c187e800 c27b0e10 00000017 c27b0f1c d14cb=
f00 c152826b
[   19.226771] Call Trace:
[   19.227782]  [<c1531d71>] dump_stack+0x48/0x60
[   19.229167]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   19.230736]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   19.236184]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   19.237735]  [<c15298ba>] genl_unbind+0x85/0x8b
[   19.239137]  [<c152826b>] netlink_release+0x23e/0x254
[   19.240656]  [<c150329b>] sock_release+0x10/0x5b
[   19.242076]  [<c15032f1>] sock_close+0xb/0xf
[   19.243444]  [<c10c1621>] __fput+0xd0/0x15c
[   19.244792]  [<c10c16d3>] ____fput+0x8/0xa
[   19.246126]  [<c104adc8>] task_work_run+0x7c/0xa2
[   19.247567]  [<c103ba25>] do_exit+0x2f1/0x735
[   19.264434]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   19.269392]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   19.270823]  [<c103bec4>] do_group_exit+0x34/0x90
[   19.272260]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   19.273739]  [<c1537745>] syscall_call+0x7/0x7
[   19.275131]  [<c1530000>] ? pfn_pte+0xb/0x33
[   19.276487] ---[ end trace f84d29e8c69486b8 ]---
[   19.277938] ------------[ cut here ]------------
[   19.279358] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   19.301392] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   19.304134] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   19.307703]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   19.311161]  c15298ba c196a9c0 00000018 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   19.314624]  d14cbee0 c15298ba c187e800 c27b0e10 00000018 c27b0f1c d14cb=
f00 c152826b
[   19.331119] Call Trace:
[   19.332144]  [<c1531d71>] dump_stack+0x48/0x60
[   19.333537]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   19.335085]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   19.343381]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   19.362938]  [<c15298ba>] genl_unbind+0x85/0x8b
[   19.364342]  [<c152826b>] netlink_release+0x23e/0x254
[   19.365850]  [<c150329b>] sock_release+0x10/0x5b
[   19.367277]  [<c15032f1>] sock_close+0xb/0xf
[   19.368652]  [<c10c1621>] __fput+0xd0/0x15c
[   19.369993]  [<c10c16d3>] ____fput+0x8/0xa
[   19.371333]  [<c104adc8>] task_work_run+0x7c/0xa2
[   19.372780]  [<c103ba25>] do_exit+0x2f1/0x735
[   19.374173]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   19.388632]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   19.390052]  [<c103bec4>] do_group_exit+0x34/0x90
[   19.391480]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   19.392949]  [<c1537745>] syscall_call+0x7/0x7
[   19.394341]  [<c1530000>] ? pfn_pte+0xb/0x33
[   19.395705] ---[ end trace f84d29e8c69486b9 ]---
[   19.397138] ------------[ cut here ]------------
[   19.398552] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   19.414522] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   19.417263] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   19.420176]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   19.423641]  c15298ba c196a9c0 00000019 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   19.440129]  d14cbee0 c15298ba c187e800 c27b0e10 00000019 c27b0f1c d14cb=
f00 c152826b
[   19.443569] Call Trace:
[   19.444587]  [<c1531d71>] dump_stack+0x48/0x60
[   19.445979]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   19.447530]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   19.462022]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   19.463531]  [<c15298ba>] genl_unbind+0x85/0x8b
[   19.464943]  [<c152826b>] netlink_release+0x23e/0x254
[   19.466432]  [<c150329b>] sock_release+0x10/0x5b
[   19.467866]  [<c15032f1>] sock_close+0xb/0xf
[   19.469208]  [<c10c1621>] __fput+0xd0/0x15c
[   19.470555]  [<c10c16d3>] ____fput+0x8/0xa
[   19.471937]  [<c104adc8>] task_work_run+0x7c/0xa2
[   19.473385]  [<c103ba25>] do_exit+0x2f1/0x735
[   19.474768]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   19.476170]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   19.477589]  [<c103bec4>] do_group_exit+0x34/0x90
[   19.479032]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   19.480523]  [<c1537745>] syscall_call+0x7/0x7
[   19.481923]  [<c1530000>] ? pfn_pte+0xb/0x33
[   19.483273] ---[ end trace f84d29e8c69486ba ]---
[   19.497737] ------------[ cut here ]------------
[   19.499155] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   19.502160] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   19.504946] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   19.507867]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   19.528345]  c15298ba c196a9c0 0000001a 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   19.531796]  d14cbee0 c15298ba c187e800 c27b0e10 0000001a c27b0f1c d14cb=
f00 c152826b
[   19.535254] Call Trace:
[   19.536278]  [<c1531d71>] dump_stack+0x48/0x60
[   19.537688]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   19.539232]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   19.549720]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   19.551234]  [<c15298ba>] genl_unbind+0x85/0x8b
[   19.552645]  [<c152826b>] netlink_release+0x23e/0x254
[   19.554158]  [<c150329b>] sock_release+0x10/0x5b
[   19.555574]  [<c15032f1>] sock_close+0xb/0xf
[   19.556954]  [<c10c1621>] __fput+0xd0/0x15c
[   19.558291]  [<c10c16d3>] ____fput+0x8/0xa
[   19.559607]  [<c104adc8>] task_work_run+0x7c/0xa2
[   19.561062]  [<c103ba25>] do_exit+0x2f1/0x735
[   19.575472]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   19.576906]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   19.578305]  [<c103bec4>] do_group_exit+0x34/0x90
[   19.579747]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   19.581201]  [<c1537745>] syscall_call+0x7/0x7
[   19.582586]  [<c1530000>] ? pfn_pte+0xb/0x33
[   19.583959] ---[ end trace f84d29e8c69486bb ]---
[   19.585384] ------------[ cut here ]------------
[   19.586826] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   19.602779] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   19.605518] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   19.608433]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   19.611889]  c15298ba c196a9c0 0000001b 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   19.628373]  d14cbee0 c15298ba c187e800 c27b0e10 0000001b c27b0f1c d14cb=
f00 c152826b
[   19.631823] Call Trace:
[   19.632840]  [<c1531d71>] dump_stack+0x48/0x60
[   19.634236]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   19.635785]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   19.637224]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   19.638739]  [<c15298ba>] genl_unbind+0x85/0x8b
[   19.653189]  [<c152826b>] netlink_release+0x23e/0x254
[   19.654718]  [<c150329b>] sock_release+0x10/0x5b
[   19.656146]  [<c15032f1>] sock_close+0xb/0xf
[   19.657512]  [<c10c1621>] __fput+0xd0/0x15c
[   19.658858]  [<c10c16d3>] ____fput+0x8/0xa
[   19.660188]  [<c104adc8>] task_work_run+0x7c/0xa2
[   19.674674]  [<c103ba25>] do_exit+0x2f1/0x735
[   19.676047]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   19.677458]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   19.678872]  [<c103bec4>] do_group_exit+0x34/0x90
[   19.680341]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   19.681817]  [<c1537745>] syscall_call+0x7/0x7
[   19.683204]  [<c1530000>] ? pfn_pte+0xb/0x33
[   19.684566] ---[ end trace f84d29e8c69486bc ]---
[   19.685986] ------------[ cut here ]------------
[   19.700439] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   19.703383] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   19.706141] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   19.718059]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   19.721523]  c15298ba c196a9c0 0000001c 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   19.724980]  d14cbee0 c15298ba c187e800 c27b0e10 0000001c c27b0f1c d14cb=
f00 c152826b
[   19.741474] Call Trace:
[   19.742494]  [<c1531d71>] dump_stack+0x48/0x60
[   19.743906]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   19.745445]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   19.746897]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   19.748385]  [<c15298ba>] genl_unbind+0x85/0x8b
[   19.749789]  [<c152826b>] netlink_release+0x23e/0x254
[   19.751292]  [<c150329b>] sock_release+0x10/0x5b
[   19.761767]  [<c15032f1>] sock_close+0xb/0xf
[   19.763129]  [<c10c1621>] __fput+0xd0/0x15c
[   19.764477]  [<c10c16d3>] ____fput+0x8/0xa
[   19.765815]  [<c104adc8>] task_work_run+0x7c/0xa2
[   19.767272]  [<c103ba25>] do_exit+0x2f1/0x735
[   19.768659]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   19.770074]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   19.771471]  [<c103bec4>] do_group_exit+0x34/0x90
[   19.772920]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   19.774386]  [<c1537745>] syscall_call+0x7/0x7
[   19.788826]  [<c1530000>] ? pfn_pte+0xb/0x33
[   19.790202] ---[ end trace f84d29e8c69486bd ]---
[   19.791636] ------------[ cut here ]------------
[   19.793052] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   19.795974] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   19.798779] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   19.814728]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   19.818173]  c15298ba c196a9c0 0000001d 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   19.821628]  d14cbee0 c15298ba c187e800 c27b0e10 0000001d c27b0f1c d14cb=
f00 c152826b
[   19.835650] Call Trace:
[   19.836695]  [<c1531d71>] dump_stack+0x48/0x60
[   19.838084]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   19.839656]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   19.841103]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   19.842598]  [<c15298ba>] genl_unbind+0x85/0x8b
[   19.844027]  [<c152826b>] netlink_release+0x23e/0x254
[   19.845524]  [<c150329b>] sock_release+0x10/0x5b
[   19.846991]  [<c15032f1>] sock_close+0xb/0xf
[   19.848347]  [<c10c1621>] __fput+0xd0/0x15c
[   19.849697]  [<c10c16d3>] ____fput+0x8/0xa
[   19.851032]  [<c104adc8>] task_work_run+0x7c/0xa2
[   19.852462]  [<c103ba25>] do_exit+0x2f1/0x735
[   19.861907]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   19.863312]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   19.864735]  [<c103bec4>] do_group_exit+0x34/0x90
[   19.866168]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   19.867632]  [<c1537745>] syscall_call+0x7/0x7
[   19.869010]  [<c1530000>] ? pfn_pte+0xb/0x33
[   19.895335] ---[ end trace f84d29e8c69486be ]---
[   19.896779] ------------[ cut here ]------------
[   19.898208] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   19.914175] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   19.916924] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   19.919814]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   19.937305]  c15298ba c196a9c0 0000001e 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   19.940778]  d14cbee0 c15298ba c187e800 c27b0e10 0000001e c27b0f1c d14cb=
f00 c152826b
[   19.944228] Call Trace:
[   19.945251]  [<c1531d71>] dump_stack+0x48/0x60
[   19.946863]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   19.948411]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   19.949854]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   19.951371]  [<c15298ba>] genl_unbind+0x85/0x8b
[   19.952783]  [<c152826b>] netlink_release+0x23e/0x254
[   19.971532]  [<c150329b>] sock_release+0x10/0x5b
[   19.972989]  [<c15032f1>] sock_close+0xb/0xf
[   19.974364]  [<c10c1621>] __fput+0xd0/0x15c
[   19.988729]  [<c10c16d3>] ____fput+0x8/0xa
[   19.990101]  [<c104adc8>] task_work_run+0x7c/0xa2
[   19.991550]  [<c103ba25>] do_exit+0x2f1/0x735
[   19.992952]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   19.994383]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   19.997817]  [<c103bec4>] do_group_exit+0x34/0x90
[   19.999252]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   20.000725]  [<c1537745>] syscall_call+0x7/0x7
[   20.002105]  [<c1530000>] ? pfn_pte+0xb/0x33
[   20.003484] ---[ end trace f84d29e8c69486bf ]---
[   20.024693] ------------[ cut here ]------------
[   20.026111] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   20.029029] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   20.031769] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   20.034681]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   20.054169]  c15298ba c196a9c0 00000001 c27b13cc d14cbec8 c1039faa 00000=
009 00000000
[   20.057599]  d14cbee0 c15298ba c187e800 c27b12c0 00000001 c27b13cc d14cb=
f00 c152826b
[   20.061036] Call Trace:
[   20.062066]  [<c1531d71>] dump_stack+0x48/0x60
[   20.063471]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   20.065024]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   20.075532]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   20.077064]  [<c15298ba>] genl_unbind+0x85/0x8b
[   20.078462]  [<c152826b>] netlink_release+0x23e/0x254
[   20.079969]  [<c150329b>] sock_release+0x10/0x5b
[   20.081395]  [<c15032f1>] sock_close+0xb/0xf
[   20.082755]  [<c10c1621>] __fput+0xd0/0x15c
[   20.097136]  [<c10c16d3>] ____fput+0x8/0xa
[   20.098464]  [<c104adc8>] task_work_run+0x7c/0xa2
[   20.099905]  [<c103ba25>] do_exit+0x2f1/0x735
[   20.101290]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   20.102694]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   20.104111]  [<c103bec4>] do_group_exit+0x34/0x90
[   20.105537]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   20.107098]  [<c1537745>] syscall_call+0x7/0x7
[   20.108526]  [<c1530000>] ? pfn_pte+0xb/0x33
[   20.127932] ---[ end trace f84d29e8c69486c0 ]---
[   20.129343] ------------[ cut here ]------------
[   20.130788] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   20.133711] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   20.136414] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   20.139320]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   20.151836]  c15298ba c196a9c0 00000004 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   20.155286]  d14cbee0 c15298ba c187e800 c27b12c0 00000004 c27b13cc d14cb=
f00 c152826b
[   20.158760] Call Trace:
[   20.159784]  [<c1531d71>] dump_stack+0x48/0x60
[   20.161180]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   20.162731]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   20.164169]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   20.178722]  [<c15298ba>] genl_unbind+0x85/0x8b
[   20.180136]  [<c152826b>] netlink_release+0x23e/0x254
[   20.181646]  [<c150329b>] sock_release+0x10/0x5b
[   20.183072]  [<c15032f1>] sock_close+0xb/0xf
[   20.184440]  [<c10c1621>] __fput+0xd0/0x15c
[   20.185789]  [<c10c16d3>] ____fput+0x8/0xa
[   20.187130]  [<c104adc8>] task_work_run+0x7c/0xa2
[   20.188568]  [<c103ba25>] do_exit+0x2f1/0x735
[   20.189945]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   20.191355]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   20.204807]  [<c103bec4>] do_group_exit+0x34/0x90
[   20.206232]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   20.207705]  [<c1537745>] syscall_call+0x7/0x7
[   20.209085]  [<c1530000>] ? pfn_pte+0xb/0x33
[   20.210439] ---[ end trace f84d29e8c69486c1 ]---
[   20.211859] ------------[ cut here ]------------
[   20.237332] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   20.240292] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   20.243006] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   20.270937]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   20.274381]  c15298ba c196a9c0 00000006 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   20.277830]  d14cbee0 c15298ba c187e800 c27b12c0 00000006 c27b13cc d14cb=
f00 c152826b
[   20.294325] Call Trace:
[   20.295344]  [<c1531d71>] dump_stack+0x48/0x60
[   20.296756]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   20.298293]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   20.299739]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   20.301274]  [<c15298ba>] genl_unbind+0x85/0x8b
[   20.302701]  [<c152826b>] netlink_release+0x23e/0x254
[   20.304210]  [<c150329b>] sock_release+0x10/0x5b
[   20.312693]  [<c15032f1>] sock_close+0xb/0xf
[   20.314062]  [<c10c1621>] __fput+0xd0/0x15c
[   20.315398]  [<c10c16d3>] ____fput+0x8/0xa
[   20.316742]  [<c104adc8>] task_work_run+0x7c/0xa2
[   20.318201]  [<c103ba25>] do_exit+0x2f1/0x735
[   20.319570]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   20.321005]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   20.322399]  [<c103bec4>] do_group_exit+0x34/0x90
[   20.334923]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   20.336385]  [<c1537745>] syscall_call+0x7/0x7
[   20.337795]  [<c1530000>] ? pfn_pte+0xb/0x33
[   20.339144] ---[ end trace f84d29e8c69486c2 ]---
[   20.340601] ------------[ cut here ]------------
[   20.342060] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   20.344992] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   20.360759] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   20.363676]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   20.367118]  c15298ba c196a9c0 00000007 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   20.370573]  d14cbee0 c15298ba c187e800 c27b12c0 00000007 c27b13cc d14cb=
f00 c152826b
[   20.387081] Call Trace:
[   20.388104]  [<c1531d71>] dump_stack+0x48/0x60
[   20.389483]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   20.391054]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   20.392475]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   20.394028]  [<c15298ba>] genl_unbind+0x85/0x8b
[   20.395473]  [<c152826b>] netlink_release+0x23e/0x254
[   20.407597]  [<c150329b>] sock_release+0x10/0x5b
[   20.409078]  [<c15032f1>] sock_close+0xb/0xf
[   20.410476]  [<c10c1621>] __fput+0xd0/0x15c
[   20.411829]  [<c10c16d3>] ____fput+0x8/0xa
[   20.413153]  [<c104adc8>] task_work_run+0x7c/0xa2
[   20.424427]  [<c103ba25>] do_exit+0x2f1/0x735
[   20.425810]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   20.427256]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   20.428706]  [<c103bec4>] do_group_exit+0x34/0x90
[   20.430154]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   20.431591]  [<c1537745>] syscall_call+0x7/0x7
[   20.432983]  [<c1530000>] ? pfn_pte+0xb/0x33
[   20.434342] ---[ end trace f84d29e8c69486c3 ]---
[   20.435766] ------------[ cut here ]------------
[   20.450232] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   20.453146] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   20.455875] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   20.458812]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   20.462238]  c15298ba c196a9c0 0000000a 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   20.474788]  d14cbee0 c15298ba c187e800 c27b12c0 0000000a c27b13cc d14cb=
f00 c152826b
[   20.510302] Call Trace:
[   20.511325]  [<c1531d71>] dump_stack+0x48/0x60
[   20.512729]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   20.514279]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   20.534770]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   20.536256]  [<c15298ba>] genl_unbind+0x85/0x8b
[   20.537692]  [<c152826b>] netlink_release+0x23e/0x254
[   20.539190]  [<c150329b>] sock_release+0x10/0x5b
[   20.540639]  [<c15032f1>] sock_close+0xb/0xf
[   20.541997]  [<c10c1621>] __fput+0xd0/0x15c
[   20.543354]  [<c10c16d3>] ____fput+0x8/0xa
[   20.544691]  [<c104adc8>] task_work_run+0x7c/0xa2
[   20.564174]  [<c103ba25>] do_exit+0x2f1/0x735
[   20.565548]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   20.566980]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   20.568380]  [<c103bec4>] do_group_exit+0x34/0x90
[   20.569832]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   20.571302]  [<c1537745>] syscall_call+0x7/0x7
[   20.572708]  [<c1530000>] ? pfn_pte+0xb/0x33
[   20.574086] ---[ end trace f84d29e8c69486c4 ]---
[   20.575497] ------------[ cut here ]------------
[   20.596973] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   20.599887] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   20.602823] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   20.612949]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   20.616401]  c15298ba c196a9c0 0000000e 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   20.619905]  d14cbee0 c15298ba c187e800 c27b12c0 0000000e c27b13cc d14cb=
f00 c152826b
[   20.623364] Call Trace:
[   20.624385]  [<c1531d71>] dump_stack+0x48/0x60
[   20.625794]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   20.627385]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   20.628837]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   20.642378]  [<c15298ba>] genl_unbind+0x85/0x8b
[   20.643803]  [<c152826b>] netlink_release+0x23e/0x254
[   20.645292]  [<c150329b>] sock_release+0x10/0x5b
[   20.655735]  [<c15032f1>] sock_close+0xb/0xf
[   20.657095]  [<c10c1621>] __fput+0xd0/0x15c
[   20.658466]  [<c10c16d3>] ____fput+0x8/0xa
[   20.659809]  [<c104adc8>] task_work_run+0x7c/0xa2
[   20.661280]  [<c103ba25>] do_exit+0x2f1/0x735
[   20.662654]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   20.682091]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   20.683504]  [<c103bec4>] do_group_exit+0x34/0x90
[   20.684948]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   20.686387]  [<c1537745>] syscall_call+0x7/0x7
[   20.696816]  [<c1530000>] ? pfn_pte+0xb/0x33
[   20.698187] ---[ end trace f84d29e8c69486c5 ]---
[   20.699604] ------------[ cut here ]------------
[   20.701077] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   20.704017] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   20.731790] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   20.734679]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   20.738112]  c15298ba c196a9c0 0000000f 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   20.741589]  d14cbee0 c15298ba c187e800 c27b12c0 0000000f c27b13cc d14cb=
f00 c152826b
[   20.760117] Call Trace:
[   20.761139]  [<c1531d71>] dump_stack+0x48/0x60
[   20.762530]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   20.764109]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   20.765539]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   20.767059]  [<c15298ba>] genl_unbind+0x85/0x8b
[   20.768454]  [<c152826b>] netlink_release+0x23e/0x254
[   20.769950]  [<c150329b>] sock_release+0x10/0x5b
[   20.771377]  [<c15032f1>] sock_close+0xb/0xf
[   20.772740]  [<c10c1621>] __fput+0xd0/0x15c
[   20.774084]  [<c10c16d3>] ____fput+0x8/0xa
[   20.775410]  [<c104adc8>] task_work_run+0x7c/0xa2
[   20.789932]  [<c103ba25>] do_exit+0x2f1/0x735
[   20.791329]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   20.792745]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   20.794159]  [<c103bec4>] do_group_exit+0x34/0x90
[   20.795597]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   20.797064]  [<c1537745>] syscall_call+0x7/0x7
[   20.798454]  [<c1530000>] ? pfn_pte+0xb/0x33
[   20.799815] ---[ end trace f84d29e8c69486c6 ]---
[   21.556447] ------------[ cut here ]------------
[   21.557914] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   21.560823] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   21.563521] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   21.574462]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   21.577924]  c15298ba c196a9c0 00000001 c27cc5bc d14cbec8 c1039faa 00000=
009 00000000
[   21.581357]  d14cbee0 c15298ba c187e800 c27cc4b0 00000001 c27cc5bc d14cb=
f00 c152826b
[   21.597850] Call Trace:
[   21.598878]  [<c1531d71>] dump_stack+0x48/0x60
[   21.600283]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   21.601831]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   21.603260]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   21.604780]  [<c15298ba>] genl_unbind+0x85/0x8b
[   21.606168]  [<c152826b>] netlink_release+0x23e/0x254
[   21.617754]  [<c150329b>] sock_release+0x10/0x5b
[   21.619182]  [<c15032f1>] sock_close+0xb/0xf
[   21.620552]  [<c10c1621>] __fput+0xd0/0x15c
[   21.621907]  [<c10c16d3>] ____fput+0x8/0xa
[   21.623226]  [<c104adc8>] task_work_run+0x7c/0xa2
[   21.624694]  [<c103ba25>] do_exit+0x2f1/0x735
[   21.644108]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   21.645514]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   21.646968]  [<c103bec4>] do_group_exit+0x34/0x90
[   21.648428]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   21.649903]  [<c1537745>] syscall_call+0x7/0x7
[   21.651310]  [<c1530000>] ? pfn_pte+0xb/0x33
[   21.670715] ---[ end trace f84d29e8c69486c7 ]---
[   21.672136] ------------[ cut here ]------------
[   21.682563] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   21.685495] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   21.688228] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   21.704183]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   21.725760]  c15298ba c196a9c0 00000005 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   21.729201]  d14cbee0 c15298ba c187e800 c27cc4b0 00000005 c27cc5bc d14cb=
f00 c152826b
[   21.732662] Call Trace:
[   21.733725]  [<c1531d71>] dump_stack+0x48/0x60
[   21.735118]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   21.736690]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   21.738119]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   21.752668]  [<c15298ba>] genl_unbind+0x85/0x8b
[   21.754091]  [<c152826b>] netlink_release+0x23e/0x254
[   21.755584]  [<c150329b>] sock_release+0x10/0x5b
[   21.757021]  [<c15032f1>] sock_close+0xb/0xf
[   21.758382]  [<c10c1621>] __fput+0xd0/0x15c
[   21.759742]  [<c10c16d3>] ____fput+0x8/0xa
[   21.761082]  [<c104adc8>] task_work_run+0x7c/0xa2
[   21.762510]  [<c103ba25>] do_exit+0x2f1/0x735
[   21.763903]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   21.778352]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   21.779764]  [<c103bec4>] do_group_exit+0x34/0x90
[   21.781211]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   21.782680]  [<c1537745>] syscall_call+0x7/0x7
[   21.784083]  [<c1530000>] ? pfn_pte+0xb/0x33
[   21.785428] ---[ end trace f84d29e8c69486c8 ]---
[   21.786874] ------------[ cut here ]------------
[   21.788306] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   21.791241] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   21.793994] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   21.819946]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   21.823380]  c15298ba c196a9c0 00000006 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   21.838820]  d14cbee0 c15298ba c187e800 c27cc4b0 00000006 c27cc5bc d14cb=
f00 c152826b
[   21.850381] Call Trace:
[   21.854550]  [<c1531d71>] dump_stack+0x48/0x60
[   21.855949]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   21.859607]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   21.862114]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   21.865811]  [<c15298ba>] genl_unbind+0x85/0x8b
[   21.868458]  [<c152826b>] netlink_release+0x23e/0x254
[   21.869971]  [<c150329b>] sock_release+0x10/0x5b
[   21.871408]  [<c15032f1>] sock_close+0xb/0xf
[   21.872779]  [<c10c1621>] __fput+0xd0/0x15c
[   21.874128]  [<c10c16d3>] ____fput+0x8/0xa
[   21.875491]  [<c104adc8>] task_work_run+0x7c/0xa2
[   21.876988]  [<c103ba25>] do_exit+0x2f1/0x735
[   21.878366]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   21.879804]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   21.895064]  [<c103bec4>] do_group_exit+0x34/0x90
[   21.902657]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   21.904222]  [<c1537745>] syscall_call+0x7/0x7
[   21.905716]  [<c1530000>] ? pfn_pte+0xb/0x33
[   21.907094] ---[ end trace f84d29e8c69486c9 ]---
[   21.914983] ------------[ cut here ]------------
[   21.916414] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   21.919412] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   21.925373] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   21.934347]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   21.942948]  c15298ba c196a9c0 00000007 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   21.952624]  d14cbee0 c15298ba c187e800 c27cc4b0 00000007 c27cc5bc d14cb=
f00 c152826b
[   21.966147] Call Trace:
[   21.967185]  [<c1531d71>] dump_stack+0x48/0x60
[   21.975661]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   21.977219]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   21.984851]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   21.987491]  [<c15298ba>] genl_unbind+0x85/0x8b
[   21.988917]  [<c152826b>] netlink_release+0x23e/0x254
[   21.996490]  [<c150329b>] sock_release+0x10/0x5b
[   21.997934]  [<c15032f1>] sock_close+0xb/0xf
[   22.008394]  [<c10c1621>] __fput+0xd0/0x15c
[   22.009746]  [<c10c16d3>] ____fput+0x8/0xa
[   22.015154]  [<c104adc8>] task_work_run+0x7c/0xa2
[   22.033791]  [<c103ba25>] do_exit+0x2f1/0x735
[   22.035171]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   22.036576]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   22.038015]  [<c103bec4>] do_group_exit+0x34/0x90
[   22.039454]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   22.040947]  [<c1537745>] syscall_call+0x7/0x7
[   22.042339]  [<c1530000>] ? pfn_pte+0xb/0x33
[   22.065781] ---[ end trace f84d29e8c69486ca ]---
[   22.067215] ------------[ cut here ]------------
[   22.075801] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   22.078824] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   22.097738] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   22.100669]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   22.107228]  c15298ba c196a9c0 00000008 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   22.117149]  d14cbee0 c15298ba c187e800 c27cc4b0 00000008 c27cc5bc d14cb=
f00 c152826b
[   22.136863] Call Trace:
[   22.137886]  [<c1531d71>] dump_stack+0x48/0x60
[   22.139271]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   22.140842]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   22.142270]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   22.143788]  [<c15298ba>] genl_unbind+0x85/0x8b
[   22.154313]  [<c152826b>] netlink_release+0x23e/0x254
[   22.156999]  [<c150329b>] sock_release+0x10/0x5b
[   22.158428]  [<c15032f1>] sock_close+0xb/0xf
[   22.177852]  [<c10c1621>] __fput+0xd0/0x15c
[   22.179203]  [<c10c16d3>] ____fput+0x8/0xa
[   22.180546]  [<c104adc8>] task_work_run+0x7c/0xa2
[   22.185028]  [<c103ba25>] do_exit+0x2f1/0x735
[   22.186402]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   22.190847]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   22.192245]  [<c103bec4>] do_group_exit+0x34/0x90
[   22.197746]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   22.199192]  [<c1537745>] syscall_call+0x7/0x7
[   22.200596]  [<c1530000>] ? pfn_pte+0xb/0x33
[   22.201960] ---[ end trace f84d29e8c69486cb ]---
[   22.210740] ------------[ cut here ]------------
[   22.215186] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   22.231184] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   22.233938] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   22.236864]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   22.240320]  c15298ba c196a9c0 00000001 c27cd87c d14cbec8 c1039faa 00000=
009 00000000
[   22.243780]  d14cbee0 c15298ba c187e800 c27cd770 00000001 c27cd87c d14cb=
f00 c152826b
[   22.253400] Call Trace:
[   22.254425]  [<c1531d71>] dump_stack+0x48/0x60
[   22.258867]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   22.260432]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   22.264911]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   22.266406]  [<c15298ba>] genl_unbind+0x85/0x8b
[   22.267839]  [<c152826b>] netlink_release+0x23e/0x254
[   22.269328]  [<c150329b>] sock_release+0x10/0x5b
[   22.275948]  [<c15032f1>] sock_close+0xb/0xf
[   22.278318]  [<c10c1621>] __fput+0xd0/0x15c
[   22.282707]  [<c10c16d3>] ____fput+0x8/0xa
[   22.284046]  [<c104adc8>] task_work_run+0x7c/0xa2
[   22.285479]  [<c103ba25>] do_exit+0x2f1/0x735
[   22.289903]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   22.291326]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   22.297800]  [<c103bec4>] do_group_exit+0x34/0x90
[   22.299268]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   22.300763]  [<c1537745>] syscall_call+0x7/0x7
[   22.305176]  [<c1530000>] ? pfn_pte+0xb/0x33
[   22.306527] ---[ end trace f84d29e8c69486cc ]---
[   22.310990] ------------[ cut here ]------------
[   22.312403] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   22.318382] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   22.321152] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   22.324064]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   22.337754]  c15298ba c196a9c0 00000004 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   22.345898]  d14cbee0 c15298ba c187e800 c27cd770 00000004 c27cd87c d14cb=
f00 c152826b
[   22.349373] Call Trace:
[   22.350417]  [<c1531d71>] dump_stack+0x48/0x60
[   22.354845]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   22.356392]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   22.360901]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   22.362400]  [<c15298ba>] genl_unbind+0x85/0x8b
[   22.363824]  [<c152826b>] netlink_release+0x23e/0x254
[   22.371268]  [<c150329b>] sock_release+0x10/0x5b
[   22.372708]  [<c15032f1>] sock_close+0xb/0xf
[   22.390084]  [<c10c1621>] __fput+0xd0/0x15c
[   22.395661]  [<c10c16d3>] ____fput+0x8/0xa
[   22.397012]  [<c104adc8>] task_work_run+0x7c/0xa2
[   22.398446]  [<c103ba25>] do_exit+0x2f1/0x735
[   22.402858]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   22.404284]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   22.408728]  [<c103bec4>] do_group_exit+0x34/0x90
[   22.410211]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   22.411686]  [<c1537745>] syscall_call+0x7/0x7
[   22.413069]  [<c1530000>] ? pfn_pte+0xb/0x33
[   22.414437] ---[ end trace f84d29e8c69486cd ]---
[   22.423912] ------------[ cut here ]------------
[   22.427075] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   22.431157] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   22.452033] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   22.459067]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   22.468787]  c15298ba c196a9c0 00000005 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   22.487386]  d14cbee0 c15298ba c187e800 c27cd770 00000005 c27cd87c d14cb=
f00 c152826b
[   22.497012] Call Trace:
[   22.498043]  [<c1531d71>] dump_stack+0x48/0x60
[   22.502544]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   22.504123]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   22.513722]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   22.515242]  [<c15298ba>] genl_unbind+0x85/0x8b
[   22.525726]  [<c152826b>] netlink_release+0x23e/0x254
[   22.527254]  [<c150329b>] sock_release+0x10/0x5b
[   22.531767]  [<c15032f1>] sock_close+0xb/0xf
[   22.533147]  [<c10c1621>] __fput+0xd0/0x15c
[   22.534531]  [<c10c16d3>] ____fput+0x8/0xa
[   22.539014]  [<c104adc8>] task_work_run+0x7c/0xa2
[   22.540473]  [<c103ba25>] do_exit+0x2f1/0x735
[   22.544901]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   22.546309]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   22.559946]  [<c103bec4>] do_group_exit+0x34/0x90
[   22.561413]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   22.565977]  [<c1537745>] syscall_call+0x7/0x7
[   22.567377]  [<c1530000>] ? pfn_pte+0xb/0x33
[   22.578476] ---[ end trace f84d29e8c69486ce ]---
[   22.584534] ------------[ cut here ]------------
[   22.589023] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   22.604053] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   22.608939] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   22.611908]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   22.630721]  c15298ba c196a9c0 00000006 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   22.636941]  d14cbee0 c15298ba c187e800 c27cd770 00000006 c27cd87c d14cb=
f00 c152826b
[   22.643960] Call Trace:
[   22.644998]  [<c1531d71>] dump_stack+0x48/0x60
[   22.655538]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   22.657144]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   22.661779]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   22.663315]  [<c15298ba>] genl_unbind+0x85/0x8b
[   22.667790]  [<c152826b>] netlink_release+0x23e/0x254
[   22.669318]  [<c150329b>] sock_release+0x10/0x5b
[   22.682881]  [<c15032f1>] sock_close+0xb/0xf
[   22.684260]  [<c10c1621>] __fput+0xd0/0x15c
[   22.688737]  [<c10c16d3>] ____fput+0x8/0xa
[   22.690075]  [<c104adc8>] task_work_run+0x7c/0xa2
[   22.705714]  [<c103ba25>] do_exit+0x2f1/0x735
[   22.707102]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   22.708510]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   22.717309]  [<c103bec4>] do_group_exit+0x34/0x90
[   22.721891]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   22.723394]  [<c1537745>] syscall_call+0x7/0x7
[   22.727907]  [<c1530000>] ? pfn_pte+0xb/0x33
[   22.729287] ---[ end trace f84d29e8c69486cf ]---
[   22.740347] ------------[ cut here ]------------
[   22.741791] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   22.748047] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   22.761903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   22.770885]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   22.777553]  c15298ba c196a9c0 00000007 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   22.784262]  d14cbee0 c15298ba c187e800 c27cd770 00000007 c27cd87c d14cb=
f00 c152826b
[   22.801973] Call Trace:
[   22.803019]  [<c1531d71>] dump_stack+0x48/0x60
[   22.804426]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   22.808260]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   22.809709]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   22.823284]  [<c15298ba>] genl_unbind+0x85/0x8b
[   22.824725]  [<c152826b>] netlink_release+0x23e/0x254
[   22.832248]  [<c150329b>] sock_release+0x10/0x5b
[   22.833701]  [<c15032f1>] sock_close+0xb/0xf
[   22.835066]  [<c10c1621>] __fput+0xd0/0x15c
[   22.836399]  [<c10c16d3>] ____fput+0x8/0xa
[   22.855644]  [<c104adc8>] task_work_run+0x7c/0xa2
[   22.857091]  [<c103ba25>] do_exit+0x2f1/0x735
[   22.858481]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   22.859905]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   22.861314]  [<c103bec4>] do_group_exit+0x34/0x90
[   22.862761]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   22.864221]  [<c1537745>] syscall_call+0x7/0x7
[   22.881663]  [<c1530000>] ? pfn_pte+0xb/0x33
[   22.883018] ---[ end trace f84d29e8c69486d0 ]---
[   22.884451] ------------[ cut here ]------------
[   22.885888] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   22.903395] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   22.915125] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   22.918020]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   22.921493]  c15298ba c196a9c0 00000008 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   22.939977]  d14cbee0 c15298ba c187e800 c27cd770 00000008 c27cd87c d14cb=
f00 c152826b
[   22.943446] Call Trace:
[   22.944465]  [<c1531d71>] dump_stack+0x48/0x60
[   22.945858]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   22.956039]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   22.957500]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   22.973061]  [<c15298ba>] genl_unbind+0x85/0x8b
[   22.974480]  [<c152826b>] netlink_release+0x23e/0x254
[   22.976006]  [<c150329b>] sock_release+0x10/0x5b
[   22.977436]  [<c15032f1>] sock_close+0xb/0xf
[   22.984558]  [<c10c1621>] __fput+0xd0/0x15c
[   22.985917]  [<c10c16d3>] ____fput+0x8/0xa
[   22.990354]  [<c104adc8>] task_work_run+0x7c/0xa2
[   22.991813]  [<c103ba25>] do_exit+0x2f1/0x735
[   23.008098]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   23.009532]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   23.011010]  [<c103bec4>] do_group_exit+0x34/0x90
[   23.012444]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   23.013945]  [<c1537745>] syscall_call+0x7/0x7
[   23.015337]  [<c1530000>] ? pfn_pte+0xb/0x33
[   23.019765] ---[ end trace f84d29e8c69486d1 ]---
[   23.021314] ------------[ cut here ]------------
[   23.025797] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   23.030784] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   23.033526] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   23.045189]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   23.051751]  c15298ba c196a9c0 00000006 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   23.058299]  d14cbee0 c15298ba c187e800 c27cdc20 00000006 c27cdd2c d14cb=
f00 c152826b
[   23.064838] Call Trace:
[   23.065869]  [<c1531d71>] dump_stack+0x48/0x60
[   23.070303]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   23.071866]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   23.076335]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   23.080800]  [<c15298ba>] genl_unbind+0x85/0x8b
[   23.082215]  [<c152826b>] netlink_release+0x23e/0x254
[   23.086769]  [<c150329b>] sock_release+0x10/0x5b
[   23.088190]  [<c15032f1>] sock_close+0xb/0xf
[   23.089545]  [<c10c1621>] __fput+0xd0/0x15c
[   23.093973]  [<c10c16d3>] ____fput+0x8/0xa
[   23.095300]  [<c104adc8>] task_work_run+0x7c/0xa2
[   23.099811]  [<c103ba25>] do_exit+0x2f1/0x735
[   23.101195]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   23.105644]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   23.107060]  [<c103bec4>] do_group_exit+0x34/0x90
[   23.112444]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   23.113983]  [<c1537745>] syscall_call+0x7/0x7
[   23.115368]  [<c1530000>] ? pfn_pte+0xb/0x33
[   23.119759] ---[ end trace f84d29e8c69486d2 ]---
[   23.121907] ------------[ cut here ]------------
[   23.126349] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   23.132292] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   23.154696] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   23.160644]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   23.175975]  c15298ba c196a9c0 00000001 c27de68c d14cbec8 c1039faa 00000=
009 00000000
[   23.180756]  d14cbee0 c15298ba c187e800 c27de580 00000001 c27de68c d14cb=
f00 c152826b
[   23.184191] Call Trace:
[   23.185213]  [<c1531d71>] dump_stack+0x48/0x60
[   23.186589]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   23.188166]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   23.193041]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   23.194585]  [<c15298ba>] genl_unbind+0x85/0x8b
[   23.199025]  [<c152826b>] netlink_release+0x23e/0x254
[   23.200532]  [<c150329b>] sock_release+0x10/0x5b
[   23.201965]  [<c15032f1>] sock_close+0xb/0xf
[   23.206272]  [<c10c1621>] __fput+0xd0/0x15c
[   23.207639]  [<c10c16d3>] ____fput+0x8/0xa
[   23.212007]  [<c104adc8>] task_work_run+0x7c/0xa2
[   23.215509]  [<c103ba25>] do_exit+0x2f1/0x735
[   23.216909]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   23.218311]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   23.219730]  [<c103bec4>] do_group_exit+0x34/0x90
[   23.221177]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   23.222649]  [<c1537745>] syscall_call+0x7/0x7
[   23.224050]  [<c1530000>] ? pfn_pte+0xb/0x33
[   23.225403] ---[ end trace f84d29e8c69486d3 ]---
[   23.240131] ------------[ cut here ]------------
[   23.241553] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   23.244502] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   23.250272] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   23.266222]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   23.269722]  c15298ba c196a9c0 00000004 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   23.273186]  d14cbee0 c15298ba c187e800 c27de580 00000004 c27de68c d14cb=
f00 c152826b
[   23.279693] Call Trace:
[   23.280730]  [<c1531d71>] dump_stack+0x48/0x60
[   23.295209]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   23.296830]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   23.298266]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   23.299777]  [<c15298ba>] genl_unbind+0x85/0x8b
[   23.301192]  [<c152826b>] netlink_release+0x23e/0x254
[   23.302702]  [<c150329b>] sock_release+0x10/0x5b
[   23.304135]  [<c15032f1>] sock_close+0xb/0xf
[   23.305482]  [<c10c1621>] __fput+0xd0/0x15c
[   23.306869]  [<c10c16d3>] ____fput+0x8/0xa
[   23.309338]  [<c104adc8>] task_work_run+0x7c/0xa2
[   23.313854]  [<c103ba25>] do_exit+0x2f1/0x735
[   23.315232]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   23.319706]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   23.321136]  [<c103bec4>] do_group_exit+0x34/0x90
[   23.325599]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   23.327099]  [<c1537745>] syscall_call+0x7/0x7
[   23.331541]  [<c1530000>] ? pfn_pte+0xb/0x33
[   23.332975] ---[ end trace f84d29e8c69486d4 ]---
[   23.337503] ------------[ cut here ]------------
[   23.338943] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   23.341856] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   23.344565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   23.358680]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   23.365167]  c15298ba c196a9c0 00000005 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   23.371659]  d14cbee0 c15298ba c187e800 c27de580 00000005 c27de68c d14cb=
f00 c152826b
[   23.376410] Call Trace:
[   23.377484]  [<c1531d71>] dump_stack+0x48/0x60
[   23.393927]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   23.395479]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   23.403110]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   23.404721]  [<c15298ba>] genl_unbind+0x85/0x8b
[   23.406148]  [<c152826b>] netlink_release+0x23e/0x254
[   23.407677]  [<c150329b>] sock_release+0x10/0x5b
[   23.409094]  [<c15032f1>] sock_close+0xb/0xf
[   23.415512]  [<c10c1621>] __fput+0xd0/0x15c
[   23.430948]  [<c10c16d3>] ____fput+0x8/0xa
[   23.432297]  [<c104adc8>] task_work_run+0x7c/0xa2
[   23.434913]  [<c103ba25>] do_exit+0x2f1/0x735
[   23.439342]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   23.440782]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   23.451283]  [<c103bec4>] do_group_exit+0x34/0x90
[   23.452741]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   23.457347]  [<c1537745>] syscall_call+0x7/0x7
[   23.458763]  [<c1530000>] ? pfn_pte+0xb/0x33
[   23.460176] ---[ end trace f84d29e8c69486d5 ]---
[   23.461634] ------------[ cut here ]------------
[   23.463130] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   23.469113] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   23.490015] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   23.495942]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   23.511457]  c15298ba c196a9c0 00000006 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   23.518010]  d14cbee0 c15298ba c187e800 c27de580 00000006 c27de68c d14cb=
f00 c152826b
[   23.530550] Call Trace:
[   23.531578]  [<c1531d71>] dump_stack+0x48/0x60
[   23.537714]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   23.543552]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   23.548105]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   23.549623]  [<c15298ba>] genl_unbind+0x85/0x8b
[   23.551110]  [<c152826b>] netlink_release+0x23e/0x254
[   23.563954]  [<c150329b>] sock_release+0x10/0x5b
[   23.565370]  [<c15032f1>] sock_close+0xb/0xf
[   23.569856]  [<c10c1621>] __fput+0xd0/0x15c
[   23.571271]  [<c10c16d3>] ____fput+0x8/0xa
[   23.581701]  [<c104adc8>] task_work_run+0x7c/0xa2
[   23.583138]  [<c103ba25>] do_exit+0x2f1/0x735
[   23.587675]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   23.589080]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   23.590535]  [<c103bec4>] do_group_exit+0x34/0x90
[   23.595028]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   23.596476]  [<c1537745>] syscall_call+0x7/0x7
[   23.611401]  [<c1530000>] ? pfn_pte+0xb/0x33
[   23.615863] ---[ end trace f84d29e8c69486d6 ]---
[   23.617304] ------------[ cut here ]------------
[   23.627851] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   23.630935] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   23.639199] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   23.654186]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   23.660675]  c15298ba c196a9c0 00000007 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   23.667173]  d14cbee0 c15298ba c187e800 c27de580 00000007 c27de68c d14cb=
f00 c152826b
[   23.676759] Call Trace:
[   23.677801]  [<c1531d71>] dump_stack+0x48/0x60
[   23.679188]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   23.683771]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   23.685199]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   23.692354]  [<c15298ba>] genl_unbind+0x85/0x8b
[   23.693805]  [<c152826b>] netlink_release+0x23e/0x254
[   23.695301]  [<c150329b>] sock_release+0x10/0x5b
[   23.696951]  [<c15032f1>] sock_close+0xb/0xf
[   23.698322]  [<c10c1621>] __fput+0xd0/0x15c
[   23.699836]  [<c10c16d3>] ____fput+0x8/0xa
[   23.701182]  [<c104adc8>] task_work_run+0x7c/0xa2
[   23.702698]  [<c103ba25>] do_exit+0x2f1/0x735
[   23.704184]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   23.705916]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   23.707361]  [<c103bec4>] do_group_exit+0x34/0x90
[   23.708964]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   23.710503]  [<c1537745>] syscall_call+0x7/0x7
[   23.711979]  [<c1530000>] ? pfn_pte+0xb/0x33
[   23.713331] ---[ end trace f84d29e8c69486d7 ]---
[   23.714939] ------------[ cut here ]------------
[   23.716371] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   23.720891] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   23.723648] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   23.726520]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   23.730035]  c15298ba c196a9c0 00000008 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   23.733643]  d14cbee0 c15298ba c187e800 c27de580 00000008 c27de68c d14cb=
f00 c152826b
[   23.737082] Call Trace:
[   23.738108]  [<c1531d71>] dump_stack+0x48/0x60
[   23.739517]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   23.741113]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   23.742552]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   23.744080]  [<c15298ba>] genl_unbind+0x85/0x8b
[   23.753688]  [<c152826b>] netlink_release+0x23e/0x254
[   23.755199]  [<c150329b>] sock_release+0x10/0x5b
[   23.756691]  [<c15032f1>] sock_close+0xb/0xf
[   23.758056]  [<c10c1621>] __fput+0xd0/0x15c
[   23.759393]  [<c10c16d3>] ____fput+0x8/0xa
[   23.760786]  [<c104adc8>] task_work_run+0x7c/0xa2
[   23.762292]  [<c103ba25>] do_exit+0x2f1/0x735
[   23.763794]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   23.765209]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   23.766645]  [<c103bec4>] do_group_exit+0x34/0x90
[   23.768085]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   23.769535]  [<c1537745>] syscall_call+0x7/0x7
[   23.770946]  [<c1530000>] ? pfn_pte+0xb/0x33
[   23.776056] ---[ end trace f84d29e8c69486d8 ]---
[   23.777524] ------------[ cut here ]------------
[   23.778984] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   23.781951] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   23.784771] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   23.790762]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   23.797257]  c15298ba c196a9c0 00000009 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   23.803791]  d14cbee0 c15298ba c187e800 c27de580 00000009 c27de68c d14cb=
f00 c152826b
[   23.810315] Call Trace:
[   23.814365]  [<c1531d71>] dump_stack+0x48/0x60
[   23.815764]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   23.820368]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   23.821837]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   23.840963]  [<c15298ba>] genl_unbind+0x85/0x8b
[   23.842386]  [<c152826b>] netlink_release+0x23e/0x254
[   23.847001]  [<c150329b>] sock_release+0x10/0x5b
[   23.848423]  [<c15032f1>] sock_close+0xb/0xf
[   23.853973]  [<c10c1621>] __fput+0xd0/0x15c
[   23.855844]  [<c10c16d3>] ____fput+0x8/0xa
[   23.857196]  [<c104adc8>] task_work_run+0x7c/0xa2
[   23.867790]  [<c103ba25>] do_exit+0x2f1/0x735
[   23.869161]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   23.873971]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   23.876477]  [<c103bec4>] do_group_exit+0x34/0x90
[   23.877950]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   23.889523]  [<c1537745>] syscall_call+0x7/0x7
[   23.890951]  [<c1530000>] ? pfn_pte+0xb/0x33
[   23.895728] ---[ end trace f84d29e8c69486d9 ]---
[   23.907284] ------------[ cut here ]------------
[   23.910777] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   23.916803] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   23.922702] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   23.938074]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   23.944705]  c15298ba c196a9c0 0000000a 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   23.971306]  d14cbee0 c15298ba c187e800 c27de580 0000000a c27de68c d14cb=
f00 c152826b
[   23.974757] Call Trace:
[   23.975784]  [<c1531d71>] dump_stack+0x48/0x60
[   23.977191]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   23.978785]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   23.980235]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   23.984783]  [<c15298ba>] genl_unbind+0x85/0x8b
[   23.986185]  [<c152826b>] netlink_release+0x23e/0x254
[   23.990694]  [<c150329b>] sock_release+0x10/0x5b
[   23.992114]  [<c15032f1>] sock_close+0xb/0xf
[   23.996510]  [<c10c1621>] __fput+0xd0/0x15c
[   23.997884]  [<c10c16d3>] ____fput+0x8/0xa
[   24.002240]  [<c104adc8>] task_work_run+0x7c/0xa2
[   24.003713]  [<c103ba25>] do_exit+0x2f1/0x735
[   24.007350]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   24.008838]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   24.013701]  [<c103bec4>] do_group_exit+0x34/0x90
[   24.015139]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   24.019637]  [<c1537745>] syscall_call+0x7/0x7
[   24.021042]  [<c1530000>] ? pfn_pte+0xb/0x33
[   24.027265] ---[ end trace f84d29e8c69486da ]---
[   24.028757] ------------[ cut here ]------------
[   24.030210] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   24.036212] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   24.039963] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   24.045911]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   24.049467]  c15298ba c196a9c0 0000000b 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   24.053296]  d14cbee0 c15298ba c187e800 c27de580 0000000b c27de68c d14cb=
f00 c152826b
[   24.070243] Call Trace:
[   24.071349]  [<c1531d71>] dump_stack+0x48/0x60
[   24.085883]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   24.087488]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   24.089069]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   24.090668]  [<c15298ba>] genl_unbind+0x85/0x8b
[   24.092073]  [<c152826b>] netlink_release+0x23e/0x254
[   24.093590]  [<c150329b>] sock_release+0x10/0x5b
[   24.095022]  [<c15032f1>] sock_close+0xb/0xf
[   24.096413]  [<c10c1621>] __fput+0xd0/0x15c
[   24.097796]  [<c10c16d3>] ____fput+0x8/0xa
[   24.102345]  [<c104adc8>] task_work_run+0x7c/0xa2
[   24.103997]  [<c103ba25>] do_exit+0x2f1/0x735
[   24.118495]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   24.120072]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   24.121475]  [<c103bec4>] do_group_exit+0x34/0x90
[   24.122941]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   24.124526]  [<c1537745>] syscall_call+0x7/0x7
[   24.126041]  [<c1530000>] ? pfn_pte+0xb/0x33
[   24.127417] ---[ end trace f84d29e8c69486db ]---
[   24.131934] ------------[ cut here ]------------
[   24.133461] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   24.138535] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   24.147591] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   24.153567]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   24.160099]  c15298ba c196a9c0 0000000c 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   24.166555]  d14cbee0 c15298ba c187e800 c27de580 0000000c c27de68c d14cb=
f00 c152826b
[   24.173105] Call Trace:
[   24.187199]  [<c1531d71>] dump_stack+0x48/0x60
[   24.188601]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   24.190223]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   24.191677]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   24.193168]  [<c15298ba>] genl_unbind+0x85/0x8b
[   24.194580]  [<c152826b>] netlink_release+0x23e/0x254
[   24.196082]  [<c150329b>] sock_release+0x10/0x5b
[   24.197514]  [<c15032f1>] sock_close+0xb/0xf
[   24.198893]  [<c10c1621>] __fput+0xd0/0x15c
[   24.200285]  [<c10c16d3>] ____fput+0x8/0xa
[   24.204667]  [<c104adc8>] task_work_run+0x7c/0xa2
[   24.206106]  [<c103ba25>] do_exit+0x2f1/0x735
[   24.207520]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   24.211974]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   24.213390]  [<c103bec4>] do_group_exit+0x34/0x90
[   24.217874]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   24.219320]  [<c1537745>] syscall_call+0x7/0x7
[   24.226779]  [<c1530000>] ? pfn_pte+0xb/0x33
[   24.228143] ---[ end trace f84d29e8c69486dc ]---
[   24.229567] ------------[ cut here ]------------
[   24.231014] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   24.233951] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   24.236694] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   24.247737]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   24.254240]  c15298ba c196a9c0 0000000d 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   24.263777]  d14cbee0 c15298ba c187e800 c27de580 0000000d c27de68c d14cb=
f00 c152826b
[   24.270253] Call Trace:
[   24.271280]  [<c1531d71>] dump_stack+0x48/0x60
[   24.275499]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   24.281127]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   24.282569]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   24.287111]  [<c15298ba>] genl_unbind+0x85/0x8b
[   24.288518]  [<c152826b>] netlink_release+0x23e/0x254
[   24.293088]  [<c150329b>] sock_release+0x10/0x5b
[   24.294525]  [<c15032f1>] sock_close+0xb/0xf
[   24.298926]  [<c10c1621>] __fput+0xd0/0x15c
[   24.300326]  [<c10c16d3>] ____fput+0x8/0xa
[   24.301672]  [<c104adc8>] task_work_run+0x7c/0xa2
[   24.306132]  [<c103ba25>] do_exit+0x2f1/0x735
[   24.307521]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   24.308942]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   24.310385]  [<c103bec4>] do_group_exit+0x34/0x90
[   24.317198]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   24.318669]  [<c1537745>] syscall_call+0x7/0x7
[   24.323090]  [<c1530000>] ? pfn_pte+0xb/0x33
[   24.324461] ---[ end trace f84d29e8c69486dd ]---
[   24.328933] ------------[ cut here ]------------
[   24.357462] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   24.360407] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   24.363143] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   24.366073]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   24.369578]  c15298ba c196a9c0 0000000e 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   24.376093]  d14cbee0 c15298ba c187e800 c27de580 0000000e c27de68c d14cb=
f00 c152826b
[   24.382607] Call Trace:
[   24.386690]  [<c1531d71>] dump_stack+0x48/0x60
[   24.388080]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   24.392683]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   24.394129]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   24.401453]  [<c15298ba>] genl_unbind+0x85/0x8b
[   24.402891]  [<c152826b>] netlink_release+0x23e/0x254
[   24.404402]  [<c150329b>] sock_release+0x10/0x5b
[   24.413926]  [<c15032f1>] sock_close+0xb/0xf
[   24.415290]  [<c10c1621>] __fput+0xd0/0x15c
[   24.416663]  [<c10c16d3>] ____fput+0x8/0xa
[   24.418004]  [<c104adc8>] task_work_run+0x7c/0xa2
[   24.419446]  [<c103ba25>] do_exit+0x2f1/0x735
[   24.420882]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   24.422286]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   24.426735]  [<c103bec4>] do_group_exit+0x34/0x90
[   24.428219]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   24.432718]  [<c1537745>] syscall_call+0x7/0x7
[   24.434123]  [<c1530000>] ? pfn_pte+0xb/0x33
[   24.435472] ---[ end trace f84d29e8c69486de ]---
[   24.436919] ------------[ cut here ]------------
[   24.438337] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   24.441299] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   24.457601] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   24.460550]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   24.470070]  c15298ba c196a9c0 0000000f 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   24.476532]  d14cbee0 c15298ba c187e800 c27de580 0000000f c27de68c d14cb=
f00 c152826b
[   24.479995] Call Trace:
[   24.481060]  [<c1531d71>] dump_stack+0x48/0x60
[   24.482443]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   24.492241]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   24.493719]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   24.498263]  [<c15298ba>] genl_unbind+0x85/0x8b
[   24.499701]  [<c152826b>] netlink_release+0x23e/0x254
[   24.504366]  [<c150329b>] sock_release+0x10/0x5b
[   24.505808]  [<c15032f1>] sock_close+0xb/0xf
[   24.509934]  [<c10c1621>] __fput+0xd0/0x15c
[   24.511291]  [<c10c16d3>] ____fput+0x8/0xa
[   24.515656]  [<c104adc8>] task_work_run+0x7c/0xa2
[   24.517107]  [<c103ba25>] do_exit+0x2f1/0x735
[   24.518477]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   24.519894]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   24.521311]  [<c103bec4>] do_group_exit+0x34/0x90
[   24.531743]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   24.533199]  [<c1537745>] syscall_call+0x7/0x7
[   24.534603]  [<c1530000>] ? pfn_pte+0xb/0x33
[   24.538995] ---[ end trace f84d29e8c69486df ]---
[   24.545282] ------------[ cut here ]------------
[   24.546742] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   24.552863] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   24.558650] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   24.564577]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   24.569518]  c15298ba c196a9c0 00000001 d150d87c d14cbec8 c1039faa 00000=
009 00000000
[   24.579103]  d14cbee0 c15298ba c187e800 d150d770 00000001 d150d87c d14cb=
f00 c152826b
[   24.585287] Call Trace:
[   24.587343]  [<c1531d71>] dump_stack+0x48/0x60
[   24.588741]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   24.593367]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   24.594813]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   24.599335]  [<c15298ba>] genl_unbind+0x85/0x8b
[   24.600817]  [<c152826b>] netlink_release+0x23e/0x254
[   24.609349]  [<c150329b>] sock_release+0x10/0x5b
[   24.610807]  [<c15032f1>] sock_close+0xb/0xf
[   24.612166]  [<c10c1621>] __fput+0xd0/0x15c
[   24.613600]  [<c10c16d3>] ____fput+0x8/0xa
[   24.614975]  [<c104adc8>] task_work_run+0x7c/0xa2
[   24.619436]  [<c103ba25>] do_exit+0x2f1/0x735
[   24.620834]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   24.625262]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   24.626688]  [<c103bec4>] do_group_exit+0x34/0x90
[   24.628123]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   24.629571]  [<c1537745>] syscall_call+0x7/0x7
[   24.630984]  [<c1530000>] ? pfn_pte+0xb/0x33
[   24.642424] ---[ end trace f84d29e8c69486e0 ]---
[   24.643902] ------------[ cut here ]------------
[   24.645329] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   24.651104] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   24.656880] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   24.663939]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   24.670444]  c15298ba c196a9c0 00000005 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   24.676940]  d14cbee0 c15298ba c187e800 d150d770 00000005 d150d87c d14cb=
f00 c152826b
[   24.685429] Call Trace:
[   24.686473]  [<c1531d71>] dump_stack+0x48/0x60
[   24.687895]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   24.692480]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   24.693954]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   24.698483]  [<c15298ba>] genl_unbind+0x85/0x8b
[   24.699916]  [<c152826b>] netlink_release+0x23e/0x254
[   24.704485]  [<c150329b>] sock_release+0x10/0x5b
[   24.705919]  [<c15032f1>] sock_close+0xb/0xf
[   24.707284]  [<c10c1621>] __fput+0xd0/0x15c
[   24.708632]  [<c10c16d3>] ____fput+0x8/0xa
[   24.715164]  [<c104adc8>] task_work_run+0x7c/0xa2
[   24.716743]  [<c103ba25>] do_exit+0x2f1/0x735
[   24.718121]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   24.719532]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   24.720969]  [<c103bec4>] do_group_exit+0x34/0x90
[   24.722415]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   24.732835]  [<c1537745>] syscall_call+0x7/0x7
[   24.734245]  [<c1530000>] ? pfn_pte+0xb/0x33
[   24.738637] ---[ end trace f84d29e8c69486e1 ]---
[   24.740072] ------------[ cut here ]------------
[   24.741499] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   24.757489] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   24.760250] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   24.763204]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   24.769711]  c15298ba c196a9c0 00000006 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   24.776246]  d14cbee0 c15298ba c187e800 d150d770 00000006 d150d87c d14cb=
f00 c152826b
[   24.782784] Call Trace:
[   24.783828]  [<c1531d71>] dump_stack+0x48/0x60
[   24.788240]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   24.789792]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   24.791237]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   24.792747]  [<c15298ba>] genl_unbind+0x85/0x8b
[   24.794157]  [<c152826b>] netlink_release+0x23e/0x254
[   24.795660]  [<c150329b>] sock_release+0x10/0x5b
[   24.797120]  [<c15032f1>] sock_close+0xb/0xf
[   24.798479]  [<c10c1621>] __fput+0xd0/0x15c
[   24.799861]  [<c10c16d3>] ____fput+0x8/0xa
[   24.815320]  [<c104adc8>] task_work_run+0x7c/0xa2
[   24.816902]  [<c103ba25>] do_exit+0x2f1/0x735
[   24.818280]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   24.819695]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   24.821115]  [<c103bec4>] do_group_exit+0x34/0x90
[   24.822548]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   24.824028]  [<c1537745>] syscall_call+0x7/0x7
[   24.838806]  [<c1530000>] ? pfn_pte+0xb/0x33
[   24.840216] ---[ end trace f84d29e8c69486e2 ]---
[   24.841668] ------------[ cut here ]------------
[   24.843094] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   24.849038] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   24.854809] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   24.860813]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   24.867308]  c15298ba c196a9c0 00000009 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   24.883839]  d14cbee0 c15298ba c187e800 d150d770 00000009 d150d87c d14cb=
f00 c152826b
[   24.887321] Call Trace:
[   24.888347]  [<c1531d71>] dump_stack+0x48/0x60
[   24.889774]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   24.901430]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   24.905916]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   24.907438]  [<c15298ba>] genl_unbind+0x85/0x8b
[   24.908853]  [<c152826b>] netlink_release+0x23e/0x254
[   24.910378]  [<c150329b>] sock_release+0x10/0x5b
[   24.911806]  [<c15032f1>] sock_close+0xb/0xf
[   24.913160]  [<c10c1621>] __fput+0xd0/0x15c
[   24.914514]  [<c10c16d3>] ____fput+0x8/0xa
[   24.915855]  [<c104adc8>] task_work_run+0x7c/0xa2
[   24.917294]  [<c103ba25>] do_exit+0x2f1/0x735
[   24.946426]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   24.947868]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   24.951137]  [<c103bec4>] do_group_exit+0x34/0x90
[   24.961601]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   24.963068]  [<c1537745>] syscall_call+0x7/0x7
[   24.967580]  [<c1530000>] ? pfn_pte+0xb/0x33
[   24.968959] ---[ end trace f84d29e8c69486e3 ]---
[   24.974560] ------------[ cut here ]------------
[   24.985044] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   24.991133] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   24.997029] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   25.003066]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   25.010762]  c15298ba c196a9c0 0000000a 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   25.029505]  d14cbee0 c15298ba c187e800 d150d770 0000000a d150d87c d14cb=
f00 c152826b
[   25.039060] Call Trace:
[   25.040104]  [<c1531d71>] dump_stack+0x48/0x60
[   25.041496]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   25.047902]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   25.051293]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   25.069854]  [<c15298ba>] genl_unbind+0x85/0x8b
[   25.071268]  [<c152826b>] netlink_release+0x23e/0x254
[   25.072765]  [<c150329b>] sock_release+0x10/0x5b
[   25.074187]  [<c15032f1>] sock_close+0xb/0xf
[   25.075541]  [<c10c1621>] __fput+0xd0/0x15c
[   25.076901]  [<c10c16d3>] ____fput+0x8/0xa
[   25.079478]  [<c104adc8>] task_work_run+0x7c/0xa2
[   25.081004]  [<c103ba25>] do_exit+0x2f1/0x735
[   25.082376]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   25.096838]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   25.099260]  [<c103bec4>] do_group_exit+0x34/0x90
[   25.100718]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   25.102164]  [<c1537745>] syscall_call+0x7/0x7
[   25.103553]  [<c1530000>] ? pfn_pte+0xb/0x33
[   25.104938] ---[ end trace f84d29e8c69486e4 ]---
[   25.106342] ------------[ cut here ]------------
[   25.107789] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   25.116751] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   25.119530] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   25.122432]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   25.128699]  c15298ba c196a9c0 0000000b 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   25.132131]  d14cbee0 c15298ba c187e800 d150d770 0000000b d150d87c d14cb=
f00 c152826b
[   25.135565] Call Trace:
[   25.136591]  [<c1531d71>] dump_stack+0x48/0x60
[   25.152227]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   25.153793]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   25.155224]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   25.156744]  [<c15298ba>] genl_unbind+0x85/0x8b
[   25.170381]  [<c152826b>] netlink_release+0x23e/0x254
[   25.171887]  [<c150329b>] sock_release+0x10/0x5b
[   25.173305]  [<c15032f1>] sock_close+0xb/0xf
[   25.174678]  [<c10c1621>] __fput+0xd0/0x15c
[   25.176014]  [<c10c16d3>] ____fput+0x8/0xa
[   25.177342]  [<c104adc8>] task_work_run+0x7c/0xa2
[   25.178851]  [<c103ba25>] do_exit+0x2f1/0x735
[   25.180230]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   25.181651]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   25.183050]  [<c103bec4>] do_group_exit+0x34/0x90
[   25.184489]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   25.185949]  [<c1537745>] syscall_call+0x7/0x7
[   25.187344]  [<c1530000>] ? pfn_pte+0xb/0x33
[   25.188704] ---[ end trace f84d29e8c69486e5 ]---
[   25.208171] ------------[ cut here ]------------
[   25.209576] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   25.212495] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   25.215226] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   25.222503]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   25.225961]  c15298ba c196a9c0 0000000d 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   25.229423]  d14cbee0 c15298ba c187e800 d150d770 0000000d d150d87c d14cb=
f00 c152826b
[   25.232869] Call Trace:
[   25.251934]  [<c1531d71>] dump_stack+0x48/0x60
[   25.253319]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   25.254883]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   25.256304]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   25.257882]  [<c15298ba>] genl_unbind+0x85/0x8b
[   25.259278]  [<c152826b>] netlink_release+0x23e/0x254
[   25.260815]  [<c150329b>] sock_release+0x10/0x5b
[   25.262225]  [<c15032f1>] sock_close+0xb/0xf
[   25.263591]  [<c10c1621>] __fput+0xd0/0x15c
[   25.264945]  [<c10c16d3>] ____fput+0x8/0xa
[   25.266271]  [<c104adc8>] task_work_run+0x7c/0xa2
[   25.267733]  [<c103ba25>] do_exit+0x2f1/0x735
[   25.269102]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   25.290545]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   25.291961]  [<c103bec4>] do_group_exit+0x34/0x90
[   25.293397]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   25.294852]  [<c1537745>] syscall_call+0x7/0x7
[   25.296232]  [<c1530000>] ? pfn_pte+0xb/0x33
[   25.297656] ---[ end trace f84d29e8c69486e6 ]---
[   25.299072] ------------[ cut here ]------------
[   25.300495] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   25.303456] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   25.306161] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   25.309051]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   25.323549]  c15298ba c196a9c0 0000000f 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   25.334658]  d14cbee0 c15298ba c187e800 d150d770 0000000f d150d87c d14cb=
f00 c152826b
[   25.339291] Call Trace:
[   25.340350]  [<c1531d71>] dump_stack+0x48/0x60
[   25.341748]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   25.343284]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   25.344740]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   25.346227]  [<c15298ba>] genl_unbind+0x85/0x8b
[   25.347659]  [<c152826b>] netlink_release+0x23e/0x254
[   25.349149]  [<c150329b>] sock_release+0x10/0x5b
[   25.350570]  [<c15032f1>] sock_close+0xb/0xf
[   25.369968]  [<c10c1621>] __fput+0xd0/0x15c
[   25.371318]  [<c10c16d3>] ____fput+0x8/0xa
[   25.372646]  [<c104adc8>] task_work_run+0x7c/0xa2
[   25.374090]  [<c103ba25>] do_exit+0x2f1/0x735
[   25.375457]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   25.376875]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   25.390514]  [<c103bec4>] do_group_exit+0x34/0x90
[   25.391959]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   25.393412]  [<c1537745>] syscall_call+0x7/0x7
[   25.394805]  [<c1530000>] ? pfn_pte+0xb/0x33
[   25.396157] ---[ end trace f84d29e8c69486e7 ]---
[   25.397656] ------------[ cut here ]------------
[   25.399074] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   25.416151] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   25.418998] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   25.421905]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   25.425336]  c15298ba c196a9c0 00000011 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   25.428790]  d14cbee0 c15298ba c187e800 d150d770 00000011 d150d87c d14cb=
f00 c152826b
[   25.440139] Call Trace:
[   25.441159]  [<c1531d71>] dump_stack+0x48/0x60
[   25.442540]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   25.444104]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   25.445537]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   25.447066]  [<c15298ba>] genl_unbind+0x85/0x8b
[   25.457078]  [<c152826b>] netlink_release+0x23e/0x254
[   25.458648]  [<c150329b>] sock_release+0x10/0x5b
[   25.460069]  [<c15032f1>] sock_close+0xb/0xf
[   25.461419]  [<c10c1621>] __fput+0xd0/0x15c
[   25.462768]  [<c10c16d3>] ____fput+0x8/0xa
[   25.464106]  [<c104adc8>] task_work_run+0x7c/0xa2
[   25.465535]  [<c103ba25>] do_exit+0x2f1/0x735
[   25.478818]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   25.480230]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   25.481637]  [<c103bec4>] do_group_exit+0x34/0x90
[   25.483081]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   25.484541]  [<c1537745>] syscall_call+0x7/0x7
[   25.500779]  [<c1530000>] ? pfn_pte+0xb/0x33
[   25.502131] ---[ end trace f84d29e8c69486e8 ]---
[   25.503557] ------------[ cut here ]------------
[   25.505022] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   25.519013] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   25.530795] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   25.533684]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   25.537106]  c15298ba c196a9c0 00000013 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   25.540592]  d14cbee0 c15298ba c187e800 d150d770 00000013 d150d87c d14cb=
f00 c152826b
[   25.544037] Call Trace:
[   25.554100]  [<c1531d71>] dump_stack+0x48/0x60
[   25.555487]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   25.557063]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   25.563955]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   25.565443]  [<c15298ba>] genl_unbind+0x85/0x8b
[   25.566898]  [<c152826b>] netlink_release+0x23e/0x254
[   25.568391]  [<c150329b>] sock_release+0x10/0x5b
[   25.569829]  [<c15032f1>] sock_close+0xb/0xf
[   25.578082]  [<c10c1621>] __fput+0xd0/0x15c
[   25.579419]  [<c10c16d3>] ____fput+0x8/0xa
[   25.580786]  [<c104adc8>] task_work_run+0x7c/0xa2
[   25.582220]  [<c103ba25>] do_exit+0x2f1/0x735
[   25.583599]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   25.590966]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   25.592371]  [<c103bec4>] do_group_exit+0x34/0x90
[   25.593831]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   25.595276]  [<c1537745>] syscall_call+0x7/0x7
[   25.607725]  [<c1530000>] ? pfn_pte+0xb/0x33
[   25.609086] ---[ end trace f84d29e8c69486e9 ]---
[   25.610514] ------------[ cut here ]------------
[   25.611967] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   25.614896] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   25.623634] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   25.626510]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   25.636826]  c15298ba c196a9c0 00000015 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   25.640320]  d14cbee0 c15298ba c187e800 d150d770 00000015 d150d87c d14cb=
f00 c152826b
[   25.643761] Call Trace:
[   25.644771]  [<c1531d71>] dump_stack+0x48/0x60
[   25.646155]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   25.647750]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   25.649205]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   25.669757]  [<c15298ba>] genl_unbind+0x85/0x8b
[   25.671174]  [<c152826b>] netlink_release+0x23e/0x254
[   25.672684]  [<c150329b>] sock_release+0x10/0x5b
[   25.674124]  [<c15032f1>] sock_close+0xb/0xf
[   25.675468]  [<c10c1621>] __fput+0xd0/0x15c
[   25.676829]  [<c10c16d3>] ____fput+0x8/0xa
[   25.690385]  [<c104adc8>] task_work_run+0x7c/0xa2
[   25.691837]  [<c103ba25>] do_exit+0x2f1/0x735
[   25.693203]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   25.694637]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   25.696039]  [<c103bec4>] do_group_exit+0x34/0x90
[   25.697540]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   25.698988]  [<c1537745>] syscall_call+0x7/0x7
[   25.700381]  [<c1530000>] ? pfn_pte+0xb/0x33
[   25.701742] ---[ end trace f84d29e8c69486ea ]---
[   25.703150] ------------[ cut here ]------------
[   25.704577] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   25.707478] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   25.710274] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   25.713169]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   25.716595]  c15298ba c196a9c0 00000016 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   25.720121]  d14cbee0 c15298ba c187e800 d150d770 00000016 d150d87c d14cb=
f00 c152826b
[   25.723562] Call Trace:
[   25.724590]  [<c1531d71>] dump_stack+0x48/0x60
[   25.725990]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   25.727550]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   25.728993]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   25.730528]  [<c15298ba>] genl_unbind+0x85/0x8b
[   25.731944]  [<c152826b>] netlink_release+0x23e/0x254
[   25.733444]  [<c150329b>] sock_release+0x10/0x5b
[   25.734867]  [<c15032f1>] sock_close+0xb/0xf
[   25.736213]  [<c10c1621>] __fput+0xd0/0x15c
[   25.737629]  [<c10c16d3>] ____fput+0x8/0xa
[   25.738940]  [<c104adc8>] task_work_run+0x7c/0xa2
[   25.740375]  [<c103ba25>] do_exit+0x2f1/0x735
[   25.741750]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   25.743146]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   25.744555]  [<c103bec4>] do_group_exit+0x34/0x90
[   25.745999]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   25.747452]  [<c1537745>] syscall_call+0x7/0x7
[   25.748848]  [<c1530000>] ? pfn_pte+0xb/0x33
[   25.750243] ---[ end trace f84d29e8c69486eb ]---
[   25.751670] ------------[ cut here ]------------
[   25.753091] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   25.756030] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   25.758823] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   25.761729]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   25.765170]  c15298ba c196a9c0 00000017 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   25.768596]  d14cbee0 c15298ba c187e800 d150d770 00000017 d150d87c d14cb=
f00 c152826b
[   25.779940] Call Trace:
[   25.780966]  [<c1531d71>] dump_stack+0x48/0x60
[   25.782340]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   25.783894]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   25.785309]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   25.786817]  [<c15298ba>] genl_unbind+0x85/0x8b
[   25.788212]  [<c152826b>] netlink_release+0x23e/0x254
[   25.797600]  [<c150329b>] sock_release+0x10/0x5b
[   25.799028]  [<c15032f1>] sock_close+0xb/0xf
[   25.800391]  [<c10c1621>] __fput+0xd0/0x15c
[   25.801736]  [<c10c16d3>] ____fput+0x8/0xa
[   25.803056]  [<c104adc8>] task_work_run+0x7c/0xa2
[   25.804508]  [<c103ba25>] do_exit+0x2f1/0x735
[   25.805892]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   25.817336]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   25.818812]  [<c103bec4>] do_group_exit+0x34/0x90
[   25.820254]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   25.821707]  [<c1537745>] syscall_call+0x7/0x7
[   25.823085]  [<c1530000>] ? pfn_pte+0xb/0x33
[   25.824453] ---[ end trace f84d29e8c69486ec ]---
[   25.825886] ------------[ cut here ]------------
[   25.827311] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   25.853284] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   25.856023] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   25.858976]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   25.862403]  c15298ba c196a9c0 0000001b 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   25.865843]  d14cbee0 c15298ba c187e800 d150d770 0000001b d150d87c d14cb=
f00 c152826b
[   25.869275] Call Trace:
[   25.878194]  [<c1531d71>] dump_stack+0x48/0x60
[   25.879572]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   25.881141]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   25.882567]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   25.884081]  [<c15298ba>] genl_unbind+0x85/0x8b
[   25.885478]  [<c152826b>] netlink_release+0x23e/0x254
[   25.887003]  [<c150329b>] sock_release+0x10/0x5b
[   25.888413]  [<c15032f1>] sock_close+0xb/0xf
[   25.909821]  [<c10c1621>] __fput+0xd0/0x15c
[   25.911178]  [<c10c16d3>] ____fput+0x8/0xa
[   25.912502]  [<c104adc8>] task_work_run+0x7c/0xa2
[   25.913953]  [<c103ba25>] do_exit+0x2f1/0x735
[   25.915320]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   25.916755]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   25.918214]  [<c103bec4>] do_group_exit+0x34/0x90
[   25.919652]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   25.921105]  [<c1537745>] syscall_call+0x7/0x7
[   25.922495]  [<c1530000>] ? pfn_pte+0xb/0x33
[   25.923872] ---[ end trace f84d29e8c69486ed ]---
[   25.925280] ------------[ cut here ]------------
[   25.926749] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   25.949691] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   25.952419] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   25.955315]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   25.958827]  c15298ba c196a9c0 0000001d 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   25.962263]  d14cbee0 c15298ba c187e800 d150d770 0000001d d150d87c d14cb=
f00 c152826b
[   25.992663] Call Trace:
[   25.993702]  [<c1531d71>] dump_stack+0x48/0x60
[   25.995092]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   25.996641]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   25.998139]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   25.999640]  [<c15298ba>] genl_unbind+0x85/0x8b
[   26.001050]  [<c152826b>] netlink_release+0x23e/0x254
[   26.002539]  [<c150329b>] sock_release+0x10/0x5b
[   26.003983]  [<c15032f1>] sock_close+0xb/0xf
[   26.005340]  [<c10c1621>] __fput+0xd0/0x15c
[   26.006698]  [<c10c16d3>] ____fput+0x8/0xa
[   26.008019]  [<c104adc8>] task_work_run+0x7c/0xa2
[   26.009451]  [<c103ba25>] do_exit+0x2f1/0x735
[   26.030868]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   26.032271]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   26.033691]  [<c103bec4>] do_group_exit+0x34/0x90
[   26.035127]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   26.036568]  [<c1537745>] syscall_call+0x7/0x7
[   26.038026]  [<c1530000>] ? pfn_pte+0xb/0x33
[   26.039373] ---[ end trace f84d29e8c69486ee ]---
[   26.040811] ------------[ cut here ]------------
[   26.042219] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   26.045129] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   26.047846] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   26.070786]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   26.074222]  c15298ba c196a9c0 0000001e 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   26.077733]  d14cbee0 c15298ba c187e800 d150d770 0000001e d150d87c d14cb=
f00 c152826b
[   26.081174] Call Trace:
[   26.082201]  [<c1531d71>] dump_stack+0x48/0x60
[   26.083603]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   26.085159]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   26.086587]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   26.088104]  [<c15298ba>] genl_unbind+0x85/0x8b
[   26.089511]  [<c152826b>] netlink_release+0x23e/0x254
[   26.111068]  [<c150329b>] sock_release+0x10/0x5b
[   26.112480]  [<c15032f1>] sock_close+0xb/0xf
[   26.113852]  [<c10c1621>] __fput+0xd0/0x15c
[   26.115185]  [<c10c16d3>] ____fput+0x8/0xa
[   26.116508]  [<c104adc8>] task_work_run+0x7c/0xa2
[   26.118034]  [<c103ba25>] do_exit+0x2f1/0x735
[   26.119399]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   26.120824]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   26.122216]  [<c103bec4>] do_group_exit+0x34/0x90
[   26.123669]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   26.125111]  [<c1537745>] syscall_call+0x7/0x7
[   26.126489]  [<c1530000>] ? pfn_pte+0xb/0x33
[   26.127879] ---[ end trace f84d29e8c69486ef ]---
[   26.129292] ------------[ cut here ]------------
[   26.150761] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   26.153671] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   26.156358] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   26.159317]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   26.162752]  c15298ba c196a9c0 0000001f 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   26.166185]  d14cbee0 c15298ba c187e800 d150d770 0000001f d150d87c d14cb=
f00 c152826b
[   26.169633] Call Trace:
[   26.170702]  [<c1531d71>] dump_stack+0x48/0x60
[   26.172086]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   26.173658]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   26.175091]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   26.176593]  [<c15298ba>] genl_unbind+0x85/0x8b
[   26.178083]  [<c152826b>] netlink_release+0x23e/0x254
[   26.179580]  [<c150329b>] sock_release+0x10/0x5b
[   26.181023]  [<c15032f1>] sock_close+0xb/0xf
[   26.182379]  [<c10c1621>] __fput+0xd0/0x15c
[   26.183743]  [<c10c16d3>] ____fput+0x8/0xa
[   26.185071]  [<c104adc8>] task_work_run+0x7c/0xa2
[   26.186508]  [<c103ba25>] do_exit+0x2f1/0x735
[   26.187901]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   26.189303]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   26.190759]  [<c103bec4>] do_group_exit+0x34/0x90
[   26.192187]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   26.193659]  [<c1537745>] syscall_call+0x7/0x7
[   26.195038]  [<c1530000>] ? pfn_pte+0xb/0x33
[   26.196381] ---[ end trace f84d29e8c69486f0 ]---
[   26.197874] ------------[ cut here ]------------
[   26.199290] WARNING: CPU: 0 PID: 311 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   26.202215] CPU: 0 PID: 311 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   26.204945] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   26.207851]  00000000 00000000 d14cbe9c c1531d71 00000000 d14cbeb8 c1039=
f0d 0000040d
[   26.211313]  c15298ba c196a9c0 00000020 00000004 d14cbec8 c1039faa 00000=
009 00000000
[   26.214835]  d14cbee0 c15298ba c187e800 d150d770 00000020 d150d87c d14cb=
f00 c152826b
[   26.218467] Call Trace:
[   26.219533]  [<c1531d71>] dump_stack+0x48/0x60
[   26.220982]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   26.222686]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   26.224187]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   26.225841]  [<c15298ba>] genl_unbind+0x85/0x8b
[   26.227254]  [<c152826b>] netlink_release+0x23e/0x254
[   26.228754]  [<c150329b>] sock_release+0x10/0x5b
[   26.230290]  [<c15032f1>] sock_close+0xb/0xf
[   26.231718]  [<c10c1621>] __fput+0xd0/0x15c
[   26.233051]  [<c10c16d3>] ____fput+0x8/0xa
[   26.234597]  [<c104adc8>] task_work_run+0x7c/0xa2
[   26.236042]  [<c103ba25>] do_exit+0x2f1/0x735
[   26.237485]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   26.238900]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   26.240314]  [<c103bec4>] do_group_exit+0x34/0x90
[   26.241753]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   26.243262]  [<c1537745>] syscall_call+0x7/0x7
[   26.244677]  [<c1530000>] ? pfn_pte+0xb/0x33
[   26.246162] ---[ end trace f84d29e8c69486f1 ]---
[   26.251242] trinity-c0 (316) uses deprecated remap_file_pages() syscall.=
 See Documentation/vm/remap_file_pages.txt.
[   26.257050] VFS: Warning: trinity-c0 using old stat() call. Recompile yo=
ur binary.
[   26.262661] VFS: Warning: trinity-c0 using old stat() call. Recompile yo=
ur binary.
[   26.270425] warning: process `trinity-c0' used the obsolete bdflush syst=
em call
[   26.270426] Fix your initscripts?
[   26.278482] warning: process `trinity-c0' used the obsolete bdflush syst=
em call
[   26.280875] Fix your initscripts?
[   26.285255] VFS: Warning: trinity-c0 using old stat() call. Recompile yo=
ur binary.
[   26.289017] warning: process `trinity-c0' used the obsolete bdflush syst=
em call
[   26.291430] Fix your initscripts?
[   26.392046] warning: process `trinity-c0' used the obsolete bdflush syst=
em call
[   26.394660] Fix your initscripts?
[   26.396011] VFS: Warning: trinity-c0 using old stat() call. Recompile yo=
ur binary.
[   26.405460] VFS: Warning: trinity-c0 using old stat() call. Recompile yo=
ur binary.
[   26.431767] ------------[ cut here ]------------
[   26.433204] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   26.436424] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   26.439266] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   26.442171]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   26.452956]  c15298ba c196a9c0 00000001 d1520a6c d14e3ec8 c1039faa 00000=
009 00000000
[   26.456397]  d14e3ee0 c15298ba c187e800 d1520960 00000001 d1520a6c d14e3=
f00 c152826b
[   26.459926] Call Trace:
[   26.460969]  [<c1531d71>] dump_stack+0x48/0x60
[   26.462359]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   26.463964]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   26.465407]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   26.466950]  [<c15298ba>] genl_unbind+0x85/0x8b
[   26.468356]  [<c152826b>] netlink_release+0x23e/0x254
[   26.494914]  [<c150329b>] sock_release+0x10/0x5b
[   26.496332]  [<c15032f1>] sock_close+0xb/0xf
[   26.497869]  [<c10c1621>] __fput+0xd0/0x15c
[   26.499219]  [<c10c16d3>] ____fput+0x8/0xa
[   26.500555]  [<c104adc8>] task_work_run+0x7c/0xa2
[   26.502007]  [<c103ba25>] do_exit+0x2f1/0x735
[   26.503391]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   26.525854]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   26.527278]  [<c103bec4>] do_group_exit+0x34/0x90
[   26.528725]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   26.530196]  [<c1537745>] syscall_call+0x7/0x7
[   26.531586]  [<c1530000>] ? pfn_pte+0xb/0x33
[   26.532949] ---[ end trace f84d29e8c69486f2 ]---
[   26.534379] ------------[ cut here ]------------
[   26.546929] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   26.550019] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   26.568031] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   26.570963]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   26.588467]  c15298ba c196a9c0 00000004 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   26.591925]  d14e3ee0 c15298ba c187e800 d1520960 00000004 d1520a6c d14e3=
f00 c152826b
[   26.599636] Call Trace:
[   26.600672]  [<c1531d71>] dump_stack+0x48/0x60
[   26.602051]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   26.603605]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   26.605037]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   26.606523]  [<c15298ba>] genl_unbind+0x85/0x8b
[   26.607972]  [<c152826b>] netlink_release+0x23e/0x254
[   26.622474]  [<c150329b>] sock_release+0x10/0x5b
[   26.623915]  [<c15032f1>] sock_close+0xb/0xf
[   26.625265]  [<c10c1621>] __fput+0xd0/0x15c
[   26.626597]  [<c10c16d3>] ____fput+0x8/0xa
[   26.627972]  [<c104adc8>] task_work_run+0x7c/0xa2
[   26.629391]  [<c103ba25>] do_exit+0x2f1/0x735
[   26.630785]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   26.632201]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   26.633633]  [<c103bec4>] do_group_exit+0x34/0x90
[   26.635063]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   26.636507]  [<c1537745>] syscall_call+0x7/0x7
[   26.650957]  [<c1530000>] ? pfn_pte+0xb/0x33
[   26.652313] ---[ end trace f84d29e8c69486f3 ]---
[   26.653751] ------------[ cut here ]------------
[   26.655162] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   26.658082] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   26.660803] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   26.676762]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   26.680207]  c15298ba c196a9c0 00000007 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   26.683672]  d14e3ee0 c15298ba c187e800 d1520960 00000007 d1520a6c d14e3=
f00 c152826b
[   26.687123] Call Trace:
[   26.688142]  [<c1531d71>] dump_stack+0x48/0x60
[   26.689528]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   26.704129]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   26.705562]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   26.707096]  [<c15298ba>] genl_unbind+0x85/0x8b
[   26.708505]  [<c152826b>] netlink_release+0x23e/0x254
[   26.710034]  [<c150329b>] sock_release+0x10/0x5b
[   26.711448]  [<c15032f1>] sock_close+0xb/0xf
[   26.712812]  [<c10c1621>] __fput+0xd0/0x15c
[   26.714167]  [<c10c16d3>] ____fput+0x8/0xa
[   26.715488]  [<c104adc8>] task_work_run+0x7c/0xa2
[   26.729980]  [<c103ba25>] do_exit+0x2f1/0x735
[   26.731364]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   26.732779]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   26.734189]  [<c103bec4>] do_group_exit+0x34/0x90
[   26.735632]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   26.737090]  [<c1537745>] syscall_call+0x7/0x7
[   26.738476]  [<c1530000>] ? pfn_pte+0xb/0x33
[   26.739833] ---[ end trace f84d29e8c69486f4 ]---
[   26.741248] ------------[ cut here ]------------
[   26.742668] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   26.745559] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   26.748319] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   26.764216]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   26.767690]  c15298ba c196a9c0 00000008 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   26.771131]  d14e3ee0 c15298ba c187e800 d1520960 00000008 d1520a6c d14e3=
f00 c152826b
[   26.774583] Call Trace:
[   26.775604]  [<c1531d71>] dump_stack+0x48/0x60
[   26.790123]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   26.791696]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   26.793137]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   26.794661]  [<c15298ba>] genl_unbind+0x85/0x8b
[   26.796064]  [<c152826b>] netlink_release+0x23e/0x254
[   26.797568]  [<c150329b>] sock_release+0x10/0x5b
[   26.814050]  [<c15032f1>] sock_close+0xb/0xf
[   26.815401]  [<c10c1621>] __fput+0xd0/0x15c
[   26.816758]  [<c10c16d3>] ____fput+0x8/0xa
[   26.818076]  [<c104adc8>] task_work_run+0x7c/0xa2
[   26.819506]  [<c103ba25>] do_exit+0x2f1/0x735
[   26.820894]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   26.822287]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   26.823706]  [<c103bec4>] do_group_exit+0x34/0x90
[   26.825136]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   26.826580]  [<c1537745>] syscall_call+0x7/0x7
[   26.844017]  [<c1530000>] ? pfn_pte+0xb/0x33
[   26.845363] ---[ end trace f84d29e8c69486f5 ]---
[   26.846807] ------------[ cut here ]------------
[   26.848215] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   26.851139] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   26.866888] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   26.869788]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   26.873221]  c15298ba c196a9c0 00000009 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   26.876696]  d14e3ee0 c15298ba c187e800 d1520960 00000009 d1520a6c d14e3=
f00 c152826b
[   26.893167] Call Trace:
[   26.894200]  [<c1531d71>] dump_stack+0x48/0x60
[   26.895578]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   26.897137]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   26.898561]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   26.900075]  [<c15298ba>] genl_unbind+0x85/0x8b
[   26.901468]  [<c152826b>] netlink_release+0x23e/0x254
[   26.902966]  [<c150329b>] sock_release+0x10/0x5b
[   26.904385]  [<c15032f1>] sock_close+0xb/0xf
[   26.918782]  [<c10c1621>] __fput+0xd0/0x15c
[   26.920135]  [<c10c16d3>] ____fput+0x8/0xa
[   26.921456]  [<c104adc8>] task_work_run+0x7c/0xa2
[   26.922900]  [<c103ba25>] do_exit+0x2f1/0x735
[   26.924290]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   26.925700]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   26.927122]  [<c103bec4>] do_group_exit+0x34/0x90
[   26.928559]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   26.930055]  [<c1537745>] syscall_call+0x7/0x7
[   26.931442]  [<c1530000>] ? pfn_pte+0xb/0x33
[   26.932807] ---[ end trace f84d29e8c69486f6 ]---
[   26.934236] ------------[ cut here ]------------
[   26.935665] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   26.938602] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   26.941335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   26.944216]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   26.947666]  c15298ba c196a9c0 0000000a 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   26.951103]  d14e3ee0 c15298ba c187e800 d1520960 0000000a d1520a6c d14e3=
f00 c152826b
[   26.954541] Call Trace:
[   26.955563]  [<c1531d71>] dump_stack+0x48/0x60
[   26.957004]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   26.958550]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   26.959998]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   26.961506]  [<c15298ba>] genl_unbind+0x85/0x8b
[   26.962915]  [<c152826b>] netlink_release+0x23e/0x254
[   26.964417]  [<c150329b>] sock_release+0x10/0x5b
[   26.965834]  [<c15032f1>] sock_close+0xb/0xf
[   26.967198]  [<c10c1621>] __fput+0xd0/0x15c
[   26.975632]  [<c10c16d3>] ____fput+0x8/0xa
[   26.977009]  [<c104adc8>] task_work_run+0x7c/0xa2
[   26.978464]  [<c103ba25>] do_exit+0x2f1/0x735
[   26.979855]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   26.981277]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   26.982689]  [<c103bec4>] do_group_exit+0x34/0x90
[   26.984138]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   26.985591]  [<c1537745>] syscall_call+0x7/0x7
[   26.987013]  [<c1530000>] ? pfn_pte+0xb/0x33
[   26.988365] ---[ end trace f84d29e8c69486f7 ]---
[   26.989791] ------------[ cut here ]------------
[   26.991217] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   26.994144] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   26.996900] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   26.999788]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.003239]  c15298ba c196a9c0 0000000b 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.019764]  d14e3ee0 c15298ba c187e800 d1520960 0000000b d1520a6c d14e3=
f00 c152826b
[   27.023210] Call Trace:
[   27.024253]  [<c1531d71>] dump_stack+0x48/0x60
[   27.025660]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.027239]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.028686]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.030196]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.044654]  [<c152826b>] netlink_release+0x23e/0x254
[   27.046147]  [<c150329b>] sock_release+0x10/0x5b
[   27.047579]  [<c15032f1>] sock_close+0xb/0xf
[   27.048934]  [<c10c1621>] __fput+0xd0/0x15c
[   27.050279]  [<c10c16d3>] ____fput+0x8/0xa
[   27.051607]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.053043]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.054426]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.055842]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.067287]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.068729]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.070192]  [<c1537745>] syscall_call+0x7/0x7
[   27.071575]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.072937] ---[ end trace f84d29e8c69486f8 ]---
[   27.074364] ------------[ cut here ]------------
[   27.075788] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.078715] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.094472] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.097387]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.100860]  c15298ba c196a9c0 0000000f 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.104291]  d14e3ee0 c15298ba c187e800 d1520960 0000000f d1520a6c d14e3=
f00 c152826b
[   27.117793] Call Trace:
[   27.118810]  [<c1531d71>] dump_stack+0x48/0x60
[   27.120200]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.121751]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.123174]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.124696]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.126092]  [<c152826b>] netlink_release+0x23e/0x254
[   27.127597]  [<c150329b>] sock_release+0x10/0x5b
[   27.143060]  [<c15032f1>] sock_close+0xb/0xf
[   27.144425]  [<c10c1621>] __fput+0xd0/0x15c
[   27.145776]  [<c10c16d3>] ____fput+0x8/0xa
[   27.147111]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.148538]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.149912]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.151324]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.152731]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.154161]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.155602]  [<c1537745>] syscall_call+0x7/0x7
[   27.170038]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.171393] ---[ end trace f84d29e8c69486f9 ]---
[   27.173570] ------------[ cut here ]------------
[   27.175003] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.177932] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.180678] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.196598]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.200058]  c15298ba c196a9c0 00000001 d15405bc d14e3ec8 c1039faa 00000=
009 00000000
[   27.203496]  d14e3ee0 c15298ba c187e800 d15404b0 00000001 d15405bc d14e3=
f00 c152826b
[   27.206953] Call Trace:
[   27.221015]  [<c1531d71>] dump_stack+0x48/0x60
[   27.222396]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.223959]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.225378]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.226890]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.228285]  [<c152826b>] netlink_release+0x23e/0x254
[   27.242842]  [<c150329b>] sock_release+0x10/0x5b
[   27.244273]  [<c15032f1>] sock_close+0xb/0xf
[   27.245634]  [<c10c1621>] __fput+0xd0/0x15c
[   27.246980]  [<c10c16d3>] ____fput+0x8/0xa
[   27.248312]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.249763]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.251153]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.252569]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.253993]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.255426]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.263950]  [<c1537745>] syscall_call+0x7/0x7
[   27.265334]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.266712] ---[ end trace f84d29e8c69486fa ]---
[   27.268128] ------------[ cut here ]------------
[   27.269548] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.272471] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.275222] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.291172]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.294626]  c15298ba c196a9c0 00000004 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.298064]  d14e3ee0 c15298ba c187e800 d15404b0 00000004 d15405bc d14e3=
f00 c152826b
[   27.301514] Call Trace:
[   27.325591]  [<c1531d71>] dump_stack+0x48/0x60
[   27.327000]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.328549]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.329992]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.331502]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.332916]  [<c152826b>] netlink_release+0x23e/0x254
[   27.334424]  [<c150329b>] sock_release+0x10/0x5b
[   27.335856]  [<c15032f1>] sock_close+0xb/0xf
[   27.337223]  [<c10c1621>] __fput+0xd0/0x15c
[   27.338556]  [<c10c16d3>] ____fput+0x8/0xa
[   27.339891]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.341332]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.342711]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.344156]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.345556]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.347009]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.348455]  [<c1537745>] syscall_call+0x7/0x7
[   27.349852]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.351217] ---[ end trace f84d29e8c69486fb ]---
[   27.352642] ------------[ cut here ]------------
[   27.354068] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.356984] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.359701] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.362594]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.366075]  c15298ba c196a9c0 00000005 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.369523]  d14e3ee0 c15298ba c187e800 d15404b0 00000005 d15405bc d14e3=
f00 c152826b
[   27.372983] Call Trace:
[   27.374021]  [<c1531d71>] dump_stack+0x48/0x60
[   27.375407]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.376981]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.378405]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.379899]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.381317]  [<c152826b>] netlink_release+0x23e/0x254
[   27.382814]  [<c150329b>] sock_release+0x10/0x5b
[   27.384271]  [<c15032f1>] sock_close+0xb/0xf
[   27.385632]  [<c10c1621>] __fput+0xd0/0x15c
[   27.386981]  [<c10c16d3>] ____fput+0x8/0xa
[   27.388303]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.389751]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.391127]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.392528]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.393950]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.395375]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.396841]  [<c1537745>] syscall_call+0x7/0x7
[   27.398222]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.399568] ---[ end trace f84d29e8c69486fc ]---
[   27.401001] ------------[ cut here ]------------
[   27.402412] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.405359] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.415004] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.417901]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.421341]  c15298ba c196a9c0 00000006 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.424831]  d14e3ee0 c15298ba c187e800 d15404b0 00000006 d15405bc d14e3=
f00 c152826b
[   27.428275] Call Trace:
[   27.429294]  [<c1531d71>] dump_stack+0x48/0x60
[   27.430697]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.432232]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.433683]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.435171]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.436574]  [<c152826b>] netlink_release+0x23e/0x254
[   27.438098]  [<c150329b>] sock_release+0x10/0x5b
[   27.439502]  [<c15032f1>] sock_close+0xb/0xf
[   27.440882]  [<c10c1621>] __fput+0xd0/0x15c
[   27.442220]  [<c10c16d3>] ____fput+0x8/0xa
[   27.443576]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.445017]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.446385]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.447809]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.449213]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.450665]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.452108]  [<c1537745>] syscall_call+0x7/0x7
[   27.453511]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.454871] ---[ end trace f84d29e8c69486fd ]---
[   27.456283] ------------[ cut here ]------------
[   27.457719] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.460633] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.463333] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.466262]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.469710]  c15298ba c196a9c0 00000007 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.473159]  d14e3ee0 c15298ba c187e800 d15404b0 00000007 d15405bc d14e3=
f00 c152826b
[   27.476595] Call Trace:
[   27.477647]  [<c1531d71>] dump_stack+0x48/0x60
[   27.479038]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.480587]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.482065]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.483637]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.485041]  [<c152826b>] netlink_release+0x23e/0x254
[   27.486542]  [<c150329b>] sock_release+0x10/0x5b
[   27.487992]  [<c15032f1>] sock_close+0xb/0xf
[   27.489344]  [<c10c1621>] __fput+0xd0/0x15c
[   27.490715]  [<c10c16d3>] ____fput+0x8/0xa
[   27.492058]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.493501]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.494881]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.496287]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.497712]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.499142]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.500599]  [<c1537745>] syscall_call+0x7/0x7
[   27.501993]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.503384] ---[ end trace f84d29e8c69486fe ]---
[   27.504808] ------------[ cut here ]------------
[   27.506222] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.509141] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.511864] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.514765]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.518198]  c15298ba c196a9c0 00000008 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.521640]  d14e3ee0 c15298ba c187e800 d15404b0 00000008 d15405bc d14e3=
f00 c152826b
[   27.525106] Call Trace:
[   27.526128]  [<c1531d71>] dump_stack+0x48/0x60
[   27.527525]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.529085]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.530523]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.532027]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.533442]  [<c152826b>] netlink_release+0x23e/0x254
[   27.534949]  [<c150329b>] sock_release+0x10/0x5b
[   27.536358]  [<c15032f1>] sock_close+0xb/0xf
[   27.537741]  [<c10c1621>] __fput+0xd0/0x15c
[   27.539078]  [<c10c16d3>] ____fput+0x8/0xa
[   27.540417]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.541854]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.543221]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.544675]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.546076]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.547526]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.548986]  [<c1537745>] syscall_call+0x7/0x7
[   27.550385]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.551744] ---[ end trace f84d29e8c69486ff ]---
[   27.553160] ------------[ cut here ]------------
[   27.554584] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.557509] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.560282] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.563155]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.566635]  c15298ba c196a9c0 00000009 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.570082]  d14e3ee0 c15298ba c187e800 d15404b0 00000009 d15405bc d14e3=
f00 c152826b
[   27.573545] Call Trace:
[   27.574600]  [<c1531d71>] dump_stack+0x48/0x60
[   27.575999]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.577560]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.579013]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.580520]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.581938]  [<c152826b>] netlink_release+0x23e/0x254
[   27.583477]  [<c150329b>] sock_release+0x10/0x5b
[   27.584907]  [<c15032f1>] sock_close+0xb/0xf
[   27.586259]  [<c10c1621>] __fput+0xd0/0x15c
[   27.587664]  [<c10c16d3>] ____fput+0x8/0xa
[   27.589018]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.590464]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.591849]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.593242]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.594658]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.596084]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.598832]  [<c1537745>] syscall_call+0x7/0x7
[   27.600228]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.601584] ---[ end trace f84d29e8c6948700 ]---
[   27.603017] ------------[ cut here ]------------
[   27.604479] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.607554] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.610287] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.613179]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.616712]  c15298ba c196a9c0 0000000a 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.622373]  d14e3ee0 c15298ba c187e800 d15404b0 0000000a d15405bc d14e3=
f00 c152826b
[   27.625858] Call Trace:
[   27.626920]  [<c1531d71>] dump_stack+0x48/0x60
[   27.628345]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.629929]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.631377]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.632911]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.634510]  [<c152826b>] netlink_release+0x23e/0x254
[   27.636048]  [<c150329b>] sock_release+0x10/0x5b
[   27.637499]  [<c15032f1>] sock_close+0xb/0xf
[   27.638864]  [<c10c1621>] __fput+0xd0/0x15c
[   27.640219]  [<c10c16d3>] ____fput+0x8/0xa
[   27.641546]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.642984]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.644417]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.645849]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.650092]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.651570]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.653054]  [<c1537745>] syscall_call+0x7/0x7
[   27.654474]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.655854] ---[ end trace f84d29e8c6948701 ]---
[   27.657285] ------------[ cut here ]------------
[   27.658707] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.662880] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.665653] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.668543]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.672845]  c15298ba c196a9c0 0000000b 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.676280]  d14e3ee0 c15298ba c187e800 d15404b0 0000000b d15405bc d14e3=
f00 c152826b
[   27.679757] Call Trace:
[   27.680804]  [<c1531d71>] dump_stack+0x48/0x60
[   27.683637]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.685185]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.686635]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.689773]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.691189]  [<c152826b>] netlink_release+0x23e/0x254
[   27.700116]  [<c150329b>] sock_release+0x10/0x5b
[   27.701528]  [<c15032f1>] sock_close+0xb/0xf
[   27.702935]  [<c10c1621>] __fput+0xd0/0x15c
[   27.704319]  [<c10c16d3>] ____fput+0x8/0xa
[   27.705651]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.708129]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.709543]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.710979]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.712418]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.713894]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.715357]  [<c1537745>] syscall_call+0x7/0x7
[   27.716791]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.718193] ---[ end trace f84d29e8c6948702 ]---
[   27.719630] ------------[ cut here ]------------
[   27.722459] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.725406] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.728130] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.731046]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.734511]  c15298ba c196a9c0 0000000c 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.738290]  d14e3ee0 c15298ba c187e800 d15404b0 0000000c d15405bc d14e3=
f00 c152826b
[   27.741862] Call Trace:
[   27.742890]  [<c1531d71>] dump_stack+0x48/0x60
[   27.745245]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.746818]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.748240]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.749744]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.751149]  [<c152826b>] netlink_release+0x23e/0x254
[   27.752649]  [<c150329b>] sock_release+0x10/0x5b
[   27.754097]  [<c15032f1>] sock_close+0xb/0xf
[   27.755463]  [<c10c1621>] __fput+0xd0/0x15c
[   27.758001]  [<c10c16d3>] ____fput+0x8/0xa
[   27.759326]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.760790]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.762165]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.763606]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.765027]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.766467]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.768069]  [<c1537745>] syscall_call+0x7/0x7
[   27.773164]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.774531] ---[ end trace f84d29e8c6948703 ]---
[   27.775959] ------------[ cut here ]------------
[   27.777419] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.780347] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.783072] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.786223]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.789766]  c15298ba c196a9c0 0000000d 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.793210]  d14e3ee0 c15298ba c187e800 d15404b0 0000000d d15405bc d14e3=
f00 c152826b
[   27.796650] Call Trace:
[   27.803849]  [<c1531d71>] dump_stack+0x48/0x60
[   27.805248]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.807688]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.809121]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.810640]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.812042]  [<c152826b>] netlink_release+0x23e/0x254
[   27.813555]  [<c150329b>] sock_release+0x10/0x5b
[   27.814988]  [<c15032f1>] sock_close+0xb/0xf
[   27.816341]  [<c10c1621>] __fput+0xd0/0x15c
[   27.817710]  [<c10c16d3>] ____fput+0x8/0xa
[   27.819033]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.820478]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.822023]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.823467]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.824889]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.826316]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.827787]  [<c1537745>] syscall_call+0x7/0x7
[   27.829175]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.830545] ---[ end trace f84d29e8c6948704 ]---
[   27.831978] ------------[ cut here ]------------
[   27.833404] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.836326] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.839060] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.841965]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.845432]  c15298ba c196a9c0 0000000e 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.848879]  d14e3ee0 c15298ba c187e800 d15404b0 0000000e d15405bc d14e3=
f00 c152826b
[   27.852301] Call Trace:
[   27.853315]  [<c1531d71>] dump_stack+0x48/0x60
[   27.867729]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.869266]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.870720]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.872214]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.873626]  [<c152826b>] netlink_release+0x23e/0x254
[   27.875116]  [<c150329b>] sock_release+0x10/0x5b
[   27.876529]  [<c15032f1>] sock_close+0xb/0xf
[   27.877943]  [<c10c1621>] __fput+0xd0/0x15c
[   27.879308]  [<c10c16d3>] ____fput+0x8/0xa
[   27.880670]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.882089]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.883465]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.897915]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.899309]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.900767]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   27.902205]  [<c1537745>] syscall_call+0x7/0x7
[   27.903602]  [<c1530000>] ? pfn_pte+0xb/0x33
[   27.904960] ---[ end trace f84d29e8c6948705 ]---
[   27.906370] ------------[ cut here ]------------
[   27.907807] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   27.923741] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   27.926438] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   27.929330]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   27.932779]  c15298ba c196a9c0 0000000f 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   27.936228]  d14e3ee0 c15298ba c187e800 d15404b0 0000000f d15405bc d14e3=
f00 c152826b
[   27.950756] Call Trace:
[   27.951777]  [<c1531d71>] dump_stack+0x48/0x60
[   27.953165]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   27.954735]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   27.956165]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   27.957694]  [<c15298ba>] genl_unbind+0x85/0x8b
[   27.959097]  [<c152826b>] netlink_release+0x23e/0x254
[   27.960608]  [<c150329b>] sock_release+0x10/0x5b
[   27.983085]  [<c15032f1>] sock_close+0xb/0xf
[   27.984452]  [<c10c1621>] __fput+0xd0/0x15c
[   27.985809]  [<c10c16d3>] ____fput+0x8/0xa
[   27.987141]  [<c104adc8>] task_work_run+0x7c/0xa2
[   27.988567]  [<c103ba25>] do_exit+0x2f1/0x735
[   27.989944]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   27.991356]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   27.992754]  [<c103bec4>] do_group_exit+0x34/0x90
[   27.994195]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.008693]  [<c1537745>] syscall_call+0x7/0x7
[   28.010087]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.011445] ---[ end trace f84d29e8c6948706 ]---
[   28.013071] ------------[ cut here ]------------
[   28.014501] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.017430] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.020156] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.036103]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.039553]  c15298ba c196a9c0 00000001 d1540a6c d14e3ec8 c1039faa 00000=
009 00000000
[   28.043011]  d14e3ee0 c15298ba c187e800 d1540960 00000001 d1540a6c d14e3=
f00 c152826b
[   28.046456] Call Trace:
[   28.060525]  [<c1531d71>] dump_stack+0x48/0x60
[   28.061927]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.063480]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.064929]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.066423]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.067845]  [<c152826b>] netlink_release+0x23e/0x254
[   28.069342]  [<c150329b>] sock_release+0x10/0x5b
[   28.070784]  [<c15032f1>] sock_close+0xb/0xf
[   28.072134]  [<c10c1621>] __fput+0xd0/0x15c
[   28.073476]  [<c10c16d3>] ____fput+0x8/0xa
[   28.074811]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.076232]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.077629]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.079024]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.080458]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.094928]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.096381]  [<c1537745>] syscall_call+0x7/0x7
[   28.097800]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.099150] ---[ end trace f84d29e8c6948707 ]---
[   28.100627] ------------[ cut here ]------------
[   28.102041] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.124879] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.127586] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.130465]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.146966]  c15298ba c196a9c0 00000004 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.150532]  d14e3ee0 c15298ba c187e800 d1540960 00000004 d1540a6c d14e3=
f00 c152826b
[   28.153986] Call Trace:
[   28.155000]  [<c1531d71>] dump_stack+0x48/0x60
[   28.156378]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.157943]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.159369]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.173947]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.175349]  [<c152826b>] netlink_release+0x23e/0x254
[   28.176876]  [<c150329b>] sock_release+0x10/0x5b
[   28.178289]  [<c15032f1>] sock_close+0xb/0xf
[   28.179651]  [<c10c1621>] __fput+0xd0/0x15c
[   28.181001]  [<c10c16d3>] ____fput+0x8/0xa
[   28.195370]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.196828]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.198196]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.199594]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.201029]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.202458]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.203934]  [<c1537745>] syscall_call+0x7/0x7
[   28.205316]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.206689] ---[ end trace f84d29e8c6948708 ]---
[   28.220151] ------------[ cut here ]------------
[   28.221567] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.224483] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.227210] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.230102]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.243594]  c15298ba c196a9c0 00000005 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.247028]  d14e3ee0 c15298ba c187e800 d1540960 00000005 d1540a6c d14e3=
f00 c152826b
[   28.250456] Call Trace:
[   28.251472]  [<c1531d71>] dump_stack+0x48/0x60
[   28.252862]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.254411]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.268887]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.270391]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.271798]  [<c152826b>] netlink_release+0x23e/0x254
[   28.273281]  [<c150329b>] sock_release+0x10/0x5b
[   28.274745]  [<c15032f1>] sock_close+0xb/0xf
[   28.276087]  [<c10c1621>] __fput+0xd0/0x15c
[   28.277437]  [<c10c16d3>] ____fput+0x8/0xa
[   28.278764]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.280201]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.294605]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.296013]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.297431]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.298875]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.300329]  [<c1537745>] syscall_call+0x7/0x7
[   28.301718]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.303059] ---[ end trace f84d29e8c6948709 ]---
[   28.304487] ------------[ cut here ]------------
[   28.305914] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.321852] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.324563] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.327463]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.330906]  c15298ba c196a9c0 00000006 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.334346]  d14e3ee0 c15298ba c187e800 d1540960 00000006 d1540a6c d14e3=
f00 c152826b
[   28.337803] Call Trace:
[   28.338824]  [<c1531d71>] dump_stack+0x48/0x60
[   28.340247]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.341799]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.343223]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.344736]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.346121]  [<c152826b>] netlink_release+0x23e/0x254
[   28.347624]  [<c150329b>] sock_release+0x10/0x5b
[   28.349021]  [<c15032f1>] sock_close+0xb/0xf
[   28.350376]  [<c10c1621>] __fput+0xd0/0x15c
[   28.351717]  [<c10c16d3>] ____fput+0x8/0xa
[   28.353028]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.354466]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.355846]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.357259]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.358661]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.360119]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.361558]  [<c1537745>] syscall_call+0x7/0x7
[   28.362947]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.364295] ---[ end trace f84d29e8c694870a ]---
[   28.365706] ------------[ cut here ]------------
[   28.367119] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.370028] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.372731] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.375636]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.379054]  c15298ba c196a9c0 00000007 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.382503]  d14e3ee0 c15298ba c187e800 d1540960 00000007 d1540a6c d14e3=
f00 c152826b
[   28.385943] Call Trace:
[   28.386966]  [<c1531d71>] dump_stack+0x48/0x60
[   28.388346]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.389887]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.391325]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.392822]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.394222]  [<c152826b>] netlink_release+0x23e/0x254
[   28.395730]  [<c150329b>] sock_release+0x10/0x5b
[   28.397151]  [<c15032f1>] sock_close+0xb/0xf
[   28.398492]  [<c10c1621>] __fput+0xd0/0x15c
[   28.399841]  [<c10c16d3>] ____fput+0x8/0xa
[   28.401204]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.402648]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.404028]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.405419]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.406836]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.408260]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.409711]  [<c1537745>] syscall_call+0x7/0x7
[   28.411099]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.412448] ---[ end trace f84d29e8c694870b ]---
[   28.413886] ------------[ cut here ]------------
[   28.415290] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.418200] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.420955] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.423857]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.427294]  c15298ba c196a9c0 00000008 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.430733]  d14e3ee0 c15298ba c187e800 d1540960 00000008 d1540a6c d14e3=
f00 c152826b
[   28.434171] Call Trace:
[   28.435194]  [<c1531d71>] dump_stack+0x48/0x60
[   28.436573]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.438139]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.439564]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.441113]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.442503]  [<c152826b>] netlink_release+0x23e/0x254
[   28.444022]  [<c150329b>] sock_release+0x10/0x5b
[   28.445436]  [<c15032f1>] sock_close+0xb/0xf
[   28.446805]  [<c10c1621>] __fput+0xd0/0x15c
[   28.448133]  [<c10c16d3>] ____fput+0x8/0xa
[   28.449466]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.450919]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.452282]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.453698]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.455087]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.456512]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.457986]  [<c1537745>] syscall_call+0x7/0x7
[   28.459358]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.460754] ---[ end trace f84d29e8c694870c ]---
[   28.462156] ------------[ cut here ]------------
[   28.463582] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.466478] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.469194] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.472072]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.475501]  c15298ba c196a9c0 00000009 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.478930]  d14e3ee0 c15298ba c187e800 d1540960 00000009 d1540a6c d14e3=
f00 c152826b
[   28.482385] Call Trace:
[   28.483411]  [<c1531d71>] dump_stack+0x48/0x60
[   28.484798]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.486330]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.494730]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.496216]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.497629]  [<c152826b>] netlink_release+0x23e/0x254
[   28.499121]  [<c150329b>] sock_release+0x10/0x5b
[   28.500574]  [<c15032f1>] sock_close+0xb/0xf
[   28.501932]  [<c10c1621>] __fput+0xd0/0x15c
[   28.503263]  [<c10c16d3>] ____fput+0x8/0xa
[   28.504594]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.506033]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.507413]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.508823]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.510226]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.511660]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.513094]  [<c1537745>] syscall_call+0x7/0x7
[   28.514480]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.515838] ---[ end trace f84d29e8c694870d ]---
[   28.517262] ------------[ cut here ]------------
[   28.518687] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.521637] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.524346] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.527249]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.530692]  c15298ba c196a9c0 0000000a 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.534127]  d14e3ee0 c15298ba c187e800 d1540960 0000000a d1540a6c d14e3=
f00 c152826b
[   28.537549] Call Trace:
[   28.538567]  [<c1531d71>] dump_stack+0x48/0x60
[   28.539955]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.541539]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.542992]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.544558]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.546005]  [<c152826b>] netlink_release+0x23e/0x254
[   28.547508]  [<c150329b>] sock_release+0x10/0x5b
[   28.548929]  [<c15032f1>] sock_close+0xb/0xf
[   28.550285]  [<c10c1621>] __fput+0xd0/0x15c
[   28.551628]  [<c10c16d3>] ____fput+0x8/0xa
[   28.552944]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.554388]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.555762]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.557169]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.558566]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.560056]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.561510]  [<c1537745>] syscall_call+0x7/0x7
[   28.562907]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.564270] ---[ end trace f84d29e8c694870e ]---
[   28.565689] ------------[ cut here ]------------
[   28.567116] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.570044] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.573975] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.576871]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.580325]  c15298ba c196a9c0 0000000b 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.583764]  d14e3ee0 c15298ba c187e800 d1540960 0000000b d1540a6c d14e3=
f00 c152826b
[   28.587197] Call Trace:
[   28.588214]  [<c1531d71>] dump_stack+0x48/0x60
[   28.589589]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.591149]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.592568]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.594083]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.595481]  [<c152826b>] netlink_release+0x23e/0x254
[   28.596999]  [<c150329b>] sock_release+0x10/0x5b
[   28.598408]  [<c15032f1>] sock_close+0xb/0xf
[   28.599772]  [<c10c1621>] __fput+0xd0/0x15c
[   28.601149]  [<c10c16d3>] ____fput+0x8/0xa
[   28.602474]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.603929]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.605298]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.606772]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.608178]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.609600]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.611068]  [<c1537745>] syscall_call+0x7/0x7
[   28.612452]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.613821] ---[ end trace f84d29e8c694870f ]---
[   28.615227] ------------[ cut here ]------------
[   28.616649] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.619697] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.622438] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.625344]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.628783]  c15298ba c196a9c0 0000000c 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.632246]  d14e3ee0 c15298ba c187e800 d1540960 0000000c d1540a6c d14e3=
f00 c152826b
[   28.635693] Call Trace:
[   28.636725]  [<c1531d71>] dump_stack+0x48/0x60
[   28.638102]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.639653]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.641120]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.642623]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.644039]  [<c152826b>] netlink_release+0x23e/0x254
[   28.645553]  [<c150329b>] sock_release+0x10/0x5b
[   28.647016]  [<c15032f1>] sock_close+0xb/0xf
[   28.648359]  [<c10c1621>] __fput+0xd0/0x15c
[   28.649704]  [<c10c16d3>] ____fput+0x8/0xa
[   28.651042]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.652467]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.653855]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.655245]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.656650]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.658087]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.659548]  [<c1537745>] syscall_call+0x7/0x7
[   28.660987]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.662341] ---[ end trace f84d29e8c6948710 ]---
[   28.663778] ------------[ cut here ]------------
[   28.665184] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.668083] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.670801] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.673706]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.677138]  c15298ba c196a9c0 0000000d 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.680645]  d14e3ee0 c15298ba c187e800 d1540960 0000000d d1540a6c d14e3=
f00 c152826b
[   28.684071] Call Trace:
[   28.685086]  [<c1531d71>] dump_stack+0x48/0x60
[   28.686467]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.688059]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.689481]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.691002]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.692389]  [<c152826b>] netlink_release+0x23e/0x254
[   28.693901]  [<c150329b>] sock_release+0x10/0x5b
[   28.695319]  [<c15032f1>] sock_close+0xb/0xf
[   28.696703]  [<c10c1621>] __fput+0xd0/0x15c
[   28.698046]  [<c10c16d3>] ____fput+0x8/0xa
[   28.699356]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.700835]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.702193]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.703604]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.705039]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.706461]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.707932]  [<c1537745>] syscall_call+0x7/0x7
[   28.709314]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.710691] ---[ end trace f84d29e8c6948711 ]---
[   28.712100] ------------[ cut here ]------------
[   28.713520] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.716435] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.719154] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.722091]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.725526]  c15298ba c196a9c0 0000000e 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.729161]  d14e3ee0 c15298ba c187e800 d1540960 0000000e d1540a6c d14e3=
f00 c152826b
[   28.732581] Call Trace:
[   28.733625]  [<c1531d71>] dump_stack+0x48/0x60
[   28.734997]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.736528]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.737993]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.739476]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.743948]  [<c152826b>] netlink_release+0x23e/0x254
[   28.745445]  [<c150329b>] sock_release+0x10/0x5b
[   28.746898]  [<c15032f1>] sock_close+0xb/0xf
[   28.748257]  [<c10c1621>] __fput+0xd0/0x15c
[   28.749578]  [<c10c16d3>] ____fput+0x8/0xa
[   28.750925]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.752359]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.753750]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.755144]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.756534]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.757986]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.759426]  [<c1537745>] syscall_call+0x7/0x7
[   28.760834]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.770196] ---[ end trace f84d29e8c6948712 ]---
[   28.771624] ------------[ cut here ]------------
[   28.773042] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.775952] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.778699] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.781585]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.785039]  c15298ba c196a9c0 0000000f 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.788469]  d14e3ee0 c15298ba c187e800 d1540960 0000000f d1540a6c d14e3=
f00 c152826b
[   28.791937] Call Trace:
[   28.792945]  [<c1531d71>] dump_stack+0x48/0x60
[   28.794338]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.795891]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.797331]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.798827]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.800236]  [<c152826b>] netlink_release+0x23e/0x254
[   28.801733]  [<c150329b>] sock_release+0x10/0x5b
[   28.803144]  [<c15032f1>] sock_close+0xb/0xf
[   28.804507]  [<c10c1621>] __fput+0xd0/0x15c
[   28.805893]  [<c10c16d3>] ____fput+0x8/0xa
[   28.807228]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.810322]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.811700]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.813096]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.814512]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.815954]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.817406]  [<c1537745>] syscall_call+0x7/0x7
[   28.818799]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.820160] ---[ end trace f84d29e8c6948713 ]---
[   28.821567] ------------[ cut here ]------------
[   28.823666] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.826558] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.829299] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.832230]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.835671]  c15298ba c196a9c0 00000011 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.839108]  d14e3ee0 c15298ba c187e800 d1540960 00000011 d1540a6c d14e3=
f00 c152826b
[   28.843998] Call Trace:
[   28.845010]  [<c1531d71>] dump_stack+0x48/0x60
[   28.846389]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.847950]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.849410]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.850985]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.852379]  [<c152826b>] netlink_release+0x23e/0x254
[   28.853896]  [<c150329b>] sock_release+0x10/0x5b
[   28.855305]  [<c15032f1>] sock_close+0xb/0xf
[   28.858738]  [<c10c1621>] __fput+0xd0/0x15c
[   28.860087]  [<c10c16d3>] ____fput+0x8/0xa
[   28.861411]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.862844]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.864225]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.865625]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.867063]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.868541]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.870120]  [<c1537745>] syscall_call+0x7/0x7
[   28.871521]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.872881] ---[ end trace f84d29e8c6948714 ]---
[   28.874310] ------------[ cut here ]------------
[   28.875732] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.878652] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.882706] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.885707]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.889163]  c15298ba c196a9c0 00000012 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.892643]  d14e3ee0 c15298ba c187e800 d1540960 00000012 d1540a6c d14e3=
f00 c152826b
[   28.896085] Call Trace:
[   28.897120]  [<c1531d71>] dump_stack+0x48/0x60
[   28.898523]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.900097]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.901522]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.903027]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.904433]  [<c152826b>] netlink_release+0x23e/0x254
[   28.905944]  [<c150329b>] sock_release+0x10/0x5b
[   28.907387]  [<c15032f1>] sock_close+0xb/0xf
[   28.910136]  [<c10c1621>] __fput+0xd0/0x15c
[   28.911536]  [<c10c16d3>] ____fput+0x8/0xa
[   28.912882]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.914326]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.915699]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.917114]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.918517]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.919961]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.921414]  [<c1537745>] syscall_call+0x7/0x7
[   28.923661]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.925037] ---[ end trace f84d29e8c6948715 ]---
[   28.926471] ------------[ cut here ]------------
[   28.927920] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.930890] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.933607] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.936487]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.939939]  c15298ba c196a9c0 00000013 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.943387]  d14e3ee0 c15298ba c187e800 d1540960 00000013 d1540a6c d14e3=
f00 c152826b
[   28.946831] Call Trace:
[   28.947851]  [<c1531d71>] dump_stack+0x48/0x60
[   28.949228]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.950820]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   28.952246]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   28.953761]  [<c15298ba>] genl_unbind+0x85/0x8b
[   28.955153]  [<c152826b>] netlink_release+0x23e/0x254
[   28.956654]  [<c150329b>] sock_release+0x10/0x5b
[   28.958078]  [<c15032f1>] sock_close+0xb/0xf
[   28.959427]  [<c10c1621>] __fput+0xd0/0x15c
[   28.960786]  [<c10c16d3>] ____fput+0x8/0xa
[   28.962102]  [<c104adc8>] task_work_run+0x7c/0xa2
[   28.963537]  [<c103ba25>] do_exit+0x2f1/0x735
[   28.964924]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   28.966319]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   28.967740]  [<c103bec4>] do_group_exit+0x34/0x90
[   28.969173]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   28.970678]  [<c1537745>] syscall_call+0x7/0x7
[   28.972059]  [<c1530000>] ? pfn_pte+0xb/0x33
[   28.973430] ---[ end trace f84d29e8c6948716 ]---
[   28.974850] ------------[ cut here ]------------
[   28.976259] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   28.979177] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   28.981903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   28.984806]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   28.988250]  c15298ba c196a9c0 00000014 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   28.991719]  d14e3ee0 c15298ba c187e800 d1540960 00000014 d1540a6c d14e3=
f00 c152826b
[   28.995159] Call Trace:
[   28.996176]  [<c1531d71>] dump_stack+0x48/0x60
[   28.997571]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   28.999119]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.000566]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.002061]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.003468]  [<c152826b>] netlink_release+0x23e/0x254
[   29.004974]  [<c150329b>] sock_release+0x10/0x5b
[   29.006389]  [<c15032f1>] sock_close+0xb/0xf
[   29.007765]  [<c10c1621>] __fput+0xd0/0x15c
[   29.009095]  [<c10c16d3>] ____fput+0x8/0xa
[   29.010456]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.011896]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.013274]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.014699]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.016093]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.017538]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.018993]  [<c1537745>] syscall_call+0x7/0x7
[   29.020387]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.021746] ---[ end trace f84d29e8c6948717 ]---
[   29.023155] ------------[ cut here ]------------
[   29.024587] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.027500] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.030257] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.033151]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.036583]  c15298ba c196a9c0 00000015 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.040044]  d14e3ee0 c15298ba c187e800 d1540960 00000015 d1540a6c d14e3=
f00 c152826b
[   29.043480] Call Trace:
[   29.051517]  [<c1531d71>] dump_stack+0x48/0x60
[   29.052905]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.054459]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.055898]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.057394]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.058799]  [<c152826b>] netlink_release+0x23e/0x254
[   29.060299]  [<c150329b>] sock_release+0x10/0x5b
[   29.061718]  [<c15032f1>] sock_close+0xb/0xf
[   29.063058]  [<c10c1621>] __fput+0xd0/0x15c
[   29.064401]  [<c10c16d3>] ____fput+0x8/0xa
[   29.065733]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.067170]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.068540]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.069947]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.071391]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.072831]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.074280]  [<c1537745>] syscall_call+0x7/0x7
[   29.075668]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.077027] ---[ end trace f84d29e8c6948718 ]---
[   29.078438] ------------[ cut here ]------------
[   29.079848] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.082764] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.085479] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.088389]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.091865]  c15298ba c196a9c0 00000016 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.095306]  d14e3ee0 c15298ba c187e800 d1540960 00000016 d1540a6c d14e3=
f00 c152826b
[   29.098744] Call Trace:
[   29.099764]  [<c1531d71>] dump_stack+0x48/0x60
[   29.101166]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.102711]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.104147]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.105658]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.107070]  [<c152826b>] netlink_release+0x23e/0x254
[   29.108556]  [<c150329b>] sock_release+0x10/0x5b
[   29.109979]  [<c15032f1>] sock_close+0xb/0xf
[   29.111363]  [<c10c1621>] __fput+0xd0/0x15c
[   29.112711]  [<c10c16d3>] ____fput+0x8/0xa
[   29.114038]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.115467]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.116856]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.118264]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.119679]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.121127]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.122567]  [<c1537745>] syscall_call+0x7/0x7
[   29.123968]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.125312] ---[ end trace f84d29e8c6948719 ]---
[   29.126770] ------------[ cut here ]------------
[   29.128178] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.131114] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.133842] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.136738]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.140172]  c15298ba c196a9c0 00000017 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.143594]  d14e3ee0 c15298ba c187e800 d1540960 00000017 d1540a6c d14e3=
f00 c152826b
[   29.147032] Call Trace:
[   29.148051]  [<c1531d71>] dump_stack+0x48/0x60
[   29.149432]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.151026]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.152447]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.153965]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.155356]  [<c152826b>] netlink_release+0x23e/0x254
[   29.156864]  [<c150329b>] sock_release+0x10/0x5b
[   29.158263]  [<c15032f1>] sock_close+0xb/0xf
[   29.159606]  [<c10c1621>] __fput+0xd0/0x15c
[   29.160961]  [<c10c16d3>] ____fput+0x8/0xa
[   29.162273]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.163730]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.165083]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.166471]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.167895]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.169321]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.170819]  [<c1537745>] syscall_call+0x7/0x7
[   29.172196]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.173556] ---[ end trace f84d29e8c694871a ]---
[   29.174978] ------------[ cut here ]------------
[   29.176392] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.179302] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.182028] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.184931]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.188357]  c15298ba c196a9c0 00000018 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.191827]  d14e3ee0 c15298ba c187e800 d1540960 00000018 d1540a6c d14e3=
f00 c152826b
[   29.195255] Call Trace:
[   29.196274]  [<c1531d71>] dump_stack+0x48/0x60
[   29.197681]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.199212]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.200665]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.202173]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.203583]  [<c152826b>] netlink_release+0x23e/0x254
[   29.205082]  [<c150329b>] sock_release+0x10/0x5b
[   29.206490]  [<c15032f1>] sock_close+0xb/0xf
[   29.207859]  [<c10c1621>] __fput+0xd0/0x15c
[   29.209191]  [<c10c16d3>] ____fput+0x8/0xa
[   29.210552]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.211991]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.213371]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.214771]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.216167]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.217602]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.219051]  [<c1537745>] syscall_call+0x7/0x7
[   29.220436]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.221788] ---[ end trace f84d29e8c694871b ]---
[   29.223193] ------------[ cut here ]------------
[   29.224673] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.227573] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.230331] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.233215]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.236662]  c15298ba c196a9c0 00000019 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.240102]  d14e3ee0 c15298ba c187e800 d1540960 00000019 d1540a6c d14e3=
f00 c152826b
[   29.243527] Call Trace:
[   29.244544]  [<c1531d71>] dump_stack+0x48/0x60
[   29.245936]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.247482]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.248924]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.250450]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.251857]  [<c152826b>] netlink_release+0x23e/0x254
[   29.253356]  [<c150329b>] sock_release+0x10/0x5b
[   29.254767]  [<c15032f1>] sock_close+0xb/0xf
[   29.256116]  [<c10c1621>] __fput+0xd0/0x15c
[   29.257458]  [<c10c16d3>] ____fput+0x8/0xa
[   29.258790]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.260231]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.261589]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.262990]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.264397]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.265837]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.267294]  [<c1537745>] syscall_call+0x7/0x7
[   29.268686]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.270076] ---[ end trace f84d29e8c694871c ]---
[   29.271486] ------------[ cut here ]------------
[   29.272908] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.275845] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.278548] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.281450]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.284889]  c15298ba c196a9c0 0000001a 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.288324]  d14e3ee0 c15298ba c187e800 d1540960 0000001a d1540a6c d14e3=
f00 c152826b
[   29.291790] Call Trace:
[   29.292801]  [<c1531d71>] dump_stack+0x48/0x60
[   29.294189]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.295744]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.297179]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.298681]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.300089]  [<c152826b>] netlink_release+0x23e/0x254
[   29.301585]  [<c150329b>] sock_release+0x10/0x5b
[   29.303008]  [<c15032f1>] sock_close+0xb/0xf
[   29.304371]  [<c10c1621>] __fput+0xd0/0x15c
[   29.305715]  [<c10c16d3>] ____fput+0x8/0xa
[   29.307041]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.308467]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.309844]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.311280]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.312689]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.321030]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.322473]  [<c1537745>] syscall_call+0x7/0x7
[   29.323881]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.325226] ---[ end trace f84d29e8c694871d ]---
[   29.326637] ------------[ cut here ]------------
[   29.328056] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.330993] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.333714] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.336573]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.340015]  c15298ba c196a9c0 0000001b 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.343436]  d14e3ee0 c15298ba c187e800 d1540960 0000001b d1540a6c d14e3=
f00 c152826b
[   29.346866] Call Trace:
[   29.347882]  [<c1531d71>] dump_stack+0x48/0x60
[   29.349260]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.350853]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.352270]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.353779]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.355169]  [<c152826b>] netlink_release+0x23e/0x254
[   29.356665]  [<c150329b>] sock_release+0x10/0x5b
[   29.358082]  [<c15032f1>] sock_close+0xb/0xf
[   29.359442]  [<c10c1621>] __fput+0xd0/0x15c
[   29.360796]  [<c10c16d3>] ____fput+0x8/0xa
[   29.362101]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.363540]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.364917]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.366314]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.367733]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.369163]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.370662]  [<c1537745>] syscall_call+0x7/0x7
[   29.372043]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.373401] ---[ end trace f84d29e8c694871e ]---
[   29.374818] ------------[ cut here ]------------
[   29.376230] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.379131] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.381853] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.384750]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.388181]  c15298ba c196a9c0 0000001c 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.391654]  d14e3ee0 c15298ba c187e800 d1540960 0000001c d1540a6c d14e3=
f00 c152826b
[   29.395096] Call Trace:
[   29.396115]  [<c1531d71>] dump_stack+0x48/0x60
[   29.397534]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.399079]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.400521]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.402023]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.403434]  [<c152826b>] netlink_release+0x23e/0x254
[   29.404940]  [<c150329b>] sock_release+0x10/0x5b
[   29.406351]  [<c15032f1>] sock_close+0xb/0xf
[   29.407722]  [<c10c1621>] __fput+0xd0/0x15c
[   29.409052]  [<c10c16d3>] ____fput+0x8/0xa
[   29.410406]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.411837]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.413201]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.414623]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.416015]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.417453]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.418904]  [<c1537745>] syscall_call+0x7/0x7
[   29.420296]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.421657] ---[ end trace f84d29e8c694871f ]---
[   29.423064] ------------[ cut here ]------------
[   29.424485] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.427394] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.430171] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.433100]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.436554]  c15298ba c196a9c0 0000001d 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.439998]  d14e3ee0 c15298ba c187e800 d1540960 0000001d d1540a6c d14e3=
f00 c152826b
[   29.443443] Call Trace:
[   29.444462]  [<c1531d71>] dump_stack+0x48/0x60
[   29.445851]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.447396]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.448830]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.450360]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.451772]  [<c152826b>] netlink_release+0x23e/0x254
[   29.453259]  [<c150329b>] sock_release+0x10/0x5b
[   29.454710]  [<c15032f1>] sock_close+0xb/0xf
[   29.456053]  [<c10c1621>] __fput+0xd0/0x15c
[   29.457398]  [<c10c16d3>] ____fput+0x8/0xa
[   29.458725]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.460163]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.461528]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.462936]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.464347]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.465789]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.467243]  [<c1537745>] syscall_call+0x7/0x7
[   29.468626]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.469967] ---[ end trace f84d29e8c6948720 ]---
[   29.471435] ------------[ cut here ]------------
[   29.472856] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.475766] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.478464] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.481354]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.484792]  c15298ba c196a9c0 0000001e 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.488219]  d14e3ee0 c15298ba c187e800 d1540960 0000001e d1540a6c d14e3=
f00 c152826b
[   29.491683] Call Trace:
[   29.492701]  [<c1531d71>] dump_stack+0x48/0x60
[   29.494095]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.495647]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.497089]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.498584]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.499988]  [<c152826b>] netlink_release+0x23e/0x254
[   29.501490]  [<c150329b>] sock_release+0x10/0x5b
[   29.502909]  [<c15032f1>] sock_close+0xb/0xf
[   29.504266]  [<c10c1621>] __fput+0xd0/0x15c
[   29.505591]  [<c10c16d3>] ____fput+0x8/0xa
[   29.506936]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.508363]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.509735]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.511172]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.512566]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.514019]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.515456]  [<c1537745>] syscall_call+0x7/0x7
[   29.516856]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.518197] ---[ end trace f84d29e8c6948721 ]---
[   29.519601] ------------[ cut here ]------------
[   29.521036] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.523940] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.526633] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.529517]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.532977]  c15298ba c196a9c0 0000001f 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.536398]  d14e3ee0 c15298ba c187e800 d1540960 0000001f d1540a6c d14e3=
f00 c152826b
[   29.539827] Call Trace:
[   29.540859]  [<c1531d71>] dump_stack+0x48/0x60
[   29.542231]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.543785]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.545207]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.546725]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.548120]  [<c152826b>] netlink_release+0x23e/0x254
[   29.549610]  [<c150329b>] sock_release+0x10/0x5b
[   29.551073]  [<c15032f1>] sock_close+0xb/0xf
[   29.552424]  [<c10c1621>] __fput+0xd0/0x15c
[   29.553773]  [<c10c16d3>] ____fput+0x8/0xa
[   29.555093]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.556517]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.557911]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.559309]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.560743]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.562222]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.563696]  [<c1537745>] syscall_call+0x7/0x7
[   29.565074]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.566419] ---[ end trace f84d29e8c6948722 ]---
[   29.567860] ------------[ cut here ]------------
[   29.569268] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.572195] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.574925] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.577813]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.581233]  c15298ba c196a9c0 00000020 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.591567]  d14e3ee0 c15298ba c187e800 d1540960 00000020 d1540a6c d14e3=
f00 c152826b
[   29.594995] Call Trace:
[   29.596007]  [<c1531d71>] dump_stack+0x48/0x60
[   29.597400]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.598943]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.600379]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.601880]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.603269]  [<c152826b>] netlink_release+0x23e/0x254
[   29.604797]  [<c150329b>] sock_release+0x10/0x5b
[   29.606201]  [<c15032f1>] sock_close+0xb/0xf
[   29.607566]  [<c10c1621>] __fput+0xd0/0x15c
[   29.608904]  [<c10c16d3>] ____fput+0x8/0xa
[   29.610260]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.611697]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.613064]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.614476]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.615891]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.617334]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.618782]  [<c1537745>] syscall_call+0x7/0x7
[   29.620171]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.621515] ---[ end trace f84d29e8c6948723 ]---
[   29.624106] ------------[ cut here ]------------
[   29.625519] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.628446] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.631202] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.634178]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.637610]  c15298ba c196a9c0 00000001 d1570a6c d14e3ec8 c1039faa 00000=
009 00000000
[   29.641104]  d14e3ee0 c15298ba c187e800 d1570960 00000001 d1570a6c d14e3=
f00 c152826b
[   29.644578] Call Trace:
[   29.647112]  [<c1531d71>] dump_stack+0x48/0x60
[   29.648517]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.650146]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.651582]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.653091]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.654507]  [<c152826b>] netlink_release+0x23e/0x254
[   29.656034]  [<c150329b>] sock_release+0x10/0x5b
[   29.657477]  [<c15032f1>] sock_close+0xb/0xf
[   29.658849]  [<c10c1621>] __fput+0xd0/0x15c
[   29.660207]  [<c10c16d3>] ____fput+0x8/0xa
[   29.661534]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.662977]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.664357]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.665765]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.667186]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.668641]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.670171]  [<c1537745>] syscall_call+0x7/0x7
[   29.671563]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.672941] ---[ end trace f84d29e8c6948724 ]---
[   29.674374] ------------[ cut here ]------------
[   29.675803] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.678726] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.681467] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.684394]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.687868]  c15298ba c196a9c0 00000004 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.691348]  d14e3ee0 c15298ba c187e800 d1570960 00000004 d1570a6c d14e3=
f00 c152826b
[   29.694837] Call Trace:
[   29.695864]  [<c1531d71>] dump_stack+0x48/0x60
[   29.697269]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.698832]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.700278]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.701796]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.703215]  [<c152826b>] netlink_release+0x23e/0x254
[   29.704753]  [<c150329b>] sock_release+0x10/0x5b
[   29.706182]  [<c15032f1>] sock_close+0xb/0xf
[   29.707560]  [<c10c1621>] __fput+0xd0/0x15c
[   29.708914]  [<c10c16d3>] ____fput+0x8/0xa
[   29.710278]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.711733]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.713115]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.714526]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.715951]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.717390]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.718858]  [<c1537745>] syscall_call+0x7/0x7
[   29.720261]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.721634] ---[ end trace f84d29e8c6948725 ]---
[   29.723063] ------------[ cut here ]------------
[   29.724492] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.727438] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.730191] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.733086]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.736520]  c15298ba c196a9c0 00000005 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.739969]  d14e3ee0 c15298ba c187e800 d1570960 00000005 d1570a6c d14e3=
f00 c152826b
[   29.743424] Call Trace:
[   29.744445]  [<c1531d71>] dump_stack+0x48/0x60
[   29.745851]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.747399]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.748847]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.750377]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.751789]  [<c152826b>] netlink_release+0x23e/0x254
[   29.753278]  [<c150329b>] sock_release+0x10/0x5b
[   29.754721]  [<c15032f1>] sock_close+0xb/0xf
[   29.756066]  [<c10c1621>] __fput+0xd0/0x15c
[   29.757412]  [<c10c16d3>] ____fput+0x8/0xa
[   29.758737]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.760180]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.761552]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.762963]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.764373]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.765819]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.767277]  [<c1537745>] syscall_call+0x7/0x7
[   29.768670]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.770063] ---[ end trace f84d29e8c6948726 ]---
[   29.771471] ------------[ cut here ]------------
[   29.772892] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.775821] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.778600] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.781550]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.785041]  c15298ba c196a9c0 00000006 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.788526]  d14e3ee0 c15298ba c187e800 d1570960 00000006 d1570a6c d14e3=
f00 c152826b
[   29.792045] Call Trace:
[   29.793068]  [<c1531d71>] dump_stack+0x48/0x60
[   29.794465]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.796040]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.797491]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.799021]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.800453]  [<c152826b>] netlink_release+0x23e/0x254
[   29.801973]  [<c150329b>] sock_release+0x10/0x5b
[   29.803423]  [<c15032f1>] sock_close+0xb/0xf
[   29.804784]  [<c10c1621>] __fput+0xd0/0x15c
[   29.806126]  [<c10c16d3>] ____fput+0x8/0xa
[   29.807469]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.808925]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.810367]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.811787]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.813186]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.814642]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.816087]  [<c1537745>] syscall_call+0x7/0x7
[   29.817484]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.818864] ---[ end trace f84d29e8c6948727 ]---
[   29.820312] ------------[ cut here ]------------
[   29.821745] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.824674] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.827424] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.830378]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.833852]  c15298ba c196a9c0 00000007 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.837317]  d14e3ee0 c15298ba c187e800 d1570960 00000007 d1570a6c d14e3=
f00 c152826b
[   29.840808] Call Trace:
[   29.841834]  [<c1531d71>] dump_stack+0x48/0x60
[   29.843229]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.844803]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.846249]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.847793]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.849203]  [<c152826b>] netlink_release+0x23e/0x254
[   29.850772]  [<c150329b>] sock_release+0x10/0x5b
[   29.852190]  [<c15032f1>] sock_close+0xb/0xf
[   29.853564]  [<c10c1621>] __fput+0xd0/0x15c
[   29.854915]  [<c10c16d3>] ____fput+0x8/0xa
[   29.856247]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.857756]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.866130]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.867546]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.868962]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.870433]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.871891]  [<c1537745>] syscall_call+0x7/0x7
[   29.873265]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.874640] ---[ end trace f84d29e8c6948728 ]---
[   29.876054] ------------[ cut here ]------------
[   29.877480] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.880401] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.883106] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.886013]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.889445]  c15298ba c196a9c0 00000008 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.892923]  d14e3ee0 c15298ba c187e800 d1570960 00000008 d1570a6c d14e3=
f00 c152826b
[   29.896356] Call Trace:
[   29.897383]  [<c1531d71>] dump_stack+0x48/0x60
[   29.898781]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.900329]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.901767]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.903260]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.904692]  [<c152826b>] netlink_release+0x23e/0x254
[   29.906177]  [<c150329b>] sock_release+0x10/0x5b
[   29.907602]  [<c15032f1>] sock_close+0xb/0xf
[   29.908959]  [<c10c1621>] __fput+0xd0/0x15c
[   29.910333]  [<c10c16d3>] ____fput+0x8/0xa
[   29.911657]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.913078]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.914456]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.915861]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.917277]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.918716]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.920173]  [<c1537745>] syscall_call+0x7/0x7
[   29.921559]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.922912] ---[ end trace f84d29e8c6948729 ]---
[   29.924334] ------------[ cut here ]------------
[   29.925751] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.928667] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.931404] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.934299]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.937737]  c15298ba c196a9c0 00000009 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.941160]  d14e3ee0 c15298ba c187e800 d1570960 00000009 d1570a6c d14e3=
f00 c152826b
[   29.945849] Call Trace:
[   29.946995]  [<c1531d71>] dump_stack+0x48/0x60
[   29.948381]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   29.949939]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   29.951427]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   29.952944]  [<c15298ba>] genl_unbind+0x85/0x8b
[   29.954360]  [<c152826b>] netlink_release+0x23e/0x254
[   29.955877]  [<c150329b>] sock_release+0x10/0x5b
[   29.957308]  [<c15032f1>] sock_close+0xb/0xf
[   29.958773]  [<c10c1621>] __fput+0xd0/0x15c
[   29.960124]  [<c10c16d3>] ____fput+0x8/0xa
[   29.961446]  [<c104adc8>] task_work_run+0x7c/0xa2
[   29.962903]  [<c103ba25>] do_exit+0x2f1/0x735
[   29.964287]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   29.965706]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   29.967189]  [<c103bec4>] do_group_exit+0x34/0x90
[   29.968671]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   29.970169]  [<c1537745>] syscall_call+0x7/0x7
[   29.971558]  [<c1530000>] ? pfn_pte+0xb/0x33
[   29.972929] ---[ end trace f84d29e8c694872a ]---
[   29.974396] ------------[ cut here ]------------
[   29.975842] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   29.978827] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   29.981585] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   29.984524]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   29.988073]  c15298ba c196a9c0 0000000a 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   29.991538]  d14e3ee0 c15298ba c187e800 d1570960 0000000a d1570a6c d14e3=
f00 c152826b
[   29.995047] Call Trace:
[   29.996069]  [<c1531d71>] dump_stack+0x48/0x60
[   29.998772]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.000354]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.003765]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.006094]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.008322]  [<c152826b>] netlink_release+0x23e/0x254
[   30.009862]  [<c150329b>] sock_release+0x10/0x5b
[   30.011359]  [<c15032f1>] sock_close+0xb/0xf
[   30.012748]  [<c10c1621>] __fput+0xd0/0x15c
[   30.014869]  [<c10c16d3>] ____fput+0x8/0xa
[   30.016209]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.017741]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.019130]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.020561]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.021978]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.023423]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.024910]  [<c1537745>] syscall_call+0x7/0x7
[   30.026355]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.027744] ---[ end trace f84d29e8c694872b ]---
[   30.029158] ------------[ cut here ]------------
[   30.030627] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.033544] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.036293] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.039265]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.042729]  c15298ba c196a9c0 0000000b 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.046173]  d14e3ee0 c15298ba c187e800 d1570960 0000000b d1570a6c d14e3=
f00 c152826b
[   30.049699] Call Trace:
[   30.050763]  [<c1531d71>] dump_stack+0x48/0x60
[   30.052150]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.053714]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.055145]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.056658]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.058128]  [<c152826b>] netlink_release+0x23e/0x254
[   30.059630]  [<c150329b>] sock_release+0x10/0x5b
[   30.061070]  [<c15032f1>] sock_close+0xb/0xf
[   30.062419]  [<c10c1621>] __fput+0xd0/0x15c
[   30.063781]  [<c10c16d3>] ____fput+0x8/0xa
[   30.065102]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.066594]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.068000]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.069393]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.070852]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.072279]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.073754]  [<c1537745>] syscall_call+0x7/0x7
[   30.075134]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.076493] ---[ end trace f84d29e8c694872c ]---
[   30.077993] ------------[ cut here ]------------
[   30.079409] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.082357] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.085090] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.088089]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.091552]  c15298ba c196a9c0 0000000c 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.095076]  d14e3ee0 c15298ba c187e800 d1570960 0000000c d1570a6c d14e3=
f00 c152826b
[   30.098574] Call Trace:
[   30.099601]  [<c1531d71>] dump_stack+0x48/0x60
[   30.101045]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.102585]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.104040]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.105537]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.107035]  [<c152826b>] netlink_release+0x23e/0x254
[   30.108532]  [<c150329b>] sock_release+0x10/0x5b
[   30.109969]  [<c15032f1>] sock_close+0xb/0xf
[   30.111362]  [<c10c1621>] __fput+0xd0/0x15c
[   30.112711]  [<c10c16d3>] ____fput+0x8/0xa
[   30.114046]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.115472]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.116862]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.118341]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.119760]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.121214]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.122675]  [<c1537745>] syscall_call+0x7/0x7
[   30.124069]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.125421] ---[ end trace f84d29e8c694872d ]---
[   30.126946] ------------[ cut here ]------------
[   30.128357] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.131325] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.134085] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.136995]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.147775]  c15298ba c196a9c0 0000000d 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.151371]  d14e3ee0 c15298ba c187e800 d1570960 0000000d d1570a6c d14e3=
f00 c152826b
[   30.154906] Call Trace:
[   30.155934]  [<c1531d71>] dump_stack+0x48/0x60
[   30.157338]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.158961]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.160399]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.161912]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.163316]  [<c152826b>] netlink_release+0x23e/0x254
[   30.164836]  [<c150329b>] sock_release+0x10/0x5b
[   30.166357]  [<c15032f1>] sock_close+0xb/0xf
[   30.167732]  [<c10c1621>] __fput+0xd0/0x15c
[   30.169069]  [<c10c16d3>] ____fput+0x8/0xa
[   30.170435]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.171879]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.173243]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.174677]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.176079]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.177578]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.179031]  [<c1537745>] syscall_call+0x7/0x7
[   30.180430]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.181788] ---[ end trace f84d29e8c694872e ]---
[   30.183209] ------------[ cut here ]------------
[   30.184690] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.187669] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.190402] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.193285]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.196761]  c15298ba c196a9c0 00000013 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.200249]  d14e3ee0 c15298ba c187e800 d1570960 00000013 d1570a6c d14e3=
f00 c152826b
[   30.203697] Call Trace:
[   30.204714]  [<c1531d71>] dump_stack+0x48/0x60
[   30.206093]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.207722]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.209153]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.210710]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.212110]  [<c152826b>] netlink_release+0x23e/0x254
[   30.213631]  [<c150329b>] sock_release+0x10/0x5b
[   30.215044]  [<c15032f1>] sock_close+0xb/0xf
[   30.216394]  [<c10c1621>] __fput+0xd0/0x15c
[   30.217808]  [<c10c16d3>] ____fput+0x8/0xa
[   30.219122]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.220561]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.221937]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.223366]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.224779]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.226227]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.227761]  [<c1537745>] syscall_call+0x7/0x7
[   30.229139]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.230529] ---[ end trace f84d29e8c694872f ]---
[   30.231958] ------------[ cut here ]------------
[   30.233391] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.236297] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.239079] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.242005]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.245439]  c15298ba c196a9c0 00000015 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.248942]  d14e3ee0 c15298ba c187e800 d1570960 00000015 d1570a6c d14e3=
f00 c152826b
[   30.252396] Call Trace:
[   30.253426]  [<c1531d71>] dump_stack+0x48/0x60
[   30.254819]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.256362]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.257934]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.259433]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.260867]  [<c152826b>] netlink_release+0x23e/0x254
[   30.262363]  [<c150329b>] sock_release+0x10/0x5b
[   30.263804]  [<c15032f1>] sock_close+0xb/0xf
[   30.265154]  [<c10c1621>] __fput+0xd0/0x15c
[   30.266552]  [<c10c16d3>] ____fput+0x8/0xa
[   30.267894]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.269319]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.270745]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.272141]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.273548]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.274989]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.276427]  [<c1537745>] syscall_call+0x7/0x7
[   30.277888]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.279245] ---[ end trace f84d29e8c6948730 ]---
[   30.280680] ------------[ cut here ]------------
[   30.282097] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.285028] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.287871] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.290802]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.294247]  c15298ba c196a9c0 00000018 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.297770]  d14e3ee0 c15298ba c187e800 d1570960 00000018 d1570a6c d14e3=
f00 c152826b
[   30.301221] Call Trace:
[   30.302244]  [<c1531d71>] dump_stack+0x48/0x60
[   30.303657]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.305195]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.306708]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.308204]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.309607]  [<c152826b>] netlink_release+0x23e/0x254
[   30.311151]  [<c150329b>] sock_release+0x10/0x5b
[   30.312560]  [<c15032f1>] sock_close+0xb/0xf
[   30.313935]  [<c10c1621>] __fput+0xd0/0x15c
[   30.315267]  [<c10c16d3>] ____fput+0x8/0xa
[   30.316587]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.318095]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.319461]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.320889]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.322287]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.323744]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.325189]  [<c1537745>] syscall_call+0x7/0x7
[   30.326643]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.328008] ---[ end trace f84d29e8c6948731 ]---
[   30.329494] ------------[ cut here ]------------
[   30.331349] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.334329] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.337096] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.340105]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.343575]  c15298ba c196a9c0 00000001 d1572fec d14e3ec8 c1039faa 00000=
009 00000000
[   30.347124]  d14e3ee0 c15298ba c187e800 d1572ee0 00000001 d1572fec d14e3=
f00 c152826b
[   30.350584] Call Trace:
[   30.351601]  [<c1531d71>] dump_stack+0x48/0x60
[   30.352994]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.354544]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.355988]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.357552]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.358957]  [<c152826b>] netlink_release+0x23e/0x254
[   30.360463]  [<c150329b>] sock_release+0x10/0x5b
[   30.361887]  [<c15032f1>] sock_close+0xb/0xf
[   30.363228]  [<c10c1621>] __fput+0xd0/0x15c
[   30.364575]  [<c10c16d3>] ____fput+0x8/0xa
[   30.365898]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.367395]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.368769]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.370206]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.371606]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.373047]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.374517]  [<c1537745>] syscall_call+0x7/0x7
[   30.375909]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.377268] ---[ end trace f84d29e8c6948732 ]---
[   30.378751] ------------[ cut here ]------------
[   30.380176] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.383081] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.385824] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.388789]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.392246]  c15298ba c196a9c0 00000004 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.395690]  d14e3ee0 c15298ba c187e800 d1572ee0 00000004 d1572fec d14e3=
f00 c152826b
[   30.399189] Call Trace:
[   30.400223]  [<c1531d71>] dump_stack+0x48/0x60
[   30.401606]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.403148]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.404591]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.406121]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.407635]  [<c152826b>] netlink_release+0x23e/0x254
[   30.409144]  [<c150329b>] sock_release+0x10/0x5b
[   30.410656]  [<c15032f1>] sock_close+0xb/0xf
[   30.412020]  [<c10c1621>] __fput+0xd0/0x15c
[   30.420428]  [<c10c16d3>] ____fput+0x8/0xa
[   30.421767]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.423199]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.424593]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.426003]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.427474]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.428915]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.430412]  [<c1537745>] syscall_call+0x7/0x7
[   30.431802]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.433147] ---[ end trace f84d29e8c6948733 ]---
[   30.434567] ------------[ cut here ]------------
[   30.435984] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.438959] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.441695] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.444567]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.448090]  c15298ba c196a9c0 00000007 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.451553]  d14e3ee0 c15298ba c187e800 d1572ee0 00000007 d1572fec d14e3=
f00 c152826b
[   30.455001] Call Trace:
[   30.456022]  [<c1531d71>] dump_stack+0x48/0x60
[   30.457421]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.459032]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.460470]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.461975]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.463382]  [<c152826b>] netlink_release+0x23e/0x254
[   30.464886]  [<c150329b>] sock_release+0x10/0x5b
[   30.466355]  [<c15032f1>] sock_close+0xb/0xf
[   30.467729]  [<c10c1621>] __fput+0xd0/0x15c
[   30.469066]  [<c10c16d3>] ____fput+0x8/0xa
[   30.470425]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.471868]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.473231]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.474658]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.476116]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.477656]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.479113]  [<c1537745>] syscall_call+0x7/0x7
[   30.480507]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.481916] ---[ end trace f84d29e8c6948734 ]---
[   30.483328] ------------[ cut here ]------------
[   30.484767] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.487768] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.490529] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.493462]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.496949]  c15298ba c196a9c0 00000008 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.500447]  d14e3ee0 c15298ba c187e800 d1572ee0 00000008 d1572fec d14e3=
f00 c152826b
[   30.503890] Call Trace:
[   30.504907]  [<c1531d71>] dump_stack+0x48/0x60
[   30.506351]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.507914]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.509344]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.510883]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.512283]  [<c152826b>] netlink_release+0x23e/0x254
[   30.513797]  [<c150329b>] sock_release+0x10/0x5b
[   30.515204]  [<c15032f1>] sock_close+0xb/0xf
[   30.516556]  [<c10c1621>] __fput+0xd0/0x15c
[   30.517978]  [<c10c16d3>] ____fput+0x8/0xa
[   30.519290]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.520740]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.522105]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.523513]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.524919]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.526405]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.527876]  [<c1537745>] syscall_call+0x7/0x7
[   30.529253]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.530649] ---[ end trace f84d29e8c6948735 ]---
[   30.532058] ------------[ cut here ]------------
[   30.533483] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.536381] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.539167] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.542102]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.545564]  c15298ba c196a9c0 00000009 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.549068]  d14e3ee0 c15298ba c187e800 d1572ee0 00000009 d1572fec d14e3=
f00 c152826b
[   30.552526] Call Trace:
[   30.553568]  [<c1531d71>] dump_stack+0x48/0x60
[   30.554960]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.556495]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.558020]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.559515]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.560940]  [<c152826b>] netlink_release+0x23e/0x254
[   30.562426]  [<c150329b>] sock_release+0x10/0x5b
[   30.563858]  [<c15032f1>] sock_close+0xb/0xf
[   30.565204]  [<c10c1621>] __fput+0xd0/0x15c
[   30.566597]  [<c10c16d3>] ____fput+0x8/0xa
[   30.567941]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.569369]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.570779]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.572194]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.573603]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.575040]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.576486]  [<c1537745>] syscall_call+0x7/0x7
[   30.577956]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.579312] ---[ end trace f84d29e8c6948736 ]---
[   30.580791] ------------[ cut here ]------------
[   30.582219] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.585123] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.587856] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.590776]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.594197]  c15298ba c196a9c0 0000000a 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.597714]  d14e3ee0 c15298ba c187e800 d1572ee0 0000000a d1572fec d14e3=
f00 c152826b
[   30.601153] Call Trace:
[   30.602166]  [<c1531d71>] dump_stack+0x48/0x60
[   30.603559]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.605107]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.606522]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.608040]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.609428]  [<c152826b>] netlink_release+0x23e/0x254
[   30.611019]  [<c150329b>] sock_release+0x10/0x5b
[   30.612466]  [<c15032f1>] sock_close+0xb/0xf
[   30.613876]  [<c10c1621>] __fput+0xd0/0x15c
[   30.615253]  [<c10c16d3>] ____fput+0x8/0xa
[   30.616632]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.618133]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.619521]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.620961]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.622362]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.623842]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.625318]  [<c1537745>] syscall_call+0x7/0x7
[   30.626744]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.628112] ---[ end trace f84d29e8c6948737 ]---
[   30.629551] ------------[ cut here ]------------
[   30.631031] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.633947] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.636658] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.639556]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.642998]  c15298ba c196a9c0 0000000b 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.646429]  d14e3ee0 c15298ba c187e800 d1572ee0 0000000b d1572fec d14e3=
f00 c152826b
[   30.649874] Call Trace:
[   30.650933]  [<c1531d71>] dump_stack+0x48/0x60
[   30.652311]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.653868]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.655292]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.656809]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.658198]  [<c152826b>] netlink_release+0x23e/0x254
[   30.659689]  [<c150329b>] sock_release+0x10/0x5b
[   30.661104]  [<c15032f1>] sock_close+0xb/0xf
[   30.662456]  [<c10c1621>] __fput+0xd0/0x15c
[   30.663806]  [<c10c16d3>] ____fput+0x8/0xa
[   30.665121]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.666551]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.667942]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.669333]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.670777]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.672199]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.673661]  [<c1537745>] syscall_call+0x7/0x7
[   30.675035]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.676375] ---[ end trace f84d29e8c6948738 ]---
[   30.677805] ------------[ cut here ]------------
[   30.679206] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.682114] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.691757] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.694649]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.698082]  c15298ba c196a9c0 0000000c 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.701504]  d14e3ee0 c15298ba c187e800 d1572ee0 0000000c d1572fec d14e3=
f00 c152826b
[   30.704939] Call Trace:
[   30.705952]  [<c1531d71>] dump_stack+0x48/0x60
[   30.707345]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.708884]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.710349]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.711841]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.713227]  [<c152826b>] netlink_release+0x23e/0x254
[   30.714733]  [<c150329b>] sock_release+0x10/0x5b
[   30.716135]  [<c15032f1>] sock_close+0xb/0xf
[   30.717486]  [<c10c1621>] __fput+0xd0/0x15c
[   30.718824]  [<c10c16d3>] ____fput+0x8/0xa
[   30.720142]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.721560]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.722939]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.724345]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.725748]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.727184]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.728626]  [<c1537745>] syscall_call+0x7/0x7
[   30.730055]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.731402] ---[ end trace f84d29e8c6948739 ]---
[   30.732824] ------------[ cut here ]------------
[   30.734253] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.737148] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.739847] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.742738]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.746147]  c15298ba c196a9c0 0000000d 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.749557]  d14e3ee0 c15298ba c187e800 d1572ee0 0000000d d1572fec d14e3=
f00 c152826b
[   30.753017] Call Trace:
[   30.754045]  [<c1531d71>] dump_stack+0x48/0x60
[   30.755424]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.756985]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.758402]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.759897]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.761306]  [<c152826b>] netlink_release+0x23e/0x254
[   30.762797]  [<c150329b>] sock_release+0x10/0x5b
[   30.764212]  [<c15032f1>] sock_close+0xb/0xf
[   30.765555]  [<c10c1621>] __fput+0xd0/0x15c
[   30.766908]  [<c10c16d3>] ____fput+0x8/0xa
[   30.768243]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.769683]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.771088]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.772478]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.773895]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.775311]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.776771]  [<c1537745>] syscall_call+0x7/0x7
[   30.778138]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.779477] ---[ end trace f84d29e8c694873a ]---
[   30.780910] ------------[ cut here ]------------
[   30.782314] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.785218] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.787911] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.790814]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.794220]  c15298ba c196a9c0 0000000e 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.797655]  d14e3ee0 c15298ba c187e800 d1572ee0 0000000e d1572fec d14e3=
f00 c152826b
[   30.801064] Call Trace:
[   30.802077]  [<c1531d71>] dump_stack+0x48/0x60
[   30.803474]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.805026]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.806449]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.807963]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.809356]  [<c152826b>] netlink_release+0x23e/0x254
[   30.810893]  [<c150329b>] sock_release+0x10/0x5b
[   30.812296]  [<c15032f1>] sock_close+0xb/0xf
[   30.813657]  [<c10c1621>] __fput+0xd0/0x15c
[   30.814985]  [<c10c16d3>] ____fput+0x8/0xa
[   30.816297]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.817747]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.819104]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.820506]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.821923]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.823378]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.824867]  [<c1537745>] syscall_call+0x7/0x7
[   30.826241]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.827592] ---[ end trace f84d29e8c694873b ]---
[   30.829008] ------------[ cut here ]------------
[   30.830455] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.833333] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.836046] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.838927]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.842358]  c15298ba c196a9c0 0000000f 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.845780]  d14e3ee0 c15298ba c187e800 d1572ee0 0000000f d1572fec d14e3=
f00 c152826b
[   30.849186] Call Trace:
[   30.850241]  [<c1531d71>] dump_stack+0x48/0x60
[   30.851630]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.853158]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.854590]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.856078]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.857482]  [<c152826b>] netlink_release+0x23e/0x254
[   30.858983]  [<c150329b>] sock_release+0x10/0x5b
[   30.860402]  [<c15032f1>] sock_close+0xb/0xf
[   30.861750]  [<c10c1621>] __fput+0xd0/0x15c
[   30.863071]  [<c10c16d3>] ____fput+0x8/0xa
[   30.864395]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.865835]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.867205]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.868591]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.869989]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.871448]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.872897]  [<c1537745>] syscall_call+0x7/0x7
[   30.874281]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.875629] ---[ end trace f84d29e8c694873c ]---
[   30.877040] ------------[ cut here ]------------
[   30.878439] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.881321] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.884029] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.886921]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.890356]  c15298ba c196a9c0 00000013 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.893764]  d14e3ee0 c15298ba c187e800 d1572ee0 00000013 d1572fec d14e3=
f00 c152826b
[   30.897182] Call Trace:
[   30.898193]  [<c1531d71>] dump_stack+0x48/0x60
[   30.899561]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.901112]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.902525]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.904025]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.905412]  [<c152826b>] netlink_release+0x23e/0x254
[   30.906920]  [<c150329b>] sock_release+0x10/0x5b
[   30.908317]  [<c15032f1>] sock_close+0xb/0xf
[   30.909661]  [<c10c1621>] __fput+0xd0/0x15c
[   30.911027]  [<c10c16d3>] ____fput+0x8/0xa
[   30.912334]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.913776]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.915132]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.916531]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.917947]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.919364]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.920831]  [<c1537745>] syscall_call+0x7/0x7
[   30.922197]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.923549] ---[ end trace f84d29e8c694873d ]---
[   30.924965] ------------[ cut here ]------------
[   30.926359] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.929250] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.931982] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.934855]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.938260]  c15298ba c196a9c0 00000014 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.941676]  d14e3ee0 c15298ba c187e800 d1572ee0 00000014 d1572fec d14e3=
f00 c152826b
[   30.945080] Call Trace:
[   30.946092]  [<c1531d71>] dump_stack+0x48/0x60
[   30.947480]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   30.949021]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   30.950477]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   30.951973]  [<c15298ba>] genl_unbind+0x85/0x8b
[   30.953370]  [<c152826b>] netlink_release+0x23e/0x254
[   30.961729]  [<c150329b>] sock_release+0x10/0x5b
[   30.963129]  [<c15032f1>] sock_close+0xb/0xf
[   30.964481]  [<c10c1621>] __fput+0xd0/0x15c
[   30.965819]  [<c10c16d3>] ____fput+0x8/0xa
[   30.967135]  [<c104adc8>] task_work_run+0x7c/0xa2
[   30.968553]  [<c103ba25>] do_exit+0x2f1/0x735
[   30.969923]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   30.971348]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   30.972744]  [<c103bec4>] do_group_exit+0x34/0x90
[   30.974176]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   30.975606]  [<c1537745>] syscall_call+0x7/0x7
[   30.976998]  [<c1530000>] ? pfn_pte+0xb/0x33
[   30.978331] ---[ end trace f84d29e8c694873e ]---
[   30.979750] ------------[ cut here ]------------
[   30.981163] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   30.984049] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   30.986753] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   30.989587]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   30.993022]  c15298ba c196a9c0 00000015 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   30.996434]  d14e3ee0 c15298ba c187e800 d1572ee0 00000015 d1572fec d14e3=
f00 c152826b
[   30.999869] Call Trace:
[   31.000901]  [<c1531d71>] dump_stack+0x48/0x60
[   31.002268]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   31.003814]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   31.005229]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   31.006731]  [<c15298ba>] genl_unbind+0x85/0x8b
[   31.008111]  [<c152826b>] netlink_release+0x23e/0x254
[   31.009586]  [<c150329b>] sock_release+0x10/0x5b
[   31.011033]  [<c15032f1>] sock_close+0xb/0xf
[   31.012375]  [<c10c1621>] __fput+0xd0/0x15c
[   31.013725]  [<c10c16d3>] ____fput+0x8/0xa
[   31.015027]  [<c104adc8>] task_work_run+0x7c/0xa2
[   31.016442]  [<c103ba25>] do_exit+0x2f1/0x735
[   31.017819]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   31.019205]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   31.020598]  [<c103bec4>] do_group_exit+0x34/0x90
[   31.022026]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   31.023469]  [<c1537745>] syscall_call+0x7/0x7
[   31.024848]  [<c1530000>] ? pfn_pte+0xb/0x33
[   31.026183] ---[ end trace f84d29e8c694873f ]---
[   31.027594] ------------[ cut here ]------------
[   31.028996] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   31.031911] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   31.034606] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   31.037499]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   31.040913]  c15298ba c196a9c0 00000016 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   31.044314]  d14e3ee0 c15298ba c187e800 d1572ee0 00000016 d1572fec d14e3=
f00 c152826b
[   31.047730] Call Trace:
[   31.048740]  [<c1531d71>] dump_stack+0x48/0x60
[   31.050148]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   31.051687]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   31.053102]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   31.054600]  [<c15298ba>] genl_unbind+0x85/0x8b
[   31.055991]  [<c152826b>] netlink_release+0x23e/0x254
[   31.057477]  [<c150329b>] sock_release+0x10/0x5b
[   31.058886]  [<c15032f1>] sock_close+0xb/0xf
[   31.060232]  [<c10c1621>] __fput+0xd0/0x15c
[   31.061550]  [<c10c16d3>] ____fput+0x8/0xa
[   31.062866]  [<c104adc8>] task_work_run+0x7c/0xa2
[   31.064295]  [<c103ba25>] do_exit+0x2f1/0x735
[   31.065660]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   31.067056]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   31.068435]  [<c103bec4>] do_group_exit+0x34/0x90
[   31.069853]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   31.071326]  [<c1537745>] syscall_call+0x7/0x7
[   31.072710]  [<c1530000>] ? pfn_pte+0xb/0x33
[   31.074055] ---[ end trace f84d29e8c6948740 ]---
[   31.075455] ------------[ cut here ]------------
[   31.076879] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   31.079756] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   31.082438] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   31.085304]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   31.088713]  c15298ba c196a9c0 00000017 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   31.092150]  d14e3ee0 c15298ba c187e800 d1572ee0 00000017 d1572fec d14e3=
f00 c152826b
[   31.095569] Call Trace:
[   31.096581]  [<c1531d71>] dump_stack+0x48/0x60
[   31.097988]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   31.099518]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   31.100946]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   31.102417]  [<c15298ba>] genl_unbind+0x85/0x8b
[   31.103830]  [<c152826b>] netlink_release+0x23e/0x254
[   31.105304]  [<c150329b>] sock_release+0x10/0x5b
[   31.106731]  [<c15032f1>] sock_close+0xb/0xf
[   31.108066]  [<c10c1621>] __fput+0xd0/0x15c
[   31.109390]  [<c10c16d3>] ____fput+0x8/0xa
[   31.110766]  [<c104adc8>] task_work_run+0x7c/0xa2
[   31.112190]  [<c103ba25>] do_exit+0x2f1/0x735
[   31.113557]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   31.114953]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   31.116333]  [<c103bec4>] do_group_exit+0x34/0x90
[   31.117773]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   31.119202]  [<c1537745>] syscall_call+0x7/0x7
[   31.120585]  [<c1530000>] ? pfn_pte+0xb/0x33
[   31.121933] ---[ end trace f84d29e8c6948741 ]---
[   31.123330] ------------[ cut here ]------------
[   31.124749] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   31.127640] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   31.130353] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   31.133205]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   31.136604]  c15298ba c196a9c0 00000018 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   31.140032]  d14e3ee0 c15298ba c187e800 d1572ee0 00000018 d1572fec d14e3=
f00 c152826b
[   31.143437] Call Trace:
[   31.144444]  [<c1531d71>] dump_stack+0x48/0x60
[   31.145820]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   31.147363]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   31.148790]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   31.150313]  [<c15298ba>] genl_unbind+0x85/0x8b
[   31.151705]  [<c152826b>] netlink_release+0x23e/0x254
[   31.153177]  [<c150329b>] sock_release+0x10/0x5b
[   31.154597]  [<c15032f1>] sock_close+0xb/0xf
[   31.155942]  [<c10c1621>] __fput+0xd0/0x15c
[   31.157274]  [<c10c16d3>] ____fput+0x8/0xa
[   31.158580]  [<c104adc8>] task_work_run+0x7c/0xa2
[   31.160016]  [<c103ba25>] do_exit+0x2f1/0x735
[   31.161369]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   31.162761]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   31.164157]  [<c103bec4>] do_group_exit+0x34/0x90
[   31.165575]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   31.167031]  [<c1537745>] syscall_call+0x7/0x7
[   31.168400]  [<c1530000>] ? pfn_pte+0xb/0x33
[   31.169745] ---[ end trace f84d29e8c6948742 ]---
[   31.172973] ------------[ cut here ]------------
[   31.174393] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   31.177289] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   31.179973] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   31.182852]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   31.186270]  c15298ba c196a9c0 00000001 d15e187c d14e3ec8 c1039faa 00000=
009 00000000
[   31.189669]  d14e3ee0 c15298ba c187e800 d15e1770 00000001 d15e187c d14e3=
f00 c152826b
[   31.193103] Call Trace:
[   31.194129]  [<c1531d71>] dump_stack+0x48/0x60
[   31.195512]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   31.197069]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   31.198487]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   31.199977]  [<c15298ba>] genl_unbind+0x85/0x8b
[   31.201368]  [<c152826b>] netlink_release+0x23e/0x254
[   31.202857]  [<c150329b>] sock_release+0x10/0x5b
[   31.204275]  [<c15032f1>] sock_close+0xb/0xf
[   31.205608]  [<c10c1621>] __fput+0xd0/0x15c
[   31.206948]  [<c10c16d3>] ____fput+0x8/0xa
[   31.208247]  [<c104adc8>] task_work_run+0x7c/0xa2
[   31.209669]  [<c103ba25>] do_exit+0x2f1/0x735
[   31.211061]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   31.212444]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   31.213856]  [<c103bec4>] do_group_exit+0x34/0x90
[   31.215278]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   31.216736]  [<c1537745>] syscall_call+0x7/0x7
[   31.218107]  [<c1530000>] ? pfn_pte+0xb/0x33
[   31.219444] ---[ end trace f84d29e8c6948743 ]---
[   31.220875] ------------[ cut here ]------------
[   31.222275] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   31.232091] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   31.234799] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   31.237665]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   31.241068]  c15298ba c196a9c0 00000004 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   31.244465]  d14e3ee0 c15298ba c187e800 d15e1770 00000004 d15e187c d14e3=
f00 c152826b
[   31.247878] Call Trace:
[   31.248891]  [<c1531d71>] dump_stack+0x48/0x60
[   31.250305]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   31.251839]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   31.253254]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   31.254762]  [<c15298ba>] genl_unbind+0x85/0x8b
[   31.256144]  [<c152826b>] netlink_release+0x23e/0x254
[   31.257648]  [<c150329b>] sock_release+0x10/0x5b
[   31.259050]  [<c15032f1>] sock_close+0xb/0xf
[   31.260402]  [<c10c1621>] __fput+0xd0/0x15c
[   31.261733]  [<c10c16d3>] ____fput+0x8/0xa
[   31.263040]  [<c104adc8>] task_work_run+0x7c/0xa2
[   31.264470]  [<c103ba25>] do_exit+0x2f1/0x735
[   31.265838]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   31.267237]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   31.268642]  [<c103bec4>] do_group_exit+0x34/0x90
[   31.270101]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   31.271531]  [<c1537745>] syscall_call+0x7/0x7
[   31.272913]  [<c1530000>] ? pfn_pte+0xb/0x33
[   31.274262] ---[ end trace f84d29e8c6948744 ]---
[   31.275676] ------------[ cut here ]------------
[   31.277089] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   31.279961] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   31.282661] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   31.285527]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   31.288938]  c15298ba c196a9c0 00000005 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   31.292365]  d14e3ee0 c15298ba c187e800 d15e1770 00000005 d15e187c d14e3=
f00 c152826b
[   31.295795] Call Trace:
[   31.296817]  [<c1531d71>] dump_stack+0x48/0x60
[   31.298184]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   31.299726]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   31.301157]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   31.302644]  [<c15298ba>] genl_unbind+0x85/0x8b
[   31.304045]  [<c152826b>] netlink_release+0x23e/0x254
[   31.305524]  [<c150329b>] sock_release+0x10/0x5b
[   31.306971]  [<c15032f1>] sock_close+0xb/0xf
[   31.308307]  [<c10c1621>] __fput+0xd0/0x15c
[   31.309639]  [<c10c16d3>] ____fput+0x8/0xa
[   31.310985]  [<c104adc8>] task_work_run+0x7c/0xa2
[   31.312400]  [<c103ba25>] do_exit+0x2f1/0x735
[   31.313780]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   31.315166]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   31.316550]  [<c103bec4>] do_group_exit+0x34/0x90
[   31.317991]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   31.319424]  [<c1537745>] syscall_call+0x7/0x7
[   31.320825]  [<c1530000>] ? pfn_pte+0xb/0x33
[   31.322160] ---[ end trace f84d29e8c6948745 ]---
[   31.323573] ------------[ cut here ]------------
[   31.324984] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   31.327871] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   31.330587] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   31.333457]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   31.336877]  c15298ba c196a9c0 00000007 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   31.340282]  d14e3ee0 c15298ba c187e800 d15e1770 00000007 d15e187c d14e3=
f00 c152826b
[   31.343703] Call Trace:
[   31.344712]  [<c1531d71>] dump_stack+0x48/0x60
[   31.346077]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   31.347632]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   31.349047]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   31.350566]  [<c15298ba>] genl_unbind+0x85/0x8b
[   31.351966]  [<c152826b>] netlink_release+0x23e/0x254
[   31.353454]  [<c150329b>] sock_release+0x10/0x5b
[   31.354865]  [<c15032f1>] sock_close+0xb/0xf
[   31.356204]  [<c10c1621>] __fput+0xd0/0x15c
[   31.357552]  [<c10c16d3>] ____fput+0x8/0xa
[   31.358871]  [<c104adc8>] task_work_run+0x7c/0xa2
[   31.360300]  [<c103ba25>] do_exit+0x2f1/0x735
[   31.361663]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   31.363047]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   31.364450]  [<c103bec4>] do_group_exit+0x34/0x90
[   31.365878]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   31.367323]  [<c1537745>] syscall_call+0x7/0x7
[   31.368701]  [<c1530000>] ? pfn_pte+0xb/0x33
[   31.370076] ---[ end trace f84d29e8c6948746 ]---
[   31.371477] ------------[ cut here ]------------
[   31.372893] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   31.375777] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   31.378476] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   31.381362]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   31.384776]  c15298ba c196a9c0 00000008 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   31.388192]  d14e3ee0 c15298ba c187e800 d15e1770 00000008 d15e187c d14e3=
f00 c152826b
[   31.391628] Call Trace:
[   31.392643]  [<c1531d71>] dump_stack+0x48/0x60
[   31.394020]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   31.395550]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   31.396989]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   31.398467]  [<c15298ba>] genl_unbind+0x85/0x8b
[   31.399870]  [<c152826b>] netlink_release+0x23e/0x254
[   31.401361]  [<c150329b>] sock_release+0x10/0x5b
[   31.402775]  [<c15032f1>] sock_close+0xb/0xf
[   31.404130]  [<c10c1621>] __fput+0xd0/0x15c
[   31.405450]  [<c10c16d3>] ____fput+0x8/0xa
[   31.406783]  [<c104adc8>] task_work_run+0x7c/0xa2
[   31.408194]  [<c103ba25>] do_exit+0x2f1/0x735
[   31.409549]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   31.410989]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   31.412373]  [<c103bec4>] do_group_exit+0x34/0x90
[   31.413817]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   31.415248]  [<c1537745>] syscall_call+0x7/0x7
[   31.416627]  [<c1530000>] ? pfn_pte+0xb/0x33
[   31.417982] ---[ end trace f84d29e8c6948747 ]---
[   31.419377] ------------[ cut here ]------------
[   31.420811] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   31.423704] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   31.426371] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   31.429286]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   31.432840]  c15298ba c196a9c0 00000009 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   31.436401]  d14e3ee0 c15298ba c187e800 d15e1770 00000009 d15e187c d14e3=
f00 c152826b
[   31.439909] Call Trace:
[   31.440977]  [<c1531d71>] dump_stack+0x48/0x60
[   31.442352]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   31.443931]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   31.445399]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   31.446961]  [<c15298ba>] genl_unbind+0x85/0x8b
[   31.448356]  [<c152826b>] netlink_release+0x23e/0x254
[   31.449847]  [<c150329b>] sock_release+0x10/0x5b
[   31.451296]  [<c15032f1>] sock_close+0xb/0xf
[   31.452652]  [<c10c1621>] __fput+0xd0/0x15c
[   31.453996]  [<c10c16d3>] ____fput+0x8/0xa
[   31.455316]  [<c104adc8>] task_work_run+0x7c/0xa2
[   31.456759]  [<c103ba25>] do_exit+0x2f1/0x735
[   31.458116]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   31.459505]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   31.460922]  [<c103bec4>] do_group_exit+0x34/0x90
[   31.462341]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   31.463799]  [<c1537745>] syscall_call+0x7/0x7
[   31.465175]  [<c1530000>] ? pfn_pte+0xb/0x33
[   31.466513] ---[ end trace f84d29e8c6948748 ]---
[   31.467946] ------------[ cut here ]------------
[   31.469342] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   31.472252] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   31.474960] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   31.477833]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   31.481241]  c15298ba c196a9c0 0000000a 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   31.484664]  d14e3ee0 c15298ba c187e800 d15e1770 0000000a d15e187c d14e3=
f00 c152826b
[   31.488073] Call Trace:
[   31.489081]  [<c1531d71>] dump_stack+0x48/0x60
[   31.490490]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   31.492034]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   31.500387]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   31.501883]  [<c15298ba>] genl_unbind+0x85/0x8b
[   31.503267]  [<c152826b>] netlink_release+0x23e/0x254
[   31.504768]  [<c150329b>] sock_release+0x10/0x5b
[   31.506167]  [<c15032f1>] sock_close+0xb/0xf
[   31.507527]  [<c10c1621>] __fput+0xd0/0x15c
[   31.508867]  [<c10c16d3>] ____fput+0x8/0xa
[   31.510215]  [<c104adc8>] task_work_run+0x7c/0xa2
[   31.511639]  [<c103ba25>] do_exit+0x2f1/0x735
[   31.512996]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   31.514395]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   31.515789]  [<c103bec4>] do_group_exit+0x34/0x90
[   31.517212]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   31.518653]  [<c1537745>] syscall_call+0x7/0x7
[   31.520041]  [<c1530000>] ? pfn_pte+0xb/0x33
[   31.521375] ---[ end trace f84d29e8c6948749 ]---
[   31.522787] ------------[ cut here ]------------
[   31.524202] WARNING: CPU: 0 PID: 313 at net/netlink/genetlink.c:1037 gen=
l_unbind+0x85/0x8b()
[   31.527130] CPU: 0 PID: 313 Comm: trinity-main Tainted: G        W      =
3.19.0-rc4-00003-gfe4b991 #13
[   31.529822] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[   31.532731]  00000000 00000000 d14e3e9c c1531d71 00000000 d14e3eb8 c1039=
f0d 0000040d
[   31.536147]  c15298ba c196a9c0 0000000b 00000004 d14e3ec8 c1039faa 00000=
009 00000000
[   31.539567]  d14e3ee0 c15298ba c187e800 d15e1770 0000000b d15e187c d14e3=
f00 c152826b
[   31.542980] Call Trace:
[   31.544061]  [<c1531d71>] dump_stack+0x48/0x60
[   31.545429]  [<c1039f0d>] warn_slowpath_common+0x7a/0x91
[   31.546988]  [<c15298ba>] ? genl_unbind+0x85/0x8b
[   31.548404]  [<c1039faa>] warn_slowpath_null+0xf/0x13
[   31.549889]  [<c15298ba>] genl_unbind+0x85/0x8b
[   31.551313]  [<c152826b>] netlink_release+0x23e/0x254
[   31.552804]  [<c150329b>] sock_release+0x10/0x5b
[   31.554217]  [<c15032f1>] sock_close+0xb/0xf
[   31.555555]  [<c10c1621>] __fput+0xd0/0x15c
[   31.556899]  [<c10c16d3>] ____fput+0x8/0xa
[   31.558206]  [<c104adc8>] task_work_run+0x7c/0xa2
[   31.559631]  [<c103ba25>] do_exit+0x2f1/0x735
[   31.561001]  [<c10c0db7>] ? vfs_write+0xb6/0xc0
[   31.562384]  [<c10c0147>] ? fdput_pos+0x21/0x25
[   31.563799]  [<c103bec4>] do_group_exit+0x34/0x90
[   31.565229]  [<c103bf31>] SyS_exit_group+0x11/0x11
[   31.566690]  [<c1537745>] syscall_call+0x7/0x7
[   31.568057]  [<c1530000>] ? pfn_pte+0xb/0x33
[   31.569396] ---[ end trace f84d29e8c694874a ]---
[   73.652687] Unregister pv shared memory for cpu 0
[   73.676419] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   73.678129] reboot: Restarting system
[   73.679377] reboot: machine restart
Elapsed time: 80
qemu-system-x86_64 -cpu kvm64 -enable-kvm -kernel /kernel/i386-randconfig-r=
2-0215/fe4b991dcd84e0104cf2e29223a819335ed048a7/vmlinuz-3.19.0-rc4-00003-gf=
e4b991 -append 'hung_task_panic=3D1 earlyprintk=3DttyS0,115200 rd.udev.log-=
priority=3Derr systemd.log_target=3Djournal systemd.log_level=3Dwarning deb=
ug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 p=
anic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdi=
sk=3D2 prompt_ramdisk=3D0 console=3DttyS0,115200 console=3Dtty0 vga=3Dnorma=
l  root=3D/dev/ram0 rw link=3D/kbuild-tests/run-queue/kvm/i386-randconfig-r=
2-0215/linux-devel:devel-roam-rand-201502150502:fe4b991dcd84e0104cf2e29223a=
819335ed048a7:bisect-linux-8/.vmlinuz-fe4b991dcd84e0104cf2e29223a819335ed04=
8a7-20150215062532-12-client1 branch=3Dlinux-devel/devel-roam-rand-20150215=
0502 BOOT_IMAGE=3D/kernel/i386-randconfig-r2-0215/fe4b991dcd84e0104cf2e2922=
3a819335ed048a7/vmlinuz-3.19.0-rc4-00003-gfe4b991 drbd.minor_count=3D8'  -i=
nitrd /kernel-tests/initrd/yocto-minimal-i386.cgz -m 320 -smp 1 -net nic,vl=
an=3D1,model=3De1000 -net user,vlan=3D1 -boot order=3Dnc -no-reboot -watchd=
og i6300esb -rtc base=3Dlocaltime -pidfile /dev/shm/kboot/pid-yocto-client1=
-20 -serial file:/dev/shm/kboot/serial-yocto-client1-20 -daemonize -display=
 none -monitor null=20

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-quantal-client6-18:20150215062334:i386-randconfig-r2-0215:3.19.0-rc4-00002-ge1d3c0f:526"
Content-Transfer-Encoding: quoted-printable

early console in setup code
early console in decompress_kernel

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.19.0-rc4-00002-ge1d3c0f (kbuild@roam) (gcc v=
ersion 4.9.1 (Debian 4.9.1-19) ) #526 SMP Sun Feb 15 06:22:40 CST 2015
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000013fdffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000013fe0000-0x0000000013ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-2014=
0531_083030-gandalf 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x13fe0 max_arch_pfn =3D 0x1000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC =20
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f0eb0-0x000f0ebf] mapped at =
[c00f0eb0]
[    0.000000]   mpc: f0ec0-f0fa4
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] initial memory mapped: [mem 0x00000000-0x01dfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x12400000-0x125fffff]
[    0.000000]  [mem 0x12400000-0x125fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x123fffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x123fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x12600000-0x13fdffff]
[    0.000000]  [mem 0x12600000-0x13dfffff] page 2M
[    0.000000]  [mem 0x13e00000-0x13fdffff] page 4k
[    0.000000] BRK [0x0197a000, 0x0197afff] PGTABLE
[    0.000000] BRK [0x0197b000, 0x0197bfff] PGTABLE
[    0.000000] BRK [0x0197c000, 0x0197cfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x12793000-0x13fd7fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000F0C90 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x13FE18BD 000034 (v01 BOCHS  BXPCRSDT 00000001 B=
XPC 00000001)
[    0.000000] ACPI: FACP 0x13FE0B37 000074 (v01 BOCHS  BXPCFACP 00000001 B=
XPC 00000001)
[    0.000000] ACPI: DSDT 0x13FE0040 000AF7 (v01 BOCHS  BXPCDSDT 00000001 B=
XPC 00000001)
[    0.000000] ACPI: FACS 0x13FE0000 000040
[    0.000000] ACPI: SSDT 0x13FE0BAB 000C5A (v01 BOCHS  BXPCSSDT 00000001 B=
XPC 00000001)
[    0.000000] ACPI: APIC 0x13FE1805 000080 (v01 BOCHS  BXPCAPIC 00000001 B=
XPC 00000001)
[    0.000000] ACPI: HPET 0x13FE1885 000038 (v01 BOCHS  BXPCHPET 00000001 B=
XPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffc000 (        fee00000)
[    0.000000] 319MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 13fe0000
[    0.000000]   low ram: 0 - 13fe0000
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:13fdf001, primary cpu clock
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   Normal   [mem 0x01000000-0x13fdffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009efff]
[    0.000000]   node   0: [mem 0x00100000-0x13fdffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x13fdffff]
[    0.000000] On node 0 totalpages: 81790
[    0.000000] free_area_init_node: node 0, pgdat c187df80, node_mem_map d2=
513020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 608 pages used for memmap
[    0.000000]   Normal zone: 77792 pages, LIFO batch:15
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffc000 (        fee00000)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC =
INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC =
INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC =
INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC =
INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC =
INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC =
INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC =
INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC =
INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC =
INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC =
INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC =
INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC =
INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC =
INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC =
INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC =
INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffb000 (fec00000)
[    0.000000] e820: [mem 0x14000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:2 nr_=
node_ids:1
[    0.000000] PERCPU: Embedded 13 pages/cpu @d24f9000 s30144 r0 d23104 u53=
248
[    0.000000] pcpu-alloc: s30144 r0 d23104 u53248 alloc=3D13*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1=20
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 124fc680
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 81150
[    0.000000] Kernel command line: hung_task_panic=3D1 earlyprintk=3DttyS0=
,115200 rd.udev.log-priority=3Derr systemd.log_target=3Djournal systemd.log=
_level=3Dwarning debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_s=
tall_timeout=3D100 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oop=
s=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 console=3DttyS0,115200 consol=
e=3Dtty0 vga=3Dnormal  root=3D/dev/ram0 rw link=3D/kbuild-tests/run-queue/k=
vm/i386-randconfig-r2-0215/linux-devel:devel-roam-rand-201502150502:e1d3c0f=
d701df831169b116cd5c5d6203ac07f70:bisect-linux-8/.vmlinuz-e1d3c0fd701df8311=
69b116cd5c5d6203ac07f70-20150215062248-6-client6 branch=3Dlinux-devel/devel=
-roam-rand-201502150502 BOOT_IMAGE=3D/kernel/i386-randconfig-r2-0215/e1d3c0=
fd701df831169b116cd5c5d6203ac07f70/vmlinuz-3.19.0-rc4-00002-ge1d3c0f drbd.m=
inor_count=3D8
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[    0.000000] Initializing CPU#0
[    0.000000] Memory: 289432K/327160K available (5346K kernel code, 720K r=
wdata, 2692K rodata, 508K init, 344K bss, 37728K reserved, 0K cma-reserved)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xffd36000 - 0xfffff000   (2852 kB)
[    0.000000]     vmalloc : 0xd47e0000 - 0xffd34000   ( 693 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd3fe0000   ( 319 MB)
[    0.000000]       .init : 0xc1891000 - 0xc1910000   ( 508 kB)
[    0.000000]       .data : 0xc1538dc9 - 0xc188f100   (3416 kB)
[    0.000000]       .text : 0xc1000000 - 0xc1538dc9   (5347 kB)
[    0.000000] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.000000] SLUB: HWalign=3D128, Order=3D0-3, MinObjects=3D0, CPUs=3D2, =
Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.000000] NR_IRQS:2304 nr_irqs:440 16
[    0.000000] CPU 0 irqstacks, hard=3Dd2012000 soft=3Dd2014000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] bootconsole [earlyser0] disabled
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.19.0-rc4-00002-ge1d3c0f (kbuild@roam) (gcc v=
ersion 4.9.1 (Debian 4.9.1-19) ) #526 SMP Sun Feb 15 06:22:40 CST 2015
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000013fdffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000013fe0000-0x0000000013ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.7.5-2014=
0531_083030-gandalf 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x13fe0 max_arch_pfn =3D 0x1000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0080000000 mask FF80000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- UC =20
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] found SMP MP-table at [mem 0x000f0eb0-0x000f0ebf] mapped at =
[c00f0eb0]
[    0.000000]   mpc: f0ec0-f0fa4
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] initial memory mapped: [mem 0x00000000-0x01dfffff]
[    0.000000] Base memory trampoline at [c009b000] 9b000 size 16384
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] init_memory_mapping: [mem 0x12400000-0x125fffff]
[    0.000000]  [mem 0x12400000-0x125fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x123fffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x123fffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x12600000-0x13fdffff]
[    0.000000]  [mem 0x12600000-0x13dfffff] page 2M
[    0.000000]  [mem 0x13e00000-0x13fdffff] page 4k
[    0.000000] BRK [0x0197a000, 0x0197afff] PGTABLE
[    0.000000] BRK [0x0197b000, 0x0197bfff] PGTABLE
[    0.000000] BRK [0x0197c000, 0x0197cfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x12793000-0x13fd7fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000F0C90 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x13FE18BD 000034 (v01 BOCHS  BXPCRSDT 00000001 B=
XPC 00000001)
[    0.000000] ACPI: FACP 0x13FE0B37 000074 (v01 BOCHS  BXPCFACP 00000001 B=
XPC 00000001)
[    0.000000] ACPI: DSDT 0x13FE0040 000AF7 (v01 BOCHS  BXPCDSDT 00000001 B=
XPC 00000001)
[    0.000000] ACPI: FACS 0x13FE0000 000040
[    0.000000] ACPI: SSDT 0x13FE0BAB 000C5A (v01 BOCHS  BXPCSSDT 00000001 B=
XPC 00000001)
[    0.000000] ACPI: APIC 0x13FE1805 000080 (v01 BOCHS  BXPCAPIC 00000001 B=
XPC 00000001)
[    0.000000] ACPI: HPET 0x13FE1885 000038 (v01 BOCHS  BXPCHPET 00000001 B=
XPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffc000 (        fee00000)
[    0.000000] 319MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 13fe0000
[    0.000000]   low ram: 0 - 13fe0000
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:13fdf001, primary cpu clock
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   Normal   [mem 0x01000000-0x13fdffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009efff]
[    0.000000]   node   0: [mem 0x00100000-0x13fdffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x13fdffff]
[    0.000000] On node 0 totalpages: 81790
[    0.000000] free_area_init_node: node 0, pgdat c187df80, node_mem_map d2=
513020
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   Normal zone: 608 pages used for memmap
[    0.000000]   Normal zone: 77792 pages, LIFO batch:15
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to         ffffc000 (        fee00000)
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC =
INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC =
INT 05
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC =
INT 09
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC =
INT 0a
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC =
INT 0b
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC =
INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC =
INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC =
INT 04
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC =
INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC =
INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC =
INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC =
INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC =
INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC =
INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC =
INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffb000 (fec00000)
[    0.000000] e820: [mem 0x14000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:2 nr_=
node_ids:1
[    0.000000] PERCPU: Embedded 13 pages/cpu @d24f9000 s30144 r0 d23104 u53=
248
[    0.000000] pcpu-alloc: s30144 r0 d23104 u53248 alloc=3D13*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1=20
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 124fc680
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 81150
[    0.000000] Kernel command line: hung_task_panic=3D1 earlyprintk=3DttyS0=
,115200 rd.udev.log-priority=3Derr systemd.log_target=3Djournal systemd.log=
_level=3Dwarning debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_s=
tall_timeout=3D100 panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oop=
s=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 console=3DttyS0,115200 consol=
e=3Dtty0 vga=3Dnormal  root=3D/dev/ram0 rw link=3D/kbuild-tests/run-queue/k=
vm/i386-randconfig-r2-0215/linux-devel:devel-roam-rand-201502150502:e1d3c0f=
d701df831169b116cd5c5d6203ac07f70:bisect-linux-8/.vmlinuz-e1d3c0fd701df8311=
69b116cd5c5d6203ac07f70-20150215062248-6-client6 branch=3Dlinux-devel/devel=
-roam-rand-201502150502 BOOT_IMAGE=3D/kernel/i386-randconfig-r2-0215/e1d3c0=
fd701df831169b116cd5c5d6203ac07f70/vmlinuz-3.19.0-rc4-00002-ge1d3c0f drbd.m=
inor_count=3D8
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[    0.000000] Initializing CPU#0
[    0.000000] Memory: 289432K/327160K available (5346K kernel code, 720K r=
wdata, 2692K rodata, 508K init, 344K bss, 37728K reserved, 0K cma-reserved)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xffd36000 - 0xfffff000   (2852 kB)
[    0.000000]     vmalloc : 0xd47e0000 - 0xffd34000   ( 693 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd3fe0000   ( 319 MB)
[    0.000000]       .init : 0xc1891000 - 0xc1910000   ( 508 kB)
[    0.000000]       .data : 0xc1538dc9 - 0xc188f100   (3416 kB)
[    0.000000]       .text : 0xc1000000 - 0xc1538dc9   (5347 kB)
[    0.000000] Checking if this processor honours the WP bit even in superv=
isor mode...Ok.
[    0.000000] SLUB: HWalign=3D128, Order=3D0-3, MinObjects=3D0, CPUs=3D2, =
Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    0.000000] NR_IRQS:2304 nr_irqs:440 16
[    0.000000] CPU 0 irqstacks, hard=3Dd2012000 soft=3Dd2014000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] bootconsole [earlyser0] disabled
[    0.000000] console [ttyS0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Detected 2925.998 MHz processor
[    0.006666] Calibrating delay loop (skipped) preset value.. 5854.82 Bogo=
MIPS (lpj=3D9753326)
[    0.006666] pid_max: default: 32768 minimum: 301
[    0.006666] ACPI: Core revision 20141107
[    0.033204] ACPI: All ACPI Tables successfully acquired
[    0.033929] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.034627] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 by=
tes)
[    0.036302] Initializing cgroup subsys perf_event
[    0.036682] Initializing cgroup subsys debug
[    0.037597] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.037597] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.040251] Freeing SMP alternatives memory: 16K (c1910000 - c1914000)
[    0.042350] Getting VERSION: 1050014
[    0.043105] Getting VERSION: 1050014
[    0.043341] Getting ID: 0
[    0.044005] Getting ID: f000000
[    0.044713] Getting LVT0: 8700
[    0.045415] Getting LVT1: 8400
[    0.046672] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.047649] enabled ExtINT on CPU#0
[    0.049052] ENABLING IO-APIC IRQs
[    0.050013] init IO_APIC IRQs
[    0.050704]  apic 0 pin 0 not connected
[    0.051476] IOAPIC[0]: Set routing entry (0-1 -> 0x31 -> IRQ 1 Mode:0 Ac=
tive:0 Dest:1)
[    0.053001] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    0.053351] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    0.054877] IOAPIC[0]: Set routing entry (0-3 -> 0x33 -> IRQ 3 Mode:0 Ac=
tive:0 Dest:1)
[    0.056687] IOAPIC[0]: Set routing entry (0-4 -> 0x34 -> IRQ 4 Mode:0 Ac=
tive:0 Dest:1)
[    0.058220] IOAPIC[0]: Set routing entry (0-5 -> 0x35 -> IRQ 5 Mode:1 Ac=
tive:0 Dest:1)
[    0.060019] IOAPIC[0]: Set routing entry (0-6 -> 0x36 -> IRQ 6 Mode:0 Ac=
tive:0 Dest:1)
[    0.061550] IOAPIC[0]: Set routing entry (0-7 -> 0x37 -> IRQ 7 Mode:0 Ac=
tive:0 Dest:1)
[    0.063353] IOAPIC[0]: Set routing entry (0-8 -> 0x38 -> IRQ 8 Mode:0 Ac=
tive:0 Dest:1)
[    0.064875] IOAPIC[0]: Set routing entry (0-9 -> 0x39 -> IRQ 9 Mode:1 Ac=
tive:0 Dest:1)
[    0.066686] IOAPIC[0]: Set routing entry (0-10 -> 0x3a -> IRQ 10 Mode:1 =
Active:0 Dest:1)
[    0.068229] IOAPIC[0]: Set routing entry (0-11 -> 0x3b -> IRQ 11 Mode:1 =
Active:0 Dest:1)
[    0.070019] IOAPIC[0]: Set routing entry (0-12 -> 0x3c -> IRQ 12 Mode:0 =
Active:0 Dest:1)
[    0.071559] IOAPIC[0]: Set routing entry (0-13 -> 0x3d -> IRQ 13 Mode:0 =
Active:0 Dest:1)
[    0.073101] IOAPIC[0]: Set routing entry (0-14 -> 0x3e -> IRQ 14 Mode:0 =
Active:0 Dest:1)
[    0.073352] IOAPIC[0]: Set routing entry (0-15 -> 0x3f -> IRQ 15 Mode:0 =
Active:0 Dest:1)
[    0.074893]  apic 0 pin 16 not connected
[    0.076669]  apic 0 pin 17 not connected
[    0.077448]  apic 0 pin 18 not connected
[    0.078245]  apic 0 pin 19 not connected
[    0.079023]  apic 0 pin 20 not connected
[    0.080003]  apic 0 pin 21 not connected
[    0.080785]  apic 0 pin 22 not connected
[    0.081567]  apic 0 pin 23 not connected
[    0.082488] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.083336] smpboot: CPU0: Intel Common KVM processor (fam: 0f, model: 0=
6, stepping: 01)
[    0.085718] Using local APIC timer interrupts.
[    0.085718] calibrating APIC timer ...
[    0.089999] ... lapic delta =3D 6250936
[    0.089999] ... PM-Timer delta =3D 358001
[    0.089999] ... PM-Timer result ok
[    0.089999] ..... delta 6250936
[    0.089999] ..... mult: 268475683
[    0.089999] ..... calibration result: 3333832
[    0.089999] ..... CPU clock speed is 2926.2820 MHz.
[    0.089999] ..... host bus clock speed is 1000.0832 MHz.
[    0.090065] Performance Events: unsupported Netburst CPU model 6 no PMU =
driver, software events only.
[    0.094835] CPU 1 irqstacks, hard=3Dd20e6000 soft=3Dd20f0000
[    0.096104] x86: Booting SMP configuration:
[    0.096669] .... node  #0, CPUs:      #1
[    0.003333] Initializing CPU#1
[    0.006666] kvm-clock: cpu 1, msr 0:13fdf041, secondary cpu clock
[    0.006666] masked ExtINT on CPU#1
[    0.113358] x86: Booted up 1 node, 2 CPUs
[    0.113336] KVM setup async PF for cpu 1
[    0.113336] kvm-stealtime: cpu 1, msr 12509680
[    0.115991] smpboot: Total of 2 processors activated (11708.65 BogoMIPS)
[    0.120726] xor: measuring software checksum speed
[    0.153335]    pIII_sse  : 11576.400 MB/sec
[    0.186669]    prefetch64-sse: 13148.400 MB/sec
[    0.187473] xor: using function: prefetch64-sse (13148.400 MB/sec)
[    0.188422] prandom: seed boundary self test passed
[    0.189726] prandom: 100 self tests passed
[    0.190011] atomic64_test: passed for i586+ platform with CX8 and with S=
SE
[    0.192030] NET: Registered protocol family 16
[    0.210005] cpuidle: using governor ladder
[    0.223338] cpuidle: using governor menu
[    0.224534] ACPI: bus type PCI registered
[    0.225494] PCI : PCI BIOS area is rw and x. Use pci=3Dnobios if you wan=
t it NX.
[    0.226675] PCI: PCI BIOS revision 2.10 entry at 0xfd456, last bus=3D0
[    0.227635] PCI: Using configuration type 1 for base access
[    0.270707] Running resizable hashtable tests...
[    0.271017]   Adding 2048 keys
[    0.591663]   Traversal complete: counted=3D2048, nelems=3D2048, entries=
=3D2048
[    0.592823]   Table expansion iteration 0...
[    0.643375]   Verifying lookups...
[    0.644257]   Table expansion iteration 1...
[    0.683401]   Verifying lookups...
[    0.684251]   Table expansion iteration 2...
[    0.723454]   Verifying lookups...
[    0.724305]   Table expansion iteration 3...
[    0.750182]   Verifying lookups...
[    0.750996]   Table shrinkage iteration 0...
[    0.763349]   Verifying lookups...
[    0.764225]   Table shrinkage iteration 1...
[    0.776682]   Verifying lookups...
[    0.777554]   Table shrinkage iteration 2...
[    0.790016]   Verifying lookups...
[    0.790898]   Table shrinkage iteration 3...
[    0.803348]   Verifying lookups...
[    0.804283]   Traversal complete: counted=3D2048, nelems=3D2048, entries=
=3D2048
[    0.805305]   Deleting 2048 keys
[    0.993343] raid6: mmxx1     2691 MB/s
[    1.050006] raid6: mmxx2     4471 MB/s
[    1.106678] raid6: sse1x1    3944 MB/s
[    1.163348] raid6: sse1x2    4717 MB/s
[    1.220007] raid6: sse2x1    7743 MB/s
[    1.276670] raid6: sse2x2    9262 MB/s
[    1.277444] raid6: using algorithm sse2x2 (9262 MB/s)
[    1.278324] raid6: using intx1 recovery algorithm
[    1.279917] ACPI: Added _OSI(Module Device)
[    1.280003] ACPI: Added _OSI(Processor Device)
[    1.280821] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.281663] ACPI: Added _OSI(Processor Aggregator Device)
[    1.284086] IOAPIC[0]: Set routing entry (0-9 -> 0x39 -> IRQ 9 Mode:1 Ac=
tive:0 Dest:3)
[    1.296500] ACPI: Interpreter enabled
[    1.296688] ACPI: (supports S0 S5)
[    1.297417] ACPI: Using IOAPIC for interrupt routing
[    1.298420] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    1.351706] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.352691] acpi PNP0A03:00: _OSC: OS supports [Segments]
[    1.353402] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.356187] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    1.357084] PCI host bridge to bus 0000:00
[    1.357870] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.360007] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    1.360992] pci_bus 0000:00: root bus resource [io  0x0d00-0xadff]
[    1.361964] pci_bus 0000:00: root bus resource [io  0xae0f-0xaeff]
[    1.363340] pci_bus 0000:00: root bus resource [io  0xaf20-0xafdf]
[    1.364295] pci_bus 0000:00: root bus resource [io  0xafe4-0xffff]
[    1.365241] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f]
[    1.366322] pci_bus 0000:00: root bus resource [mem 0x14000000-0xfebffff=
f]
[    1.366701] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    1.370010] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    1.372691] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    1.375774] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    1.377488] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    1.378564] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    1.379576] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    1.380003] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    1.383477] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    1.384700] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX=
4 ACPI
[    1.386151] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX=
4 SMB
[    1.388152] pci 0000:00:02.0: [1013:00b8] type 00 class 0x030000
[    1.390401] pci 0000:00:02.0: reg 0x10: [mem 0xfc000000-0xfdffffff pref]
[    1.392261] pci 0000:00:02.0: reg 0x14: [mem 0xfebf0000-0xfebf0fff]
[    1.397084] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    1.400029] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    1.401770] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    1.403337] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    1.408135] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    1.410655] pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000
[    1.412021] pci 0000:00:04.0: reg 0x10: [mem 0xfebf1000-0xfebf100f]
[    1.416881] pci_bus 0000:00: on NUMA node 0
[    1.422150] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    1.424382] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    1.426574] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    1.428382] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    1.430353] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    1.434699] ACPI: Enabled 16 GPEs in block 00 to 0F
[    1.437772] vgaarb: setting as boot device: PCI:0000:00:02.0
[    1.438708] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    1.440002] vgaarb: loaded
[    1.443335] vgaarb: bridge control possible 0000:00:02.0
[    1.446750] SCSI subsystem initialized
[    1.447957] pps_core: LinuxPPS API ver. 1 registered
[    1.448827] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti-k2GhghHVRtY@public.gmane.org>
[    1.450186] EDAC MC: Ver: 3.0.0
[    1.451333] Advanced Linux Sound Architecture Driver Initialized.
[    1.453409] PCI: Using ACPI for IRQ routing
[    1.454220] PCI: pci_cache_line_size set to 64 bytes
[    1.455164] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.456147] e820: reserve RAM buffer [mem 0x13fe0000-0x13ffffff]
[    1.458245] Switched to clocksource kvm-clock
[    1.458728] FS-Cache: Loaded
[    1.460118] pnp: PnP ACPI init
[    1.461602] IOAPIC[0]: Set routing entry (0-8 -> 0x38 -> IRQ 8 Mode:0 Ac=
tive:0 Dest:3)
[    1.464434] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.466364] IOAPIC[0]: Set routing entry (0-1 -> 0x31 -> IRQ 1 Mode:0 Ac=
tive:0 Dest:3)
[    1.469144] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.471069] IOAPIC[0]: Set routing entry (0-12 -> 0x3c -> IRQ 12 Mode:0 =
Active:0 Dest:3)
[    1.473912] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    1.476061] IOAPIC[0]: Set routing entry (0-6 -> 0x36 -> IRQ 6 Mode:0 Ac=
tive:0 Dest:3)
[    1.478607] pnp 00:03: [dma 2]
[    1.480113] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    1.482323] IOAPIC[0]: Set routing entry (0-7 -> 0x37 -> IRQ 7 Mode:0 Ac=
tive:0 Dest:3)
[    1.485148] pnp 00:04: Plug and Play ACPI device, IDs PNP0400 (active)
[    1.486570] IOAPIC[0]: Set routing entry (0-4 -> 0x34 -> IRQ 4 Mode:0 Ac=
tive:0 Dest:3)
[    1.488400] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.492643] pnp: PnP ACPI: found 6 devices
[    1.543769] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    1.544716] pci_bus 0000:00: resource 5 [io  0x0d00-0xadff]
[    1.545676] pci_bus 0000:00: resource 6 [io  0xae0f-0xaeff]
[    1.546620] pci_bus 0000:00: resource 7 [io  0xaf20-0xafdf]
[    1.547657] pci_bus 0000:00: resource 8 [io  0xafe4-0xffff]
[    1.548584] pci_bus 0000:00: resource 9 [mem 0x000a0000-0x000bffff]
[    1.549607] pci_bus 0000:00: resource 10 [mem 0x14000000-0xfebfffff]
[    1.550705] NET: Registered protocol family 1
[    1.551598] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    1.552601] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    1.553662] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    1.554727] pci 0000:00:02.0: Video device with shadowed ROM
[    1.555715] PCI: CLS 0 bytes, default 64
[    1.556768] Unpacking initramfs...
[    2.345370] Freeing initrd memory: 24852K (d2793000 - d3fd8000)
[    2.348898] Scanning for low memory corruption every 60 seconds
[    2.352102] PCLMULQDQ-NI instructions are not detected.
[    2.353035] The force parameter has not been set to 1. The Iris poweroff=
 handler will not be installed.
[    2.354698] NatSemi SCx200 Driver
[    2.356911] futex hash table entries: 512 (order: 3, 32768 bytes)
[    2.386217] zpool: loaded
[    2.386902] zbud: loaded
[    2.389811] VFS: Disk quotas dquot_6.5.2
[    2.390977] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    2.393668] ntfs: driver 2.1.31 [Flags: R/O].
[    2.396168] fuse init (API version 7.23)
[    2.399132] JFS: nTxBlock =3D 2455, nTxLock =3D 19643
[    2.402024] NILFS version 2 loaded
[    2.406548] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[    2.408038] io scheduler noop registered
[    2.408821] io scheduler deadline registered (default)
[    2.409715] test_string_helpers: Running tests...
[    2.412945] test_firmware: interface ready
[    2.413810] xz_dec_test: module loaded
[    2.414564] xz_dec_test: Create a device node with 'mknod xz_dec_test c =
251 0' and write .xz files to it.
[    2.417247] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[    2.418660] ACPI: Power Button [PWRF]
[    2.421559] r3964: Philips r3964 Driver $Revision: 1.10 $
[    2.422453] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.449181] serial 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 1=
15200) is a 16550A
[    2.456385] lp: driver loaded but no devices found
[    2.458161] Non-volatile memory driver v1.3
[    2.460144] ppdev: user-space parallel port driver
[    2.461650] scx200_gpio: no SCx200 gpio present
[    2.463118] nsc_gpio initializing
[    2.464435] smapi::smapi_init, ERROR invalid usSmapiID
[    2.466009] mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAPI is=
 not available on this machine
[    2.468861] mwave: mwavedd::mwave_init: Error: Failed to initialize boar=
d data
[    2.470412] mwave: mwavedd::mwave_init: Error: Failed to initialize
[    2.471423] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 secon=
ds, margin is 60 seconds).
[    2.473333] parport_pc 00:04: reported by Plug and Play ACPI
[    2.474457] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
[    2.557432] lp0: using parport0 (interrupt-driven).
[    2.558319] lp0: console ready
[    2.560736] lkdtm: No crash points registered, enable through debugfs
[    2.562116] Silicon Labs C2 port support v. 0.51.0 - (C) 2007 Rodolfo Gi=
ometti
[    2.563939] c2port c2port0: C2 port uc added
[    2.564756] c2port c2port0: uc flash has 30 blocks x 512 bytes (15360 by=
tes total)
[    2.567431] Uniform Multi-Platform E-IDE driver
[    2.568708] ide_generic: please use "probe_mask=3D0x3f" module parameter=
 for probing all legacy ISA IDE ports
[    2.570427] ide-gd driver 1.18
[    2.571192] ide-cd driver 5.00
[    2.572201] rdac: device handler registered
[    2.573160] hp_sw: device handler registered
[    2.574018] alua: device handler registered
[    2.575499] st: Version 20101219, fixed bufsize 32768, s/g segs 256
[    2.576686] osst :I: Tape driver with OnStream support version 0.99.4
[    2.576686] osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
[    2.581947] scsi_debug: host protection
[    2.582748] scsi host0: scsi_debug, version 1.85 [20141022], dev_size_mb=
=3D8, opts=3D0x0
[    2.587347] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       01=
84 PQ: 0 ANSI: 6
[    2.590405] Rounding down aligned max_sectors from 4294967295 to 4294967=
288
[    2.592435] HSI/SSI char device loaded
[    2.593991] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    2.596474] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.598080] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.647528] mousedev: PS/2 mouse device common for all mice
[    2.651205] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    2.655182] sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.38 MB/8.=
00 MiB)
[    2.658644] apanel: Fujitsu BIOS signature 'FJKEYINF' not found...
[    2.660399] sd 0:0:0:0: [sda] Write Protect is off
[    2.661284] sd 0:0:0:0: [sda] Mode Sense: 73 00 10 08
[    2.661514] ideapad_slidebar: DMI does not match
[    2.662074] i2c-parport: adapter type unspecified
[    2.663179] IR NEC protocol handler initialized
[    2.663187] IR RC6 protocol handler initialized
[    2.663195] IR JVC protocol handler initialized
[    2.663202] IR Sony protocol handler initialized
[    2.663210] IR SANYO protocol handler initialized
[    2.663217] IR Sharp protocol handler initialized
[    2.663326] Registered IR keymap rc-empty
[    2.664080] input: rc-core loopback device as /devices/virtual/rc/rc0/in=
put4
[    2.664365] rc0: rc-core loopback device as /devices/virtual/rc/rc0
[    2.665694] smssdio: Siano SMS1xxx SDIO driver
[    2.665695] smssdio: Copyright Pierre Ossman
[    2.665886] pps_ldisc: PPS line discipline registered
[    2.665995] Driver for 1-wire Dallas network protocol.
[    2.666396] DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
[    2.666530] 1-Wire driver for the DS2760 battery monitor chip - (c) 2004=
-2005, Szabolcs Gyurko
[    2.666896] power_supply test_ac: uevent
[    2.666898] power_supply test_ac: POWER_SUPPLY_NAME=3Dtest_ac
[    2.666905] power_supply test_ac: prop ONLINE=3D1
[    2.666929] power_supply test_ac: power_supply_changed
[    2.667396] power_supply test_battery: uevent
[    2.667397] power_supply test_battery: POWER_SUPPLY_NAME=3Dtest_battery
[    2.667405] power_supply test_battery: prop STATUS=3DDischarging
[    2.667416] power_supply test_battery: prop CHARGE_TYPE=3DFast
[    2.667427] power_supply test_battery: prop HEALTH=3DGood
[    2.667438] power_supply test_battery: prop PRESENT=3D1
[    2.667449] power_supply test_battery: prop TECHNOLOGY=3DLi-ion
[    2.667460] power_supply test_battery: prop CHARGE_FULL_DESIGN=3D100
[    2.667471] power_supply test_battery: prop CHARGE_FULL=3D100
[    2.667481] power_supply test_battery: prop CHARGE_NOW=3D50
[    2.667492] power_supply test_battery: prop CAPACITY=3D50
[    2.667503] power_supply test_battery: prop CAPACITY_LEVEL=3DNormal
[    2.667514] power_supply test_battery: prop TIME_TO_EMPTY_AVG=3D3600
[    2.667525] power_supply test_battery: prop TIME_TO_FULL_NOW=3D3600
[    2.667536] power_supply test_battery: prop MODEL_NAME=3DTest battery
[    2.667545] power_supply test_battery: prop MANUFACTURER=3DLinux
[    2.667555] power_supply test_battery: prop SERIAL_NUMBER=3D3.19.0-rc4-0=
0002-ge1d3c0f
[    2.667565] power_supply test_battery: prop TEMP=3D26
[    2.667575] power_supply test_battery: prop VOLTAGE_NOW=3D3300
[    2.668194] power_supply test_battery: power_supply_changed
[    2.668395] power_supply test_usb: uevent
[    2.668397] power_supply test_usb: POWER_SUPPLY_NAME=3Dtest_usb
[    2.668404] power_supply test_usb: prop ONLINE=3D1
[    2.668426] power_supply test_usb: power_supply_changed
[    2.671941] f71882fg: Not a Fintek device
[    2.671988] f71882fg: Not a Fintek device
[    2.675703] pc87360: PC8736x not detected, module not inserted
[    2.675880] sch56xx_common: Unsupported device id: 0xff
[    2.675915] sch56xx_common: Unsupported device id: 0xff
[    2.677804] acquirewdt: WDT driver for Acquire single board computer ini=
tialising
[    2.678165] acquirewdt: I/O address 0x0043 already in use
[    2.678186] acquirewdt: probe of acquirewdt failed with error -5
[    2.678379] advantechwdt: WDT driver for Advantech single board computer=
 initialising
[    2.679016] advantechwdt: initialized. timeout=3D60 sec (nowayout=3D1)
[    2.679155] ib700wdt: WDT driver for IB700 single board computer initial=
ising
[    2.679477] ib700wdt: START method I/O 443 is not available
[    2.679499] ib700wdt: probe of ib700wdt failed with error -5
[    2.679676] wafer5823wdt: WDT driver for Wafer 5823 single board compute=
r initialising
[    2.679686] wafer5823wdt: I/O address 0x0443 already in use
[    2.679865] it87_wdt: no device
[    2.679970] pc87413_wdt: Version 1.1 at io 0x2E
[    2.679982] pc87413_wdt: cannot register miscdev on minor=3D130 (err=3D-=
16)
[    2.680002] sbc60xxwdt: I/O address 0x0443 already in use
[    2.680045] sbc8360: failed to register misc device
[    2.680065] sbc7240_wdt: I/O address 0x0443 already in use
[    2.680093] cpu5wdt: misc_register failed
[    2.680271] w83877f_wdt: I/O address 0x0443 already in use
[    2.680283] machzwd: MachZ ZF-Logic Watchdog driver initializing
[    2.680299] machzwd: no ZF-Logic found
[    2.680312] sbc_epx_c3: cannot register miscdev on minor=3D130 (err=3D-1=
6)
[    2.680716] watchdog: Software Watchdog: cannot register miscdev on mino=
r=3D130 (err=3D-16).
[    2.680717] watchdog: Software Watchdog: a legacy watchdog module is pro=
bably present.
[    2.681031] softdog: Software Watchdog Timer: 0.08 initialized. soft_nob=
oot=3D0 soft_margin=3D60 sec soft_panic=3D0 (nowayout=3D1)
[    2.681316] power_supply test_ac: power_supply_changed_work
[    2.681321] power_supply test_ac: power_supply_update_gen_leds 1
[    2.681334] power_supply test_ac: uevent
[    2.681336] power_supply test_ac: POWER_SUPPLY_NAME=3Dtest_ac
[    2.681343] power_supply test_ac: prop ONLINE=3D1
[    2.681359] power_supply test_battery: power_supply_changed_work
[    2.681361] power_supply test_battery: power_supply_update_bat_leds 2
[    2.681373] power_supply test_battery: uevent
[    2.681375] power_supply test_battery: POWER_SUPPLY_NAME=3Dtest_battery
[    2.681382] power_supply test_battery: prop STATUS=3DDischarging
[    2.681392] power_supply test_battery: prop CHARGE_TYPE=3DFast
[    2.681402] power_supply test_battery: prop HEALTH=3DGood
[    2.681412] power_supply test_battery: prop PRESENT=3D1
[    2.681422] power_supply test_battery: prop TECHNOLOGY=3DLi-ion
[    2.681433] power_supply test_battery: prop CHARGE_FULL_DESIGN=3D100
[    2.681443] power_supply test_battery: prop CHARGE_FULL=3D100
[    2.681453] power_supply test_battery: prop CHARGE_NOW=3D50
[    2.681463] power_supply test_battery: prop CAPACITY=3D50
[    2.681473] power_supply test_battery: prop CAPACITY_LEVEL=3DNormal
[    2.681484] power_supply test_battery: prop TIME_TO_EMPTY_AVG=3D3600
[    2.681494] power_supply test_battery: prop TIME_TO_FULL_NOW=3D3600
[    2.681504] power_supply test_battery: prop MODEL_NAME=3DTest battery
[    2.681514] power_supply test_battery: prop MANUFACTURER=3DLinux
[    2.681524] power_supply test_battery: prop SERIAL_NUMBER=3D3.19.0-rc4-0=
0002-ge1d3c0f
[    2.681535] power_supply test_battery: prop TEMP=3D26
[    2.681544] power_supply test_battery: prop VOLTAGE_NOW=3D3300
[    2.681559] power_supply test_usb: power_supply_changed_work
[    2.681561] power_supply test_usb: power_supply_update_gen_leds 1
[    2.681573] power_supply test_usb: uevent
[    2.681574] power_supply test_usb: POWER_SUPPLY_NAME=3Dtest_usb
[    2.681581] power_supply test_usb: prop ONLINE=3D1
[    2.683573] device-mapper: uevent: version 1.0.3
[    2.684799] device-mapper: ioctl: 4.29.0-ioctl (2014-10-28) initialised:=
 dm-devel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
[    2.686148] device-mapper: multipath: version 1.7.0 loaded
[    2.686156] device-mapper: multipath round-robin: version 1.0.0 loaded
[    2.686164] device-mapper: multipath service-time: version 0.2.0 loaded
[    2.686186] Driver 'mmcblk' needs updating - please use bus_type methods
[    2.686347] sdhci: Secure Digital Host Controller Interface driver
[    2.686347] sdhci: Copyright(c) Pierre Ossman
[    2.686352] wbsd: Winbond W83L51xD SD/MMC card interface driver
[    2.686353] wbsd: Copyright(c) Pierre Ossman
[    2.687726] ledtrig-cpu: registered to indicate activity on CPUs
[    2.794095] panel: driver version 0.9.5 registered on parport0 (io=3D0x3=
78).
[    2.794508] input: Speakup as /devices/virtual/input/input6
[    2.795257] initialized device: /dev/synth, node (MAJOR 10, MINOR 25)
[    2.795303] speakup 3.1.6: initialized
[    2.795304] synth name on entry is: (null)
[    2.796220] logger: created 256K log 'log_main'
[    2.796415] logger: created 256K log 'log_events'
[    2.796613] logger: created 256K log 'log_radio'
[    2.796822] logger: created 256K log 'log_system'
[    2.797432] FPGA DOWNLOAD --->
[    2.797433] FPGA image file name: xlinx_fpga_firmware.bit
[    2.797618] GPIO INIT FAIL!!
[    2.798486]  fake-fmc-carrier: mezzanine 0
[    2.798493]       Manufacturer: fake-vendor
[    2.798493]       Product name: fake-design-for-testing
[    2.798666] fmc fake-design-for-testing-f001: Driver has no ID: matches =
all
[    2.798707] fmc_trivial: probe of fake-design-for-testing-f001 failed wi=
th error -95
[    2.798774] fmc fake-design-for-testing-f001: Driver has no ID: matches =
all
[    2.798802] fmc_write_eeprom fake-design-for-testing-f001: fmc_write_eep=
rom: no busid passed, refusing all cards
[    2.798878] fmc fake-design-for-testing-f001: Driver has no ID: matches =
all
[    2.799114] fmc_chardev fake-design-for-testing-f001: Created misc devic=
e "fake-design-for-testing-f001"
[    2.803372] ... APIC ID:      00000000 (0)
[    2.803374] ... APIC VERSION: 01050014
[    2.803395] 000000000000000000000000000000000000000000000000000000000000=
0000
[    2.803409] 000000000e20000000000000000000000000000000000000000000000000=
0000
[    2.803423] 000000000000000000000000000000000000000000000000000000000000=
8000
[    2.803441]=20
[    2.803443] number of MP IRQ sources: 15.
[    2.803444] number of IO-APIC #0 registers: 24.
[    2.803444] testing the IO APIC.......................
[    2.803456] IO APIC #0......
[    2.803457] .... register #00: 00000000
[    2.803457] .......    : physical APIC id: 00
[    2.803458] .......    : Delivery Type: 0
[    2.803458] .......    : LTS          : 0
[    2.803459] .... register #01: 00170011
[    2.803459] .......     : max redirection entries: 17
[    2.803460] .......     : PRQ implemented: 0
[    2.803460] .......     : IO APIC version: 11
[    2.803460] .... register #02: 00000000
[    2.803461] .......     : arbitration: 00
[    2.803461] .... IRQ redirection table:
[    2.803469] 1    0    0   0   0    0    0    00
[    2.803476] 0    0    0   0   0    1    1    31
[    2.803483] 0    0    0   0   0    1    1    30
[    2.803490] 0    0    0   0   0    1    1    33
[    2.803497] 1    0    0   0   0    1    1    34
[    2.803504] 1    1    0   0   0    1    1    35
[    2.803511] 0    0    0   0   0    1    1    36
[    2.803518] 0    0    0   0   0    1    1    37
[    2.803525] 0    0    0   0   0    1    1    38
[    2.803531] 0    1    0   0   0    1    1    39
[    2.803538] 1    1    0   0   0    1    1    3A
[    2.803545] 1    1    0   0   0    1    1    3B
[    2.803552] 0    0    0   0   0    1    1    3C
[    2.803559] 0    0    0   0   0    1    1    3D
[    2.803566] 0    0    0   0   0    1    1    3E
[    2.803573] 0    0    0   0   0    1    1    3F
[    2.803580] 1    0    0   0   0    0    0    00
[    2.803587] 1    0    0   0   0    0    0    00
[    2.803594] 1    0    0   0   0    0    0    00
[    2.803601] 1    0    0   0   0    0    0    00
[    2.803608] 1    0    0   0   0    0    0    00
[    2.803615] 1    0    0   0   0    0    0    00
[    2.803622] 1    0    0   0   0    0    0    00
[    2.803629] 1    0    0   0   0    0    0    00
[    2.803629] IRQ to pin mappings:
[    2.803631] IRQ0 -> 0:2
[    2.803632] IRQ1 -> 0:1
[    2.803634] IRQ3 -> 0:3
[    2.803635] IRQ4 -> 0:4
[    2.803636] IRQ5 -> 0:5
[    2.803637] IRQ6 -> 0:6
[    2.803638] IRQ7 -> 0:7
[    2.803639] IRQ8 -> 0:8
[    2.803640] IRQ9 -> 0:9
[    2.803641] IRQ10 -> 0:10
[    2.803642] IRQ11 -> 0:11
[    2.803643] IRQ12 -> 0:12
[    2.803644] IRQ13 -> 0:13
[    2.803645] IRQ14 -> 0:14
[    2.803646] IRQ15 -> 0:15
[    2.803647] .................................... done.
[    2.803659] Using IPI No-Shortcut mode
[    2.811352] Btrfs loaded, debug=3Don, assert=3Don, integrity-checker=3Don
[    2.811404] BTRFS: selftest: Running btrfs free space cache tests
[    2.811409] BTRFS: selftest: Running extent only tests
[    2.811433] BTRFS: selftest: Running bitmap only tests
[    2.811471] BTRFS: selftest: Running bitmap and extent tests
[    2.811554] BTRFS: selftest: Running space stealing from bitmap to extent
[    2.811871] BTRFS: selftest: Free space cache tests finished
[    2.811872] BTRFS: selftest: Running extent buffer operation tests
[    2.811873] BTRFS: selftest: Running btrfs_split_item tests
[    2.811915] BTRFS: selftest: Running find delalloc tests
[    2.896700] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 supports DPO and FUA
[    3.008987] kworker/u4:1 invoked oom-killer: gfp_mask=3D0x2000d0, order=
=3D0, oom_score_adj=3D0
[    3.016509] kworker/u4:1 cpuset=3D/ mems_allowed=3D0
[    3.017449] CPU: 0 PID: 79 Comm: kworker/u4:1 Not tainted 3.19.0-rc4-000=
02-ge1d3c0f #526
[    3.018893] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    3.020558] Workqueue: events_unbound async_run_entry_fn
[    3.021483]  c1946cd8 00000000 d38c7bc8 c1531cc1 ccbb4f90 d38c7c08 c1530=
26e c171de4a
[    3.023375]  ccbb5254 002000d0 00000000 00000000 00000000 002000d0 00000=
000 00000001
[    3.025269]  00000000 c1095aaf ccba03c8 00000000 c17e6b6c d38c7c3c c1096=
127 00000000
[    3.027146] Call Trace:
[    3.027751]  [<c1531cc1>] dump_stack+0x48/0x60
[    3.028549]  [<c153026e>] dump_header+0x71/0x1a6
[    3.029433]  [<c1095aaf>] ? oom_scan_process_thread+0xf/0x65
[    3.030349]  [<c1096127>] out_of_memory+0x211/0x250
[    3.031183]  [<c1098aa5>] __alloc_pages_nodemask+0x602/0x628
[    3.032084]  [<c10b6e5c>] new_slab+0x1c3/0x1d3
[    3.032869]  [<c1103b58>] ? __kernfs_new_node+0x43/0xad
[    3.033790]  [<c10b8754>] __slab_alloc+0x244/0x2b8
[    3.034712]  [<c1103b58>] ? __kernfs_new_node+0x43/0xad
[    3.035580]  [<c1053bc1>] ? ___might_sleep+0x2c/0xdc
[    3.036415]  [<c1053d07>] ? __might_sleep+0x96/0x9e
[    3.037256]  [<c1103b58>] ? __kernfs_new_node+0x43/0xad
[    3.038114]  [<c10b885c>] kmem_cache_alloc+0x50/0x9f
[    3.038951]  [<c10b885c>] ? kmem_cache_alloc+0x50/0x9f
[    3.039811]  [<c1103b58>] ? __kernfs_new_node+0x43/0xad
[    3.040682]  [<c1103b58>] __kernfs_new_node+0x43/0xad
[    3.041542]  [<c1104694>] kernfs_new_node+0x20/0x3a
[    3.042368]  [<c1105809>] __kernfs_create_file+0x29/0x83
[    3.043237]  [<c1105d91>] sysfs_add_file_mode_ns+0xbd/0x11c
[    3.044147]  [<c1105e03>] sysfs_add_file+0x13/0x18
[    3.044963]  [<c1106708>] sysfs_merge_group+0x3d/0x7f
[    3.045815]  [<c12eef27>] dpm_sysfs_add+0x38/0x9c
[    3.046630]  [<c12e8b10>] device_add+0x234/0x49d
[    3.047461]  [<c124655b>] ? kvasprintf+0x3b/0x46
[    3.048272]  [<c12e8e01>] device_create_groups_vargs+0x73/0x9a
[    3.049190]  [<c12e8e01>] ? device_create_groups_vargs+0x73/0x9a
[    3.050146]  [<c12e95a4>] device_create_vargs+0x13/0x15
[    3.051018]  [<c10a2209>] bdi_register+0x2d/0xb0
[    3.051819]  [<c10a22a9>] bdi_register_dev+0x1d/0x1f
[    3.052666]  [<c12354fc>] add_disk+0x132/0x35e
[    3.053512]  [<c12f109a>] ? __pm_runtime_use_autosuspend+0x47/0x4c
[    3.054467]  [<c134ac1d>] sd_probe_async+0xeb/0x182
[    3.055299]  [<c104d589>] async_run_entry_fn+0x72/0x12d
[    3.056175]  [<c1535034>] ? __schedule+0x224/0x397
[    3.057011]  [<c1048404>] process_one_work+0x104/0x1e8
[    3.057863]  [<c1048404>] ? process_one_work+0x104/0x1e8
[    3.058730]  [<c10486cb>] worker_thread+0x1c2/0x262
[    3.059558]  [<c1048509>] ? process_scheduled_works+0x21/0x21
[    3.060477]  [<c104bb49>] kthread+0xa0/0xa5
[    3.061257]  [<c1537541>] ret_from_kernel_thread+0x21/0x30
[    3.062141]  [<c104baa9>] ? __kthread_parkme+0x83/0x83
[    3.062996] Mem-Info:
[    3.063597] DMA per-cpu:
[    3.064217] CPU    0: hi:    0, btch:   1 usd:   0
[    3.065037] CPU    1: hi:    0, btch:   1 usd:   0
[    3.065856] Normal per-cpu:
[    3.066498] CPU    0: hi:   90, btch:  15 usd:   0
[    3.067329] CPU    1: hi:   90, btch:  15 usd:  14
[    3.068150] active_anon:0 inactive_anon:0 isolated_anon:0
[    3.068150]  active_file:2010 inactive_file:51581 isolated_file:0
[    3.068150]  unevictable:17862 dirty:0 writeback:0 unstable:0
[    3.068150]  free:839 slab_reclaimable:1392 slab_unreclaimable:1505
[    3.068150]  mapped:0 shmem:0 pagetables:0 bounce:0
[    3.068150]  free_cma:0
[    3.072980] DMA free:1260kB min:112kB low:140kB high:168kB active_anon:0=
kB inactive_anon:0kB active_file:0kB inactive_file:13520kB unevictable:0kB =
isolated(anon):0kB isolated(file):0kB present:15992kB managed:15916kB mlock=
ed:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB slab_reclaimable:0kB sl=
ab_unreclaimable:264kB kernel_stack:0kB pagetables:0kB unstable:0kB bounce:=
0kB free_cma:0kB writeback_tmp:0kB pages_scanned:81912 all_unreclaimable? y=
es
[    3.078637] lowmem_reserve[]: 0 291 291
[    3.079599] Normal free:2096kB min:2124kB low:2652kB high:3184kB active_=
anon:0kB inactive_anon:0kB active_file:8040kB inactive_file:192804kB unevic=
table:71448kB isolated(anon):0kB isolated(file):0kB present:311168kB manage=
d:298384kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB slab_re=
claimable:5568kB slab_unreclaimable:5756kB kernel_stack:408kB pagetables:0k=
B unstable:0kB bounce:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:2275=
192 all_unreclaimable? yes
[    3.085412] lowmem_reserve[]: 0 0 0
[    3.086336] DMA: 1*4kB (R) 1*8kB (R) 0*16kB 1*32kB (R) 1*64kB (R) 1*128k=
B (R) 0*256kB 0*512kB 1*1024kB (R) 0*2048kB 0*4096kB =3D 1260kB
[    3.089140] Normal: 0*4kB 1*8kB (R) 0*16kB 0*32kB 1*64kB (R) 0*128kB 0*2=
56kB 0*512kB 0*1024kB 1*2048kB (R) 0*4096kB =3D 2120kB
[    3.091707] 71468 total pagecache pages
[    3.092438] 81790 pages RAM
[    3.093082] 0 pages HighMem/MovableOnly
[    3.093841] 3215 pages reserved
[    3.094518] [ pid ]   uid  tgid total_vm      rss nr_ptes swapents oom_s=
core_adj name
[    3.095939] Kernel panic - not syncing: Out of memory and no killable pr=
ocesses...
[    3.095939]=20
[    3.097168] CPU: 0 PID: 79 Comm: kworker/u4:1 Not tainted 3.19.0-rc4-000=
02-ge1d3c0f #526
[    3.097168] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.7.5-20140531_083030-gandalf 04/01/2014
[    3.097168] Workqueue: events_unbound async_run_entry_fn
[    3.097168]  c1946cd8 00000000 d38c7bec c1531cc1 ccba03c8 d38c7c04 c1530=
05f 00000000
[    3.097168]  ccba03c8 00000000 c17e6b6c d38c7c3c c1096131 c171e029 00000=
000 c17e6a00
[    3.097168]  00000000 002000d0 000132ef 00000000 00000000 c17e6b6c 00000=
000 00000001
[    3.097168] Call Trace:
[    3.097168]  [<c1531cc1>] dump_stack+0x48/0x60
[    3.097168]  [<c153005f>] panic+0x81/0x192
[    3.097168]  [<c1096131>] out_of_memory+0x21b/0x250
[    3.097168]  [<c1098aa5>] __alloc_pages_nodemask+0x602/0x628
[    3.097168]  [<c10b6e5c>] new_slab+0x1c3/0x1d3
[    3.097168]  [<c1103b58>] ? __kernfs_new_node+0x43/0xad
[    3.097168]  [<c10b8754>] __slab_alloc+0x244/0x2b8
[    3.097168]  [<c1103b58>] ? __kernfs_new_node+0x43/0xad
[    3.097168]  [<c1053bc1>] ? ___might_sleep+0x2c/0xdc
[    3.097168]  [<c1053d07>] ? __might_sleep+0x96/0x9e
[    3.097168]  [<c1103b58>] ? __kernfs_new_node+0x43/0xad
[    3.097168]  [<c10b885c>] kmem_cache_alloc+0x50/0x9f
[    3.097168]  [<c10b885c>] ? kmem_cache_alloc+0x50/0x9f
[    3.097168]  [<c1103b58>] ? __kernfs_new_node+0x43/0xad
[    3.097168]  [<c1103b58>] __kernfs_new_node+0x43/0xad
[    3.097168]  [<c1104694>] kernfs_new_node+0x20/0x3a
[    3.097168]  [<c1105809>] __kernfs_create_file+0x29/0x83
[    3.097168]  [<c1105d91>] sysfs_add_file_mode_ns+0xbd/0x11c
[    3.097168]  [<c1105e03>] sysfs_add_file+0x13/0x18
[    3.097168]  [<c1106708>] sysfs_merge_group+0x3d/0x7f
[    3.097168]  [<c12eef27>] dpm_sysfs_add+0x38/0x9c
[    3.097168]  [<c12e8b10>] device_add+0x234/0x49d
[    3.097168]  [<c124655b>] ? kvasprintf+0x3b/0x46
[    3.097168]  [<c12e8e01>] device_create_groups_vargs+0x73/0x9a
[    3.097168]  [<c12e8e01>] ? device_create_groups_vargs+0x73/0x9a
[    3.097168]  [<c12e95a4>] device_create_vargs+0x13/0x15
[    3.097168]  [<c10a2209>] bdi_register+0x2d/0xb0
[    3.097168]  [<c10a22a9>] bdi_register_dev+0x1d/0x1f
[    3.097168]  [<c12354fc>] add_disk+0x132/0x35e
[    3.097168]  [<c12f109a>] ? __pm_runtime_use_autosuspend+0x47/0x4c
[    3.097168]  [<c134ac1d>] sd_probe_async+0xeb/0x182
[    3.097168]  [<c104d589>] async_run_entry_fn+0x72/0x12d
[    3.097168]  [<c1535034>] ? __schedule+0x224/0x397
[    3.097168]  [<c1048404>] process_one_work+0x104/0x1e8
[    3.097168]  [<c1048404>] ? process_one_work+0x104/0x1e8
[    3.097168]  [<c10486cb>] worker_thread+0x1c2/0x262
[    3.097168]  [<c1048509>] ? process_scheduled_works+0x21/0x21
[    3.097168]  [<c104bb49>] kthread+0xa0/0xa5
[    3.097168]  [<c1537541>] ret_from_kernel_thread+0x21/0x30
[    3.097168]  [<c104baa9>] ? __kthread_parkme+0x83/0x83
[    3.097168] Kernel Offset: 0x0 from 0xc1000000 (relocation range: 0xc000=
0000-0xd47dffff)

Elapsed time: 5
qemu-system-x86_64 -cpu kvm64 -enable-kvm -kernel /kernel/i386-randconfig-r=
2-0215/e1d3c0fd701df831169b116cd5c5d6203ac07f70/vmlinuz-3.19.0-rc4-00002-ge=
1d3c0f -append 'hung_task_panic=3D1 earlyprintk=3DttyS0,115200 rd.udev.log-=
priority=3Derr systemd.log_target=3Djournal systemd.log_level=3Dwarning deb=
ug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 p=
anic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdi=
sk=3D2 prompt_ramdisk=3D0 console=3DttyS0,115200 console=3Dtty0 vga=3Dnorma=
l  root=3D/dev/ram0 rw link=3D/kbuild-tests/run-queue/kvm/i386-randconfig-r=
2-0215/linux-devel:devel-roam-rand-201502150502:e1d3c0fd701df831169b116cd5c=
5d6203ac07f70:bisect-linux-8/.vmlinuz-e1d3c0fd701df831169b116cd5c5d6203ac07=
f70-20150215062248-6-client6 branch=3Dlinux-devel/devel-roam-rand-201502150=
502 BOOT_IMAGE=3D/kernel/i386-randconfig-r2-0215/e1d3c0fd701df831169b116cd5=
c5d6203ac07f70/vmlinuz-3.19.0-rc4-00002-ge1d3c0f drbd.minor_count=3D8'  -in=
itrd /kernel-tests/initrd/quantal-core-i386.cgz -m 320 -smp 2 -net nic,vlan=
=3D1,model=3De1000 -net user,vlan=3D1 -boot order=3Dnc -no-reboot -watchdog=
 i6300esb -rtc base=3Dlocaltime -pidfile /dev/shm/kboot/pid-quantal-client6=
-18 -serial file:/dev/shm/kboot/serial-quantal-client6-18 -daemonize -displ=
ay none -monitor null=20

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-3.19.0-rc4-00003-gfe4b991"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 3.19.0-rc4 Kernel Configuration
#
# CONFIG_64BIT is not set
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_MMU=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
# CONFIG_ZONE_DMA32 is not set
# CONFIG_AUDIT_ARCH is not set
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_X86_HT=y
CONFIG_ARCH_HWEIGHT_CFLAGS="-fcall-saved-ecx -fcall-saved-edx"
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_FHANDLE is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_LEGACY_ALLOC_HWIRQ=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_IRQ_DOMAIN=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_FANOUT_EXACT=y
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_RCU_NOCB_CPU is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
# CONFIG_IKCONFIG_PROC is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_CGROUPS=y
CONFIG_CGROUP_DEBUG=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_MEMCG is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_INIT_FALLBACK=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_PCI_QUIRKS=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLUB_CPU_PARTIAL is not set
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_ATTRS=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_CC_STACKPROTECTOR=y
CONFIG_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
CONFIG_CC_STACKPROTECTOR_REGULAR=y
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
# CONFIG_GCOV_FORMAT_AUTODETECT is not set
# CONFIG_GCOV_FORMAT_3_4 is not set
CONFIG_GCOV_FORMAT_4_7=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_STOP_MACHINE=y
CONFIG_BLOCK=y
# CONFIG_LBDAF is not set
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_CMDLINE_PARSER is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_PADATA=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUE_RWLOCK=y
CONFIG_QUEUE_RWLOCK=y
# CONFIG_FREEZER is not set

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_BIGSMP=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_KVM_GUEST=y
CONFIG_KVM_DEBUG_FS=y
CONFIG_LGUEST_GUEST=y
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_MEMTEST is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_MELAN=y
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS=32
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set
CONFIG_VM86=y
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
# CONFIG_MICROCODE_INTEL_EARLY is not set
# CONFIG_MICROCODE_AMD_EARLY is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_X86_PAE=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
# CONFIG_BALLOON_COMPACTION is not set
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_ZONE_DMA_FLAG=1
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_X86_RESERVE_LOW=64
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_MPX=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
# CONFIG_ACPI_INITRD_TABLE_OVERRIDE is not set
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_HT_IRQ=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y

#
# PCI host controller drivers
#
CONFIG_ISA_DMA_API=y
# CONFIG_ISA is not set
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
CONFIG_ALIX=y
# CONFIG_NET5501 is not set
# CONFIG_GEOS is not set
# CONFIG_TS5500 is not set
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_PMC_ATOM=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_NET_KEY is not set
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_MMAP is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_NET_MPLS_GSO is not set
# CONFIG_HSR is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_RFKILL_REGULATOR is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_NFC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
# CONFIG_DEVTMPFS is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
# CONFIG_FIRMWARE_IN_KERNEL is not set
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_FENCE_TRACE is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set

#
# DRBD disabled because PROC_FS or INET not selected
#
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1780 is not set
CONFIG_SENSORS_BH1770=y
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
CONFIG_VMWARE_BALLOON=y
CONFIG_BMP085=y
CONFIG_BMP085_I2C=y
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=y
# CONFIG_SRAM is not set
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y

#
# Altera FPGA firmware download module
#
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_BLK_DEV_IDE_SATA=y
CONFIG_IDE_GD=y
# CONFIG_IDE_GD_ATA is not set
# CONFIG_IDE_GD_ATAPI is not set
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_PLATFORM=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_IDEPNP is not set

#
# PCI IDE chipsets support
#
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_CS5536 is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set
# CONFIG_BLK_DEV_IDEDMA is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
CONFIG_SCSI_MQ_DEFAULT=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_OSST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=y
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
# CONFIG_SCSI_DH_EMC is not set
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=y
# CONFIG_SCSI_OSD_ULD is not set
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
# CONFIG_ATA is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
CONFIG_BCACHE_CLOSURES_DEBUG=y
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=y
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
CONFIG_DM_DEBUG_BLOCK_STACK_TRACING=y
CONFIG_DM_CRYPT=y
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_THIN_PROVISIONING is not set
# CONFIG_DM_CACHE is not set
CONFIG_DM_ERA=y
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_RAID is not set
CONFIG_DM_ZERO=y
CONFIG_DM_MULTIPATH=y
# CONFIG_DM_MULTIPATH_QL is not set
CONFIG_DM_MULTIPATH_ST=y
# CONFIG_DM_DELAY is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=y
# CONFIG_DM_VERITY is not set
CONFIG_DM_SWITCH=y
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=y
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=y
# CONFIG_TCM_USER is not set
CONFIG_LOOPBACK_TARGET=y
# CONFIG_ISCSI_TARGET is not set
CONFIG_SBP_TARGET=y
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
# CONFIG_FIREWIRE_SBP2 is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_I2O is not set
# CONFIG_MACINTOSH_DRIVERS is not set
# CONFIG_NETDEVICES is not set
# CONFIG_VHOST_NET is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
# CONFIG_INPUT_ARIZONA_HAPTICS is not set
CONFIG_INPUT_BMA150=y
# CONFIG_INPUT_PCSPKR is not set
CONFIG_INPUT_MC13783_PWRBUTTON=y
CONFIG_INPUT_MMA8450=y
# CONFIG_INPUT_MPU3050 is not set
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GP2A=y
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_TILT_POLLED=y
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF50633_PMU is not set
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
# CONFIG_INPUT_DA9055_ONKEY is not set
CONFIG_INPUT_WM831X_ON=y
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_FINTEK is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MFD_HSU is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX=y
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_MEN_Z135=y
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_NVRAM=y
CONFIG_R3964=y
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
CONFIG_MWAVE=y
CONFIG_SCx200_GPIO=y
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_ST33_I2C is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_GPIO=y
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA_PCI is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_TAOS_EVM=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y

#
# PPS support
#
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=y
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_DEVRES=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers:
#
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_IT8761E=y
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_LYNXPOINT is not set

#
# I2C GPIO expanders:
#
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_CRYSTAL_COVE is not set
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_SX150X=y
CONFIG_GPIO_TPS65912=y
CONFIG_GPIO_WM831X=y
CONFIG_GPIO_WM8994=y
# CONFIG_GPIO_ADP5520 is not set
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set

#
# PCI GPIO expanders:
#
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_INTEL_MID is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders:
#
CONFIG_GPIO_MCP23S08=y

#
# AC97 GPIO expanders:
#

#
# LPC GPIO expanders:
#
CONFIG_GPIO_KEMPLD=y

#
# MODULbus GPIO expanders:
#
CONFIG_GPIO_TPS6586X=y
# CONFIG_GPIO_TPS65910 is not set

#
# USB GPIO expanders:
#
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
# CONFIG_W1_MASTER_GPIO is not set

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2408=y
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=y
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2760=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_BQ27000 is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_PDA_POWER is not set
# CONFIG_WM831X_BACKUP is not set
CONFIG_WM831X_POWER=y
CONFIG_TEST_POWER=y
CONFIG_BATTERY_88PM860X=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SBS=y
# CONFIG_BATTERY_BQ27x00 is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_CHARGER_88PM860X=y
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MAX8997=y
CONFIG_CHARGER_MAX8998=y
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=y
CONFIG_POWER_RESET=y
# CONFIG_POWER_AVS is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
CONFIG_SENSORS_MC13783_ADC=y
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC4151=y
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_HTU21 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX34440 is not set
CONFIG_SENSORS_MAX8688=y
CONFIG_SENSORS_TPS40422=y
CONFIG_SENSORS_UCD9000=y
# CONFIG_SENSORS_UCD9200 is not set
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INT340X_THERMAL is not set

#
# Texas Instruments thermal drivers
#
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
# CONFIG_MENF21BMC_WATCHDOG is not set
CONFIG_WM831X_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
# CONFIG_DW_WATCHDOG is not set
CONFIG_RN5T618_WATCHDOG=y
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
# CONFIG_SC520_WDT is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
CONFIG_MEN_A21_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_AS3711=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_AXP20X is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_INTEL_SOC_PMIC=y
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_AB3100=y
CONFIG_REGULATOR_ARIZONA=y
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_DA9055=y
# CONFIG_REGULATOR_DA9063 is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_MAX1586=y
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX8998=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_PCF50633=y
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_RN5T618=y
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65090=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_TPS80031=y
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8994=y
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_RC_SUPPORT=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_DVB_CORE=y
# CONFIG_TTPCI_EEPROM is not set
CONFIG_DVB_MAX_ADAPTERS=8
# CONFIG_DVB_DYNAMIC_MINORS is not set

#
# Media drivers
#
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
CONFIG_RC_DECODERS=y
# CONFIG_LIRC is not set
CONFIG_IR_NEC_DECODER=y
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_JVC_DECODER=y
CONFIG_IR_SONY_DECODER=y
CONFIG_IR_SANYO_DECODER=y
CONFIG_IR_SHARP_DECODER=y
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
CONFIG_IR_HIX5HD2=y
# CONFIG_IR_IMON is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=y
CONFIG_IR_GPIO_CIR=y
# CONFIG_MEDIA_PCI_SUPPORT is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=y

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_SMS_SIANO_MDTV=y
# CONFIG_SMS_SIANO_RC is not set

#
# Media ancillary drivers (tuners, sensors, i2c, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_TUNER=y
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# Multistandard (satellite) frontends
#

#
# Multistandard (cable + terrestrial) frontends
#

#
# DVB-S (satellite) frontends
#

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_AS102_FE is not set

#
# DVB-C (cable) frontends
#

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#

#
# ISDB-T (terrestrial) frontends
#

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#

#
# Digital terrestrial only tuners/PLL
#

#
# SEC control devices for DVB-S
#

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set

#
# Direct Rendering Manager
#
# CONFIG_DRM is not set

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
# CONFIG_VGASTATE is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
# CONFIG_SND_VERBOSE_PROCFS is not set
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_RAWMIDI_SEQ is not set
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SIS7019 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=y
CONFIG_SND_DICE=y
CONFIG_SND_OXFW=y
# CONFIG_SND_ISIGHT is not set
# CONFIG_SND_SCS1X is not set
CONFIG_SND_FIREWORKS=y
CONFIG_SND_BEBOB=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
# CONFIG_SND_ATMEL_SOC is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=y
# CONFIG_SND_SOC_FSL_SSI is not set
CONFIG_SND_SOC_FSL_SPDIF=y
# CONFIG_SND_SOC_FSL_ESAI is not set
CONFIG_SND_SOC_IMX_AUDMUX=y
# CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH is not set
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_AK4554=y
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK5386=y
CONFIG_SND_SOC_ALC5623=y
CONFIG_SND_SOC_CS35L32=y
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
CONFIG_SND_SOC_CS42L52=y
CONFIG_SND_SOC_CS42L56=y
# CONFIG_SND_SOC_CS42L73 is not set
CONFIG_SND_SOC_CS4265=y
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_HDMI_CODEC=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_PCM1681=y
# CONFIG_SND_SOC_PCM512x_I2C is not set
CONFIG_SND_SOC_RT5631=y
# CONFIG_SND_SOC_RT5677_SPI is not set
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_I2C=y
CONFIG_SND_SOC_SSM4567=y
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_TAS2552=y
CONFIG_SND_SOC_TAS5086=y
# CONFIG_SND_SOC_TFA9879 is not set
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
CONFIG_SND_SOC_TLV320AIC31XX=y
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TS3A227E is not set
CONFIG_SND_SOC_WM8510=y
CONFIG_SND_SOC_WM8523=y
CONFIG_SND_SOC_WM8580=y
CONFIG_SND_SOC_WM8711=y
CONFIG_SND_SOC_WM8728=y
# CONFIG_SND_SOC_WM8731 is not set
CONFIG_SND_SOC_WM8737=y
CONFIG_SND_SOC_WM8741=y
CONFIG_SND_SOC_WM8750=y
CONFIG_SND_SOC_WM8753=y
CONFIG_SND_SOC_WM8776=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8962=y
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_TPA6130A2 is not set
CONFIG_SND_SIMPLE_CARD=y
CONFIG_SOUND_PRIME=y
# CONFIG_SOUND_OSS is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_PRODIKEYS=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=y
CONFIG_HID_KEYTOUCH=y
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=y
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_HIDPP is not set
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# CONFIG_USB_GADGET is not set
CONFIG_UWB=y
# CONFIG_UWB_WHCI is not set
CONFIG_MMC=y
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_CLKGATE is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_MMC_BLOCK_BOUNCE=y
CONFIG_SDIO_UART=y
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
# CONFIG_MMC_SDHCI_PLTFM is not set
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3533 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_NET48XX=y
CONFIG_LEDS_WRAP=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_MAX8997 is not set
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_MM_EDAC=y
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set
# CONFIG_AUXDISPLAY is not set
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
# CONFIG_SLICOSS is not set
CONFIG_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_RTS5208 is not set
CONFIG_FT1000=y

#
# Speakup console speech
#
CONFIG_SPEAKUP=y
CONFIG_SPEAKUP_SYNTH_ACNTSA=y
CONFIG_SPEAKUP_SYNTH_APOLLO=y
CONFIG_SPEAKUP_SYNTH_AUDPTR=y
# CONFIG_SPEAKUP_SYNTH_BNS is not set
# CONFIG_SPEAKUP_SYNTH_DECTLK is not set
CONFIG_SPEAKUP_SYNTH_DECEXT=y
# CONFIG_SPEAKUP_SYNTH_LTLK is not set
CONFIG_SPEAKUP_SYNTH_SOFT=y
# CONFIG_SPEAKUP_SYNTH_SPKOUT is not set
CONFIG_SPEAKUP_SYNTH_TXPRT=y
CONFIG_SPEAKUP_SYNTH_DUMMY=y
CONFIG_TOUCHSCREEN_CLEARPAD_TM1217=y
CONFIG_TOUCHSCREEN_SYNAPTICS_I2C_RMI4=y
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ANDROID_LOGGER=y
CONFIG_ANDROID_TIMED_OUTPUT=y
CONFIG_ANDROID_TIMED_GPIO=y
CONFIG_ANDROID_LOW_MEMORY_KILLER=y
# CONFIG_SYNC is not set
CONFIG_ION=y
CONFIG_ION_TEST=y
# CONFIG_ION_DUMMY is not set
# CONFIG_WIMAX_GDM72XX is not set
CONFIG_FIREWIRE_SERIAL=y
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_DGNC is not set
# CONFIG_DGAP is not set
CONFIG_GS_FPGABOOT=y
# CONFIG_X86_PLATFORM_DEVICES is not set
# CONFIG_CHROME_PLATFORMS is not set

#
# SOC (System On Chip) specific Drivers
#
CONFIG_SOC_TI=y

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_STE_MODEM_RPROC=y

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set

#
# DEVFREQ Drivers
#
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ARIZONA=y
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
# CONFIG_RESET_CONTROLLER is not set
CONFIG_FMC=y
CONFIG_FMC_FAKEDEV=y
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDER_IPC_32BIT=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_GOOGLE_FIRMWARE=y

#
# Google Firmware Drivers
#
CONFIG_GOOGLE_MEMCONSOLE=y

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_NILFS2_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_FILE_LOCKING=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
# CONFIG_INOTIFY_USER is not set
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_OVERLAY_FS=y

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_HISTOGRAM=y
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
# CONFIG_TMPFS is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_DEBUG_ON=y
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KMEMCHECK=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_LOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_TIMER_STATS is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_SPARSE_RCU_POINTER=y
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_CPU_STALL_INFO=y
# CONFIG_RCU_TRACE is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS=y
# CONFIG_DEBUG_STRICT_USER_COPY_CHECKS is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set

#
# Runtime Testing
#
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_STRING_HELPERS=y
CONFIG_TEST_KSTRTOX=y
CONFIG_TEST_RHASHTABLE=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_BUILD_DOCSRC=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_UDELAY=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_STRICT_DEVMEM=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_X86_PTDUMP is not set
CONFIG_DEBUG_RODATA=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_STRESS is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=2
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_STATIC_CPU_HAS is not set

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_PCOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=y
# CONFIG_CRYPTO_AUTHENC is not set
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_SEQIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
CONFIG_CRYPTO_TGR192=y
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
# CONFIG_CRYPTO_ARC4 is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SALSA20_586 is not set
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_ZLIB is not set
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_DRBG_MENU is not set
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_HW is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_LGUEST is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
CONFIG_CRC32_SLICEBY4=y
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
CONFIG_AVERAGE=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
CONFIG_ARCH_HAS_SG_CHAIN=y

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

_______________________________________________
LKP mailing list
LKP-VuQAYsv1563Yd54FQh9/CA@public.gmane.org

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nFreZHaLTZJo0R7j--
