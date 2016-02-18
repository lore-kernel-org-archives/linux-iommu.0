From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 01/13] iommu: exynos: rework iommu group initialization
Date: Thu, 18 Feb 2016 15:12:48 +0100
Message-ID: <1455804780-9616-2-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch replaces custom code in add_device implementation with
iommu_group_get_for_dev() call and provides the needed callback.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 97c41b8ab5d9..4fc079073c86 100644
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
