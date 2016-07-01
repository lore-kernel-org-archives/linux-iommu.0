From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4 0/8] Generic DT bindings for PCI IOMMUs and ARM SMMUv3
Date: Fri,  1 Jul 2016 17:50:09 +0100
Message-ID: <cover.1467388950.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Here's a quick repost to address the comments on v3[1], in the hope of
making some progress while I'm away next week.

I've dropped the workaround consolidation patch (and added the
equivalent to patch 6) since it's as much of a step sideways as in the
right direction, so we may as well hold off until _really_ fixing probe
ordering. Beyond that, a few minor tweaks per Will's comments.

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/14303

Lorenzo Pieralisi (1):
  arm64: mm: change IOMMU notifier action to attach DMA ops

Mark Rutland (1):
  Docs: dt: add PCI IOMMU map bindings

Robin Murphy (6):
  of/irq: Break out msi-map lookup (again)
  iommu/of: Handle iommu-map property for PCI
  iommu/of: Introduce iommu_fwspec
  iommu/arm-smmu: Implement of_xlate() for SMMUv3
  iommu/arm-smmu: Support non-PCI devices with SMMUv3
  iommu/arm-smmu: Set PRIVCFG in stage 1 STEs

 .../devicetree/bindings/pci/pci-iommu.txt          | 171 +++++++++++
 arch/arm64/mm/dma-mapping.c                        |  22 +-
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/arm-smmu-v3.c                        | 313 ++++++++++-----------
 drivers/iommu/of_iommu.c                           |  95 ++++++-
 drivers/of/irq.c                                   |  78 +----
 drivers/of/of_pci.c                                | 102 +++++++
 include/linux/of_iommu.h                           |  15 +
 include/linux/of_pci.h                             |  10 +
 9 files changed, 549 insertions(+), 259 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt

-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
