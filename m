From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 00/19] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
	reserved regions
Date: Mon,  9 Jan 2017 13:45:51 +0000
Message-ID: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
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
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Following LPC discussions, we now report reserved regions through
the iommu-group sysfs reserved_regions attribute file.

Reserved regions are populated through the IOMMU get_resv_region
callback (former get_dm_regions), now implemented by amd-iommu,
intel-iommu and arm-smmu:
- the intel-iommu reports the [0xfee00000 - 0xfeefffff] MSI window
  as a reserved region and RMRR regions as direct-mapped regions.
- the amd-iommu reports device direct mapped regions, the MSI region
  and HT regions.
- the arm-smmu reports the MSI window (arbitrarily located at
  0x8000000 and 1MB large).

Unsafe interrupt assignment is tested by enumerating all MSI irq
domains and checking MSI remapping is supported in the above hierarchy.
This check is done in case we detect the iommu translates MSI
(an IOMMU_RESV_MSI window exists). Otherwise the IRQ remapping
capability is checked at IOMMU level. Obviously this is a defensive
IRQ safety assessment: Assuming there are several MSI controllers
in the system and at least one does not implement IRQ remapping,
the assignment will be considered as unsafe (even if this controller
is not acessible from the assigned devices).

The two first patches stem from Robin's branch:
http://linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/misc
They are likely to be pulled separately.

Best Regards

Eric

Git: complete series available at
https://github.com/eauger/linux/tree/v4.10-rc3-reserved-v7

History:

PATCHv6 -> PATCHv7:
- "iommu/dma: Implement PCI allocation optimisation" was added to apply
  "iommu/dma: Allow MSI-only cookies"
- report Intel RMRR as direct-mapped regions
- report the type in the iommu group sysfs reserved_regions file
- do not merge regions of different types when building the list
  of reserved regions
- intgerate Robin's "iommu/dma: Allow MSI-only cookies" last
  version
- update Documentation/ABI/testing/sysfs-kernel-iommu_groups
- rename IOMMU_RESV_NOMAP into IOMMU_RESV_RESERVED

PATCHv5 -> PATCHv6
- Introduce IRQ_DOMAIN_FLAG_MSI as suggested by Marc
- irq_domain_is_msi, irq_domain_is_msi_remap,
  irq_domain_hierarchical_is_msi_remap,
- set IRQ_DOMAIN_FLAG_MSI in msi_create_irq_domain
- fix compil issue on i386
- rework test at VFIO level

RFCv4 -> PATCHv5
- fix IRQ security assessment by looking at irq domain parents
- check DOMAIN_BUS_FSL_MC_MSI irq domains
- AMD MSI and HT regions are exposed in iommu group sysfs

RFCv3 -> RFCv4:
- arm-smmu driver does not register PCI host bridge windows as
  reserved regions anymore
- Implement reserved region get/put callbacks also in arm-smmuv3
- take the iommu_group lock on iommu_get_group_resv_regions
- add a type field in iommu_resv_region instead of using prot
- init the region list_head in iommu_alloc_resv_region, also
  add type parameter
- iommu_insert_resv_region manage overlaps and sort reserved
  windows
- address IRQ safety assessment by enumerating all the MSI irq
  domains and checking the MSI_REMAP flag
- update Documentation/ABI/testing/sysfs-kernel-iommu_groups

RFC v2 -> v3:
- switch to an iommu-group sysfs API
- use new dummy allocator provided by Robin
- dummy allocator initialized by vfio-iommu-type1 after enumerating
  the reserved regions
- at the moment ARM MSI base address/size is left unchanged compared
  to v2
- we currently report reserved regions and not usable IOVA regions as
  requested by Alex

RFC v1 -> v2:
- fix intel_add_reserved_regions
- add mutex lock/unlock in vfio_iommu_type1


Eric Auger (17):
  iommu: Rename iommu_dm_regions into iommu_resv_regions
  iommu: Add a new type field in iommu_resv_region
  iommu: iommu_alloc_resv_region
  iommu: Only map direct mapped regions
  iommu: iommu_get_group_resv_regions
  iommu: Implement reserved_regions iommu-group sysfs file
  iommu/vt-d: Implement reserved region get/put callbacks
  iommu/amd: Declare MSI and HT regions as reserved IOVA regions
  iommu/arm-smmu: Implement reserved region get/put callbacks
  iommu/arm-smmu-v3: Implement reserved region get/put callbacks
  irqdomain: Add irq domain MSI and MSI_REMAP flags
  genirq/msi: Set IRQ_DOMAIN_FLAG_MSI on MSI domain creation
  irqdomain: irq_domain_check_msi_remap
  irqchip/gicv3-its: Sets IRQ_DOMAIN_FLAG_MSI_REMAP
  vfio/type1: Allow transparent MSI IOVA allocation
  vfio/type1: Check MSI remapping at irq domain level
  iommu/arm-smmu: Do not advertise IOMMU_CAP_INTR_REMAP anymore

Robin Murphy (2):
  iommu/dma: Implement PCI allocation optimisation
  iommu/dma: Allow MSI-only cookies

 .../ABI/testing/sysfs-kernel-iommu_groups          |  12 ++
 drivers/iommu/amd_iommu.c                          |  54 ++++---
 drivers/iommu/arm-smmu-v3.c                        |  30 +++-
 drivers/iommu/arm-smmu.c                           |  30 +++-
 drivers/iommu/dma-iommu.c                          | 138 ++++++++++++----
 drivers/iommu/intel-iommu.c                        |  92 ++++++++---
 drivers/iommu/iommu.c                              | 179 +++++++++++++++++++--
 drivers/irqchip/irq-gic-v3-its.c                   |   1 +
 drivers/vfio/vfio_iommu_type1.c                    |  37 ++++-
 include/linux/dma-iommu.h                          |   6 +
 include/linux/iommu.h                              |  46 ++++--
 include/linux/irqdomain.h                          |  36 +++++
 kernel/irq/irqdomain.c                             |  39 +++++
 kernel/irq/msi.c                                   |   4 +-
 14 files changed, 606 insertions(+), 98 deletions(-)

-- 
1.9.1
