From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v7 12/25] iommu/exynos: Add/remove callbacks should fail if no
 iommu is available
Date: Tue, 19 May 2015 15:20:32 +0200
Message-ID: <1432041645-11172-13-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Return fail if given master device passed to add_device/remove_device
callbacks doesn't has associated any sysmmu controller.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 0e7250fda087..a5f0c99602c2 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1081,6 +1081,9 @@ static int exynos_iommu_add_device(struct device *dev)
 	struct iommu_group *group;
 	int ret;
 
+	if (!has_sysmmu(dev))
+		return -ENODEV;
+
 	group = iommu_group_get(dev);
 
 	if (!group) {
@@ -1099,6 +1102,9 @@ static int exynos_iommu_add_device(struct device *dev)
 
 static void exynos_iommu_remove_device(struct device *dev)
 {
+	if (!has_sysmmu(dev))
+		return;
+
 	iommu_group_remove_device(dev);
 }
 
-- 
1.9.2
