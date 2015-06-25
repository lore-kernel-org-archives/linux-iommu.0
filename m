From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] iommu/exynos: Skip unsupported devices instead of returning
 -ENODEV
Date: Thu, 25 Jun 2015 15:10:44 +0200
Message-ID: <1435237844-25004-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

IOMMU core calls add_device() for every device on the given bus and
since commit 19762d7095e6392b6ec56c363a6f29b2119488c2 ("iommu: Propagate
error in add_iommu_group") all error from it are propagated to the iommu
core. In case of platform bus there are many devices without sysmmu
controller, so skip them gently instead of returning error, which would
be propagated up to bus_set_iommu() and cause initialization failure.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Please queue this patch to v4.2-rcX line. It fixes regression introduced
by a commit merged in parallel to the exynos iommu patches.
---
 drivers/iommu/exynos-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 97c41b8ab5d9..e7f873253a6b 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1119,8 +1119,9 @@ static int exynos_iommu_add_device(struct device *dev)
 	struct iommu_group *group;
 	int ret;
 
+	/* skip devices which doesn't have sysmmu controller */
 	if (!has_sysmmu(dev))
-		return -ENODEV;
+		return 0;
 
 	group = iommu_group_get(dev);
 
-- 
1.9.2
