From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [v3 3/5] iommu/tegra: smmu: Simplify allocation at once
Date: Mon, 25 Jun 2012 14:23:56 +0300
Message-ID: <1340623438-14958-3-git-send-email-hdoyu@nvidia.com>
References: <1340623438-14958-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340623438-14958-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

To simplify the code, alloc necessary data at once.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   29 +++++++++--------------------
 1 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 2c92b8c..98fcc72 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -241,8 +241,6 @@ struct smmu_device {
 	spinlock_t	lock;
 	char		*name;
 	struct device	*dev;
-	int		num_as;
-	struct smmu_as	*as;		/* Run-time allocated array */
 	struct page *avp_vector_page;	/* dummy page shared by all AS's */
 
 	/*
@@ -254,6 +252,9 @@ struct smmu_device {
 	unsigned long asid_security;
 
 	struct device_node *ahb;
+
+	int		num_as;
+	struct smmu_as	as[0];		/* Run-time allocated array */
 };
 
 static struct smmu_device *smmu_handle; /* unique for a system */
@@ -902,15 +903,18 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int i, asids, err = 0;
 	dma_addr_t base;
-	size_t size;
-	const void *prop;
+	size_t bytes, size;
 
 	if (smmu_handle)
 		return -EIO;
 
 	BUILD_BUG_ON(PAGE_SHIFT != SMMU_PAGE_SHIFT);
 
-	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
+	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
+		return -ENODEV;
+
+	bytes = sizeof(*smmu) + asids * sizeof(*smmu->as);
+	smmu = devm_kzalloc(dev, bytes, GFP_KERNEL);
 	if (!smmu) {
 		dev_err(dev, "failed to allocate smmu_device\n");
 		return -ENOMEM;
@@ -938,13 +942,6 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	if (!size)
 		return -EINVAL;
 
-	prop = of_get_property(dev->of_node, "nvidia,#asids", NULL);
-	if (!prop)
-		return -ENODEV;
-	asids = be32_to_cpup(prop);
-	if (!asids)
-		return -ENODEV;
-
 	smmu->ahb = of_parse_phandle(dev->of_node, "nvidia,ahb", 0);
 	if (!smmu->ahb)
 		return -ENODEV;
@@ -959,14 +956,6 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	smmu->translation_enable_2 = ~0;
 	smmu->asid_security = 0;
 
-	smmu->as = devm_kzalloc(dev,
-			sizeof(smmu->as[0]) * smmu->num_as, GFP_KERNEL);
-	if (!smmu->as) {
-		dev_err(dev, "failed to allocate smmu_as\n");
-		err = -ENOMEM;
-		goto fail;
-	}
-
 	for (i = 0; i < smmu->num_as; i++) {
 		struct smmu_as *as = &smmu->as[i];
 
-- 
1.7.5.4
