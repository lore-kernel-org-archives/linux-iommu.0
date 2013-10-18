From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv3 10/19] iommu/tegra: smmu: Get "nvidia,swgroups" from DT
Date: Fri, 18 Oct 2013 13:26:51 +0300
Message-ID: <1382092020-13170-11-git-send-email-hdoyu@nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This provides the info about which H/W Accelerators are supported on
Tegra SoC. This info is passed from DT. This is necessary to have the
unified SMMU driver among Tegra SoCs. Instead of using platform data,
DT passes "nvidia,swgroups" now. DT is mandatory in Tegra.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/iommu/nvidia,tegra30-smmu.txt         |  6 +++++
 drivers/iommu/tegra-smmu.c                         | 31 ++++++++++------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
index 89fb543..6a844b3 100644
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
@@ -8,6 +8,11 @@ Required properties:
 - nvidia,#asids : # of ASIDs
 - dma-window : IOVA start address and length.
 - nvidia,ahb : phandle to the ahb bus connected to SMMU.
+- nvidia,swgroups: A bitmap of supported HardWare Accelerators(HWA).
+  Each bit represents one swgroup. The assignments may be found in header
+  file <dt-bindings/memory/tegra-swgroup.h>. Its max is 64. 2 cells
+  are required. This unique ID info can be used to calculate
+  MC_SMMU_<SWGROUP name>_ASID_0 offset and HOTRESET bit.
 
 Example:
 	smmu {
@@ -17,5 +22,6 @@ Example:
 		       0x7000f228 0x05c>;
 		nvidia,#asids = <4>;		/* # of ASIDs */
 		dma-window = <0 0x40000000>;	/* IOVA start & length */
+		nvidia,swgroups = <0x00000000 0x000779ff>;
 		nvidia,ahb = <&ahb>;
 	};
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 4dcdd6c..22951e6 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -247,7 +247,7 @@ struct smmu_client {
 	struct device		*dev;
 	struct list_head	list;
 	struct smmu_as		*as;
-	u32			hwgrp;
+	u64			hwgrp;
 };
 
 /*
@@ -289,6 +289,8 @@ struct smmu_device {
 	struct device	*dev;
 	struct page *avp_vector_page;	/* dummy page shared by all AS's */
 
+	u64 swgroups;			/* swgroup ID bitmap */
+
 	/*
 	 * Register image savers for suspend/resume
 	 */
@@ -364,15 +366,16 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
  */
 #define FLUSH_SMMU_REGS(smmu)	smmu_read(smmu, SMMU_CONFIG)
 
-#define smmu_client_hwgrp(c) (u32)((c)->dev->platform_data)
+#define smmu_client_hwgrp(c)	(c->as->smmu->swgroups)
 
 static int __smmu_client_set_hwgrp(struct smmu_client *c,
-				   unsigned long map, int on)
+				   u64 map, int on)
 {
 	int i;
 	struct smmu_as *as = c->as;
 	u32 val, offs, mask = SMMU_ASID_ENABLE(as->asid);
 	struct smmu_device *smmu = as->smmu;
+	unsigned long *bitmap = (unsigned long *)&map;
 
 	WARN_ON(!on && map);
 	if (on && !map)
@@ -380,12 +383,10 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 	if (!on)
 		map = smmu_client_hwgrp(c);
 
-	for_each_set_bit(i, &map, HWGRP_COUNT) {
+	for_each_set_bit(i, bitmap, sizeof(map) * BITS_PER_BYTE) {
 		offs = HWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
-			if (WARN_ON(val & mask))
-				goto err_hw_busy;
 			val |= mask;
 		} else {
 			WARN_ON((val & mask) == mask);
@@ -396,15 +397,6 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
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
@@ -776,7 +768,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	struct smmu_as *as = domain->priv;
 	struct smmu_device *smmu = as->smmu;
 	struct smmu_client *client, *c;
-	u32 map;
+	u64 map;
 	int err;
 
 	client = devm_kzalloc(smmu->dev, sizeof(*c), GFP_KERNEL);
@@ -784,7 +776,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 		return -ENOMEM;
 	client->dev = dev;
 	client->as = as;
-	map = (unsigned long)dev->platform_data;
+	map = smmu->swgroups;
 	if (!map)
 		return -EINVAL;
 
@@ -1191,6 +1183,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	int i, asids, err = 0;
 	dma_addr_t uninitialized_var(base);
 	size_t bytes, uninitialized_var(size);
+	u64 swgroups;
 
 	if (smmu_handle)
 		return -EIO;
@@ -1200,6 +1193,9 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
 		return -ENODEV;
 
+	if (of_property_read_u64(dev->of_node, "nvidia,swgroups", &swgroups))
+		return -ENODEV;
+
 	bytes = sizeof(*smmu) + asids * (sizeof(*smmu->as) +
 					 sizeof(struct dma_iommu_mapping *));
 	smmu = devm_kzalloc(dev, bytes, GFP_KERNEL);
@@ -1246,6 +1242,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	smmu->num_as = asids;
 	smmu->iovmm_base = base;
 	smmu->page_count = size;
+	smmu->swgroups = swgroups;
 
 	smmu->translation_enable_0 = ~0;
 	smmu->translation_enable_1 = ~0;
-- 
1.8.1.5
