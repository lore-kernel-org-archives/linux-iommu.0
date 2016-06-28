From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 0/9] Generic DT bindings for PCI IOMMUs and ARM SMMUv3
Date: Tue, 28 Jun 2016 16:48:19 +0100
Message-ID: <cover.1467123945.git.robin.murphy@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I didn't want the ongoing SMMUv2 rework delaying getting this out any
longer, so here's the SMMUv3-flavoured parts of the respin to address
the last round of comments[1] plus some new bits which fell out of the
woodwork along the way. This time I've actually fully tested the
platform device/multiple ID support as well (turns out I was being a
bit thick and our model does have some suitable peripherals after all).

As ever, branch at git://linux-arm.org/linux-rm iommu/generic-v3

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/13936

Lorenzo Pieralisi (1):
  arm64: mm: change IOMMU notifier action to attach DMA ops

Mark Rutland (1):
  Docs: dt: add PCI IOMMU map bindings

Robin Murphy (7):
  iommu/of: Consolidate device creation workarounds
  of/irq: Break out msi-map lookup (again)
  iommu/of: Handle iommu-map property for PCI
  iommu/of: Introduce iommu_fwspec
  iommu/arm-smmu: Implement of_xlate() for SMMUv3
  iommu/arm-smmu: Support non-PCI devices with SMMUv3
  iommu/arm-smmu: Set PRIVCFG in stage 1 STEs

 .../devicetree/bindings/pci/pci-iommu.txt          | 171 ++++++++++++
 arch/arm64/mm/dma-mapping.c                        |  22 +-
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/arm-smmu-v3.c                        | 307 ++++++++++-----------
 drivers/iommu/exynos-iommu.c                       |  20 +-
 drivers/iommu/mtk_iommu.c                          |   8 +-
 drivers/iommu/of_iommu.c                           |  96 ++++++-
 drivers/of/irq.c                                   |  78 +-----
 drivers/of/of_pci.c                                | 102 +++++++
 include/linux/of_iommu.h                           |  18 ++
 include/linux/of_pci.h                             |  10 +
 11 files changed, 554 insertions(+), 280 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt

-- 
2.8.1.dirty
