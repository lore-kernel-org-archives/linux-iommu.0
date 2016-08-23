From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 00/19] Generic DT bindings for PCI IOMMUs and ARM SMMU
Date: Tue, 23 Aug 2016 20:15:17 +0100
Message-ID: <3a9a9369-d8cd-66f4-9344-965c80894bb6@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 23/08/16 20:05, Robin Murphy wrote:
> Hi all,

Oh bums, looks like I managed to miss LAKML off the CC list. If anyone
there is interested, it's over here:

https://lists.linuxfoundation.org/pipermail/iommu/2016-August/018230.html

Robin.

> 
> At long last I've finished the big SMMUv2 rework, so here's everything
> all together for a v5. As a quick breakdown:
> 
> Patches 1-3 are the core PCI part, all acked and ready to go. No code
> changes from v4.
> 
> Patch 4 is merely bugfixed from v4 for simplicity, as I've not yet
> managed to take as close a look at Lorenzo's follow-on work as I'd like.
> 
> Patches 5-7 (SMMUv3) are mostly unchanged beyond a slight tweak to #5.
> 
> Patches 8-17 are the all-new SMMUv2 rework.
> 
> Patch 18 goes along with the fix already in 4.8-rc3 to help avoid 64-bit
> DMA masks going wrong now that DMA ops will be enabled.
> 
> Finally, patch 19 addresses the previous problem of having to choose
> between DMA ops or working MSIs. This is currently at the end as
> moving it before #17 would require a further interim SMMUv2 patch, and
> a 19-patch series is already quite enough...
> 
> I've pushed out a branch based on iommu/next to the usual place:
> 
> git://linux-arm.org/linux-rm iommu/generic-v5
> 
> Thanks,
> Robin.
> ---
> 
> Mark Rutland (1):
>   Docs: dt: add PCI IOMMU map bindings
> 
> Robin Murphy (18):
>   of/irq: Break out msi-map lookup (again)
>   iommu/of: Handle iommu-map property for PCI
>   iommu/of: Introduce iommu_fwspec
>   iommu/arm-smmu: Implement of_xlate() for SMMUv3
>   iommu/arm-smmu: Support non-PCI devices with SMMUv3
>   iommu/arm-smmu: Set PRIVCFG in stage 1 STEs
>   iommu/arm-smmu: Handle stream IDs more dynamically
>   iommu/arm-smmu: Consolidate stream map entry state
>   iommu/arm-smmu: Keep track of S2CR state
>   iommu/arm-smmu: Refactor mmu-masters handling
>   iommu/arm-smmu: Streamline SMMU data lookups
>   iommu/arm-smmu: Add a stream map entry iterator
>   iommu/arm-smmu: Intelligent SMR allocation
>   iommu/arm-smmu: Convert to iommu_fwspec
>   Docs: dt: document ARM SMMU generic binding usage
>   iommu/arm-smmu: Wire up generic configuration support
>   iommu/arm-smmu: Set domain geometry
>   iommu/dma: Add support for mapping MSIs
> 
>  .../devicetree/bindings/iommu/arm,smmu.txt         |  63 +-
>  .../devicetree/bindings/pci/pci-iommu.txt          | 171 ++++
>  drivers/iommu/Kconfig                              |   2 +-
>  drivers/iommu/arm-smmu-v3.c                        | 347 ++++----
>  drivers/iommu/arm-smmu.c                           | 952 ++++++++++-----------
>  drivers/iommu/dma-iommu.c                          | 141 ++-
>  drivers/iommu/of_iommu.c                           |  95 +-
>  drivers/irqchip/irq-gic-v2m.c                      |   3 +
>  drivers/irqchip/irq-gic-v3-its.c                   |   3 +
>  drivers/of/irq.c                                   |  78 +-
>  drivers/of/of_pci.c                                | 102 +++
>  include/linux/dma-iommu.h                          |   9 +
>  include/linux/of_iommu.h                           |  15 +
>  include/linux/of_pci.h                             |  10 +
>  14 files changed, 1208 insertions(+), 783 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
