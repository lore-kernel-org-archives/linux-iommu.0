From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 4/5] iommu/exynos: Add default_domain check in
 iommu_attach_device
Date: Thu, 24 Nov 2016 12:20:19 +0100
Message-ID: <1479986420-30859-5-git-send-email-m.szyprowski@samsung.com>
References: <1479986420-30859-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1479986420-30859-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds default_domain check before calling
exynos_iommu_detach_device. This path was intended only to cope with
default domains, which are automatically attached by the iommu core, so
return error if user tries to attach device, which is already attached
to other (non-default) domain.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 426b1534d4d3..63d9358a6d9c 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -859,8 +859,17 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 	if (!has_sysmmu(dev))
 		return -ENODEV;
 
-	if (owner->domain)
+	if (owner->domain) {
+		struct iommu_group *group = iommu_group_get(dev);
+
+		if (!group ||
+		    owner->domain != iommu_group_default_domain(group)) {
+			iommu_group_put(group);
+			return -EINVAL;
+		}
+		iommu_group_put(group);
 		exynos_iommu_detach_device(owner->domain, dev);
+	}
 
 	mutex_lock(&owner->rpm_lock);
 
-- 
1.9.1
