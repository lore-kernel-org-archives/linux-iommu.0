From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 0/2] iommu/arm: Add support for non-coherent page tables
Date: Thu, 17 Jan 2019 14:57:16 +0530
Message-ID: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, tfiga@chromium.org, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

As discussed in the Qcom system cache support thread [1], it is
imperative that we enable the support for non-cacheable page tables
for SMMU implementations for which removing snoop latency on walks
by making mappings as non-cacheable, outweighs the cost of cache
maintenance on PTE updates.

This series adds a new SMMU device tree option to let the particular
SMMU configuration setup cacheable or non-cacheable mappings for
page-tables out of box. We set a new quirk for i/o page tables -
IO_PGTABLE_QUIRK_NON_COHERENT, that lets us set different TCR
configurations.

This quirk enables the non-cacheable page tables for all masters
sitting on SMMU. Should this control be available per smmu_domain
as each master may have a different perf requirement?
Enabling this for the entire SMMU may not be desirable for all
masters.

[1] https://lore.kernel.org/patchwork/patch/1020906/

Vivek Gautam (2):
  iommu/io-pgtable-arm: Add support for non-coherent page tables
  iommu/arm-smmu: Add support for non-coherent page table mappings

 drivers/iommu/arm-smmu.c       |  7 +++++++
 drivers/iommu/io-pgtable-arm.c | 17 ++++++++++++-----
 drivers/iommu/io-pgtable.h     |  6 ++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
