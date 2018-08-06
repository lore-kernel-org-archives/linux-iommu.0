From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 4/5] iommu/arm-smmu-v3: add support for non-strict mode
Date: Mon, 6 Aug 2018 20:27:03 +0800
Message-ID: <1533558424-16748-5-git-send-email-thunder.leizhen@huawei.com>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Dynamically choose strict or non-strict mode for page table config based
on the iommu domain type.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2f1304b..904bc1e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1622,6 +1622,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
 		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;

+	if (domain->type == IOMMU_DOMAIN_DMA) {
+		domain->non_strict = 1;
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+	}
+
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
 		return -ENOMEM;
@@ -1782,7 +1787,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
 {
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;

-	if (smmu)
+	if (smmu && !domain->non_strict)
 		__arm_smmu_tlb_sync(smmu);
 }

--
1.8.3
