From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v2] iommu/arm-smmu: fix some checkpatch issues
Date: Tue,  8 Jul 2014 09:52:18 -0700
Message-ID: <1404838338-19295-1-git-send-email-mitchelh@codeaurora.org>
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

The checkpatch errors being fixed are:

    arm-smmu.c:320: WARNING: line over 80 characters
    #320: FILE: arm-smmu.c:320:
    +#define FSR_IGN                                (FSR_AFF | FSR_ASF | FSR_TLBMCF |       \
    
    arm-smmu.c:322: WARNING: line over 80 characters
    #322: FILE: arm-smmu.c:322:
    +#define FSR_FAULT                      (FSR_MULTI | FSR_SS | FSR_UUT |         \
    
    arm-smmu.c:408: ERROR: space prohibited before open square bracket '['
    #408: FILE: arm-smmu.c:408:
    +static struct arm_smmu_option_prop arm_smmu_options [] = {
    
    arm-smmu.c:416: WARNING: Missing a blank line after declarations
    #416: FILE: arm-smmu.c:416:
    +       int i = 0;
    +       do {
    
    arm-smmu.c:430: WARNING: Missing a blank line after declarations
    #430: FILE: arm-smmu.c:430:
    +               struct pci_bus *bus = to_pci_dev(dev)->bus;
    +               while (!pci_is_root_bus(bus))
    
    arm-smmu.c:445: WARNING: Missing a blank line after declarations
    #445: FILE: arm-smmu.c:445:
    +               struct arm_smmu_master *master;
    +               master = container_of(node, struct arm_smmu_master, node);
    
    arm-smmu.c:479: WARNING: Missing a blank line after declarations
    #479: FILE: arm-smmu.c:479:
    +               struct arm_smmu_master *this;
    +               this = container_of(*new, struct arm_smmu_master, node);
    
    arm-smmu.c:718: WARNING: suspect code indent for conditional statements (8, 14)
    #718: FILE: arm-smmu.c:718:
    +       if (smmu->version == 1)
    +             reg |= cfg->irptndx << CBAR_IRPTNDX_SHIFT;
    
    arm-smmu.c:850: WARNING: line over 80 characters
    #850: FILE: arm-smmu.c:850:
    +                     (MAIR_ATTR_WBRWA << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_CACHE)) |
    
    arm-smmu.c:957: WARNING: Prefer kcalloc over kzalloc with multiply
    #957: FILE: arm-smmu.c:957:
    +       pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
    
    arm-smmu.c:974: WARNING: Missing a blank line after declarations
    #974: FILE: arm-smmu.c:974:
    +       pgtable_t table = pmd_pgtable(*pmd);
    +       pgtable_page_dtor(table);
    
    arm-smmu.c:1060: WARNING: Prefer kmalloc_array over kmalloc with multiply
    #1060: FILE: arm-smmu.c:1060:
    +       smrs = kmalloc(sizeof(*smrs) * cfg->num_streamids, GFP_KERNEL);
    
    arm-smmu.c:1110: WARNING: Missing a blank line after declarations
    #1110: FILE: arm-smmu.c:1110:
    +               u8 idx = smrs[i].idx;
    +               writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(idx));
    
    arm-smmu.c:1126: WARNING: Missing a blank line after declarations
    #1126: FILE: arm-smmu.c:1126:
    +               u16 sid = cfg->streamids[i];
    +               writel_relaxed(S2CR_TYPE_BYPASS,
    
    arm-smmu.c:1144: WARNING: Missing a blank line after declarations
    #1144: FILE: arm-smmu.c:1144:
    +               u32 idx, s2cr;
    +               idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
    
    arm-smmu.c:1238: WARNING: Missing a blank line after declarations
    #1238: FILE: arm-smmu.c:1238:
    +               pgtable_t table = alloc_page(GFP_ATOMIC|__GFP_ZERO);
    +               if (!table)
    
    arm-smmu.c:1303: WARNING: Missing a blank line after declarations
    #1303: FILE: arm-smmu.c:1303:
    +               int i = 1;
    +               pteval &= ~ARM_SMMU_PTE_CONT;
    
    arm-smmu.c:1317: WARNING: line over 80 characters
    #1317: FILE: arm-smmu.c:1317:
    +                               pte_val(*(cont_start + j)) &= ~ARM_SMMU_PTE_CONT;
    
    arm-smmu.c:1620: WARNING: line over 80 characters
    #1620: FILE: arm-smmu.c:1620:
    +               writel_relaxed(S2CR_TYPE_BYPASS, gr0_base + ARM_SMMU_GR0_S2CR(i));
    
    arm-smmu.c:1760: WARNING: line over 80 characters
    #1760: FILE: arm-smmu.c:1760:
    +       size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
    
    arm-smmu.c:1764: WARNING: quoted string split across lines
    #1764: FILE: arm-smmu.c:1764:
    +               dev_warn(smmu->dev, "SMMU address space size (0x%lx) differs "
    +                       "from mapped region size (0x%lx)!\n", size, smmu->size);
    
    arm-smmu.c:1785: WARNING: min() should probably be min_t(unsigned long, VA_BITS, size)
    #1785: FILE: arm-smmu.c:1785:
    +       smmu->s1_output_size = min((unsigned long)VA_BITS, size);
    
    arm-smmu.c:1792: WARNING: min() should probably be min_t(unsigned long, PHYS_MASK_SHIFT, size)
    #1792: FILE: arm-smmu.c:1792:
    +       smmu->s2_output_size = min((unsigned long)PHYS_MASK_SHIFT, size);
    
    arm-smmu.c:1816: WARNING: line over 80 characters
    #1816: FILE: arm-smmu.c:1816:
    +                  smmu->input_size, smmu->s1_output_size, smmu->s2_output_size);
    
    arm-smmu.c:1870: WARNING: Missing a blank line after declarations
    #1870: FILE: arm-smmu.c:1870:
    +               int irq = platform_get_irq(pdev, i);
    +               if (irq < 0) {
    
    arm-smmu.c:1936: WARNING: Missing a blank line after declarations
    #1936: FILE: arm-smmu.c:1936:
    +               struct arm_smmu_master *master;
    +               master = container_of(node, struct arm_smmu_master, node);
    
    arm-smmu.c:1965: WARNING: Missing a blank line after declarations
    #1965: FILE: arm-smmu.c:1965:
    +               struct arm_smmu_master *master;
    +               master = container_of(node, struct arm_smmu_master, node);
    
    arm-smmu.c:1976: ERROR: space required after that ',' (ctx:VxV)
    #1976: FILE: arm-smmu.c:1976:
    +       writel(sCR0_CLIENTPD,ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
                                ^
    
    total: 2 errors, 26 warnings, 2036 lines checked
    
    arm-smmu.c has style problems, please review.
    
    If any of these errors are false positives, please report
    them to the maintainer, see CHECKPATCH in MAINTAINERS.


The only one I'm leaving alone is:

    arm-smmu.c:853: WARNING: line over 80 characters
    #853: FILE: arm-smmu.c:853:
    +                     (MAIR_ATTR_WBRWA << MAIR_ATTR_SHIFT(MAIR_ATTR_IDX_CACHE)) |

since it seems to be a case where "exceeding 80 columns significantly
increases readability and does not hide information."
(Documentation/CodingStyle).

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
Changelog:

  - v2: submitted against will/iommu/staging, added to commit message.
---
 drivers/iommu/arm-smmu.c | 59 ++++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5496de58fc..f3f66416e2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -317,9 +317,9 @@
 #define FSR_AFF				(1 << 2)
 #define FSR_TF				(1 << 1)
 
-#define FSR_IGN				(FSR_AFF | FSR_ASF | FSR_TLBMCF |	\
-					 FSR_TLBLKF)
-#define FSR_FAULT			(FSR_MULTI | FSR_SS | FSR_UUT |		\
+#define FSR_IGN				(FSR_AFF | FSR_ASF | \
+					 FSR_TLBMCF | FSR_TLBLKF)
+#define FSR_FAULT			(FSR_MULTI | FSR_SS | FSR_UUT | \
 					 FSR_EF | FSR_PF | FSR_TF | FSR_IGN)
 
 #define FSYNR0_WNR			(1 << 4)
@@ -405,7 +405,7 @@ struct arm_smmu_option_prop {
 	const char *prop;
 };
 
-static struct arm_smmu_option_prop arm_smmu_options [] = {
+static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
 	{ 0, NULL},
 };
@@ -413,6 +413,7 @@ static struct arm_smmu_option_prop arm_smmu_options [] = {
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
+
 	do {
 		if (of_property_read_bool(smmu->dev->of_node,
 						arm_smmu_options[i].prop)) {
@@ -427,6 +428,7 @@ static struct device *dev_get_master_dev(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
 		struct pci_bus *bus = to_pci_dev(dev)->bus;
+
 		while (!pci_is_root_bus(bus))
 			bus = bus->parent;
 		return bus->bridge->parent;
@@ -442,6 +444,7 @@ static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 
 	while (node) {
 		struct arm_smmu_master *master;
+
 		master = container_of(node, struct arm_smmu_master, node);
 
 		if (dev_node < master->of_node)
@@ -475,8 +478,8 @@ static int insert_smmu_master(struct arm_smmu_device *smmu,
 	new = &smmu->masters.rb_node;
 	parent = NULL;
 	while (*new) {
-		struct arm_smmu_master *this;
-		this = container_of(*new, struct arm_smmu_master, node);
+		struct arm_smmu_master *this
+			= container_of(*new, struct arm_smmu_master, node);
 
 		parent = *new;
 		if (master->of_node < this->of_node)
@@ -716,7 +719,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	/* CBAR */
 	reg = cfg->cbar;
 	if (smmu->version == 1)
-	      reg |= cfg->irptndx << CBAR_IRPTNDX_SHIFT;
+		reg |= cfg->irptndx << CBAR_IRPTNDX_SHIFT;
 
 	/*
 	 * Use the weakest shareability/memory types, so they are
@@ -954,7 +957,7 @@ static int arm_smmu_domain_init(struct iommu_domain *domain)
 	if (!smmu_domain)
 		return -ENOMEM;
 
-	pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
+	pgd = kcalloc(PTRS_PER_PGD, sizeof(pgd_t), GFP_KERNEL);
 	if (!pgd)
 		goto out_free_domain;
 	smmu_domain->cfg.pgd = pgd;
@@ -971,6 +974,7 @@ out_free_domain:
 static void arm_smmu_free_ptes(pmd_t *pmd)
 {
 	pgtable_t table = pmd_pgtable(*pmd);
+
 	pgtable_page_dtor(table);
 	__free_page(table);
 }
@@ -1057,7 +1061,7 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 	if (cfg->smrs)
 		return -EEXIST;
 
-	smrs = kmalloc(sizeof(*smrs) * cfg->num_streamids, GFP_KERNEL);
+	smrs = kmalloc_array(cfg->num_streamids, sizeof(*smrs), GFP_KERNEL);
 	if (!smrs) {
 		dev_err(smmu->dev, "failed to allocate %d SMRs\n",
 			cfg->num_streamids);
@@ -1107,6 +1111,7 @@ static void arm_smmu_master_free_smrs(struct arm_smmu_device *smmu,
 	/* Invalidate the SMRs before freeing back to the allocator */
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		u8 idx = smrs[i].idx;
+
 		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(idx));
 		__arm_smmu_free_bitmap(smmu->smr_map, idx);
 	}
@@ -1123,6 +1128,7 @@ static void arm_smmu_bypass_stream_mapping(struct arm_smmu_device *smmu,
 
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		u16 sid = cfg->streamids[i];
+
 		writel_relaxed(S2CR_TYPE_BYPASS,
 			       gr0_base + ARM_SMMU_GR0_S2CR(sid));
 	}
@@ -1141,6 +1147,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		u32 idx, s2cr;
+
 		idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
 		s2cr = S2CR_TYPE_TRANS |
 		       (smmu_domain->cfg.cbndx << S2CR_CBNDX_SHIFT);
@@ -1235,6 +1242,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 	if (pmd_none(*pmd)) {
 		/* Allocate a new set of tables */
 		pgtable_t table = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+
 		if (!table)
 			return -ENOMEM;
 
@@ -1300,6 +1308,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 	 */
 	do {
 		int i = 1;
+
 		pteval &= ~ARM_SMMU_PTE_CONT;
 
 		if (arm_smmu_pte_is_contiguous_range(addr, end)) {
@@ -1314,7 +1323,8 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 			idx &= ~(ARM_SMMU_PTE_CONT_ENTRIES - 1);
 			cont_start = pmd_page_vaddr(*pmd) + idx;
 			for (j = 0; j < ARM_SMMU_PTE_CONT_ENTRIES; ++j)
-				pte_val(*(cont_start + j)) &= ~ARM_SMMU_PTE_CONT;
+				pte_val(*(cont_start + j)) &=
+					~ARM_SMMU_PTE_CONT;
 
 			arm_smmu_flush_pgtable(smmu, cont_start,
 					       sizeof(*pte) *
@@ -1617,7 +1627,8 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Mark all SMRn as invalid and all S2CRn as bypass */
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
 		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(i));
-		writel_relaxed(S2CR_TYPE_BYPASS, gr0_base + ARM_SMMU_GR0_S2CR(i));
+		writel_relaxed(S2CR_TYPE_BYPASS,
+			gr0_base + ARM_SMMU_GR0_S2CR(i));
 	}
 
 	/* Make sure all context banks are disabled and clear CB_FSR  */
@@ -1757,11 +1768,13 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
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
@@ -1782,14 +1795,14 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
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
@@ -1813,7 +1826,8 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 	dev_notice(smmu->dev,
 		   "\t%lu-bit VA, %lu-bit IPA, %lu-bit PA\n",
-		   smmu->input_size, smmu->s1_output_size, smmu->s2_output_size);
+		   smmu->input_size, smmu->s1_output_size,
+		   smmu->s2_output_size);
 	return 0;
 }
 
@@ -1867,6 +1881,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 
 	for (i = 0; i < num_irqs; ++i) {
 		int irq = platform_get_irq(pdev, i);
+
 		if (irq < 0) {
 			dev_err(dev, "failed to get irq index %d\n", i);
 			return -ENODEV;
@@ -1932,8 +1947,8 @@ out_free_irqs:
 
 out_put_masters:
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
-		struct arm_smmu_master *master;
-		master = container_of(node, struct arm_smmu_master, node);
+		struct arm_smmu_master *master
+			= container_of(node, struct arm_smmu_master, node);
 		of_node_put(master->of_node);
 	}
 
@@ -1961,8 +1976,8 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		return -ENODEV;
 
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
-		struct arm_smmu_master *master;
-		master = container_of(node, struct arm_smmu_master, node);
+		struct arm_smmu_master *master
+			= container_of(node, struct arm_smmu_master, node);
 		of_node_put(master->of_node);
 	}
 
@@ -1973,7 +1988,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		free_irq(smmu->irqs[i], smmu);
 
 	/* Turn the thing off */
-	writel(sCR0_CLIENTPD,ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
