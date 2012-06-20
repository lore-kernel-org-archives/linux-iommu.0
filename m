From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/5] iommu/tegra: smmu: Remove unnecessary cleanups with
	devm_*()
Date: Wed, 20 Jun 2012 10:16:59 +0300
Message-ID: <1340176620-13012-4-git-send-email-hdoyu@nvidia.com>
References: <20120521124707.GC2604@amd.com>
	<1340176620-13012-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1340176620-13012-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Remove unnecessary cleanup procedures with devm_*() functions.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   37 ++++++-------------------------------
 1 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 5447f05..3ef7dea 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1039,51 +1039,26 @@ static int tegra_smmu_probe(struct platform_device *pdev)
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
