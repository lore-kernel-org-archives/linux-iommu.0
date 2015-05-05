From: Gregor Dick <gdick-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
Subject: PROBLEM: Deadlock in attach_device() in AMD IOMMU driver
Date: Tue, 5 May 2015 10:24:13 +0100
Message-ID: <55488C3D.50509@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kieran Mansley <kmansley-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Joerg,

I see a deadlock in pci_enable_ats() called from attach_device() in
drivers/iommu/amd_iommu.c. It appears to be a recursive attempt to take
pci_sriov::lock.

The problem occurs when a network driver (sfc.ko, here an internal
testing version) enables SR-IOV on its device by calling
pci_enable_sriov(). There are two PFs for this physical device. This
call in turn results in a call to virtfn_add(), which takes the
pci_sriov lock for the first function on the bus. The AMD IOMMU driver
then handles the device-change notification by calling attach_device()
which in turn calls pci_enable_ats().  This latter function also
attempts to take the pci_sriov lock (although this time for
dev->physfn rather than dev->sriov->dev, but these need not be
distinct).

I can reproduce the problem reliably on the stock 3.12.28-4 SLES12
kernel. I haven't been able to do so on any of the other kernels that
I've tested, but these have been derived from 3.10 at the latest. In
particular, I've tested the RHEL 7.0, RHEL 6.6 and RHEL 5.11 kernels. If
need be I could test on more recent kernels when the machines are
available.

Here is the report from lockdep:

 >  =============================================
 >  [ INFO: possible recursive locking detected ]
 >  3.12.28-4-lockdep #1 Tainted: G           OE
 >  ---------------------------------------------
 >  kworker/8:1/105 is trying to acquire lock:
 >   (&iov->lock){+.+.+.}, at: [<ffffffff813333ef>]
 >                                             pci_enable_ats+0x5f/0x160
 >
 > but task is already holding lock:
 >   (&iov->lock){+.+.+.}, at: [<ffffffff813335cd>]
 >                                             virtfn_add+0x4d/0x380
 >
 > other info that might help us debug this:
 >   Possible unsafe locking scenario:
 >
 >         CPU0
 >         ----
 >    lock(&iov->lock);
 >    lock(&iov->lock);
 >
 >  *** DEADLOCK ***
 >
 >   May be due to missing lock nesting notation
 >
 >  4 locks held by kworker/8:1/105:
 >   #0:  (events){.+.+.+}, at:
 >         [<ffffffff81077b2c>] process_one_work+0x19c/0x580
 >   #1:  ((&wfc.work)){+.+.+.}, at:
 >         [<ffffffff81077b2c>] process_one_work+0x19c/0x580
 >   #2:  (&iov->lock){+.+.+.}, at:
 >         [<ffffffff813335cd>] virtfn_add+0x4d/0x380
 >   #3:  (&(&priv->bus_notifier)->rwsem){++++.+}, at:
 >         [<ffffffff81085f4a>] __blocking_notifier_call_chain+0x3a/0x70
 >
 > stack backtrace:
 >  CPU: 8 PID: 105 Comm: kworker/8:1 Tainted: G  OE 3.12.28-4-lockdep #1
 >  Hardware name: Dell Inc. PowerEdge R715/0G2DP3, BIOS 3.2.2 09/15/2014
 >  Workqueue: events work_for_cpu_fn
 >   ffff880219d5c580 ffff880219d5b840 ffffffff81579c7f ffffffff825da220
 >   ffff880219d5b8b0 ffffffff810af57b ffffffff81095035 0000000000000002
 >   ffff880219d5d1f8 ffffffff00000000 1260b584e827613a ffffffff82246e00
 >  Call Trace:
 >   [<ffffffff810061d1>] try_stack_unwind+0x191/0x1a0
 >   [<ffffffff81004a1b>] dump_trace+0x9b/0x370
 >   [<ffffffff8100622d>] show_trace_log_lvl+0x4d/0x60
 >   [<ffffffff81004da4>] show_stack_log_lvl+0xb4/0x1a0
 >   [<ffffffff81006285>] show_stack+0x25/0x50
 >   [<ffffffff81579c7f>] dump_stack+0x54/0x74
 >   [<ffffffff810af57b>] __lock_acquire+0xf9b/0x1350
 >   [<ffffffff810b0129>] lock_acquire+0x99/0x140
 >   [<ffffffff8157e153>] mutex_lock_nested+0x83/0x400
 >   [<ffffffff813333ef>] pci_enable_ats+0x5f/0x160
 >   [<ffffffff8144b82d>] attach_device+0x10d/0x200
 >   [<ffffffff8144e2a2>] device_change_notifier+0xc2/0x180
 >   [<ffffffff81586c2c>] notifier_call_chain+0x4c/0x70
 >   [<ffffffff81085f63>] __blocking_notifier_call_chain+0x53/0x70
 >   [<ffffffff81085f96>] blocking_notifier_call_chain+0x16/0x20
 >   [<ffffffff813e1ce8>] device_add+0x4c8/0x7b0
 >   [<ffffffff813115fa>] pci_device_add+0x11a/0x160
 >   [<ffffffff8133375a>] virtfn_add+0x1da/0x380
 >   [<ffffffff81333d0e>] pci_enable_sriov+0x28e/0x580
 >   [<ffffffffa054c35b>] efx_siena_sriov_init+0x5cb/0x890 [sfc]
 >   [<ffffffffa0519bb3>] efx_pci_probe+0xdc3/0x1160 [sfc]
 >   [<ffffffff813182de>] local_pci_probe+0x3e/0x70
 >   [<ffffffff81074024>] work_for_cpu_fn+0x14/0x20
 >   [<ffffffff81077b8e>] process_one_work+0x1fe/0x580
 >   [<ffffffff81078c58>] worker_thread+0x268/0x3b0
 >   [<ffffffff8107fb7d>] kthread+0xed/0x100
 >   [<ffffffff8158b37c>] ret_from_fork+0x7c/0xb0

/proc/cpuinfo:

 > processor       : 0 [up to 15]
 > vendor_id       : AuthenticAMD
 > cpu family      : 16
 > model           : 9
 > model name      : AMD Opteron(tm) Processor 6128
 > stepping        : 1
 > cpu MHz         : 2000.044
 > cache size      : 512 KB
 > physical id     : 0
 > siblings        : 8
 > core id         : 0
 > cpu cores       : 8
 > apicid          : 0
 > initial apicid  : 0
 > fpu             : yes
 > fpu_exception   : yes
 > cpuid level     : 5
 > wp              : yes
 > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
 > mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
 > fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good
 > nonstop_tsc extd_apicid amd_dcm pni monitor cx16 popcnt lahf_lm
 > cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
 > osvw ibs skinit wdt nodeid_msr npt lbrv svm_lock nrip_save pausefilter
 > bogomips        : 4000.08
 > TLB size        : 1024 4K pages
 > clflush size    : 64
 > cache_alignment : 64
 > address sizes   : 48 bits physical, 48 bits virtual
 > power management: ts ttp tm stc 100mhzsteps hwpstate

Here is the lspci output. The relevant devices are on bus 0x22.

 > 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
 > to PCI bridge (external gfx0 port A) (rev 02)
 > 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory
 > Management Unit (IOMMU)
 > 00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
 > to PCI bridge (PCI express gpp port B)
 > 00:03.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
 > to PCI bridge (PCI express gpp port C)
 > 00:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
 > to PCI bridge (PCI express gpp port D)
 > 00:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
 > to PCI bridge (PCI express gpp port H)
 > 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI]
 > SB7x0/SB8x0/SB9x0 SATA Controller [IDE mode]
 > 00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
 > SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
 > 00:12.1 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0
 > USB OHCI1 Controller
 > 00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
 > SB7x0/SB8x0/SB9x0 USB EHCI Controller
 > 00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
 > SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
 > 00:13.1 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0
 > USB OHCI1 Controller
 > 00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI]
 > SB7x0/SB8x0/SB9x0 USB EHCI Controller
 > 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus
Controller
 > (rev 3d)
 > 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI]
SB7x0/SB8x0/SB9x0
 > LPC host controller
 > 00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI
 > to PCI Bridge
 > 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor HyperTransport Configuration
 > 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor Address Map
 > 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor DRAM Controller
 > 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor Miscellaneous Control
 > 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor Link Control
 > 00:19.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor HyperTransport Configuration
 > 00:19.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor Address Map
 > 00:19.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor DRAM Controller
 > 00:19.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor Miscellaneous Control
 > 00:19.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor Link Control
 > 00:1a.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor HyperTransport Configuration
 > 00:1a.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor Address Map
 > 00:1a.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor DRAM Controller
 > 00:1a.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor Miscellaneous Control
 > 00:1a.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor Link Control
 > 00:1b.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor HyperTransport Configuration
 > 00:1b.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor Address Map
 > 00:1b.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor DRAM Controller
 > 00:1b.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor Miscellaneous Control
 > 00:1b.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 10h
 > Processor Link Control
 > 01:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709
 > Gigabit Ethernet (rev 20)
 > 01:00.1 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709
 > Gigabit Ethernet (rev 20)
 > 02:00.0 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709
 > Gigabit Ethernet (rev 20)
 > 02:00.1 Ethernet controller: Broadcom Corporation NetXtreme II BCM5709
 > Gigabit Ethernet (rev 20)
 > 03:00.0 PCI bridge: PLX Technology, Inc. PEX 8624 24-lane, 6-Port PCI
 > Express Gen 2 (5.0 GT/s) Switch [ExpressLane] (rev bb)
 > 04:00.0 PCI bridge: PLX Technology, Inc. PEX 8624 24-lane, 6-Port PCI
 > Express Gen 2 (5.0 GT/s) Switch [ExpressLane] (rev bb)
 > 04:01.0 PCI bridge: PLX Technology, Inc. PEX 8624 24-lane, 6-Port PCI
 > Express Gen 2 (5.0 GT/s) Switch [ExpressLane] (rev bb)
 > 04:04.0 PCI bridge: PLX Technology, Inc. PEX 8624 24-lane, 6-Port PCI
 > Express Gen 2 (5.0 GT/s) Switch [ExpressLane] (rev bb)
 > 04:05.0 PCI bridge: PLX Technology, Inc. PEX 8624 24-lane, 6-Port PCI
 > Express Gen 2 (5.0 GT/s) Switch [ExpressLane] (rev bb)
 > 05:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic
 > SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon] (rev 03)
 > 0a:03.0 VGA compatible controller: Matrox Electronics Systems Ltd. MGA
 > G200eW WPCM450 (rev 0a)
 > 20:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890
 > Northbridge only dual slot (2x8) PCI-e GFX Hydra part (rev 02)
 > 20:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD/ATI] RD990 I/O Memory
 > Management Unit (IOMMU)
 > 20:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
 > to PCI bridge (PCI express gpp port B)
 > 20:03.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
 > to PCI bridge (PCI express gpp port C)
 > 20:0b.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890 PCI
 > to PCI bridge (NB-SB link)
 > 22:00.0 Ethernet controller: Solarflare Communications SFC9020
 > [Solarstorm]
 > 22:00.1 Ethernet controller: Solarflare Communications SFC9020
 > [Solarstorm]

Please let me know if I can provide any more information or run any
further tests.

With thanks,
Gregor Dick
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
