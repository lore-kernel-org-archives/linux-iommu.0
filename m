From: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Subject: Re: 4.19-rc3: IOMMU PT warnings: WARNING: CPU: 0 PID: 1 at
	mm/page_alloc.c:4065 __alloc_pages_slowpath+0xb7b/0xcd0
Date: Mon, 10 Sep 2018 17:07:38 +0300 (EEST)
Message-ID: <alpine.LRH.2.21.1809101705250.6328@math.ut.ee>
References: <alpine.LRH.2.21.1809101111040.31938@math.ut.ee>
	<20180910132304.GA20244@lst.de>
	<e3f0e78a-3e3d-aae7-2588-599184dee534@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e3f0e78a-3e3d-aae7-2588-599184dee534-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> Given the __alloc_pages_slowpath() warning, this looks like it's probably
> stemming from the oversized PASID table issue which a few other folks have hit
> too. I think this patch is the most up-to-date fix:
> 
> https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg25639.html

The warning is gone but there seem to be more warnings about 
IOMMU_DOMAIN_DMA:

[    0.171992] DMAR: Host address width 39
[    0.171994] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.171998] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
[    0.171999] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.172002] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.172004] DMAR: RMRR base: 0x000000ca02f000 end: 0x000000ca04efff
[    0.172005] DMAR: RMRR base: 0x000000cb800000 end: 0x000000cfffffff
[    0.172007] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.172008] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.173441] DMAR-IR: Enabled IRQ remapping in xapic mode

[...]

[    0.324160] DMAR: No ATSR found
[    0.324175] DMAR: dmar0: Using Queued invalidation
[    0.324229] DMAR: dmar1: Using Queued invalidation
[    0.324453] DMAR: Hardware identity mapping for device 0000:00:00.0
[    0.324501] DMAR: Hardware identity mapping for device 0000:00:02.0
[    0.324503] DMAR: Hardware identity mapping for device 0000:00:08.0
[    0.324505] DMAR: Hardware identity mapping for device 0000:00:14.0
[    0.324507] DMAR: Hardware identity mapping for device 0000:00:16.0
[    0.324508] DMAR: Hardware identity mapping for device 0000:00:17.0
[    0.324510] DMAR: Hardware identity mapping for device 0000:00:1b.0
[    0.324512] DMAR: Hardware identity mapping for device 0000:00:1b.2
[    0.324513] DMAR: Hardware identity mapping for device 0000:00:1b.3
[    0.324515] DMAR: Hardware identity mapping for device 0000:00:1b.4
[    0.324516] DMAR: Hardware identity mapping for device 0000:00:1c.0
[    0.324518] DMAR: Hardware identity mapping for device 0000:00:1c.2
[    0.324520] DMAR: Hardware identity mapping for device 0000:00:1c.4
[    0.324521] DMAR: Hardware identity mapping for device 0000:00:1d.0
[    0.324523] DMAR: Hardware identity mapping for device 0000:00:1f.0
[    0.324524] DMAR: Hardware identity mapping for device 0000:00:1f.2
[    0.324526] DMAR: Hardware identity mapping for device 0000:00:1f.3
[    0.324528] DMAR: Hardware identity mapping for device 0000:00:1f.4
[    0.324529] DMAR: Hardware identity mapping for device 0000:00:1f.6
[    0.324532] DMAR: Hardware identity mapping for device 0000:09:00.0
[    0.324533] DMAR: Setting RMRR:
[    0.324535] DMAR: Ignoring identity map for HW passthrough device 0000:00:02.0 [0xcb800000 - 0xcfffffff]
[    0.324536] DMAR: Ignoring identity map for HW passthrough device 0000:00:14.0 [0xca02f000 - 0xca04efff]
[    0.324539] DMAR: Prepare 0-16MiB unity mapping for LPC
[    0.324540] DMAR: Ignoring identity map for HW passthrough device 0000:00:1f.0 [0x0 - 0xffffff]
[    0.324576] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.324601] pci 0000:00:00.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324604] iommu: Adding device 0000:00:00.0 to group 0
[    0.324610] pci 0000:00:02.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324613] iommu: Adding device 0000:00:02.0 to group 1
[    0.324619] pci 0000:00:08.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324621] iommu: Adding device 0000:00:08.0 to group 2
[    0.324629] pci 0000:00:14.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324631] iommu: Adding device 0000:00:14.0 to group 3
[    0.324639] pci 0000:00:16.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324641] iommu: Adding device 0000:00:16.0 to group 4
[    0.324647] pci 0000:00:17.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324649] iommu: Adding device 0000:00:17.0 to group 5
[    0.324664] pci 0000:00:1b.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324666] iommu: Adding device 0000:00:1b.0 to group 6
[    0.324673] pci 0000:00:1b.2: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324675] iommu: Adding device 0000:00:1b.2 to group 7
[    0.324683] pci 0000:00:1b.3: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324685] iommu: Adding device 0000:00:1b.3 to group 8
[    0.324693] pci 0000:00:1b.4: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324695] iommu: Adding device 0000:00:1b.4 to group 9
[    0.324708] pci 0000:00:1c.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324711] iommu: Adding device 0000:00:1c.0 to group 10
[    0.324718] pci 0000:00:1c.2: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324721] iommu: Adding device 0000:00:1c.2 to group 11
[    0.324728] pci 0000:00:1c.4: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324730] iommu: Adding device 0000:00:1c.4 to group 12
[    0.324738] pci 0000:00:1d.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324740] iommu: Adding device 0000:00:1d.0 to group 13
[    0.324754] pci 0000:00:1f.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324757] iommu: Adding device 0000:00:1f.0 to group 14
[    0.324763] pci 0000:00:1f.2: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324765] iommu: Adding device 0000:00:1f.2 to group 14
[    0.324771] pci 0000:00:1f.3: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324773] iommu: Adding device 0000:00:1f.3 to group 14
[    0.324779] pci 0000:00:1f.4: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324782] iommu: Adding device 0000:00:1f.4 to group 14
[    0.324788] pci 0000:00:1f.6: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324790] iommu: Adding device 0000:00:1f.6 to group 15
[    0.324797] pci 0000:02:00.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324800] iommu: Adding device 0000:02:00.0 to group 16
[    0.324807] pci 0000:09:00.0: failed to allocate default IOMMU domain of type 4; falling back to IOMMU_DOMAIN_DMA
[    0.324810] iommu: Adding device 0000:09:00.0 to group 17



-- 
Meelis Roos (mroos-Y27EyoLml9s@public.gmane.org)
