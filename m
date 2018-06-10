From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/5] add non-strict mode support for arm-smmu-v3
Date: Sun, 10 Jun 2018 19:07:18 +0800
Message-ID: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, Guozhu Li <liguozhu@hisilicon.com>, Xinwei Hu <huxinwei@huawei.com>
List-Id: iommu@lists.linux-foundation.org

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

Zhen Lei (5):
  iommu/arm-smmu-v3: fix the implementation of flush_iotlb_all hook
  iommu/dma: add support for non-strict mode
  iommu/amd: use default branch to deal with all non-supported
    capabilities
  iommu/io-pgtable-arm: add support for non-strict mode
  iommu/arm-smmu-v3: add support for non-strict mode

 drivers/iommu/amd_iommu.c      |  4 +---
 drivers/iommu/arm-smmu-v3.c    | 16 +++++++++++++---
 drivers/iommu/dma-iommu.c      | 25 +++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c | 23 ++++++++++++++---------
 include/linux/iommu.h          |  7 +++++++
 5 files changed, 60 insertions(+), 15 deletions(-)

-- 
1.8.3
