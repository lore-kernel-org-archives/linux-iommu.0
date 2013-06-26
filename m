From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 22/23] iommu/tegra: smmu: Support Multiple ASID
Date: Wed, 26 Jun 2013 12:28:25 +0300
Message-ID: <1372238906-9346-23-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Support Multiple Address Space(AS). Tegra SMMU can have multiple
ASes. We reserve 2 of them for static assignment, AS[0] for system
default, AS[1] for AHB clusters as protected domain from others, where
there are many traditional pheripheral devices like USB, SD/MMC. They
should be isolated from some smart devices like host1x for system
robustness. Even if smart devices behaves wrongly, the traditional
devices(SD/MMC, USB) wouldn't be affected, and the system could
continue most likely.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 96dbef3..9018151 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -904,7 +904,18 @@ enum {
 static int smmu_iommu_add_device(struct device *dev)
 {
 	int err;
-	struct dma_iommu_mapping *map = smmu_handle->map[SYSTEM_DEFAULT];
+	u64 swgids;
+	struct dma_iommu_mapping *map = NULL;
+
+	swgids = tegra_smmu_of_get_swgids(dev);
+	switch (swgids) {
+	case SWGID(PPCS):
+		map = smmu_handle->map[SYSTEM_PROTECTED];
+		break;
+	default:
+		map = smmu_handle->map[SYSTEM_DEFAULT];
+		break;
+	}
 
 	if (!map)
 		goto out;
@@ -915,7 +926,7 @@ static int smmu_iommu_add_device(struct device *dev)
 		return err;
 	}
 out:
-	dev_dbg(dev, "Attached to map %p\n", map);
+	dev_dbg(dev, "Attached to map %p, swgids:%08llx\n", map, swgids);
 	return 0;
 }
 
-- 
1.8.1.5
