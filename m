From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v14 00/16] KVM PCIe/MSI passthrough on ARM/ARM64
Date: Wed, 12 Oct 2016 13:22:08 +0000
Message-ID: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
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
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is the second respin on top of Robin's series [1], addressing Alex' comments.

Major changes are:
- MSI-doorbell API now is moved to DMA IOMMU API following Alex suggestion
  to put all API pieces at the same place (so eventually in the IOMMU
  subsystem)
- new iommu_domain_msi_resv struct and accessor through DOMAIN_ATTR_MSI_RESV
  domain with mirror VFIO capability
- more robustness I think in the VFIO layer
- added "iommu/iova: fix __alloc_and_insert_iova_range" since with the current
  code I failed allocating an IOVA page in a single page domain with upper part
  reserved

IOVA range exclusion will be handled in a separate series

The priority really is to discuss and freeze the API and especially the MSI
doorbell's handling. Do we agree to put that in DMA IOMMU?

Note: the size computation does not take into account possible page overlaps
between doorbells but it would add quite a lot of complexity i think.

Tested on AMD Overdrive (single GICv2m frame) with I350 VF assignment.

dependency:
the series depends on Robin's generic-v7 branch:
[1] [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
http://www.spinics.net/lists/arm-kernel/msg531110.html

Best Regards

Eric

Git: complete series available at
https://github.com/eauger/linux/tree/generic-v7-pcie-passthru-v14

the above branch includes a temporary patch to work around a ThunderX pci
bus reset crash (which I think unrelated to this series):
"vfio: pci: HACK! workaround thunderx pci_try_reset_bus crash"
Do not take this one for other platforms.


Eric Auger (15):
  iommu/iova: fix __alloc_and_insert_iova_range
  iommu: Introduce DOMAIN_ATTR_MSI_RESV
  iommu/dma: MSI doorbell alloc/free
  iommu/dma: Introduce iommu_calc_msi_resv
  iommu/arm-smmu: Implement domain_get_attr for DOMAIN_ATTR_MSI_RESV
  irqchip/gic-v2m: Register the MSI doorbell
  irqchip/gicv3-its: Register the MSI doorbell
  vfio: Introduce a vfio_dma type field
  vfio/type1: vfio_find_dma accepting a type argument
  vfio/type1: Implement recursive vfio_find_dma_from_node
  vfio/type1: Handle unmap/unpin and replay for VFIO_IOVA_RESERVED slots
  vfio: Allow reserved msi iova registration
  vfio/type1: Check doorbell safety
  iommu/arm-smmu: Do not advertise IOMMU_CAP_INTR_REMAP
  vfio/type1: Introduce MSI_RESV capability

Robin Murphy (1):
  iommu/dma: Allow MSI-only cookies

 drivers/iommu/Kconfig            |   4 +-
 drivers/iommu/arm-smmu-v3.c      |  10 +-
 drivers/iommu/arm-smmu.c         |  10 +-
 drivers/iommu/dma-iommu.c        | 184 ++++++++++++++++++++++++++
 drivers/iommu/iova.c             |   2 +-
 drivers/irqchip/irq-gic-v2m.c    |  10 +-
 drivers/irqchip/irq-gic-v3-its.c |  13 ++
 drivers/vfio/vfio_iommu_type1.c  | 279 +++++++++++++++++++++++++++++++++++++--
 include/linux/dma-iommu.h        |  59 +++++++++
 include/linux/iommu.h            |   8 ++
 include/uapi/linux/vfio.h        |  30 ++++-
 11 files changed, 587 insertions(+), 22 deletions(-)

-- 
1.9.1
