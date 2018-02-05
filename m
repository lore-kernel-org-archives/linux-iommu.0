From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu: Do not return error code for APIs with size_t return
	type
Date: Mon,  5 Feb 2018 05:45:53 -0500
Message-ID: <1517827553-81034-1-git-send-email-suravee.suthikulpanit@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently, iommu_unmap, iommu_unmap_fast and iommu_map_sg return
size_t.  However, some of the return values are error codes (< 0),
which can be misinterpreted as large size. Therefore, returning size 0
instead to signify failure to map/unmap.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---

Note: This issue was previously discussed here (https://lkml.org/lkml/2018/1/30/873).

 drivers/iommu/amd_iommu.c |  2 +-
 drivers/iommu/iommu.c     |  6 +++---
 include/linux/iommu.h     | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7d5eb00..fed8059 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3037,7 +3037,7 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 	size_t unmap_size;
 
 	if (domain->mode == PAGE_MODE_NONE)
-		return -EINVAL;
+		return 0;
 
 	mutex_lock(&domain->api_lock);
 	unmap_size = iommu_unmap_page(domain, iova, page_size);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3de5c0b..dcd55fd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1568,10 +1568,10 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 
 	if (unlikely(ops->unmap == NULL ||
 		     domain->pgsize_bitmap == 0UL))
-		return -ENODEV;
+		return 0;
 
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
-		return -EINVAL;
+		return 0;
 
 	/* find out the minimum page size supported */
 	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
@@ -1584,7 +1584,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	if (!IS_ALIGNED(iova | size, min_pagesz)) {
 		pr_err("unaligned: iova 0x%lx size 0x%zx min_pagesz 0x%x\n",
 		       iova, size, min_pagesz);
-		return -EINVAL;
+		return 0;
 	}
 
 	pr_debug("unmap this: iova 0x%lx size 0x%zx\n", iova, size);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 41b8c57..19938ee 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -465,23 +465,23 @@ static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return -ENODEV;
 }
 
-static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			      size_t size)
+static inline size_t iommu_unmap(struct iommu_domain *domain,
+				 unsigned long iova, size_t size)
 {
-	return -ENODEV;
+	return 0;
 }
 
-static inline int iommu_unmap_fast(struct iommu_domain *domain, unsigned long iova,
-				   int gfp_order)
+static inline size_t iommu_unmap_fast(struct iommu_domain *domain,
+				      unsigned long iova, int gfp_order)
 {
-	return -ENODEV;
+	return 0;
 }
 
 static inline size_t iommu_map_sg(struct iommu_domain *domain,
 				  unsigned long iova, struct scatterlist *sg,
 				  unsigned int nents, int prot)
 {
-	return -ENODEV;
+	return 0;
 }
 
 static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
-- 
1.8.3.1
