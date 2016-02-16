From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 01/11] iommu: exynos: rework iommu group initialization
Date: Tue, 16 Feb 2016 15:56:54 +0100
Message-ID: <1455634624-18130-2-git-send-email-m.szyprowski@samsung.com>
References: <1455634624-18130-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1455634624-18130-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch replaces custom code in add_device implementation with
iommu_group_get_for_dev() call and provides the needed callback.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 97c41b8..4fc0790 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1114,28 +1114,32 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 	return phys;
 }
 
+static struct iommu_group *get_device_iommu_group(struct device *dev)
+{
+	struct iommu_group *group;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		group = iommu_group_alloc();
+
+	return group;
+}
+
 static int exynos_iommu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
-	int ret;
 
 	if (!has_sysmmu(dev))
 		return -ENODEV;
 
-	group = iommu_group_get(dev);
+	group = iommu_group_get_for_dev(dev);
 
-	if (!group) {
-		group = iommu_group_alloc();
-		if (IS_ERR(group)) {
-			dev_err(dev, "Failed to allocate IOMMU group\n");
-			return PTR_ERR(group);
-		}
-	}
+	if (IS_ERR(group))
+		return PTR_ERR(group);
 
-	ret = iommu_group_add_device(group, dev);
 	iommu_group_put(group);
 
-	return ret;
+	return 0;
 }
 
 static void exynos_iommu_remove_device(struct device *dev)
@@ -1182,6 +1186,7 @@ static struct iommu_ops exynos_iommu_ops = {
 	.unmap = exynos_iommu_unmap,
 	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = exynos_iommu_iova_to_phys,
+	.device_group = get_device_iommu_group,
 	.add_device = exynos_iommu_add_device,
 	.remove_device = exynos_iommu_remove_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
-- 
1.9.2
