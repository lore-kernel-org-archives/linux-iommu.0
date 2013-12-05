From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/6] iommu/tegra124: smmu: add support platform data
Date: Thu, 5 Dec 2013 14:25:16 +0200
Message-ID: <1386246319-17851-4-git-send-email-hdoyu@nvidia.com>
References: <1386246319-17851-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386246319-17851-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The later Tegra SoC(>= T124) has more registers for
MC_SMMU_TRANSLATION_ENABLE_*. Now those info is provided as platfrom
data. If those varies a lot on SoCs in the future, we can consider
putting them into DT later.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/iommu/nvidia,tegra30-smmu.txt         |  4 +-
 drivers/iommu/tegra-smmu.c                         | 68 ++++++++++++++--------
 2 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
index fd53f54..71be0d2 100644
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
@@ -1,8 +1,8 @@
 NVIDIA Tegra 30 IOMMU H/W, SMMU (System Memory Management Unit)
 
 Required properties in the IOMMU node:
-- compatible : "nvidia,tegra30-smmu"
-- reg : Should contain 3 register banks(address and length) for each
+- compatible : "nvidia,tegra124-smmu", "nvidia,tegra30-smmu"
+- reg : Can contain multiple register banks(address and length) for each
   of the SMMU register blocks.
 - interrupts : Should contain MC General interrupt.
 - nvidia,#asids : # of ASIDs
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index a723a1b..b5737f9 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -32,6 +32,7 @@
 #include <linux/iommu.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_iommu.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -108,8 +109,6 @@ enum {
 	(SMMU_STATS_CACHE_COUNT_BASE + 8 * cache + 4 * hitmiss)
 
 #define SMMU_TRANSLATION_ENABLE_0		0x228
-#define SMMU_TRANSLATION_ENABLE_1		0x22c
-#define SMMU_TRANSLATION_ENABLE_2		0x230
 
 #define SMMU_AFI_ASID	0x238   /* PCIE */
 #define SMMU_ASID_BASE	SMMU_AFI_ASID
@@ -237,12 +236,12 @@ struct smmu_device {
 	struct rb_root	clients;
 	struct page *avp_vector_page;	/* dummy page shared by all AS's */
 
+	int nr_xlats;		/* number of translation_enable registers */
+
 	/*
 	 * Register image savers for suspend/resume
 	 */
-	unsigned long translation_enable_0;
-	unsigned long translation_enable_1;
-	unsigned long translation_enable_2;
+	u32 *xlat;
 	unsigned long asid_security;
 
 	struct dentry *debugfs_root;
@@ -256,6 +255,11 @@ struct smmu_device {
 	struct smmu_as	as[0];		/* Run-time allocated array */
 };
 
+struct smmu_platform_data {
+	int asids;		/* number of asids */
+	int nr_xlats;		/* number of translation_enable registers */
+};
+
 static struct smmu_device *smmu_handle; /* unique for a system */
 
 /*
@@ -506,9 +510,10 @@ static int smmu_setup_regs(struct smmu_device *smmu)
 			__smmu_client_set_swgroups(c, c->swgroups, 1);
 	}
 
-	smmu_write(smmu, smmu->translation_enable_0, SMMU_TRANSLATION_ENABLE_0);
-	smmu_write(smmu, smmu->translation_enable_1, SMMU_TRANSLATION_ENABLE_1);
-	smmu_write(smmu, smmu->translation_enable_2, SMMU_TRANSLATION_ENABLE_2);
+	for (i = 0; i < smmu->nr_xlats; i++)
+		smmu_write(smmu, smmu->xlat[i],
+			   SMMU_TRANSLATION_ENABLE_0 + i * sizeof(u32));
+
 	smmu_write(smmu, smmu->asid_security, SMMU_ASID_SECURITY);
 	smmu_write(smmu, SMMU_TLB_CONFIG_RESET_VAL, SMMU_CACHE_CONFIG(_TLB));
 	smmu_write(smmu, SMMU_PTC_CONFIG_RESET_VAL, SMMU_CACHE_CONFIG(_PTC));
@@ -1205,11 +1210,13 @@ err_out:
 
 static int tegra_smmu_suspend(struct device *dev)
 {
+	int i;
 	struct smmu_device *smmu = dev_get_drvdata(dev);
 
-	smmu->translation_enable_0 = smmu_read(smmu, SMMU_TRANSLATION_ENABLE_0);
-	smmu->translation_enable_1 = smmu_read(smmu, SMMU_TRANSLATION_ENABLE_1);
-	smmu->translation_enable_2 = smmu_read(smmu, SMMU_TRANSLATION_ENABLE_2);
+	for (i = 0; i < smmu->nr_xlats; i++)
+		smmu->xlat[i] = smmu_read(smmu,
+				SMMU_TRANSLATION_ENABLE_0 + i * sizeof(u32));
+
 	smmu->asid_security = smmu_read(smmu, SMMU_ASID_SECURITY);
 	return 0;
 }
@@ -1243,6 +1250,18 @@ static void tegra_smmu_create_default_map(struct smmu_device *smmu)
 	}
 }
 
+static const struct smmu_platform_data tegra124_smmu_pdata = {
+	.asids = 128,
+	.nr_xlats = 4,
+};
+
+static struct of_device_id tegra_smmu_of_match[] = {
+	{ .compatible = "nvidia,tegra124-smmu", .data = &tegra124_smmu_pdata, },
+	{ .compatible = "nvidia,tegra30-smmu", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tegra_smmu_of_match);
+
 static int tegra_smmu_probe(struct platform_device *pdev)
 {
 	struct smmu_device *smmu;
@@ -1250,20 +1269,29 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	int i, asids, err = 0;
 	dma_addr_t uninitialized_var(base);
 	size_t bytes, uninitialized_var(size);
+	const struct of_device_id *match;
+	const struct smmu_platform_data *pdata;
+	int nr_xlats;
 
 	if (smmu_handle)
 		return -EIO;
 
 	BUILD_BUG_ON(PAGE_SHIFT != SMMU_PAGE_SHIFT);
 
-	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
-		return -ENODEV;
+	match = of_match_device(tegra_smmu_of_match, &pdev->dev);
+	if (!match)
+		return -EINVAL;
+	pdata = match->data;
+	nr_xlats = (pdata && pdata->nr_xlats) ?	pdata->nr_xlats : 3;
 
+	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
+		asids = (pdata && pdata->asids) ? pdata->asids : 4;
 	if (asids < NUM_OF_STATIC_MAPS)
 		return -EINVAL;
 
 	bytes = sizeof(*smmu) + asids * (sizeof(*smmu->as) +
 					 sizeof(struct dma_iommu_mapping *));
+	bytes += sizeof(u32) * nr_xlats;
 	smmu = devm_kzalloc(dev, bytes, GFP_KERNEL);
 	if (!smmu) {
 		dev_err(dev, "failed to allocate smmu_device\n");
@@ -1272,6 +1300,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 
 	smmu->clients = RB_ROOT;
 	smmu->map = (struct dma_iommu_mapping **)(smmu->as + asids);
+	smmu->xlat = (u32 *)(smmu->map + smmu->num_as);
 	smmu->nregs = pdev->num_resources;
 	smmu->regs = devm_kzalloc(dev, 2 * smmu->nregs * sizeof(*smmu->regs),
 				  GFP_KERNEL);
@@ -1304,13 +1333,12 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	smmu->ahb = of_parse_phandle(dev->of_node, "nvidia,ahb", 0);
 	smmu->iommu.dev = dev;
 	smmu->num_as = asids;
+	smmu->nr_xlats = nr_xlats;
 	smmu->iovmm_base = base;
 	smmu->page_count = size;
-
-	smmu->translation_enable_0 = ~0;
-	smmu->translation_enable_1 = ~0;
-	smmu->translation_enable_2 = ~0;
 	smmu->asid_security = 0;
+	for (i = 0; i < smmu->nr_xlats; i++)
+		smmu->xlat[i] = ~0;
 
 	for (i = 0; i < smmu->num_as; i++) {
 		struct smmu_as *as = &smmu->as[i];
@@ -1365,12 +1393,6 @@ static const struct dev_pm_ops tegra_smmu_pm_ops = {
 	.resume		= tegra_smmu_resume,
 };
 
-static struct of_device_id tegra_smmu_of_match[] = {
-	{ .compatible = "nvidia,tegra30-smmu", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, tegra_smmu_of_match);
-
 static struct platform_driver tegra_smmu_driver = {
 	.probe		= tegra_smmu_probe,
 	.remove		= tegra_smmu_remove,
-- 
1.8.1.5
