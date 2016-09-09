From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 21/20] drm/exynos: Fix iommu_dma_init_domain prototype change
Date: Fri,  9 Sep 2016 19:17:46 +0100
Message-ID: <47cdafe035630f29aa1e8ff121c5a5306a2f1eb2.1473444220.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1473173789.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, punit.agrawal-5wv7dgnIgG8@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When adding an extra argument to a function, one really should try a bit
harder to catch *all* the callers...

CC: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
CC: Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
CC: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>
CC: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

---

Ideally, this should be squashed into "iommu/dma: Avoid PCI host bridge
windows" to avoid potential bisection breakage. Sorry!

 drivers/gpu/drm/exynos/exynos_drm_iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.h b/drivers/gpu/drm/exynos/exynos_drm_iommu.h
index c8de4913fdbe..87f6b5672e11 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_iommu.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.h
@@ -66,7 +66,7 @@ static inline int __exynos_iommu_create_mapping(struct exynos_drm_private *priv,
 	if (ret)
 		goto free_domain;
 
-	ret = iommu_dma_init_domain(domain, start, size);
+	ret = iommu_dma_init_domain(domain, start, size, NULL);
 	if (ret)
 		goto put_cookie;
 
-- 
2.8.1.dirty
