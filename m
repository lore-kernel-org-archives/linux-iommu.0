From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 16/22] iommu/tegra: smmu: Get "nvidia,swgroup" from DT
Date: Fri, 5 Jul 2013 13:44:51 +0300
Message-ID: <1373021097-32420-17-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This provides the info about which H/W Accelerators are supported on
Tegra SoC. This info is passed from DT. This is necessary to have the
unified SMMU driver among Tegra SoCs. Instead of using platform data,
DT passes "nvidia,swgroup" now. DT is mandatory in Tegra.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/iommu/nvidia,tegra30-smmu.txt         |    6 +++-
 drivers/iommu/tegra-smmu.c                         |   31 +++++++++-----------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
index ce5c43e..0c14dca 100644
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
@@ -8,14 +8,18 @@ Required properties:
 - nvidia,#asids : # of ASIDs
 - dma-window : IOVA start address and length.
 - nvidia,ahb : phandle to the ahb bus connected to SMMU.
+- nvidia,swgroups: A bitmap of supported HardWare Accelerators(HWA).
+  Each bit represents one swgroup. The assignments may be found in header
+  file <dt-bindings/memory/tegra-swgroup.h>.
 
 Example:
-	smmu {
+	iommu {
 		compatible = "nvidia,tegra30-smmu";
 		reg = <0x7000f010 0x02c
 		       0x7000f1f0 0x010
 		       0x7000f228 0x05c>;
 		nvidia,#asids = <4>;		/* # of ASIDs */
 		dma-window = <0 0x40000000>;	/* IOVA start & length */
+		nvidia,swgroups = TEGRA30_SWGROUP_ALL;
 		nvidia,ahb = <&ahb>;
 	};
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 95c6c80..c7b33f2 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -265,7 +265,7 @@ struct smmu_client {
 	struct device		*dev;
 	struct list_head	list;
 	struct smmu_as		*as;
-	u32			hwgrp;
+	u64			hwgrp;
 };
 
 /*
@@ -307,6 +307,8 @@ struct smmu_device {
 	struct device	*dev;
 	struct page *avp_vector_page;	/* dummy page shared by all AS's */
 
+	u64 swgroup;			/* swgroup ID bitmap */
+
 	/*
 	 * Register image savers for suspend/resume
 	 */
@@ -382,10 +384,10 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
  */
 #define FLUSH_SMMU_REGS(smmu)	smmu_read(smmu, SMMU_CONFIG)
 
-#define smmu_client_hwgrp(c) (u32)((c)->dev->platform_data)
+#define smmu_client_hwgrp(c)	(c->as->smmu->swgroup)
 
 static int __smmu_client_set_hwgrp(struct smmu_client *c,
-				   unsigned long map, int on)
+				   u64 map, int on)
 {
 	int i;
 	struct smmu_as *as = c->as;
@@ -398,12 +400,11 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 	if (!on)
 		map = smmu_client_hwgrp(c);
 
-	for_each_set_bit(i, &map, HWGRP_COUNT) {
+	for_each_set_bit(i, (unsigned long *)&map,
+			 sizeof(map) * BITS_PER_BYTE) {
 		offs = HWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
-			if (WARN_ON(val & mask))
-				goto err_hw_busy;
 			val |= mask;
 		} else {
 			WARN_ON((val & mask) == mask);
@@ -414,15 +415,6 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 	FLUSH_SMMU_REGS(smmu);
 	c->hwgrp = map;
 	return 0;
-
-err_hw_busy:
-	for_each_set_bit(i, &map, HWGRP_COUNT) {
-		offs = HWGRP_ASID_REG(i);
-		val = smmu_read(smmu, offs);
-		val &= ~mask;
-		smmu_write(smmu, val, offs);
-	}
-	return -EBUSY;
 }
 
 static int smmu_client_set_hwgrp(struct smmu_client *c, u32 map, int on)
@@ -794,7 +786,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	struct smmu_as *as = domain->priv;
 	struct smmu_device *smmu = as->smmu;
 	struct smmu_client *client, *c;
-	u32 map;
+	u64 map;
 	int err;
 
 	client = devm_kzalloc(smmu->dev, sizeof(*c), GFP_KERNEL);
@@ -802,7 +794,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 		return -ENOMEM;
 	client->dev = dev;
 	client->as = as;
-	map = (unsigned long)dev->platform_data;
+	map = smmu->swgroup;
 	if (!map)
 		return -EINVAL;
 
@@ -1210,6 +1202,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	int i, asids, err = 0;
 	dma_addr_t uninitialized_var(base);
 	size_t bytes, uninitialized_var(size);
+	u64 swgroup;
 
 	if (smmu_handle)
 		return -EIO;
@@ -1219,6 +1212,9 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
 		return -ENODEV;
 
+	if (of_property_read_u64(dev->of_node, "nvidia,swgroup", &swgroup))
+		return -ENODEV;
+
 	bytes = sizeof(*smmu) + asids * (sizeof(*smmu->as) +
 					 sizeof(struct dma_iommu_mapping *));
 	smmu = devm_kzalloc(dev, bytes, GFP_KERNEL);
@@ -1267,6 +1263,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	smmu->num_as = asids;
 	smmu->iovmm_base = base;
 	smmu->page_count = size;
+	smmu->swgroup = swgroup;
 
 	smmu->translation_enable_0 = ~0;
 	smmu->translation_enable_1 = ~0;
-- 
1.7.9.5
