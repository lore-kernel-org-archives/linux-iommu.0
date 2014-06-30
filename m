From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 4/5] iommu/arm-smmu: remove support for chained SMMUs
Date: Mon, 30 Jun 2014 11:52:09 +0100
Message-ID: <1404125530-17984-5-git-send-email-will.deacon@arm.com>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404125530-17984-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The ARM SMMU driver has supported chained SMMUs (i.e. SMMUs connected
back-to-back in series) via the smmu-parent property in device tree.
This was in anticipation of somebody building such a configuration,
however that seems not to be the case.

This patch removes the unused chained SMMU hack from the driver. We can
consider adding it back later if somebody decided they need it, but for
the time being it's just pointless mess that we're carrying in mainline.

Removal of the feature also makes migration to the generic IOMMU bindings
easier.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         |   6 -
 drivers/iommu/arm-smmu.c                           | 263 ++++++---------------
 2 files changed, 77 insertions(+), 192 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index f284b99402bc..2d0f7cd867ea 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -42,12 +42,6 @@ conditions.
 
 ** System MMU optional properties:
 
-- smmu-parent   : When multiple SMMUs are chained together, this
-                  property can be used to provide a phandle to the
-                  parent SMMU (that is the next SMMU on the path going
-                  from the mmu-masters towards memory) node for this
-                  SMMU.
-
 - calxeda,smmu-secure-config-access : Enable proper handling of buggy
                   implementations that always use secure access to
                   SMMU configuration registers. In this case non-secure
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 835d01f47302..60986de3ada8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -333,28 +333,17 @@ struct arm_smmu_smr {
 struct arm_smmu_master_cfg {
 	int				num_streamids;
 	u16				streamids[MAX_MASTER_STREAMIDS];
-
-	/*
-	 * We only need to allocate these on the root SMMU, as we
-	 * configure unmatched streams to bypass translation.
-	 */
 	struct arm_smmu_smr		*smrs;
 };
 
 struct arm_smmu_master {
 	struct device_node		*of_node;
-
-	/*
-	 * The following is specific to the master's position in the
-	 * SMMU chain.
-	 */
 	struct rb_node			node;
 	struct arm_smmu_master_cfg	cfg;
 };
 
 struct arm_smmu_device {
 	struct device			*dev;
-	struct device_node		*parent_of_node;
 
 	void __iomem			*base;
 	unsigned long			size;
@@ -392,7 +381,6 @@ struct arm_smmu_device {
 };
 
 struct arm_smmu_cfg {
-	struct arm_smmu_device		*smmu;
 	u8				cbndx;
 	u8				irptndx;
 	u32				cbar;
@@ -404,15 +392,8 @@ struct arm_smmu_cfg {
 #define ARM_SMMU_CB_VMID(cfg)		((cfg)->cbndx + 1)
 
 struct arm_smmu_domain {
-	/*
-	 * A domain can span across multiple, chained SMMUs and requires
-	 * all devices within the domain to follow the same translation
-	 * path.
-	 */
-	struct arm_smmu_device		*leaf_smmu;
-	struct arm_smmu_cfg		root_cfg;
-	phys_addr_t			output_mask;
-
+	struct arm_smmu_device		*smmu;
+	struct arm_smmu_cfg		cfg;
 	spinlock_t			lock;
 };
 
@@ -546,59 +527,20 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 	return insert_smmu_master(smmu, master);
 }
 
-static struct arm_smmu_device *find_parent_smmu(struct arm_smmu_device *smmu)
+static struct arm_smmu_device *find_smmu_for_device(struct device *dev)
 {
-	struct arm_smmu_device *parent;
-
-	if (!smmu->parent_of_node)
-		return NULL;
-
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(parent, &arm_smmu_devices, list)
-		if (parent->dev->of_node == smmu->parent_of_node)
-			goto out_unlock;
-
-	parent = NULL;
-	dev_warn(smmu->dev,
-		 "Failed to find SMMU parent despite parent in DT\n");
-out_unlock:
-	spin_unlock(&arm_smmu_devices_lock);
-	return parent;
-}
-
-static struct arm_smmu_device *find_parent_smmu_for_device(struct device *dev)
-{
-	struct arm_smmu_device *child, *parent, *smmu;
+	struct arm_smmu_device *smmu;
 	struct arm_smmu_master *master = NULL;
 	struct device_node *dev_node = dev_get_master_dev(dev)->of_node;
 
 	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(parent, &arm_smmu_devices, list) {
-		smmu = parent;
-
-		/* Try to find a child of the current SMMU. */
-		list_for_each_entry(child, &arm_smmu_devices, list) {
-			if (child->parent_of_node == parent->dev->of_node) {
-				/* Does the child sit above our master? */
-				master = find_smmu_master(child, dev_node);
-				if (master) {
-					smmu = NULL;
-					break;
-				}
-			}
-		}
-
-		/* We found some children, so keep searching. */
-		if (!smmu) {
-			master = NULL;
-			continue;
-		}
-
+	list_for_each_entry(smmu, &arm_smmu_devices, list) {
 		master = find_smmu_master(smmu, dev_node);
 		if (master)
 			break;
 	}
 	spin_unlock(&arm_smmu_devices_lock);
+
 	return master ? smmu : NULL;
 }
 
@@ -639,9 +581,10 @@ static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 	}
 }
 
-static void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
+static void arm_smmu_tlb_inv_context(struct arm_smmu_domain *smmu_domain)
 {
-	struct arm_smmu_device *smmu = cfg->smmu;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	void __iomem *base = ARM_SMMU_GR0(smmu);
 	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
 
@@ -665,11 +608,11 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	unsigned long iova;
 	struct iommu_domain *domain = dev;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
-	struct arm_smmu_device *smmu = root_cfg->smmu;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	void __iomem *cb_base;
 
-	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);
+	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
 	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
 
 	if (!(fsr & FSR_FAULT))
@@ -696,7 +639,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	} else {
 		dev_err_ratelimited(smmu->dev,
 		    "Unhandled context fault: iova=0x%08lx, fsynr=0x%x, cb=%d\n",
-		    iova, fsynr, root_cfg->cbndx);
+		    iova, fsynr, cfg->cbndx);
 		ret = IRQ_NONE;
 		resume = RESUME_TERMINATE;
 	}
@@ -761,19 +704,19 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 {
 	u32 reg;
 	bool stage1;
-	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
-	struct arm_smmu_device *smmu = root_cfg->smmu;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	void __iomem *cb_base, *gr0_base, *gr1_base;
 
 	gr0_base = ARM_SMMU_GR0(smmu);
 	gr1_base = ARM_SMMU_GR1(smmu);
-	stage1 = root_cfg->cbar != CBAR_TYPE_S2_TRANS;
-	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);
+	stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
+	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
 
 	/* CBAR */
-	reg = root_cfg->cbar;
+	reg = cfg->cbar;
 	if (smmu->version == 1)
-	      reg |= root_cfg->irptndx << CBAR_IRPTNDX_SHIFT;
+	      reg |= cfg->irptndx << CBAR_IRPTNDX_SHIFT;
 
 	/*
 	 * Use the weakest shareability/memory types, so they are
@@ -783,9 +726,9 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 		reg |= (CBAR_S1_BPSHCFG_NSH << CBAR_S1_BPSHCFG_SHIFT) |
 			(CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
 	} else {
-		reg |= ARM_SMMU_CB_VMID(root_cfg) << CBAR_VMID_SHIFT;
+		reg |= ARM_SMMU_CB_VMID(cfg) << CBAR_VMID_SHIFT;
 	}
-	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(root_cfg->cbndx));
+	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
 
 	if (smmu->version > 1) {
 		/* CBA2R */
@@ -795,7 +738,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 		reg = CBA2R_RW64_32BIT;
 #endif
 		writel_relaxed(reg,
-			       gr1_base + ARM_SMMU_GR1_CBA2R(root_cfg->cbndx));
+			       gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
 
 		/* TTBCR2 */
 		switch (smmu->input_size) {
@@ -845,13 +788,13 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	}
 
 	/* TTBR0 */
-	arm_smmu_flush_pgtable(smmu, root_cfg->pgd,
+	arm_smmu_flush_pgtable(smmu, cfg->pgd,
 			       PTRS_PER_PGD * sizeof(pgd_t));
-	reg = __pa(root_cfg->pgd);
+	reg = __pa(cfg->pgd);
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
-	reg = (phys_addr_t)__pa(root_cfg->pgd) >> 32;
+	reg = (phys_addr_t)__pa(cfg->pgd) >> 32;
 	if (stage1)
-		reg |= ARM_SMMU_CB_ASID(root_cfg) << TTBRn_HI_ASID_SHIFT;
+		reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
 
 	/*
@@ -920,44 +863,24 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 }
 
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
-					struct device *dev,
-					struct arm_smmu_device *device_smmu)
+					struct arm_smmu_device *smmu)
 {
 	int irq, ret, start;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
-	struct arm_smmu_device *smmu, *parent;
-
-	/*
-	 * Walk the SMMU chain to find the root device for this chain.
-	 * We assume that no masters have translations which terminate
-	 * early, and therefore check that the root SMMU does indeed have
-	 * a StreamID for the master in question.
-	 */
-	parent = device_smmu;
-	smmu_domain->output_mask = -1;
-	do {
-		smmu = parent;
-		smmu_domain->output_mask &= (1ULL << smmu->s2_output_size) - 1;
-	} while ((parent = find_parent_smmu(smmu)));
-
-	if (!find_smmu_master_cfg(smmu, dev)) {
-		dev_err(dev, "unable to find root SMMU config for device\n");
-		return -ENODEV;
-	}
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 
 	if (smmu->features & ARM_SMMU_FEAT_TRANS_NESTED) {
 		/*
 		 * We will likely want to change this if/when KVM gets
 		 * involved.
 		 */
-		root_cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
+		cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
 		start = smmu->num_s2_context_banks;
 	} else if (smmu->features & ARM_SMMU_FEAT_TRANS_S2) {
-		root_cfg->cbar = CBAR_TYPE_S2_TRANS;
+		cfg->cbar = CBAR_TYPE_S2_TRANS;
 		start = 0;
 	} else {
-		root_cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
+		cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
 		start = smmu->num_s2_context_banks;
 	}
 
@@ -966,39 +889,38 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (IS_ERR_VALUE(ret))
 		return ret;
 
-	root_cfg->cbndx = ret;
+	cfg->cbndx = ret;
 	if (smmu->version == 1) {
-		root_cfg->irptndx = atomic_inc_return(&smmu->irptndx);
-		root_cfg->irptndx %= smmu->num_context_irqs;
+		cfg->irptndx = atomic_inc_return(&smmu->irptndx);
+		cfg->irptndx %= smmu->num_context_irqs;
 	} else {
-		root_cfg->irptndx = root_cfg->cbndx;
+		cfg->irptndx = cfg->cbndx;
 	}
 
-	irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
+	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
 	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
 			  "arm-smmu-context-fault", domain);
 	if (IS_ERR_VALUE(ret)) {
 		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
-			root_cfg->irptndx, irq);
-		root_cfg->irptndx = INVALID_IRPTNDX;
+			cfg->irptndx, irq);
+		cfg->irptndx = INVALID_IRPTNDX;
 		goto out_free_context;
 	}
 
-	root_cfg->smmu = smmu;
+	smmu_domain->smmu = smmu;
 	arm_smmu_init_context_bank(smmu_domain);
-	smmu_domain->leaf_smmu = device_smmu;
 	return 0;
 
 out_free_context:
-	__arm_smmu_free_bitmap(smmu->context_map, root_cfg->cbndx);
+	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
 	return ret;
 }
 
 static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
-	struct arm_smmu_device *smmu = root_cfg->smmu;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	void __iomem *cb_base;
 	int irq;
 
@@ -1006,16 +928,16 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 		return;
 
 	/* Disable the context bank and nuke the TLB before freeing it. */
-	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);
+	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
 	writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
-	arm_smmu_tlb_inv_context(root_cfg);
+	arm_smmu_tlb_inv_context(smmu_domain);
 
-	if (root_cfg->irptndx != INVALID_IRPTNDX) {
-		irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
+	if (cfg->irptndx != INVALID_IRPTNDX) {
+		irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
 		free_irq(irq, domain);
 	}
 
-	__arm_smmu_free_bitmap(smmu->context_map, root_cfg->cbndx);
+	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
 }
 
 static int arm_smmu_domain_init(struct iommu_domain *domain)
@@ -1035,7 +957,7 @@ static int arm_smmu_domain_init(struct iommu_domain *domain)
 	pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
 	if (!pgd)
 		goto out_free_domain;
-	smmu_domain->root_cfg.pgd = pgd;
+	smmu_domain->cfg.pgd = pgd;
 
 	spin_lock_init(&smmu_domain->lock);
 	domain->priv = smmu_domain;
@@ -1090,8 +1012,8 @@ static void arm_smmu_free_puds(pgd_t *pgd)
 static void arm_smmu_free_pgtables(struct arm_smmu_domain *smmu_domain)
 {
 	int i;
-	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
-	pgd_t *pgd, *pgd_base = root_cfg->pgd;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	pgd_t *pgd, *pgd_base = cfg->pgd;
 
 	/*
 	 * Recursively free the page tables for this domain. We don't
@@ -1142,7 +1064,7 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 		return -ENOMEM;
 	}
 
-	/* Allocate the SMRs on the root SMMU */
+	/* Allocate the SMRs on the SMMU */
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		int idx = __arm_smmu_alloc_bitmap(smmu->smr_map, 0,
 						  smmu->num_mapping_groups);
@@ -1210,34 +1132,18 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 				      struct arm_smmu_master_cfg *cfg)
 {
 	int i, ret;
-	struct arm_smmu_device *parent, *smmu = smmu_domain->root_cfg.smmu;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
 	ret = arm_smmu_master_configure_smrs(smmu, cfg);
 	if (ret)
 		return ret;
 
-	/* Bypass the leaves */
-	smmu = smmu_domain->leaf_smmu;
-	while ((parent = find_parent_smmu(smmu))) {
-		/*
-		 * We won't have a StreamID match for anything but the root
-		 * smmu, so we only need to worry about StreamID indexing,
-		 * where we must install bypass entries in the S2CRs.
-		 */
-		if (smmu->features & ARM_SMMU_FEAT_STREAM_MATCH)
-			continue;
-
-		arm_smmu_bypass_stream_mapping(smmu, cfg);
-		smmu = parent;
-	}
-
-	/* Now we're at the root, time to point at our context bank */
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		u32 idx, s2cr;
 		idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
 		s2cr = S2CR_TYPE_TRANS |
-		       (smmu_domain->root_cfg.cbndx << S2CR_CBNDX_SHIFT);
+		       (smmu_domain->cfg.cbndx << S2CR_CBNDX_SHIFT);
 		writel_relaxed(s2cr, gr0_base + ARM_SMMU_GR0_S2CR(idx));
 	}
 
@@ -1247,7 +1153,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 					  struct arm_smmu_master_cfg *cfg)
 {
-	struct arm_smmu_device *smmu = smmu_domain->root_cfg.smmu;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	/*
 	 * We *must* clear the S2CR first, because freeing the SMR means
@@ -1261,37 +1167,37 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = -EINVAL;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_device *device_smmu;
+	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_cfg *cfg;
 	unsigned long flags;
 
-	device_smmu = dev_get_master_dev(dev)->archdata.iommu;
-	if (!device_smmu) {
+	smmu = dev_get_master_dev(dev)->archdata.iommu;
+	if (!smmu) {
 		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
 		return -ENXIO;
 	}
 
 	/*
-	 * Sanity check the domain. We don't currently support domains
-	 * that cross between different SMMU chains.
+	 * Sanity check the domain. We don't support domains across
+	 * different SMMUs.
 	 */
 	spin_lock_irqsave(&smmu_domain->lock, flags);
-	if (!smmu_domain->leaf_smmu) {
+	if (!smmu_domain->smmu) {
 		/* Now that we have a master, we can finalise the domain */
-		ret = arm_smmu_init_domain_context(domain, dev, device_smmu);
+		ret = arm_smmu_init_domain_context(domain, smmu);
 		if (IS_ERR_VALUE(ret))
 			goto err_unlock;
-	} else if (smmu_domain->leaf_smmu != device_smmu) {
+	} else if (smmu_domain->smmu != smmu) {
 		dev_err(dev,
 			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
-			dev_name(smmu_domain->leaf_smmu->dev),
-			dev_name(device_smmu->dev));
+			dev_name(smmu_domain->smmu->dev),
+			dev_name(smmu->dev));
 		goto err_unlock;
 	}
 	spin_unlock_irqrestore(&smmu_domain->lock, flags);
 
 	/* Looks ok, so add the device to the domain */
-	cfg = find_smmu_master_cfg(smmu_domain->leaf_smmu, dev);
+	cfg = find_smmu_master_cfg(smmu_domain->smmu, dev);
 	if (!cfg)
 		return -ENODEV;
 
@@ -1307,7 +1213,7 @@ static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_master_cfg *cfg;
 
-	cfg = find_smmu_master_cfg(smmu_domain->leaf_smmu, dev);
+	cfg = find_smmu_master_cfg(smmu_domain->smmu, dev);
 	if (cfg)
 		arm_smmu_domain_remove_master(smmu_domain, cfg);
 }
@@ -1497,12 +1403,12 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	int ret, stage;
 	unsigned long end;
 	phys_addr_t input_mask, output_mask;
-	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
-	pgd_t *pgd = root_cfg->pgd;
-	struct arm_smmu_device *smmu = root_cfg->smmu;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	pgd_t *pgd = cfg->pgd;
 	unsigned long flags;
 
-	if (root_cfg->cbar == CBAR_TYPE_S2_TRANS) {
+	if (cfg->cbar == CBAR_TYPE_S2_TRANS) {
 		stage = 2;
 		output_mask = (1ULL << smmu->s2_output_size) - 1;
 	} else {
@@ -1552,10 +1458,6 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if (!smmu_domain)
 		return -ENODEV;
 
-	/* Check for silent address truncation up the SMMU chain. */
-	if ((phys_addr_t)iova & ~smmu_domain->output_mask)
-		return -ERANGE;
-
 	return arm_smmu_handle_mapping(smmu_domain, iova, paddr, size, prot);
 }
 
@@ -1566,7 +1468,7 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 
 	ret = arm_smmu_handle_mapping(smmu_domain, iova, 0, size, 0);
-	arm_smmu_tlb_inv_context(&smmu_domain->root_cfg);
+	arm_smmu_tlb_inv_context(smmu_domain);
 	return ret ? 0 : size;
 }
 
@@ -1578,9 +1480,9 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	pmd_t pmd;
 	pte_t pte;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 
-	pgdp = root_cfg->pgd;
+	pgdp = cfg->pgd;
 	if (!pgdp)
 		return 0;
 
@@ -1607,7 +1509,7 @@ static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
 				   unsigned long cap)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	u32 features = smmu_domain->root_cfg.smmu->features;
+	u32 features = smmu_domain->smmu->features;
 
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
@@ -1636,7 +1538,7 @@ static int arm_smmu_add_device(struct device *dev)
 		return -EINVAL;
 	}
 
-	smmu = find_parent_smmu_for_device(dev);
+	smmu = find_smmu_for_device(dev);
 	if (!smmu)
 		return -ENODEV;
 
@@ -1914,7 +1816,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct arm_smmu_device *smmu;
-	struct device_node *dev_node;
 	struct device *dev = &pdev->dev;
 	struct rb_node *node;
 	struct of_phandle_args masterspec;
@@ -1984,12 +1885,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	dev_notice(dev, "registered %d master devices\n", i);
 
-	if ((dev_node = of_parse_phandle(dev->of_node, "smmu-parent", 0)))
-		smmu->parent_of_node = dev_node;
-
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
-		goto out_put_parent;
+		goto out_put_masters;
 
 	parse_driver_options(smmu);
 
@@ -1999,7 +1897,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 			"found only %d context interrupt(s) but %d required\n",
 			smmu->num_context_irqs, smmu->num_context_banks);
 		err = -ENODEV;
-		goto out_put_parent;
+		goto out_put_masters;
 	}
 
 	for (i = 0; i < smmu->num_global_irqs; ++i) {
@@ -2027,10 +1925,6 @@ out_free_irqs:
 	while (i--)
 		free_irq(smmu->irqs[i], smmu);
 
-out_put_parent:
-	if (smmu->parent_of_node)
-		of_node_put(smmu->parent_of_node);
-
 out_put_masters:
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
 		struct arm_smmu_master *master;
@@ -2061,9 +1955,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	if (!smmu)
 		return -ENODEV;
 
-	if (smmu->parent_of_node)
-		of_node_put(smmu->parent_of_node);
-
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
 		struct arm_smmu_master *master;
 		master = container_of(node, struct arm_smmu_master, node);
-- 
2.0.0
