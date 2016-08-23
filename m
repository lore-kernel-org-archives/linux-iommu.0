From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 17/19] iommu/arm-smmu: Wire up generic configuration support
Date: Tue, 23 Aug 2016 20:05:28 +0100
Message-ID: <4439250e01ac071bae8f03a5ccf107ed7ddc0b49.1471975357.git.robin.murphy@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With everything else now in place, fill in an of_xlate callback and the
appropriate registration to plumb into the generic configuration
machinery, and watch everything just work.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 168 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 107 insertions(+), 61 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ea22beb58b59..85bc74d8fca0 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -43,6 +43,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_iommu.h>
+#include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -418,6 +419,8 @@ struct arm_smmu_option_prop {
 
 static atomic_t cavium_smmu_context_count = ATOMIC_INIT(0);
 
+static bool legacy_binding_used;
+
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
 	{ 0, NULL},
@@ -799,12 +802,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->smmu)
 		goto out_unlock;
 
-	/* We're bypassing these SIDs, so don't allocate an actual context */
-	if (domain->type == IOMMU_DOMAIN_DMA) {
-		smmu_domain->smmu = smmu;
-		goto out_unlock;
-	}
-
 	/*
 	 * Mapping the requested stage onto what we support is surprisingly
 	 * complicated, mainly because the spec allows S1+S2 SMMUs without
@@ -954,7 +951,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	void __iomem *cb_base;
 	int irq;
 
-	if (!smmu || domain->type == IOMMU_DOMAIN_DMA)
+	if (!smmu)
 		return;
 
 	/*
@@ -988,8 +985,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	if (!smmu_domain)
 		return NULL;
 
-	if (type == IOMMU_DOMAIN_DMA &&
-	    iommu_get_dma_cookie(&smmu_domain->domain)) {
+	if (type == IOMMU_DOMAIN_DMA && (legacy_binding_used ||
+	    iommu_get_dma_cookie(&smmu_domain->domain))) {
 		kfree(smmu_domain);
 		return NULL;
 	}
@@ -1101,19 +1098,22 @@ static int arm_smmu_master_alloc_smes(struct device *dev)
 	mutex_lock(&smmu->stream_map_mutex);
 	/* Figure out a viable stream map entry allocation */
 	for_each_cfg_sme(fwspec, i, idx) {
+		u16 sid = fwspec->ids[i];
+		u16 mask = fwspec->ids[i] >> SMR_MASK_SHIFT;
+
 		if (idx >= 0) {
 			ret = -EEXIST;
 			goto out_err;
 		}
 
-		ret = arm_smmu_find_sme(smmu, fwspec->ids[i], 0);
+		ret = arm_smmu_find_sme(smmu, sid, mask);
 		if (ret < 0)
 			goto out_err;
 
 		idx = ret;
 		if (smrs && smmu->s2crs[idx].count == 0) {
-			smrs[idx].id = fwspec->ids[i];
-			smrs[idx].mask = 0; /* We don't currently share SMRs */
+			smrs[idx].id = sid;
+			smrs[idx].mask = mask;
 			smrs[idx].valid = true;
 		}
 		smmu->s2crs[idx].count++;
@@ -1171,15 +1171,6 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	u8 cbndx = smmu_domain->cfg.cbndx;
 	int i, idx;
 
-	/*
-	 * FIXME: This won't be needed once we have IOMMU-backed DMA ops
-	 * for all devices behind the SMMU. Note that we need to take
-	 * care configuring SMRs for devices both a platform_device and
-	 * and a PCI device (i.e. a PCI host controller)
-	 */
-	if (smmu_domain->domain.type == IOMMU_DOMAIN_DMA)
-		type = S2CR_TYPE_BYPASS;
-
 	for_each_cfg_sme(fwspec, i, idx) {
 		if (type == s2cr[idx].type && cbndx == s2cr[idx].cbndx)
 			continue;
@@ -1342,25 +1333,50 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	}
 }
 
+static int arm_smmu_match_node(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static struct arm_smmu_device *arm_smmu_get_by_node(struct device_node *np)
+{
+	struct device *dev = driver_find_device(&arm_smmu_driver.driver, NULL,
+						np, arm_smmu_match_node);
+	put_device(dev);
+	return dev ? dev_get_drvdata(dev) : NULL;
+}
+
 static int arm_smmu_add_device(struct device *dev)
 {
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_cfg *cfg;
-	struct iommu_fwspec *fwspec;
-	int i, ret;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec(dev);
+	int i, ret = 0;
 
-	ret = arm_smmu_register_legacy_master(dev, &smmu);
-	fwspec = dev_iommu_fwspec(dev);
-	if (ret)
-		goto out_free;
+	if (fwspec) {
+		smmu = arm_smmu_get_by_node(fwspec->iommu_np);
+	} else {
+		if (!legacy_binding_used)
+			return -ENODEV;
+		ret = arm_smmu_register_legacy_master(dev, &smmu);
+		fwspec = dev_iommu_fwspec(dev);
+		if (ret)
+			goto out_free;
+	}
 
 	ret = -EINVAL;
 	for (i = 0; i < fwspec->num_ids; i++) {
 		u16 sid = fwspec->ids[i];
+		u16 mask = fwspec->ids[i] >> SMR_MASK_SHIFT;
 
 		if (sid & ~smmu->streamid_mask) {
 			dev_err(dev, "stream ID 0x%x out of range for SMMU (0x%x)\n",
-				sid, cfg->smmu->streamid_mask);
+				sid, smmu->streamid_mask);
+			goto out_free;
+		}
+		if (mask & ~smmu->smr_mask_mask) {
+			dev_err(dev, "SMR mask 0x%x out of range for SMMU (0x%x)\n",
+				sid, smmu->smr_mask_mask);
 			goto out_free;
 		}
 	}
@@ -1472,6 +1488,23 @@ out_unlock:
 	return ret;
 }
 
+static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	u32 fwid = 0;
+	int ret = iommu_fwspec_init(dev, args->np);
+
+	if (ret)
+		return ret;
+
+	if (args->args_count > 0)
+		fwid |= (u16)args->args[0];
+
+	if (args->args_count > 1)
+		fwid |= (u16)args->args[1] << SMR_MASK_SHIFT;
+
+	return iommu_fwspec_add_ids(dev, &fwid, 1);
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -1486,6 +1519,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.domain_get_attr	= arm_smmu_domain_get_attr,
 	.domain_set_attr	= arm_smmu_domain_set_attr,
+	.of_xlate		= arm_smmu_of_xlate,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
@@ -1920,9 +1954,29 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (!legacy_binding_used &&
+	    of_find_property(dev->of_node, "mmu-masters", NULL)) {
+		pr_notice("Deprecated \"mmu-masters\" property in use; DMA API support unavailable.\n");
+		legacy_binding_used = true;
+	}
+
 	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
 	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
+
+	/* Oh, for a proper bus abstraction */
+	if (!iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
+#ifdef CONFIG_ARM_AMBA
+	if (!iommu_present(&amba_bustype))
+		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
+#endif
+#ifdef CONFIG_PCI
+	if (!iommu_present(&pci_bus_type)) {
+		pci_request_acs();
+		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
+	}
+#endif
 	return 0;
 }
 
@@ -1956,41 +2010,14 @@ static struct platform_driver arm_smmu_driver = {
 
 static int __init arm_smmu_init(void)
 {
-	struct device_node *np;
-	int ret;
+	static bool registered;
+	int ret = 0;
 
-	/*
-	 * Play nice with systems that don't have an ARM SMMU by checking that
-	 * an ARM SMMU exists in the system before proceeding with the driver
-	 * and IOMMU bus operation registration.
-	 */
-	np = of_find_matching_node(NULL, arm_smmu_of_match);
-	if (!np)
-		return 0;
-
-	of_node_put(np);
-
-	ret = platform_driver_register(&arm_smmu_driver);
-	if (ret)
-		return ret;
-
-	/* Oh, for a proper bus abstraction */
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
-
-#ifdef CONFIG_ARM_AMBA
-	if (!iommu_present(&amba_bustype))
-		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
-#endif
-
-#ifdef CONFIG_PCI
-	if (!iommu_present(&pci_bus_type)) {
-		pci_request_acs();
-		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
+	if (!registered) {
+		ret = platform_driver_register(&arm_smmu_driver);
+		registered = !ret;
 	}
-#endif
-
-	return 0;
+	return ret;
 }
 
 static void __exit arm_smmu_exit(void)
@@ -2001,6 +2028,25 @@ static void __exit arm_smmu_exit(void)
 subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);
 
+static int __init arm_smmu_of_init(struct device_node *np)
+{
+	int ret = arm_smmu_init();
+
+	if (ret)
+		return ret;
+
+	if (!of_platform_device_create(np, NULL, platform_bus_type.dev_root))
+		return -ENODEV;
+
+	return 0;
+}
+IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", arm_smmu_of_init);
+IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2", arm_smmu_of_init);
+IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400", arm_smmu_of_init);
+IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401", arm_smmu_of_init);
+IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500", arm_smmu_of_init);
+IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2", arm_smmu_of_init);
+
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
 MODULE_LICENSE("GPL v2");
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
