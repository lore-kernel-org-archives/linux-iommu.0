From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [v2 1/2] iommu/tegra: smmu: Simplify allocation at once
Date: Tue, 15 May 2012 11:12:48 +0300
Message-ID: <1337069574-2022-1-git-send-email-hdoyu@nvidia.com>
References: <4FB19677.4040702@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4FB19677.4040702-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

To simplify the code, alloc necessary data at once.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
---
This patch requires:

    [PATCH 1/1] dt: Add general DMA window parser
        http://marc.info/?l=linux-tegra&m=133671302703840&w=2
---
 drivers/iommu/tegra-smmu.c |   32 +++++++++++---------------------
 1 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index dbaba77..5eb32b3 100644
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
@@ -900,17 +901,21 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 {
 	struct smmu_device *smmu;
 	struct device *dev = &pdev->dev;
-	int i, asids, err = 0;
+	int i, err = 0;
+	u32 asids;
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
@@ -939,13 +944,6 @@ static int tegra_smmu_probe(struct platform_device *pdev)
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
@@ -960,14 +958,6 @@ static int tegra_smmu_probe(struct platform_device *pdev)
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
