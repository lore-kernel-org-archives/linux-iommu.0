From: Eric Auger <eric.auger@redhat.com>
Subject: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA reserved regions
Date: Tue, 15 Nov 2016 13:09:13 +0000
Message-ID: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, pranav.sawargaonkar@gmail.com, iommu@lists.linux-foundation.org, punit.agrawal@arm.com, diana.craciun@nxp.com
List-Id: iommu@lists.linux-foundation.org

Following LPC discussions, we now report reserved regions through
iommu-group sysfs reserved_regions attribute file.

Reserved regions are populated through the IOMMU get_resv_region callback
(former get_dm_regions), now implemented by amd-iommu, intel-iommu and
arm-smmu.

The intel-iommu reports the [FEE0_0000h - FEF0_000h] MSI window as an
IOMMU_RESV_NOMAP reserved region.

arm-smmu reports the MSI window (arbitrarily located at 0x8000000 and
1MB large) and the PCI host bridge windows.

The series integrates a not officially posted patch from Robin:
"iommu/dma: Allow MSI-only cookies".

This series currently does not address IRQ safety assessment.

Best Regards

Eric

Git: complete series available at
https://github.com/eauger/linux/tree/v4.9-rc5-reserved-rfc-v3

History:
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


Eric Auger (10):
  iommu/dma: Allow MSI-only cookies
  iommu: Rename iommu_dm_regions into iommu_resv_regions
  iommu: Add new reserved IOMMU attributes
  iommu: iommu_alloc_resv_region
  iommu: Do not map reserved regions
  iommu: iommu_get_group_resv_regions
  iommu: Implement reserved_regions iommu-group sysfs file
  iommu/vt-d: Implement reserved region get/put callbacks
  iommu/arm-smmu: Implement reserved region get/put callbacks
  vfio/type1: Get MSI cookie

 drivers/iommu/amd_iommu.c       |  20 +++---
 drivers/iommu/arm-smmu.c        |  52 +++++++++++++++
 drivers/iommu/dma-iommu.c       | 116 ++++++++++++++++++++++++++-------
 drivers/iommu/intel-iommu.c     |  50 ++++++++++----
 drivers/iommu/iommu.c           | 141 ++++++++++++++++++++++++++++++++++++----
 drivers/vfio/vfio_iommu_type1.c |  26 ++++++++
 include/linux/dma-iommu.h       |   7 ++
 include/linux/iommu.h           |  49 ++++++++++----
 8 files changed, 391 insertions(+), 70 deletions(-)

-- 
1.9.1
