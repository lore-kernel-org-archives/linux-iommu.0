From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH 2/2] iommu/tegra: assume CONFIG_OF in SMMU driver
Date: Fri, 15 Feb 2013 15:01:07 -0700
Message-ID: <1360965667-19699-2-git-send-email-swarren@wwwdotorg.org>
References: <1360965667-19699-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1360965667-19699-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Tegra only supports, and always enables, device tree. Remove all ifdefs
for DT support from the driver.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 05a8ddb..eb0109f 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1268,13 +1268,11 @@ const struct dev_pm_ops tegra_smmu_pm_ops = {
 	.resume		= tegra_smmu_resume,
 };
 
-#ifdef CONFIG_OF
 static struct of_device_id tegra_smmu_of_match[] = {
 	{ .compatible = "nvidia,tegra30-smmu", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tegra_smmu_of_match);
-#endif
 
 static struct platform_driver tegra_smmu_driver = {
 	.probe		= tegra_smmu_probe,
@@ -1283,7 +1281,7 @@ static struct platform_driver tegra_smmu_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "tegra-smmu",
 		.pm	= &tegra_smmu_pm_ops,
-		.of_match_table = of_match_ptr(tegra_smmu_of_match),
+		.of_match_table = tegra_smmu_of_match,
 	},
 };
 
-- 
1.7.10.4
