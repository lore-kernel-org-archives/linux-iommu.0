Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E9718056
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:19:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CC83D75;
	Tue, 12 Sep 2023 09:19:38 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6B873F738;
	Tue, 12 Sep 2023 09:18:59 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	m.szyprowski@samsung.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	thierry.reding@gmail.com,
	vdumpa@nvidia.com
Subject: [PATCH 7/8] iommu: Retire map/unmap ops
Date: Tue, 12 Sep 2023 17:18:43 +0100
Message-Id: <d2afdf13b2fbf537713c3ec642dfd49d16dd9e6a.1694525662.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1694525662.git.robin.murphy@arm.com>
References: <cover.1694525662.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With everyone now implementing the new interfaces, clean up the last
remnants of the old map/unmap ops and simplify the calling logic again.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 60 ++++++++++---------------------------------
 include/linux/iommu.h |  6 -----
 2 files changed, 13 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3bfc56df4f78..c83f2e4c56f5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2417,30 +2417,6 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 	return pgsize;
 }
 
-static int __iommu_map_pages(struct iommu_domain *domain, unsigned long iova,
-			     phys_addr_t paddr, size_t size, int prot,
-			     gfp_t gfp, size_t *mapped)
-{
-	const struct iommu_domain_ops *ops = domain->ops;
-	size_t pgsize, count;
-	int ret;
-
-	pgsize = iommu_pgsize(domain, iova, paddr, size, &count);
-
-	pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx count %zu\n",
-		 iova, &paddr, pgsize, count);
-
-	if (ops->map_pages) {
-		ret = ops->map_pages(domain, iova, paddr, pgsize, count, prot,
-				     gfp, mapped);
-	} else {
-		ret = ops->map(domain, iova, paddr, pgsize, prot, gfp);
-		*mapped = ret ? 0 : pgsize;
-	}
-
-	return ret;
-}
-
 static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
@@ -2451,8 +2427,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	phys_addr_t orig_paddr = paddr;
 	int ret = 0;
 
-	if (unlikely(!(ops->map || ops->map_pages) ||
-		     domain->pgsize_bitmap == 0UL))
+	if (unlikely(!ops->map_pages || domain->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
@@ -2475,10 +2450,14 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
 
 	while (size) {
-		size_t mapped = 0;
+		size_t pgsize, count, mapped = 0;
 
-		ret = __iommu_map_pages(domain, iova, paddr, size, prot, gfp,
-					&mapped);
+		pgsize = iommu_pgsize(domain, iova, paddr, size, &count);
+
+		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx count %zu\n",
+			 iova, &paddr, pgsize, count);
+		ret = ops->map_pages(domain, iova, paddr, pgsize, count, prot,
+				     gfp, &mapped);
 		/*
 		 * Some pages may have been mapped, even if an error occurred,
 		 * so we should account for those so they can be unmapped.
@@ -2522,19 +2501,6 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_map);
 
-static size_t __iommu_unmap_pages(struct iommu_domain *domain,
-				  unsigned long iova, size_t size,
-				  struct iommu_iotlb_gather *iotlb_gather)
-{
-	const struct iommu_domain_ops *ops = domain->ops;
-	size_t pgsize, count;
-
-	pgsize = iommu_pgsize(domain, iova, iova, size, &count);
-	return ops->unmap_pages ?
-	       ops->unmap_pages(domain, iova, pgsize, count, iotlb_gather) :
-	       ops->unmap(domain, iova, pgsize, iotlb_gather);
-}
-
 static size_t __iommu_unmap(struct iommu_domain *domain,
 			    unsigned long iova, size_t size,
 			    struct iommu_iotlb_gather *iotlb_gather)
@@ -2544,8 +2510,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 
-	if (unlikely(!(ops->unmap || ops->unmap_pages) ||
-		     domain->pgsize_bitmap == 0UL))
+	if (unlikely(!ops->unmap_pages || domain->pgsize_bitmap == 0UL))
 		return 0;
 
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
@@ -2572,9 +2537,10 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	 * or we hit an area that isn't mapped.
 	 */
 	while (unmapped < size) {
-		unmapped_page = __iommu_unmap_pages(domain, iova,
-						    size - unmapped,
-						    iotlb_gather);
+		size_t pgsize, count;
+
+		pgsize = iommu_pgsize(domain, iova, iova, size - unmapped, &count);
+		unmapped_page = ops->unmap_pages(domain, iova, pgsize, count, iotlb_gather);
 		if (!unmapped_page)
 			break;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c50a769d569a..5c347029cf70 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -312,10 +312,8 @@ struct iommu_ops {
  * * ENODEV	- device specific errors, not able to be attached
  * * <others>	- treated as ENODEV by the caller. Use is discouraged
  * @set_dev_pasid: set an iommu domain to a pasid of device
- * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
  *             an iommu domain.
- * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @unmap_pages: unmap a number of pages of the same size from an iommu domain
  * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
  * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
@@ -334,13 +332,9 @@ struct iommu_domain_ops {
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
 			     ioasid_t pasid);
 
-	int (*map)(struct iommu_domain *domain, unsigned long iova,
-		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
 	int (*map_pages)(struct iommu_domain *domain, unsigned long iova,
 			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			 int prot, gfp_t gfp, size_t *mapped);
-	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
-			size_t size, struct iommu_iotlb_gather *iotlb_gather);
 	size_t (*unmap_pages)(struct iommu_domain *domain, unsigned long iova,
 			      size_t pgsize, size_t pgcount,
 			      struct iommu_iotlb_gather *iotlb_gather);
-- 
2.39.2.101.g768bb238c484.dirty

