From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [v3 4/5] iommu/tegra: smmu: Remove unnecessary cleanups with devm_*()
Date: Mon, 25 Jun 2012 14:23:57 +0300
Message-ID: <1340623438-14958-4-git-send-email-hdoyu@nvidia.com>
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

Remove unnecessary cleanup procedures with devm_*() functions.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   37 ++++++-------------------------------
 1 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 98fcc72..cc6aba4 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -971,51 +971,26 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	spin_lock_init(&smmu->lock);
 	err = smmu_setup_regs(smmu);
 	if (err)
-		goto fail;
+		return err;
 	platform_set_drvdata(pdev, smmu);
 
 	smmu->avp_vector_page = alloc_page(GFP_KERNEL);
 	if (!smmu->avp_vector_page)
-		goto fail;
+		return -ENOMEM;
 
 	smmu_handle = smmu;
 	return 0;
-
-fail:
-	if (smmu->avp_vector_page)
-		__free_page(smmu->avp_vector_page);
-	if (smmu && smmu->as) {
-		for (i = 0; i < smmu->num_as; i++) {
-			if (smmu->as[i].pdir_page) {
-				ClearPageReserved(smmu->as[i].pdir_page);
-				__free_page(smmu->as[i].pdir_page);
-			}
-		}
-		devm_kfree(dev, smmu->as);
-	}
-	devm_kfree(dev, smmu);
-	return err;
 }
 
 static int tegra_smmu_remove(struct platform_device *pdev)
 {
 	struct smmu_device *smmu = platform_get_drvdata(pdev);
-	struct device *dev = smmu->dev;
+	int i;
 
 	smmu_write(smmu, SMMU_CONFIG_DISABLE, SMMU_CONFIG);
-	platform_set_drvdata(pdev, NULL);
-	if (smmu->as) {
-		int i;
-
-		for (i = 0; i < smmu->num_as; i++)
-			free_pdir(&smmu->as[i]);
-		devm_kfree(dev, smmu->as);
-	}
-	if (smmu->avp_vector_page)
-		__free_page(smmu->avp_vector_page);
-	if (smmu->regs)
-		devm_iounmap(dev, smmu->regs);
-	devm_kfree(dev, smmu);
+	for (i = 0; i < smmu->num_as; i++)
+		free_pdir(&smmu->as[i]);
+	__free_page(smmu->avp_vector_page);
 	smmu_handle = NULL;
 	return 0;
 }
-- 
1.7.5.4
