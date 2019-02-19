From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 3/5] iommu/arm-smmu-v3: add macro xxx_SIZE to replace xxx_DWORDS shift
Date: Tue, 19 Feb 2019 15:54:41 +0800
Message-ID: <20190219075443.17732-4-thunder.leizhen@huawei.com>
References: <20190219075443.17732-1-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219075443.17732-1-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

The (STRTAB_L1_DESC_DWORDS << 3) appears more than 1 times, replace it
with STRTAB_L1_DESC_SIZE to eliminate the duplication. And the latter
seems more clear when it's used to calculate memory size. And the same is
true for STRTAB_STE_DWORDS and CTXDESC_CD_DWORDS.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c3c4ff2..5bb5dcd 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -202,10 +202,12 @@
 #define STRTAB_SPLIT			8

 #define STRTAB_L1_DESC_DWORDS		1
+#define STRTAB_L1_DESC_SIZE		(STRTAB_L1_DESC_DWORDS << 3)
 #define STRTAB_L1_DESC_SPAN		GENMASK_ULL(4, 0)
 #define STRTAB_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 6)

 #define STRTAB_STE_DWORDS		8
+#define STRTAB_STE_SIZE			(STRTAB_STE_DWORDS << 3)
 #define STRTAB_STE_0_V			(1UL << 0)
 #define STRTAB_STE_0_CFG		GENMASK_ULL(3, 1)
 #define STRTAB_STE_0_CFG_ABORT		0
@@ -251,6 +253,7 @@

 /* Context descriptor (stage-1 only) */
 #define CTXDESC_CD_DWORDS		8
+#define CTXDESC_CD_SIZE			(CTXDESC_CD_DWORDS << 3)
 #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
 #define ARM64_TCR_T0SZ			GENMASK_ULL(5, 0)
 #define CTXDESC_CD_0_TCR_TG0		GENMASK_ULL(7, 6)
@@ -1563,7 +1566,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)

 		if (cfg->cdptr) {
 			dmam_free_coherent(smmu_domain->smmu->dev,
-					   CTXDESC_CD_DWORDS << 3,
+					   CTXDESC_CD_SIZE,
 					   cfg->cdptr,
 					   cfg->cdptr_dma);

@@ -1590,7 +1593,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (asid < 0)
 		return asid;

-	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
+	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_SIZE,
 					 &cfg->cdptr_dma,
 					 GFP_KERNEL | __GFP_ZERO);
 	if (!cfg->cdptr) {
@@ -2176,7 +2179,7 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
 			arm_smmu_init_dummy_l2_strtab(smmu, i << STRTAB_SPLIT);
 		} else {
 			arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
-			strtab += STRTAB_L1_DESC_DWORDS << 3;
+			strtab += STRTAB_L1_DESC_SIZE;
 		}
 	}

@@ -2201,7 +2204,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 			 "2-level strtab only covers %u/%u bits of SID\n",
 			 size, smmu->sid_bits);

-	l1size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
+	l1size = cfg->num_l1_ents * STRTAB_L1_DESC_SIZE;
 	strtab = dmam_alloc_coherent(smmu->dev, l1size, &cfg->strtab_dma,
 				     GFP_KERNEL | __GFP_ZERO);
 	if (!strtab) {
@@ -2228,7 +2231,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	u32 size;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;

-	size = (1 << smmu->sid_bits) * (STRTAB_STE_DWORDS << 3);
+	size = (1 << smmu->sid_bits) * STRTAB_STE_SIZE;
 	strtab = dmam_alloc_coherent(smmu->dev, size, &cfg->strtab_dma,
 				     GFP_KERNEL | __GFP_ZERO);
 	if (!strtab) {
--
1.8.3
