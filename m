From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 02/13] iommu/arm-smmu: Convert DMA buffer allocations to the
	managed API
Date: Thu, 17 Dec 2015 12:12:02 +0000
Message-ID: <1450354333-27256-3-git-send-email-will.deacon@arm.com>
References: <1450354333-27256-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450354333-27256-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, zhangbo_a-95E7rUnPDLLQT0dZR+AlfA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The ARM SMMUv3 driver uses dma_{alloc,free}_coherent to manage its
queues and configuration data structures.

This patch converts the driver to the managed (dmam_*) API, so that
resources are freed automatically on device teardown. This greatly
simplifies the failure paths and allows us to remove a bunch of
handcrafted freeing code.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 132 +++++++-------------------------------------
 1 file changed, 21 insertions(+), 111 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e0032c098b32..86480480895d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1122,8 +1122,8 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	strtab = &cfg->strtab[(sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS];
 
 	desc->span = STRTAB_SPLIT + 1;
-	desc->l2ptr = dma_zalloc_coherent(smmu->dev, size, &desc->l2ptr_dma,
-					  GFP_KERNEL);
+	desc->l2ptr = dmam_alloc_coherent(smmu->dev, size, &desc->l2ptr_dma,
+					  GFP_KERNEL | __GFP_ZERO);
 	if (!desc->l2ptr) {
 		dev_err(smmu->dev,
 			"failed to allocate l2 stream table for SID %u\n",
@@ -1428,10 +1428,10 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
 		if (cfg->cdptr) {
-			dma_free_coherent(smmu_domain->smmu->dev,
-					  CTXDESC_CD_DWORDS << 3,
-					  cfg->cdptr,
-					  cfg->cdptr_dma);
+			dmam_free_coherent(smmu_domain->smmu->dev,
+					   CTXDESC_CD_DWORDS << 3,
+					   cfg->cdptr,
+					   cfg->cdptr_dma);
 
 			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
 		}
@@ -1456,8 +1456,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (IS_ERR_VALUE(asid))
 		return asid;
 
-	cfg->cdptr = dma_zalloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
-					 &cfg->cdptr_dma, GFP_KERNEL);
+	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
+					 &cfg->cdptr_dma,
+					 GFP_KERNEL | __GFP_ZERO);
 	if (!cfg->cdptr) {
 		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
 		ret = -ENOMEM;
@@ -1936,7 +1937,7 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 {
 	size_t qsz = ((1 << q->max_n_shift) * dwords) << 3;
 
-	q->base = dma_alloc_coherent(smmu->dev, qsz, &q->base_dma, GFP_KERNEL);
+	q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma, GFP_KERNEL);
 	if (!q->base) {
 		dev_err(smmu->dev, "failed to allocate queue (0x%zx bytes)\n",
 			qsz);
@@ -1956,23 +1957,6 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static void arm_smmu_free_one_queue(struct arm_smmu_device *smmu,
-				    struct arm_smmu_queue *q)
-{
-	size_t qsz = ((1 << q->max_n_shift) * q->ent_dwords) << 3;
-
-	dma_free_coherent(smmu->dev, qsz, q->base, q->base_dma);
-}
-
-static void arm_smmu_free_queues(struct arm_smmu_device *smmu)
-{
-	arm_smmu_free_one_queue(smmu, &smmu->cmdq.q);
-	arm_smmu_free_one_queue(smmu, &smmu->evtq.q);
-
-	if (smmu->features & ARM_SMMU_FEAT_PRI)
-		arm_smmu_free_one_queue(smmu, &smmu->priq.q);
-}
-
 static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -1982,49 +1966,20 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
 				      ARM_SMMU_CMDQ_CONS, CMDQ_ENT_DWORDS);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* evtq */
 	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_PROD,
 				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS);
 	if (ret)
-		goto out_free_cmdq;
+		return ret;
 
 	/* priq */
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
 
-	ret = arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
-				      ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS);
-	if (ret)
-		goto out_free_evtq;
-
-	return 0;
-
-out_free_evtq:
-	arm_smmu_free_one_queue(smmu, &smmu->evtq.q);
-out_free_cmdq:
-	arm_smmu_free_one_queue(smmu, &smmu->cmdq.q);
-out:
-	return ret;
-}
-
-static void arm_smmu_free_l2_strtab(struct arm_smmu_device *smmu)
-{
-	int i;
-	size_t size;
-	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-
-	size = 1 << (STRTAB_SPLIT + ilog2(STRTAB_STE_DWORDS) + 3);
-	for (i = 0; i < cfg->num_l1_ents; ++i) {
-		struct arm_smmu_strtab_l1_desc *desc = &cfg->l1_desc[i];
-
-		if (!desc->l2ptr)
-			continue;
-
-		dma_free_coherent(smmu->dev, size, desc->l2ptr,
-				  desc->l2ptr_dma);
-	}
+	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
+				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS);
 }
 
 static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
@@ -2053,7 +2008,6 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 	void *strtab;
 	u64 reg;
 	u32 size, l1size;
-	int ret;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 
 	/*
@@ -2076,8 +2030,8 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 			 size, smmu->sid_bits);
 
 	l1size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
-	strtab = dma_zalloc_coherent(smmu->dev, l1size, &cfg->strtab_dma,
-				     GFP_KERNEL);
+	strtab = dmam_alloc_coherent(smmu->dev, l1size, &cfg->strtab_dma,
+				     GFP_KERNEL | __GFP_ZERO);
 	if (!strtab) {
 		dev_err(smmu->dev,
 			"failed to allocate l1 stream table (%u bytes)\n",
@@ -2094,13 +2048,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 		<< STRTAB_BASE_CFG_SPLIT_SHIFT;
 	cfg->strtab_base_cfg = reg;
 
-	ret = arm_smmu_init_l1_strtab(smmu);
-	if (ret)
-		dma_free_coherent(smmu->dev,
-				  l1size,
-				  strtab,
-				  cfg->strtab_dma);
-	return ret;
+	return arm_smmu_init_l1_strtab(smmu);
 }
 
 static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
@@ -2111,8 +2059,8 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 
 	size = (1 << smmu->sid_bits) * (STRTAB_STE_DWORDS << 3);
-	strtab = dma_zalloc_coherent(smmu->dev, size, &cfg->strtab_dma,
-				     GFP_KERNEL);
+	strtab = dmam_alloc_coherent(smmu->dev, size, &cfg->strtab_dma,
+				     GFP_KERNEL | __GFP_ZERO);
 	if (!strtab) {
 		dev_err(smmu->dev,
 			"failed to allocate linear stream table (%u bytes)\n",
@@ -2156,21 +2104,6 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-static void arm_smmu_free_strtab(struct arm_smmu_device *smmu)
-{
-	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-	u32 size = cfg->num_l1_ents;
-
-	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-		arm_smmu_free_l2_strtab(smmu);
-		size *= STRTAB_L1_DESC_DWORDS << 3;
-	} else {
-		size *= STRTAB_STE_DWORDS * 3;
-	}
-
-	dma_free_coherent(smmu->dev, size, cfg->strtab, cfg->strtab_dma);
-}
-
 static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -2179,21 +2112,7 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_init_strtab(smmu);
-	if (ret)
-		goto out_free_queues;
-
-	return 0;
-
-out_free_queues:
-	arm_smmu_free_queues(smmu);
-	return ret;
-}
-
-static void arm_smmu_free_structures(struct arm_smmu_device *smmu)
-{
-	arm_smmu_free_strtab(smmu);
-	arm_smmu_free_queues(smmu);
+	return arm_smmu_init_strtab(smmu);
 }
 
 static int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
@@ -2698,15 +2617,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, smmu);
 
 	/* Reset the device */
-	ret = arm_smmu_device_reset(smmu);
-	if (ret)
-		goto out_free_structures;
-
-	return 0;
-
-out_free_structures:
-	arm_smmu_free_structures(smmu);
-	return ret;
+	return arm_smmu_device_reset(smmu);
 }
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
@@ -2714,7 +2625,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
 	arm_smmu_device_disable(smmu);
-	arm_smmu_free_structures(smmu);
 	return 0;
 }
 
-- 
2.1.4
