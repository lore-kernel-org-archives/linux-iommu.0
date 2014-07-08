From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu: fix some checkpatch issues
Date: Mon,  7 Jul 2014 17:45:24 -0700
Message-ID: <1404780324-21847-1-git-send-email-mitchelh@codeaurora.org>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Fix some issues reported by checkpatch.pl. Mostly whitespace, but also
includes min=>min_t, kzalloc=>kcalloc, and kmalloc=>kmalloc_array.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 59 ++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1599354e97..e59517c3b7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -316,9 +316,9 @@
 #define FSR_AFF				(1 << 2)
 #define FSR_TF				(1 << 1)
 
-#define FSR_IGN				(FSR_AFF | FSR_ASF | FSR_TLBMCF |	\
+#define FSR_IGN				(FSR_AFF | FSR_ASF | FSR_TLBMCF | \
 					 FSR_TLBLKF)
-#define FSR_FAULT			(FSR_MULTI | FSR_SS | FSR_UUT |		\
+#define FSR_FAULT			(FSR_MULTI | FSR_SS | FSR_UUT | \
 					 FSR_EF | FSR_PF | FSR_TF | FSR_IGN)
 
 #define FSYNR0_WNR			(1 << 4)
@@ -419,7 +419,7 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
-static struct arm_smmu_option_prop arm_smmu_options [] = {
+static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
 	{ 0, NULL},
 };
@@ -427,6 +427,7 @@ static struct arm_smmu_option_prop arm_smmu_options [] = {
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
+
 	do {
 		if (of_property_read_bool(smmu->dev->of_node,
 						arm_smmu_options[i].prop)) {
@@ -443,8 +444,8 @@ static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 	struct rb_node *node = smmu->masters.rb_node;
 
 	while (node) {
-		struct arm_smmu_master *master;
-		master = container_of(node, struct arm_smmu_master, node);
+		struct arm_smmu_master *master
+			= container_of(node, struct arm_smmu_master, node);
 
 		if (dev_node < master->of_node)
 			node = node->rb_left;
@@ -465,8 +466,8 @@ static int insert_smmu_master(struct arm_smmu_device *smmu,
 	new = &smmu->masters.rb_node;
 	parent = NULL;
 	while (*new) {
-		struct arm_smmu_master *this;
-		this = container_of(*new, struct arm_smmu_master, node);
+		struct arm_smmu_master *this
+			= container_of(*new, struct arm_smmu_master, node);
 
 		parent = *new;
 		if (master->of_node < this->of_node)
@@ -708,7 +709,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	/* CBAR */
 	reg = root_cfg->cbar;
 	if (smmu->version == 1)
-	      reg |= root_cfg->irptndx << CBAR_IRPTNDX_SHIFT;
+		reg |= root_cfg->irptndx << CBAR_IRPTNDX_SHIFT;
 
 	/*
 	 * Use the weakest shareability/memory types, so they are
@@ -963,7 +964,7 @@ static int arm_smmu_domain_init(struct iommu_domain *domain)
 	if (!smmu_domain)
 		return -ENOMEM;
 
-	pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
+	pgd = kcalloc(PTRS_PER_PGD, sizeof(pgd_t), GFP_KERNEL);
 	if (!pgd)
 		goto out_free_domain;
 	smmu_domain->root_cfg.pgd = pgd;
@@ -980,6 +981,7 @@ out_free_domain:
 static void arm_smmu_free_ptes(pmd_t *pmd)
 {
 	pgtable_t table = pmd_pgtable(*pmd);
+
 	pgtable_page_dtor(table);
 	__free_page(table);
 }
@@ -1066,7 +1068,7 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 	if (master->smrs)
 		return -EEXIST;
 
-	smrs = kmalloc(sizeof(*smrs) * master->num_streamids, GFP_KERNEL);
+	smrs = kmalloc_array(master->num_streamids, sizeof(*smrs), GFP_KERNEL);
 	if (!smrs) {
 		dev_err(smmu->dev, "failed to allocate %d SMRs for master %s\n",
 			master->num_streamids, master->of_node->name);
@@ -1116,6 +1118,7 @@ static void arm_smmu_master_free_smrs(struct arm_smmu_device *smmu,
 	/* Invalidate the SMRs before freeing back to the allocator */
 	for (i = 0; i < master->num_streamids; ++i) {
 		u8 idx = smrs[i].idx;
+
 		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(idx));
 		__arm_smmu_free_bitmap(smmu->smr_map, idx);
 	}
@@ -1132,6 +1135,7 @@ static void arm_smmu_bypass_stream_mapping(struct arm_smmu_device *smmu,
 
 	for (i = 0; i < master->num_streamids; ++i) {
 		u16 sid = master->streamids[i];
+
 		writel_relaxed(S2CR_TYPE_BYPASS,
 			       gr0_base + ARM_SMMU_GR0_S2CR(sid));
 	}
@@ -1166,6 +1170,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	/* Now we're at the root, time to point at our context bank */
 	for (i = 0; i < master->num_streamids; ++i) {
 		u32 idx, s2cr;
+
 		idx = master->smrs ? master->smrs[i].idx : master->streamids[i];
 		s2cr = S2CR_TYPE_TRANS |
 		       (smmu_domain->root_cfg.cbndx << S2CR_CBNDX_SHIFT);
@@ -1261,6 +1266,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 	if (pmd_none(*pmd)) {
 		/* Allocate a new set of tables */
 		pgtable_t table = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+
 		if (!table)
 			return -ENOMEM;
 
@@ -1326,6 +1332,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 	 */
 	do {
 		int i = 1;
+
 		pteval &= ~ARM_SMMU_PTE_CONT;
 
 		if (arm_smmu_pte_is_contiguous_range(addr, end)) {
@@ -1340,7 +1347,8 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 			idx &= ~(ARM_SMMU_PTE_CONT_ENTRIES - 1);
 			cont_start = pmd_page_vaddr(*pmd) + idx;
 			for (j = 0; j < ARM_SMMU_PTE_CONT_ENTRIES; ++j)
-				pte_val(*(cont_start + j)) &= ~ARM_SMMU_PTE_CONT;
+				pte_val(*(cont_start + j))
+					&= ~ARM_SMMU_PTE_CONT;
 
 			arm_smmu_flush_pgtable(smmu, cont_start,
 					       sizeof(*pte) *
@@ -1639,7 +1647,8 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Mark all SMRn as invalid and all S2CRn as bypass */
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
 		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(i));
-		writel_relaxed(S2CR_TYPE_BYPASS, gr0_base + ARM_SMMU_GR0_S2CR(i));
+		writel_relaxed(S2CR_TYPE_BYPASS,
+			gr0_base + ARM_SMMU_GR0_S2CR(i));
 	}
 
 	/* Make sure all context banks are disabled and clear CB_FSR  */
@@ -1779,11 +1788,13 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	smmu->pagesize = (id & ID1_PAGESIZE) ? SZ_64K : SZ_4K;
 
 	/* Check for size mismatch of SMMU address space from mapped region */
-	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
+	size = 1 <<
+		(((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
 	size *= (smmu->pagesize << 1);
 	if (smmu->size != size)
-		dev_warn(smmu->dev, "SMMU address space size (0x%lx) differs "
-			"from mapped region size (0x%lx)!\n", size, smmu->size);
+		dev_warn(smmu->dev,
+			"SMMU address space size (0x%lx) differs from mapped region size (0x%lx)!\n",
+			size, smmu->size);
 
 	smmu->num_s2_context_banks = (id >> ID1_NUMS2CB_SHIFT) &
 				      ID1_NUMS2CB_MASK;
@@ -1804,14 +1815,14 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	 * allocation (PTRS_PER_PGD).
 	 */
 #ifdef CONFIG_64BIT
-	smmu->s1_output_size = min((unsigned long)VA_BITS, size);
+	smmu->s1_output_size = min_t(unsigned long, VA_BITS, size);
 #else
 	smmu->s1_output_size = min(32UL, size);
 #endif
 
 	/* The stage-2 output mask is also applied for bypass */
 	size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
-	smmu->s2_output_size = min((unsigned long)PHYS_MASK_SHIFT, size);
+	smmu->s2_output_size = min_t(unsigned long, PHYS_MASK_SHIFT, size);
 
 	if (smmu->version == 1) {
 		smmu->input_size = 32;
@@ -1835,7 +1846,8 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 	dev_notice(smmu->dev,
 		   "\t%lu-bit VA, %lu-bit IPA, %lu-bit PA\n",
-		   smmu->input_size, smmu->s1_output_size, smmu->s2_output_size);
+		   smmu->input_size, smmu->s1_output_size,
+		   smmu->s2_output_size);
 	return 0;
 }
 
@@ -1890,6 +1902,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 
 	for (i = 0; i < num_irqs; ++i) {
 		int irq = platform_get_irq(pdev, i);
+
 		if (irq < 0) {
 			dev_err(dev, "failed to get irq index %d\n", i);
 			return -ENODEV;
@@ -1913,7 +1926,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	dev_notice(dev, "registered %d master devices\n", i);
 
-	if ((dev_node = of_parse_phandle(dev->of_node, "smmu-parent", 0)))
+	dev_node = of_parse_phandle(dev->of_node, "smmu-parent", 0);
+	if (dev_node)
 		smmu->parent_of_node = dev_node;
 
 	err = arm_smmu_device_cfg_probe(smmu);
@@ -1962,8 +1976,8 @@ out_put_parent:
 
 out_put_masters:
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
-		struct arm_smmu_master *master;
-		master = container_of(node, struct arm_smmu_master, node);
+		struct arm_smmu_master *master
+			= container_of(node, struct arm_smmu_master, node);
 		of_node_put(master->of_node);
 	}
 
@@ -1995,6 +2009,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
 		struct arm_smmu_master *master;
+
 		master = container_of(node, struct arm_smmu_master, node);
 		of_node_put(master->of_node);
 	}
@@ -2006,7 +2021,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		free_irq(smmu->irqs[i], smmu);
 
 	/* Turn the thing off */
-	writel(sCR0_CLIENTPD,ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
