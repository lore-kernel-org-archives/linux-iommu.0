From: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Subject: Re: IOMMU+DMAR causing NMIs-s
Date: Wed, 24 Aug 2016 11:19:34 +0300 (EEST)
Message-ID: <alpine.LRH.2.20.1608240106140.27855@math.ut.ee>
References: <alpine.LRH.2.20.1607121525060.2088@math.ut.ee>
	<5630546.0MIYeGNSYG@vostro.rjw.lan>
	<alpine.LRH.2.20.1607121654490.2088@math.ut.ee>
	<alpine.LRH.2.20.1607130855210.11080@math.ut.ee>
	<20160713081817.GJ12639@8bytes.org>
	<alpine.LRH.2.20.1607131122010.20366@math.ut.ee>
	<20160713090332.GK12639@8bytes.org>
	<alpine.LRH.2.20.1607131239410.20366@math.ut.ee>
	<20160713094917.GM12639@8bytes.org>
	<alpine.LRH.2.20.1607131257390.20366@math.ut.ee>
	<20160713101859.GO12639@8bytes.org>
	<20160713084830.09453584@t450s.home>
	<1a4c4b65-c716-08a5-af89-1b0f551024ed@hpe.com>
	<alpine.LRH.2.20.1607132258001.30020@math.ut.ee>
	<20160713170408.6e5d2534@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160713170408.6e5d2534-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Getting back to an issue after more than a month of summer.

> With hpwdt disabled, can you reboot a few times and look for DMAR
> faults in the dmesg to see if they're all consistent, ie. device 1e.0
> doing a read from 0xb000?  Is there any correlation to radeon hanging
> and one of those DMAR faults appearing in the log (you can make use of
> the iLO for a serial console so you can record more of the boot than
> what can be captured on the VGA console).  Also, this should be an

Tested on 4.6.0 with hpwdt off.

On most boots, nothing strange happens. Got some NMIs (below). Usually it's
during the radeon startup but in slighlty varying places, and the address
varies: 1000 2000 3000 9000 a000 b000.

Got also a hang after radeon startup:
http://kodu.ut.ee/~mroos/boot-radeon-3.png

[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason a1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 1000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d23dc000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
[drm] radeon: ring at 0x00000000C8001000
[drm] ring test succeeded in 1 usecs
kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[drm] ib test succeeded in 0 usecs
[drm] No TV DAC info found in BIOS
[drm] Radeon Display Connectors
[drm] Connector 0:
[drm]   VGA-1
[drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[drm]   Encoders:
[drm]     CRT1: INTERNAL_DAC1
[drm] Connector 1:
[drm]   VGA-2
[drm]   DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c
[drm]   Encoders:
[drm]     CRT2: INTERNAL_DAC2
CE: hpet increased min_delta_ns to 20115 nsec
[drm] fb mappable at 0xE8040000
[drm] vram apper at 0xE8000000
[drm] size 786432
[drm] fb depth is 8
[drm]    pitch is 1024
fbcon: radeondrmfb (fb0) is primary device

======================================================================================

[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason a1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 3000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d2736000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
[drm] radeon: ring at 0x00000000C8001000
[drm] ring test succeeded in 1 usecs
Adding 25153532k swap on /dev/sda5.  Priority:-1 extents:1 across:25153532k FS
kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[drm] ib test succeeded in 0 usecs
[drm] No TV DAC info found in BIOS
[drm] Radeon Display Connectors
[drm] Connector 0:
[drm]   VGA-1
[drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[drm]   Encoders:
[drm]     CRT1: INTERNAL_DAC1
[drm] Connector 1:
[drm]   VGA-2
[drm]   DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c
[drm]   Encoders:
[drm]     CRT2: INTERNAL_DAC2
[drm] fb mappable at 0xE8040000
[drm] vram apper at 0xE8000000
[drm] size 786432
[drm] fb depth is 8
[drm]    pitch is 1024
fbcon: radeondrmfb (fb0) is primary device

=======================================================================================

[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason a1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 9000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x

=======================================================================================

[drm] Initialized drm 1.1.0 20060810
Error: Driver 'pcspkr' is already registered, aborting...
ipmi_si 0000:01:04.6: Using irq 21
ipmi_si 0000:01:04.6: Found new BMC (man_id: 0x00000b, prod_id: 0x2000, dev_id: 0x11)
ipmi_si 0000:01:04.6: IPMI kcs interface initialized
[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason b1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 3000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d28be000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).

=======================================================================================

[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason b1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 3000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d20a6000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
[drm] radeon: ring at 0x00000000C8001000
[drm] ring test succeeded in 1 usecs

=======================================================================================

[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason b1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 2000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d2198000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[drm] radeon: ring at 0x00000000C8001000

=======================================================================================

[drm] Initialized drm 1.1.0 20060810
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
Error: Driver 'pcspkr' is already registered, aborting...
ipmi_si 0000:01:04.6: Using irq 21
ipmi_si 0000:01:04.6: Found new BMC (man_id: 0x00000b, prod_id: 0x2000, dev_id: 0x11)
ipmi_si 0000:01:04.6: IPMI kcs interface initialized
[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason a1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 1000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d2316000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.

========================================================================================

[drm] radeon kernel modesetting enabled.
kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason b1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 1000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d72d7000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.

=======================================================================================

[drm] Initialized drm 1.1.0 20060810
ipmi_si 0000:01:04.6: Using irq 21
ipmi_si 0000:01:04.6: Found new BMC (man_id: 0x00000b, prod_id: 0x2000, dev_id: 0x11)
ipmi_si 0000:01:04.6: IPMI kcs interface initialized
[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason a1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 1000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d7040000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode

=========================================================================================

[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason b1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 3000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d212b000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
[drm] radeon: ring at 0x00000000C8001000

=========================================================================================

[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason a1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 1000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d1ffa000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode

==========================================================================================

[drm] Initialized drm 1.1.0 20060810
[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason b1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr a000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d6b70000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
[drm] radeon: ring at 0x00000000C8001000

===========================================================================================

[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason b1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 1000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d6e1a000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
[drm] radeon: ring at 0x00000000C8001000

===========================================================================================

[drm] radeon kernel modesetting enabled.
kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason b1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr b000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d328d000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
[drm] radeon: ring at 0x00000000C8001000
[drm] ring test succeeded in 1 usecs
[drm] ib test succeeded in 0 usecs
[drm] No TV DAC info found in BIOS

===========================================================================================

[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason a1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr a000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d269e000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
[drm] radeon: ring at 0x00000000C8001000
[drm] ring test succeeded in 1 usecs
Adding 25153532k swap on /dev/sda5.  Priority:-1 extents:1 across:25153532k FS

===========================================================================================

[drm] Initialized drm 1.1.0 20060810
Error: Driver 'pcspkr' is already registered, aborting...
iTCO_vendor_support: vendor-support=0
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason a1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr b000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d6813000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
[drm] radeon: ring at 0x00000000C8001000
[drm] ring test succeeded in 1 usecs

=========================================================================================

[drm] Initialized drm 1.1.0 20060810
Error: Driver 'pcspkr' is already registered, aborting...
ipmi_si 0000:01:04.6: Using irq 21
ipmi_si 0000:01:04.6: Found new BMC (man_id: 0x00000b, prod_id: 0x2000, dev_id: 0x11)
ipmi_si 0000:01:04.6: IPMI kcs interface initialized
[drm] radeon kernel modesetting enabled.
Adding 25153532k swap on /dev/sda5.  Priority:-1 extents:1 across:25153532k FS
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason b1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 1000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800d265b000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
[drm] radeon: ring at 0x00000000C8001000
[drm] ring test succeeded in 1 usecs

=======================================================================================

[drm] Initialized drm 1.1.0 20060810
Error: Driver 'pcspkr' is already registered, aborting...
ipmi_si 0000:01:04.6: Using irq 21
ipmi_si 0000:01:04.6: Found new BMC (man_id: 0x00000b, prod_id: 0x2000, dev_id: 0x11)
ipmi_si 0000:01:04.6: IPMI kcs interface initialized
[drm] radeon kernel modesetting enabled.
CRAT table not found
Finished initializing topology ret=0
kfd kfd: Initialized module
[drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x103C:0x31FB 0x02).
[drm] register mmio base: 0xF5FF0000
[drm] register mmio size: 65536
radeon 0000:01:03.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (64M used)
radeon 0000:01:03.0: GTT: 512M 0x00000000C8000000 - 0x00000000E7FFFFFF
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 16bits DDR
[TTM] Zone  kernel: Available graphics memory: 12373318 kiB
[TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[TTM] Initializing pool allocator
[TTM] Initializing DMA pool allocator
[drm] radeon: 64M of VRAM memory ready
[drm] radeon: 512M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
NMI: PCI system error (SERR) for reason b1 on CPU 0.
Dazed and confused, but trying to continue
DMAR: DRHD: handling fault status reg 2
DMAR: DMAR:[DMA Read] Request device [00:1e.0] fault addr 1000 
DMAR:[fault reason 06] PTE Read access is not set
[drm] PCI GART of 512M enabled (table at 0x00000000FFF00000).
radeon 0000:01:03.0: WB disabled
radeon 0000:01:03.0: fence driver on ring 0 use gpu addr 0x00000000c8000000 and cpu addr 0xffff8800ce36a000
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Loading R100 Microcode
[drm] radeon: ring at 0x00000000C8001000


-- 
Meelis Roos (mroos-Y27EyoLml9s@public.gmane.org)
