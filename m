From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 5/5] iommu/exynos: Properly release device from the default
 domain in ->remove
Date: Thu, 24 Nov 2016 12:20:20 +0100
Message-ID: <1479986420-30859-6-git-send-email-m.szyprowski@samsung.com>
References: <1479986420-30859-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1479986420-30859-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

IOMMU core doesn't detach device from the default domain before calling
->iommu_remove_device, so check that and do the proper cleanup or
warn if device is still attached to non-default domain.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 63d9358a6d9c..0223db074d03 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1245,9 +1245,21 @@ static int exynos_iommu_add_device(struct device *dev)
 
 static void exynos_iommu_remove_device(struct device *dev)
 {
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+
 	if (!has_sysmmu(dev))
 		return;
 
+	if (owner->domain) {
+		struct iommu_group *group = iommu_group_get(dev);
+
+		if (group) {
+			WARN_ON(owner->domain !=
+				iommu_group_default_domain(group));
+			exynos_iommu_detach_device(owner->domain, dev);
+			iommu_group_put(group);
+		}
+	}
 	iommu_group_remove_device(dev);
 }
 
-- 
1.9.1
