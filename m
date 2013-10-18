From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv3 19/19] iommu/tegra: smmu: Support Multiple ASID
Date: Fri, 18 Oct 2013 13:27:00 +0300
Message-ID: <1382092020-13170-20-git-send-email-hdoyu@nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1382092020-13170-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
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
index 66406b7..e703741 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -925,7 +925,18 @@ enum {
 static int smmu_iommu_add_device(struct device *dev)
 {
 	int err;
-	struct dma_iommu_mapping *map = smmu_handle->map[SYSTEM_DEFAULT];
+	u64 swgroups;
+	struct dma_iommu_mapping *map = NULL;
+
+	swgroups = smmu_of_get_memory_client(dev);
+	switch (swgroups) {
+	case TEGRA_SWGROUP_BIT(PPCS):
+		map = smmu_handle->map[SYSTEM_PROTECTED];
+		break;
+	default:
+		map = smmu_handle->map[SYSTEM_DEFAULT];
+		break;
+	}
 
 	if (!map)
 		goto out;
@@ -935,7 +946,7 @@ static int smmu_iommu_add_device(struct device *dev)
 		return err;
 
 out:
-	dev_dbg(dev, "Attached to map %p\n", map);
+	dev_dbg(dev, "Attached to map %p, swgroup:%08llx\n", map, swgroups);
 	return 0;
 }
 
-- 
1.8.1.5
