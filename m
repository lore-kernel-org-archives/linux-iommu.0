From: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH/RFC 3/4] iommu/arm-smmu: add support for specifying clocks
Date: Thu,  5 Feb 2015 16:32:01 -0800
Message-ID: <1423182722-16646-4-git-send-email-lauraa@codeaurora.org>
References: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1423182722-16646-1-git-send-email-lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Joreg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

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
Signed-off-by: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
This is a rework of the patch to add clocks and it attempted to address
previous comments. I sent it with this series to give the rest of the
RFC some series but I'll probably resend later versions of this one separately
from the rest of the series.
---
 .../devicetree/bindings/iommu/arm,smmu.txt         |  10 ++
 drivers/iommu/arm-smmu.c                           | 149 ++++++++++++++++++++-
 drivers/iommu/iommu.c                              |  49 ++++++-
 include/linux/iommu.h                              |   2 +
 4 files changed, 203 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 0676050..9200e0b 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -48,6 +48,16 @@ conditions.
                   SMMU configuration registers. In this case non-secure
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
 
 Example:
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6cd47b7..d9f7cf48 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -391,6 +391,10 @@ struct arm_smmu_device {
 
 	struct list_head		list;
 	struct rb_root			masters;
+
+	int				num_clocks;
+	struct clk			**clocks;
+	atomic_t			clk_enable;
 };
 
 struct arm_smmu_cfg {
@@ -596,6 +600,36 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 	clear_bit(idx, map);
 }
 
+static int arm_smmu_enable_clocks(struct arm_smmu_device *smmu)
+{
+	int i, ret = 0;
+
+	atomic_add(1, &smmu->clk_enable);
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
+	if (!atomic_add_unless(&smmu->clk_enable, -1, 0))
+		return;
+
+	for (i = 0; i < smmu->num_clocks; ++i)
+		clk_disable_unprepare(smmu->clocks[i]);
+}
+
 /* Wait for any pending TLB invalidations to complete */
 static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 {
@@ -1259,6 +1293,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	/*
+	 * Need the explicit clock enable calls because the context
+	 * isn't set up for this to work with enable_resource/
+	 * disable resource
+	 */
+	arm_smmu_enable_clocks(smmu);
+
+	/*
 	 * Sanity check the domain. We don't support domains across
 	 * different SMMUs.
 	 */
@@ -1267,7 +1308,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		/* Now that we have a master, we can finalise the domain */
 		ret = arm_smmu_init_domain_context(domain, smmu);
 		if (IS_ERR_VALUE(ret))
-			return ret;
+			goto out;
 
 		dom_smmu = smmu_domain->smmu;
 	}
@@ -1276,17 +1317,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		dev_err(dev,
 			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
 			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	/* Looks ok, so add the device to the domain */
 	cfg = find_smmu_master_cfg(dev);
-	if (!cfg)
-		return -ENODEV;
+	if (!cfg) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	ret = arm_smmu_domain_add_master(smmu_domain, cfg);
 	if (!ret)
 		dev->archdata.iommu = domain;
+out:
+	arm_smmu_disable_clocks(smmu);
 	return ret;
 }
 
@@ -1715,6 +1761,42 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	}
 }
 
+static int arm_smmu_enable_resources(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_device *smmu;
+
+	if (!smmu_domain)
+		return 0;
+
+	smmu = smmu_domain->smmu;
+
+	if (!smmu)
+		return 0;
+
+	arm_smmu_enable_clocks(smmu);
+
+	return 0;
+}
+
+static int arm_smmu_disable_resources(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_device *smmu;
+
+	if (!smmu_domain)
+		return 0;
+
+	smmu = smmu_domain->smmu;
+
+	if (!smmu)
+		return 0;
+
+	arm_smmu_disable_clocks(smmu);
+
+	return 0;
+}
+
 static const struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_init		= arm_smmu_domain_init,
@@ -1732,6 +1814,8 @@ static const struct iommu_ops arm_smmu_ops = {
 	.pgsize_bitmap		= (SECTION_SIZE |
 				   ARM_SMMU_PTE_CONT_SIZE |
 				   PAGE_SIZE),
+	.enable_resources	= arm_smmu_enable_resources,
+	.disable_resources	= arm_smmu_disable_resources,
 };
 
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
@@ -1805,6 +1889,51 @@ static int arm_smmu_id_size_to_bits(int size)
 	}
 }
 
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
+			return PTR_ERR(c);
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
 static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 {
 	unsigned long size;
@@ -2031,10 +2160,16 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
-	err = arm_smmu_device_cfg_probe(smmu);
+	err = arm_smmu_init_clocks(smmu);
 	if (err)
 		return err;
 
+	arm_smmu_enable_clocks(smmu);
+
+	err = arm_smmu_device_cfg_probe(smmu);
+	if (err)
+		goto out_disable_clocks;
+
 	i = 0;
 	smmu->masters = RB_ROOT;
 	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
@@ -2081,6 +2216,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	spin_unlock(&arm_smmu_devices_lock);
 
 	arm_smmu_device_reset(smmu);
+	arm_smmu_disable_clocks(smmu);
 	return 0;
 
 out_free_irqs:
@@ -2094,6 +2230,9 @@ out_put_masters:
 		of_node_put(master->of_node);
 	}
 
+out_disable_clocks:
+	arm_smmu_disable_clocks(smmu);
+
 	return err;
 }
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f7718d7..236b1e1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -927,9 +927,17 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
-	if (likely(domain->ops->domain_destroy != NULL))
+	if (likely(domain->ops->domain_destroy != NULL)) {
+		if (domain->ops->enable_resources)
+			domain->ops->enable_resources(domain);
+
 		domain->ops->domain_destroy(domain);
 
+		if (domain->ops->disable_resources)
+			domain->ops->disable_resources(domain);
+
+	}
+
 	kfree(domain);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
@@ -940,9 +948,16 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
 
+	if (domain->ops->enable_resources)
+		domain->ops->enable_resources(domain);
+
 	ret = domain->ops->attach_dev(domain, dev);
 	if (!ret)
 		trace_attach_device_to_domain(dev);
+
+	if (domain->ops->disable_resources)
+		domain->ops->disable_resources(domain);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
@@ -952,8 +967,15 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 	if (unlikely(domain->ops->detach_dev == NULL))
 		return;
 
+	if (domain->ops->enable_resources)
+		domain->ops->enable_resources(domain);
+
 	domain->ops->detach_dev(domain, dev);
 	trace_detach_device_from_domain(dev);
+
+	if (domain->ops->disable_resources)
+		domain->ops->disable_resources(domain);
+
 }
 EXPORT_SYMBOL_GPL(iommu_detach_device);
 
@@ -998,10 +1020,20 @@ EXPORT_SYMBOL_GPL(iommu_detach_group);
 
 phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
+	phys_addr_t phys;
+
 	if (unlikely(domain->ops->iova_to_phys == NULL))
 		return 0;
 
-	return domain->ops->iova_to_phys(domain, iova);
+	if (domain->ops->enable_resources)
+		domain->ops->enable_resources(domain);
+
+	phys = domain->ops->iova_to_phys(domain, iova);
+
+	if (domain->ops->disable_resources)
+		domain->ops->disable_resources(domain);
+
+	return phys;
 }
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 
@@ -1065,6 +1097,9 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
 
+	if (domain->ops->enable_resources)
+		domain->ops->enable_resources(domain);
+
 	while (size) {
 		size_t pgsize = iommu_pgsize(domain, iova | paddr, size);
 
@@ -1080,6 +1115,9 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		size -= pgsize;
 	}
 
+	if (domain->ops->disable_resources)
+		domain->ops->disable_resources(domain);
+
 	/* unroll mapping in case something went wrong */
 	if (ret)
 		iommu_unmap(domain, orig_iova, orig_size - size);
@@ -1115,6 +1153,10 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 
 	pr_debug("unmap this: iova 0x%lx size 0x%zx\n", iova, size);
 
+
+	if (domain->ops->enable_resources)
+		domain->ops->enable_resources(domain);
+
 	/*
 	 * Keep iterating until we either unmap 'size' bytes (or more)
 	 * or we hit an area that isn't mapped.
@@ -1133,6 +1175,9 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 		unmapped += unmapped_page;
 	}
 
+	if (domain->ops->disable_resources)
+		domain->ops->disable_resources(domain);
+
 	trace_unmap(iova, 0, size);
 	return unmapped;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 38daa45..79cc5af 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -145,6 +145,8 @@ struct iommu_ops {
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 #endif
 
+	int (*enable_resources)(struct iommu_domain *domain);
+	int (*disable_resources)(struct iommu_domain *domain);
 	unsigned long pgsize_bitmap;
 	void *priv;
 };
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
