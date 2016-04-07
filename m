From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/5] iommu: Allow selecting page sizes per domain
Date: Thu,  7 Apr 2016 18:42:06 +0100
Message-ID: <9592488039a26b52df4ff36254928ad64e2c6aa4.1460048991.git.robin.murphy@arm.com>
References: <cover.1460048991.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1460048991.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Many IOMMUs support multiple page table formats, meaning that any given
domain may only support a subset of the hardware page sizes presented in
iommu_ops->pgsize_bitmap. There are also certain use-cases where the
creator of a domain may want to control which page sizes are used, for
example to force the use of hugepage mappings to reduce pagetable walk
depth.

To this end, add a per-domain pgsize_bitmap to represent the subset of
page sizes actually in use, to make it possible for domains with
different requirements to coexist.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
[rm: hijacked and rebased original patch with new commit message]
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/dma-iommu.c       |  2 +-
 drivers/iommu/iommu.c           | 22 ++++++++++++----------
 drivers/iommu/mtk_iommu.c       |  2 +-
 drivers/vfio/vfio_iommu_type1.c |  2 +-
 include/linux/iommu.h           |  3 ++-
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58f2fe6..6edc852 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -94,7 +94,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size
 		return -ENODEV;
 
 	/* Use the smallest supported page size for IOVA granularity */
-	order = __ffs(domain->ops->pgsize_bitmap);
+	order = __ffs(domain->pgsize_bitmap);
 	base_pfn = max_t(unsigned long, 1, base >> order);
 	end_pfn = (base + size - 1) >> order;
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b9df141..ab4d014 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -337,9 +337,9 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 	if (!domain || domain->type != IOMMU_DOMAIN_DMA)
 		return 0;
 
-	BUG_ON(!domain->ops->pgsize_bitmap);
+	BUG_ON(!domain->pgsize_bitmap);
 
-	pg_size = 1UL << __ffs(domain->ops->pgsize_bitmap);
+	pg_size = 1UL << __ffs(domain->pgsize_bitmap);
 	INIT_LIST_HEAD(&mappings);
 
 	iommu_get_dm_regions(dev, &mappings);
@@ -1073,6 +1073,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 
 	domain->ops  = bus->iommu_ops;
 	domain->type = type;
+	/* Assume all sizes by default; the driver may override this later */
+	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
 
 	return domain;
 }
@@ -1297,7 +1299,7 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 	pgsize = (1UL << (pgsize_idx + 1)) - 1;
 
 	/* throw away page sizes not supported by the hardware */
-	pgsize &= domain->ops->pgsize_bitmap;
+	pgsize &= domain->pgsize_bitmap;
 
 	/* make sure we're still sane */
 	BUG_ON(!pgsize);
@@ -1319,14 +1321,14 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	int ret = 0;
 
 	if (unlikely(domain->ops->map == NULL ||
-		     domain->ops->pgsize_bitmap == 0UL))
+		     domain->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
 		return -EINVAL;
 
 	/* find out the minimum page size supported */
-	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
 
 	/*
 	 * both the virtual address and the physical one, as well as
@@ -1373,14 +1375,14 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 	unsigned long orig_iova = iova;
 
 	if (unlikely(domain->ops->unmap == NULL ||
-		     domain->ops->pgsize_bitmap == 0UL))
+		     domain->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
 		return -EINVAL;
 
 	/* find out the minimum page size supported */
-	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
 
 	/*
 	 * The virtual address, as well as the size of the mapping, must be
@@ -1426,10 +1428,10 @@ size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	unsigned int i, min_pagesz;
 	int ret;
 
-	if (unlikely(domain->ops->pgsize_bitmap == 0UL))
+	if (unlikely(domain->pgsize_bitmap == 0UL))
 		return 0;
 
-	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
+	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
 
 	for_each_sg(sg, s, nents, i) {
 		phys_addr_t phys = page_to_phys(sg_page(s)) + s->offset;
@@ -1510,7 +1512,7 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 		break;
 	case DOMAIN_ATTR_PAGING:
 		paging  = data;
-		*paging = (domain->ops->pgsize_bitmap != 0UL);
+		*paging = (domain->pgsize_bitmap != 0UL);
 		break;
 	case DOMAIN_ATTR_WINDOWS:
 		count = data;
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index db74553..c3043d8 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -269,7 +269,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_data *data)
 	}
 
 	/* Update our support page sizes bitmap */
-	mtk_iommu_ops.pgsize_bitmap = dom->cfg.pgsize_bitmap;
+	dom->domain.pgsize_bitmap = dom->cfg.pgsize_bitmap;
 
 	writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
 	       data->base + REG_MMU_PT_BASE_ADDR);
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 75b24e9..15a6582 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -407,7 +407,7 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
 
 	mutex_lock(&iommu->lock);
 	list_for_each_entry(domain, &iommu->domain_list, next)
-		bitmap &= domain->domain->ops->pgsize_bitmap;
+		bitmap &= domain->domain->pgsize_bitmap;
 	mutex_unlock(&iommu->lock);
 
 	/*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 45b055d..664683a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -79,6 +79,7 @@ struct iommu_domain_geometry {
 struct iommu_domain {
 	unsigned type;
 	const struct iommu_ops *ops;
+	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	iommu_fault_handler_t handler;
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
@@ -156,7 +157,7 @@ struct iommu_dm_region {
  * @domain_set_windows: Set the number of windows for a domain
  * @domain_get_windows: Return the number of windows for a domain
  * @of_xlate: add OF master IDs to iommu grouping
- * @pgsize_bitmap: bitmap of supported page sizes
+ * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
-- 
2.7.3.dirty
