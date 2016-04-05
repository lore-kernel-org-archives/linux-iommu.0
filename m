From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 1/2] iommu: Support dynamic pgsize_bitmap
Date: Tue,  5 Apr 2016 14:01:29 -0700
Message-ID: <1459890090-16040-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Pratik Patel <pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Currently we use a single pgsize_bitmap per IOMMU driver.  However, some
IOMMU drivers might service different IOMMUs with different supported
page sizes.  Some drivers might also want to restrict page sizes for
different use cases.  Support these use cases by adding a
.get_pgsize_bitmap function to the iommu_ops which can optionally be
used by the driver to return a domain-specific pgsize_bitmap.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/iommu.c | 28 +++++++++++++++++++---------
 include/linux/iommu.h |  3 +++
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bfd4f7c3b1d8..6141710f3091 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -325,6 +325,13 @@ int iommu_group_set_name(struct iommu_group *group, const char *name)
 }
 EXPORT_SYMBOL_GPL(iommu_group_set_name);
 
+static unsigned long iommu_get_pgsize_bitmap(struct iommu_domain *domain)
+{
+	if (domain->ops->get_pgsize_bitmap)
+		return domain->ops->get_pgsize_bitmap(domain);
+	return domain->ops->pgsize_bitmap;
+}
+
 static int iommu_group_create_direct_mappings(struct iommu_group *group,
 					      struct device *dev)
 {
@@ -337,9 +344,9 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 	if (!domain || domain->type != IOMMU_DOMAIN_DMA)
 		return 0;
 
-	BUG_ON(!domain->ops->pgsize_bitmap);
+	BUG_ON(!(domain->ops->pgsize_bitmap || domain->ops->get_pgsize_bitmap));
 
-	pg_size = 1UL << __ffs(domain->ops->pgsize_bitmap);
+	pg_size = 1UL << __ffs(iommu_get_pgsize_bitmap(domain));
 	INIT_LIST_HEAD(&mappings);
 
 	iommu_get_dm_regions(dev, &mappings);
@@ -1318,14 +1325,15 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	int ret = 0;
 
 	if (unlikely(domain->ops->map == NULL ||
-		     domain->ops->pgsize_bitmap == 0UL))
+		     (domain->ops->pgsize_bitmap == 0UL &&
+		      !domain->ops->get_pgsize_bitmap)))
 		return -ENODEV;
 
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
 		return -EINVAL;
 
 	/* find out the minimum page size supported */
-	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
+	min_pagesz = 1 << __ffs(iommu_get_pgsize_bitmap(domain));
 
 	/*
 	 * both the virtual address and the physical one, as well as
@@ -1372,14 +1380,15 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 	unsigned long orig_iova = iova;
 
 	if (unlikely(domain->ops->unmap == NULL ||
-		     domain->ops->pgsize_bitmap == 0UL))
+		     (domain->ops->pgsize_bitmap == 0UL &&
+		      !domain->ops->get_pgsize_bitmap)))
 		return -ENODEV;
 
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
 		return -EINVAL;
 
 	/* find out the minimum page size supported */
-	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
+	min_pagesz = 1 << __ffs(iommu_get_pgsize_bitmap(domain));
 
 	/*
 	 * The virtual address, as well as the size of the mapping, must be
@@ -1425,10 +1434,11 @@ size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	unsigned int i, min_pagesz;
 	int ret;
 
-	if (unlikely(domain->ops->pgsize_bitmap == 0UL))
+	if (unlikely(domain->ops->pgsize_bitmap == 0UL &&
+		     !domain->ops->get_pgsize_bitmap))
 		return 0;
 
-	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
+	min_pagesz = 1 << __ffs(iommu_get_pgsize_bitmap(domain));
 
 	for_each_sg(sg, s, nents, i) {
 		phys_addr_t phys = page_to_phys(sg_page(s)) + s->offset;
@@ -1509,7 +1519,7 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 		break;
 	case DOMAIN_ATTR_PAGING:
 		paging  = data;
-		*paging = (domain->ops->pgsize_bitmap != 0UL);
+		*paging = (iommu_get_pgsize_bitmap(domain) != 0UL);
 		break;
 	case DOMAIN_ATTR_WINDOWS:
 		count = data;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a5c539fa5d2b..03f8d50670db 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -156,6 +156,8 @@ struct iommu_dm_region {
  * @domain_get_windows: Return the number of windows for a domain
  * @of_xlate: add OF master IDs to iommu grouping
  * @pgsize_bitmap: bitmap of supported page sizes
+ * @get_pgsize_bitmap: gets a bitmap of supported page sizes for a domain
+ *                     This takes precedence over @pgsize_bitmap.
  * @priv: per-instance data private to the iommu driver
  */
 struct iommu_ops {
@@ -200,6 +202,7 @@ struct iommu_ops {
 #endif
 
 	unsigned long pgsize_bitmap;
+	unsigned long (*get_pgsize_bitmap)(struct iommu_domain *domain);
 	void *priv;
 };
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
