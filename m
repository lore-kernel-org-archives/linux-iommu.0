From: Eric Auger <eric.auger@redhat.com>
Subject: [RFC v2 0/4] arm-smmu-v3 tlbi-on-map option
Date: Fri, 11 Aug 2017 15:45:26 +0200
Message-ID: <1502459130-6234-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Will.Deacon@arm.com, robin.murphy@arm.com, Jean-Philippe.Brucker@arm.com
Cc: christoffer.dall@linaro.org, Marc.Zyngier@arm.com, alex.williamson@redhat.com, peterx@redhat.com, mst@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com
List-Id: iommu@lists.linux-foundation.org

This series adds a new tlbi-on-map option to the smmuv3 driver.
When set, the IO_PGTABLE_QUIRK_TLBI_ON_MAP quirk is applied for
LPAE tables and the smmuv3 driver sends TLB invalidations on map.

This mode is useful when running the driver on a guest as it allows
the virtualizer to trap any change to the translation structures.
This is similar to the Intel vtd caching mode (CM).

This is mandated for vSMMUv3/VFIO integration where guest mappings
must be applied to the physical IOMMU and also for VHOST.

When this mode is set we use an implementation defined TLBI
invalidation command which allows to invalidate a range of IOVA
instead of using CMD_TLBI_NH_VA which works by page. This
is needed for sake of efficiency when running DPDK use case on
guest as DPDK uses hugepages. As far as I understand the intel
IOMMU provides such invalidation command (using the address mask
parameter) and at the moment, I haven't found something similar
in the smmuv3 architecture specification.

Best Regards

Eric

Git: complete series available at
https://github.com/eauger/linux/tree/v4.13-rc3-tlbi-on-map-rfcv2

History:
v1 -> v2:
- add support for ACPI probing
- add implementation defined CMD_TLBI_NH_VA_AM which allows
  IOVA range invalidation


Eric Auger (4):
  iommu/io-pgtable-arm: flush TLBs when IO_PGTABLE_QUIRK_TLBI_ON_MAP
  iommu/arm-smmu-v3: Add tlbi_on_map option
  iommu/arm-smmu-v3: Add hypothetical caching mode model
  iommu/arm-smmu-v3: add CMD_TLBI_NH_VA_AM command for iova range
    invalidation

 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  4 +++
 drivers/iommu/arm-smmu-v3.c                        | 34 ++++++++++++++++++++--
 drivers/iommu/io-pgtable-arm.c                     | 14 +++++++--
 3 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.5.5
