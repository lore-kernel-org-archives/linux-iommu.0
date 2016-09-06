From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v6 00/20] Generic DT bindings for PCI IOMMUs and ARM SMMU
Date: Tue,  6 Sep 2016 16:33:33 +0100
Message-ID: <cover.1473173789.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here's v6 to address last week's comments. For the sake of honesty I've
left Lorenzo's tested-by off everything I've changed since, and Eric's
reviewed-by off patch 19 having non-trivially reworked the guts of it.

Patch 20 is new, but as it's currently a solution waiting for a problem
as far as we're aware, oughtn't to get in the way; hopefully the rest is
in good shape for 4.9 now.

Branch here, based on Will's iommu/devel queue:

git://linux-arm.org/linux-rm iommu/generic-v6

Thanks,
Robin.
---

Mark Rutland (1):
  Docs: dt: add PCI IOMMU map bindings

Robin Murphy (19):
  of/irq: Break out msi-map lookup (again)
  iommu/of: Handle iommu-map property for PCI
  iommu/of: Introduce iommu_fwspec
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

 .../devicetree/bindings/iommu/arm,smmu.txt         |  63 +-
 .../devicetree/bindings/pci/pci-iommu.txt          | 171 ++++
 arch/arm64/mm/dma-mapping.c                        |   2 +-
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/arm-smmu-v3.c                        | 347 ++++----
 drivers/iommu/arm-smmu.c                           | 964 ++++++++++-----------
 drivers/iommu/dma-iommu.c                          | 155 +++-
 drivers/iommu/of_iommu.c                           | 100 ++-
 drivers/irqchip/irq-gic-v2m.c                      |   3 +
 drivers/irqchip/irq-gic-v3-its.c                   |   3 +
 drivers/of/irq.c                                   |  78 +-
 drivers/of/of_pci.c                                | 102 +++
 include/linux/dma-iommu.h                          |  12 +-
 include/linux/of_iommu.h                           |  15 +
 include/linux/of_pci.h                             |  10 +
 15 files changed, 1243 insertions(+), 784 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt

-- 
2.8.1.dirty
