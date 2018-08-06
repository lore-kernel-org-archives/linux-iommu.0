From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 0/5] add non-strict mode support for arm-smmu-v3
Date: Mon, 6 Aug 2018 20:26:59 +0800
Message-ID: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>
List-Id: iommu@lists.linux-foundation.org

v3 -> v4:
1. Add a new member "non_strict" in struct iommu_domain to mark whether
   that domain use non-strict mode or not. This can help us to remove the
   capability which was added in prior version.
2. Add a new quirk IO_PGTABLE_QUIRK_NON_STRICT, so that we can get "strict
   mode" in io-pgtable-arm.c according to data->iop.cfg.quirks.
3. rename the new boot option to "arm_iommu".

Thanks for Robin's review comments.

v2 -> v3:
Add a bootup option "iommu_strict_mode" to make the manager can choose which
mode to be used. The first 5 patches have not changed.
+	iommu_strict_mode=	[arm-smmu-v3]
+		0 - strict mode (default)
+		1 - non-strict mode

v1 -> v2:
Use the lowest bit of the io_pgtable_ops.unmap's iova parameter to pass the strict mode:
0, IOMMU_STRICT;
1, IOMMU_NON_STRICT;
Treat 0 as IOMMU_STRICT, so that the unmap operation can compatible with
other IOMMUs which still use strict mode. In other words, this patch series
will not impact other IOMMU drivers. I tried add a new quirk IO_PGTABLE_QUIRK_NON_STRICT
in io_pgtable_cfg.quirks, but it can not pass the strict mode of the domain from SMMUv3
driver to io-pgtable module. 

Add a new member domain_non_strict in struct iommu_dma_cookie, this member will only be
initialized when the related domain and IOMMU driver support non-strict mode.

v1:
In common, a IOMMU unmap operation follow the below steps:
1. remove the mapping in page table of the specified iova range
2. execute tlbi command to invalid the mapping which is cached in TLB
3. wait for the above tlbi operation to be finished
4. free the IOVA resource
5. free the physical memory resource

This maybe a problem when unmap is very frequently, the combination of tlbi
and wait operation will consume a lot of time. A feasible method is put off
tlbi and iova-free operation, when accumulating to a certain number or
reaching a specified time, execute only one tlbi_all command to clean up
TLB, then free the backup IOVAs. Mark as non-strict mode.

But it must be noted that, although the mapping has already been removed in
the page table, it maybe still exist in TLB. And the freed physical memory
may also be reused for others. So a attacker can persistent access to memory
based on the just freed IOVA, to obtain sensible data or corrupt memory. So
the VFIO should always choose the strict mode.

Some may consider put off physical memory free also, that will still follow
strict mode. But for the map_sg cases, the memory allocation is not controlled
by IOMMU APIs, so it is not enforceable.

Fortunately, Intel and AMD have already applied the non-strict mode, and put
queue_iova() operation into the common file dma-iommu.c., and my work is based
on it. The difference is that arm-smmu-v3 driver will call IOMMU common APIs to
unmap, but Intel and AMD IOMMU drivers are not.

Below is the performance data of strict vs non-strict for NVMe device:
Randomly Read  IOPS: 146K(strict) vs 573K(non-strict)
Randomly Write IOPS: 143K(strict) vs 513K(non-strict)


Zhen Lei (5):
  iommu/arm-smmu-v3: fix the implementation of flush_iotlb_all hook
  iommu/dma: add support for non-strict mode
  iommu/io-pgtable-arm: add support for non-strict mode
  iommu/arm-smmu-v3: add support for non-strict mode
  iommu/arm-smmu-v3: add bootup option "arm_iommu"

 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++
 drivers/iommu/arm-smmu-v3.c                     | 32 +++++++++++++++++++++++--
 drivers/iommu/dma-iommu.c                       | 23 ++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c                  | 27 ++++++++++++++-------
 drivers/iommu/io-pgtable.h                      |  3 +++
 drivers/iommu/iommu.c                           |  1 +
 include/linux/iommu.h                           |  1 +
 7 files changed, 85 insertions(+), 11 deletions(-)

-- 
1.8.3
