From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 12/19] iommu: exynos: remove useless device_add/remove
 callbacks
Date: Wed, 19 Nov 2014 12:15:41 +0100
Message-ID: <1416395748-10731-13-git-send-email-m.szyprowski@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

The driver doesn't need to do anything important in device add/remove
callbacks, because initialization will be done from device-tree specific
callbacks added later. IOMMU groups created by current code were never
used.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index a9616cd64e37..93b97df772f1 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1056,32 +1056,6 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
-static int exynos_iommu_add_device(struct device *dev)
-{
-	struct iommu_group *group;
-	int ret;
-
-	group = iommu_group_get(dev);
-
-	if (!group) {
-		group = iommu_group_alloc();
-		if (IS_ERR(group)) {
-			dev_err(dev, "Failed to allocate IOMMU group\n");
-			return PTR_ERR(group);
-		}
-	}
-
-	ret = iommu_group_add_device(group, dev);
-	iommu_group_put(group);
-
-	return ret;
-}
-
-static void exynos_iommu_remove_device(struct device *dev)
-{
-	iommu_group_remove_device(dev);
-}
-
 static const struct iommu_ops exynos_iommu_ops = {
 	.domain_init = exynos_iommu_domain_init,
 	.domain_destroy = exynos_iommu_domain_destroy,
@@ -1090,8 +1064,6 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.map = exynos_iommu_map,
 	.unmap = exynos_iommu_unmap,
 	.iova_to_phys = exynos_iommu_iova_to_phys,
-	.add_device = exynos_iommu_add_device,
-	.remove_device = exynos_iommu_remove_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 };
 
-- 
1.9.2
