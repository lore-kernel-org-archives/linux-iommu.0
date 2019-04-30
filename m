From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v2 3/4] iommu/dma-iommu: Use the dev->coherent_dma_mask
Date: Tue, 30 Apr 2019 04:12:22 -0700
Message-ID: <20190430111222.GA3191@infradead.org>
References: <20190430002952.18909-1-tmurphy@arista.com>
 <20190430002952.18909-4-tmurphy@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190430002952.18909-4-tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, murphyt7-/Zw1syy4LHg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>  static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> -		size_t size, int prot, struct iommu_domain *domain)
> +		size_t size, int prot, struct iommu_domain *domain,
> +		dma_addr_t dma_limit)

Can we just call this dma_mask?

>  static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
> @@ -1250,7 +1251,8 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  	if (!msi_page)
>  		return NULL;
>  
> -	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
> +	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain,
> +			dma_get_mask(dev));

Hmm, I don't think we need the DMA mask for the MSI mapping, this
should probably always use a 64-bit mask.  Or we could just untangle
it from the DMA mapping fast path entire, something like:

---
>From 0debafc85174ca830f2e371ff8e8f7465bde3ad8 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Date: Tue, 30 Apr 2019 07:06:23 -0400
Subject: iommu/dma: opencode __iommu_dma_map in iommu_dma_get_msi_page

The MSI page mapping really is a little different from the normal DMA
mappings and doesn't need to look at the DMA mask.  Just open code
it instead of trying to squeeze the behavior into the DMA path helpers.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c35bab7626..2ac0df0879d7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -358,11 +358,6 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long shift, iova_len, iova = 0;
 
-	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
-		cookie->msi_iova += size;
-		return cookie->msi_iova - size;
-	}
-
 	shift = iova_shift(iovad);
 	iova_len = size >> shift;
 	/*
@@ -397,10 +392,7 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 {
 	struct iova_domain *iovad = &cookie->iovad;
 
-	/* The MSI case is only ever cleaning up its most recent allocation */
-	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
-		cookie->msi_iova -= size;
-	else if (cookie->fq_domain)	/* non-strict mode */
+	if (cookie->fq_domain)	/* non-strict mode */
 		queue_iova(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad), 0);
 	else
@@ -430,14 +422,10 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	size_t iova_off = 0;
+	size_t iova_off = iova_offset(&cookie->iovad, phys);
 	dma_addr_t iova;
 
-	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
-		iova_off = iova_offset(&cookie->iovad, phys);
-		size = iova_align(&cookie->iovad, size + iova_off);
-	}
-
+	size = iova_align(&cookie->iovad, size + iova_off);
 	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
@@ -1121,7 +1109,6 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi_page;
-	dma_addr_t iova;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 	size_t size = cookie_msi_granule(cookie);
 
@@ -1134,16 +1121,16 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = __iommu_dma_map(dev, msi_addr, size, prot);
-	if (iova == DMA_MAPPING_ERROR)
+	if (iommu_map(domain, cookie->msi_iova, msi_addr, size, prot))
 		goto out_free_page;
 
 	INIT_LIST_HEAD(&msi_page->list);
 	msi_page->phys = msi_addr;
-	msi_page->iova = iova;
+	msi_page->iova = cookie->msi_iova;
 	list_add(&msi_page->list, &cookie->msi_page_list);
-	return msi_page;
 
+	cookie->msi_iova += size;
+	return msi_page;
 out_free_page:
 	kfree(msi_page);
 	return NULL;
-- 
2.20.1
