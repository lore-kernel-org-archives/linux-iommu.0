From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 4/5] iommu/arm-smmu-v3: move arm_smmu_get_step_for_sid() a little ahead
Date: Tue, 19 Feb 2019 15:54:42 +0800
Message-ID: <20190219075443.17732-5-thunder.leizhen@huawei.com>
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

No functional change, just prepare for the next patch.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5bb5dcd..84adecc 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1273,6 +1273,28 @@ static int arm_smmu_init_dummy_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return __arm_smmu_init_l2_strtab(smmu, sid, &dummy_desc);
 }

+static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
+{
+	__le64 *step;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		struct arm_smmu_strtab_l1_desc *l1_desc;
+		int idx;
+
+		/* Two-level walk */
+		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
+		l1_desc = &cfg->l1_desc[idx];
+		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
+		step = &l1_desc->l2ptr[idx];
+	} else {
+		/* Simple linear lookup */
+		step = &cfg->strtab[sid * STRTAB_STE_DWORDS];
+	}
+
+	return step;
+}
+
 /* IRQ and event handlers */
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
@@ -1704,28 +1726,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	return 0;
 }

-static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
-{
-	__le64 *step;
-	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-
-	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-		struct arm_smmu_strtab_l1_desc *l1_desc;
-		int idx;
-
-		/* Two-level walk */
-		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
-		l1_desc = &cfg->l1_desc[idx];
-		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
-		step = &l1_desc->l2ptr[idx];
-	} else {
-		/* Simple linear lookup */
-		step = &cfg->strtab[sid * STRTAB_STE_DWORDS];
-	}
-
-	return step;
-}
-
 static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
 {
 	int i, j;
--
1.8.3
