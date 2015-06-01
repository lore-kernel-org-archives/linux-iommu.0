From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/3] drm/exynos: iommu: improve a check for non-iommu dma_ops
Date: Mon, 01 Jun 2015 13:15:16 +0200
Message-ID: <1433157316-6341-4-git-send-email-m.szyprowski@samsung.com>
References: <1433157316-6341-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1433157316-6341-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

DRM Exynos driver is relying on dma-mapping internal structures when used
with IOMMU enabled. This patch partially hides dma-mapping internal things
by using proper get_dma_ops/set_dma_ops calls.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.c b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
index 323601a52a25..34596da7be33 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_iommu.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
@@ -117,8 +117,8 @@ int drm_iommu_attach_device(struct drm_device *drm_dev,
 	 * If iommu attach succeeded, the sub driver would have dma_ops
 	 * for iommu and also all sub drivers have same dma_ops.
 	 */
-	if (!dev->archdata.dma_ops)
-		dev->archdata.dma_ops = subdrv_dev->archdata.dma_ops;
+	if (get_dma_ops(dev) == get_dma_ops(NULL))
+		set_dma_ops(dev, get_dma_ops(subdrv_dev));
 
 	return 0;
 }
-- 
1.9.2
