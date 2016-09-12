From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
Date: Mon, 12 Sep 2016 17:13:38 +0100
Message-ID: <cover.1473695704.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

To any more confusing fixups and crazily numbered extra patches, here's
a quick v7 with everything rebased into the right order. The significant
change this time is to implement iommu_fwspec properly from the start,
which ends up being far simpler and more robust than faffing about
introducing it somewhere 'less intrusive' to move toward core code later.

New branch in the logical place:

git://linux-arm.org/linux-rm iommu/generic-v7

Robin.

Mark Rutland (1):
  Docs: dt: add PCI IOMMU map bindings

Robin Murphy (21):
  of/irq: Break out msi-map lookup (again)
  iommu/of: Handle iommu-map property for PCI
  iommu: Introduce iommu_fwspec
  Docs: dt: document ARM SMMUv3 generic binding usage
  iommu/arm-smmu: Fall back to global bypass
  iommu/arm-smmu: Implement of_xlate() for SMMUv3
  iommu/arm-smmu: Support non-PCI devices with SMMUv3
  iommu/arm-smmu: Set PRIVCFG in stage 1 STEs
  iommu/arm-smmu: Handle stream IDs more dynamically
  iommu/arm-smmu: Consolidate stream map entry state
  iommu/arm-smmu: Keep track of S2CR state
  iommu/arm-smmu: Refactor mmu-masters handling
  iommu/arm-smmu: Streamline SMMU data lookups
  iommu/arm-smmu: Add a stream map entry iterator
  iommu/arm-smmu: Intelligent SMR allocation
  iommu/arm-smmu: Convert to iommu_fwspec
  Docs: dt: document ARM SMMU generic binding usage
  iommu/arm-smmu: Wire up generic configuration support
  iommu/arm-smmu: Set domain geometry
  iommu/dma: Add support for mapping MSIs
  iommu/dma: Avoid PCI host bridge windows

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   8 +-
 .../devicetree/bindings/iommu/arm,smmu.txt         |  63 +-
 .../devicetree/bindings/pci/pci-iommu.txt          | 171 ++++
 arch/arm64/mm/dma-mapping.c                        |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_iommu.h          |   2 +-
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/arm-smmu-v3.c                        | 386 +++++----
 drivers/iommu/arm-smmu.c                           | 962 ++++++++++-----------
 drivers/iommu/dma-iommu.c                          | 161 +++-
 drivers/iommu/iommu.c                              |  56 ++
 drivers/iommu/of_iommu.c                           |  52 +-
 drivers/irqchip/irq-gic-v2m.c                      |   3 +
 drivers/irqchip/irq-gic-v3-its.c                   |   3 +
 drivers/of/irq.c                                   |  78 +-
 drivers/of/of_pci.c                                | 102 +++
 include/linux/device.h                             |   3 +
 include/linux/dma-iommu.h                          |  12 +-
 include/linux/iommu.h                              |  38 +
 include/linux/of_pci.h                             |  10 +
 19 files changed, 1323 insertions(+), 791 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt

-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
