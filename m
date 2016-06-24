From: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v5 5/8] iommu/rockchip: Prepare to support generic DMA mapping
Date: Fri, 24 Jun 2016 10:13:30 +0800
Message-ID: <1466734413-7453-6-git-send-email-zhengsq@rock-chips.com>
References: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1466734413-7453-1-git-send-email-zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Set geometry for allocated domains and fix .domain_alloc() callback to
work with IOMMU_DOMAIN_DMA domain type, which is used for implicit
domains on ARM64.

Signed-off-by: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 712ed75..9afcbf7 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -889,7 +889,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	struct platform_device *pdev;
 	struct device *iommu_dev;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED)
+	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
 
 	/* Register a pdev per domain, so DMA API can base on this *dev
@@ -906,8 +906,8 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 
 	rk_domain->pdev = pdev;
 
-	/* To init the iovad which is required by iommu_dma_init_domain() */
-	if (iommu_get_dma_cookie(&rk_domain->domain))
+	if (type == IOMMU_DOMAIN_DMA &&
+	    iommu_get_dma_cookie(&rk_domain->domain))
 		goto err_unreg_pdev;
 
 	/*
@@ -933,12 +933,17 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
 	spin_lock_init(&rk_domain->dt_lock);
 	INIT_LIST_HEAD(&rk_domain->iommus);
 
+	rk_domain->domain.geometry.aperture_start = 0;
+	rk_domain->domain.geometry.aperture_end   = DMA_BIT_MASK(32);
+	rk_domain->domain.geometry.force_aperture = true;
+
 	return &rk_domain->domain;
 
 err_free_dt:
 	free_page((unsigned long)rk_domain->dt);
 err_put_cookie:
-	iommu_put_dma_cookie(&rk_domain->domain);
+	if (type == IOMMU_DOMAIN_DMA)
+		iommu_put_dma_cookie(&rk_domain->domain);
 err_unreg_pdev:
 	platform_device_unregister(pdev);
 
@@ -967,7 +972,8 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 			 SPAGE_SIZE, DMA_TO_DEVICE);
 	free_page((unsigned long)rk_domain->dt);
 
-	iommu_put_dma_cookie(&rk_domain->domain);
+	if (domain->type == IOMMU_DOMAIN_DMA)
+		iommu_put_dma_cookie(&rk_domain->domain);
 
 	platform_device_unregister(rk_domain->pdev);
 }
-- 
1.9.1
