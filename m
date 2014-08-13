From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 1/6] iommu/arm-smmu: add support for specifying clocks
Date: Tue, 12 Aug 2014 17:51:34 -0700
Message-ID: <1407891099-24641-2-git-send-email-mitchelh@codeaurora.org>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1407891099-24641-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On some platforms with tight power constraints it is polite to only
leave your clocks on for as long as you absolutely need them. Currently
we assume that all clocks necessary for SMMU register access are always
on.

Add some optional device tree properties to specify any clocks that are
necessary for SMMU register access and turn them on and off as needed.

If no clocks are specified in the device tree things continue to work
the way they always have: we assume all necessary clocks are always
turned on.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         |  11 ++
 drivers/iommu/arm-smmu.c                           | 127 +++++++++++++++++++--
 2 files changed, 129 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 2d0f7cd867..ceae3fe207 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -48,6 +48,17 @@ conditions.
                   aliases of secure registers have to be used during
                   SMMU configuration.
 
+- clocks        : List of clocks to be used during SMMU register access. See
+                  Documentation/devicetree/bindings/clock/clock-bindings.txt
+                  for information about the format. For each clock specified
+                  here, there must be a corresponding entery in clock-names
+                  (see below).
+
+- clock-names   : List of clock names corresponding to the clocks specified in
+                  the "clocks" property (above). See
+                  Documentation/devicetree/bindings/clock/clock-bindings.txt
+                  for more info.
+
 Example:
 
         smmu {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9fd8754db0..e123d75db3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -399,6 +399,9 @@ struct arm_smmu_device {
 
 	struct list_head		list;
 	struct rb_root			masters;
+
+	int num_clocks;
+	struct clk **clocks;
 };
 
 struct arm_smmu_cfg {
@@ -589,6 +592,31 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 	clear_bit(idx, map);
 }
 
+static int arm_smmu_enable_clocks(struct arm_smmu_device *smmu)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < smmu->num_clocks; ++i) {
+		ret = clk_prepare_enable(smmu->clocks[i]);
+		if (ret) {
+			dev_err(smmu->dev, "Couldn't enable clock #%d\n", i);
+			while (i--)
+				clk_disable_unprepare(smmu->clocks[i]);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static void arm_smmu_disable_clocks(struct arm_smmu_device *smmu)
+{
+	int i;
+
+	for (i = 0; i < smmu->num_clocks; ++i)
+		clk_disable_unprepare(smmu->clocks[i]);
+}
+
 /* Wait for any pending TLB invalidations to complete */
 static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 {
@@ -644,11 +672,15 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	void __iomem *cb_base;
 
+	arm_smmu_enable_clocks(smmu);
+
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
 	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
 
-	if (!(fsr & FSR_FAULT))
+	if (!(fsr & FSR_FAULT)) {
+		arm_smmu_disable_clocks(smmu);
 		return IRQ_NONE;
+	}
 
 	if (fsr & FSR_IGN)
 		dev_err_ratelimited(smmu->dev,
@@ -683,6 +715,8 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	if (fsr & FSR_SS)
 		writel_relaxed(resume, cb_base + ARM_SMMU_CB_RESUME);
 
+	arm_smmu_disable_clocks(smmu);
+
 	return ret;
 }
 
@@ -692,13 +726,17 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	struct arm_smmu_device *smmu = dev;
 	void __iomem *gr0_base = ARM_SMMU_GR0_NS(smmu);
 
+	arm_smmu_enable_clocks(smmu);
+
 	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
 	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
 	gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
 	gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
 
-	if (!gfsr)
+	if (!gfsr) {
+		arm_smmu_disable_clocks(smmu);
 		return IRQ_NONE;
+	}
 
 	dev_err_ratelimited(smmu->dev,
 		"Unexpected global fault, this could be serious\n");
@@ -707,6 +745,7 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 		gfsr, gfsynr0, gfsynr1, gfsynr2);
 
 	writel(gfsr, gr0_base + ARM_SMMU_GR0_sGFSR);
+	arm_smmu_disable_clocks(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -991,10 +1030,12 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	if (!smmu)
 		return;
 
+	arm_smmu_enable_clocks(smmu_domain->smmu);
 	/* Disable the context bank and nuke the TLB before freeing it. */
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
 	writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
 	arm_smmu_tlb_inv_context(smmu_domain);
+	arm_smmu_disable_clocks(smmu_domain->smmu);
 
 	if (cfg->irptndx != INVALID_IRPTNDX) {
 		irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
@@ -1222,6 +1263,7 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 	 * We *must* clear the S2CR first, because freeing the SMR means
 	 * that it can be re-allocated immediately.
 	 */
+	arm_smmu_enable_clocks(smmu);
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		u32 idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
 
@@ -1230,6 +1272,7 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 	}
 
 	arm_smmu_master_free_smrs(smmu, cfg);
+	arm_smmu_disable_clocks(smmu);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -1250,6 +1293,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -EEXIST;
 	}
 
+	arm_smmu_enable_clocks(smmu);
+
 	/*
 	 * Sanity check the domain. We don't support domains across
 	 * different SMMUs.
@@ -1259,7 +1304,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		/* Now that we have a master, we can finalise the domain */
 		ret = arm_smmu_init_domain_context(domain, smmu);
 		if (IS_ERR_VALUE(ret))
-			return ret;
+			goto disable_clocks;
 
 		dom_smmu = smmu_domain->smmu;
 	}
@@ -1268,17 +1313,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		dev_err(dev,
 			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
 			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto disable_clocks;
 	}
 
 	/* Looks ok, so add the device to the domain */
 	cfg = find_smmu_master_cfg(dev);
-	if (!cfg)
-		return -ENODEV;
+	if (!cfg) {
+		ret = -ENODEV;
+		goto disable_clocks;
+	}
 
 	ret = arm_smmu_domain_add_master(smmu_domain, cfg);
 	if (!ret)
 		dev->archdata.iommu = domain;
+disable_clocks:
+	arm_smmu_disable_clocks(smmu);
 	return ret;
 }
 
@@ -1544,7 +1594,9 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 
 	ret = arm_smmu_handle_mapping(smmu_domain, iova, 0, size, 0);
+	arm_smmu_enable_clocks(smmu_domain->smmu);
 	arm_smmu_tlb_inv_context(smmu_domain);
+	arm_smmu_disable_clocks(smmu_domain->smmu);
 	return ret ? 0 : size;
 }
 
@@ -1792,7 +1844,52 @@ static int arm_smmu_id_size_to_bits(int size)
 	}
 }
 
-static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
+static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
+{
+	const char *cname;
+	struct property *prop;
+	int i;
+	struct device *dev = smmu->dev;
+
+	smmu->num_clocks = of_property_count_strings(dev->of_node,
+						"clock-names");
+
+	if (!smmu->num_clocks)
+		return 0;
+
+	smmu->clocks = devm_kzalloc(
+		dev, sizeof(*smmu->clocks) * smmu->num_clocks,
+		GFP_KERNEL);
+
+	if (!smmu->clocks) {
+		dev_err(dev,
+			"Failed to allocate memory for clocks\n");
+		return -ENODEV;
+	}
+
+	i = 0;
+	of_property_for_each_string(dev->of_node, "clock-names",
+				prop, cname) {
+		struct clk *c = devm_clk_get(dev, cname);
+		if (IS_ERR(c)) {
+			dev_err(dev, "Couldn't get clock: %s",
+				cname);
+			return -ENODEV;
+		}
+
+		if (clk_get_rate(c) == 0) {
+			long rate = clk_round_rate(c, 1000);
+			clk_set_rate(c, rate);
+		}
+
+		smmu->clocks[i] = c;
+
+		++i;
+	}
+	return 0;
+}
+
+int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 {
 	unsigned long size;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
@@ -2027,10 +2124,16 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	dev_notice(dev, "registered %d master devices\n", i);
 
-	err = arm_smmu_device_cfg_probe(smmu);
+	err = arm_smmu_init_clocks(smmu);
 	if (err)
 		goto out_put_masters;
 
+	arm_smmu_enable_clocks(smmu);
+
+	err = arm_smmu_device_cfg_probe(smmu);
+	if (err)
+		goto out_disable_clocks;
+
 	parse_driver_options(smmu);
 
 	if (smmu->version > 1 &&
@@ -2039,7 +2142,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 			"found only %d context interrupt(s) but %d required\n",
 			smmu->num_context_irqs, smmu->num_context_banks);
 		err = -ENODEV;
-		goto out_put_masters;
+		goto out_disable_clocks;
 	}
 
 	for (i = 0; i < smmu->num_global_irqs; ++i) {
@@ -2061,12 +2164,16 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	spin_unlock(&arm_smmu_devices_lock);
 
 	arm_smmu_device_reset(smmu);
+	arm_smmu_disable_clocks(smmu);
 	return 0;
 
 out_free_irqs:
 	while (i--)
 		free_irq(smmu->irqs[i], smmu);
 
+out_disable_clocks:
+	arm_smmu_disable_clocks(smmu);
+
 out_put_masters:
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
 		struct arm_smmu_master *master
@@ -2110,7 +2217,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		free_irq(smmu->irqs[i], smmu);
 
 	/* Turn the thing off */
+	arm_smmu_enable_clocks(smmu);
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	arm_smmu_disable_clocks(smmu);
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
