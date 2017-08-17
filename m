From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 03/13] vfio/type1: Use sychronized interface of the IOMMU-API
Date: Thu, 17 Aug 2017 14:56:26 +0200
Message-ID: <1502974596-23835-4-git-send-email-joro@8bytes.org>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502974596-23835-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The map and unmap functions of the IOMMU-API changed their
semantics: They do no longer guarantee that the hardware
TLBs are synchronized with the page-table updates they made.

To make conversion easier, new synchronized functions have
been introduced which give these guarantees again until the
code is converted to use the new TLB-flush interface of the
IOMMU-API, which allows certain optimizations.

But for now, just convert this code to use the synchronized
functions so that it will behave as before.

Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/vfio/vfio_iommu_type1.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 8549cb1..4ad83d4 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -672,7 +672,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 				      struct vfio_domain, next);
 
 	list_for_each_entry_continue(d, &iommu->domain_list, next) {
-		iommu_unmap(d->domain, dma->iova, dma->size);
+		iommu_unmap_sync(d->domain, dma->iova, dma->size);
 		cond_resched();
 	}
 
@@ -687,9 +687,9 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 		}
 
 		/*
-		 * To optimize for fewer iommu_unmap() calls, each of which
-		 * may require hardware cache flushing, try to find the
-		 * largest contiguous physical memory chunk to unmap.
+		 * To optimize for fewer iommu_unmap_sync() calls, each of which
+		 * may require hardware cache flushing, try to find the largest
+		 * contiguous physical memory chunk to unmap.
 		 */
 		for (len = PAGE_SIZE;
 		     !domain->fgsp && iova + len < end; len += PAGE_SIZE) {
@@ -698,7 +698,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 				break;
 		}
 
-		unmapped = iommu_unmap(domain->domain, iova, len);
+		unmapped = iommu_unmap_sync(domain->domain, iova, len);
 		if (WARN_ON(!unmapped))
 			break;
 
@@ -877,15 +877,15 @@ static int map_try_harder(struct vfio_domain *domain, dma_addr_t iova,
 	int ret = 0;
 
 	for (i = 0; i < npage; i++, pfn++, iova += PAGE_SIZE) {
-		ret = iommu_map(domain->domain, iova,
-				(phys_addr_t)pfn << PAGE_SHIFT,
-				PAGE_SIZE, prot | domain->prot);
+		ret = iommu_map_sync(domain->domain, iova,
+				     (phys_addr_t)pfn << PAGE_SHIFT,
+				     PAGE_SIZE, prot | domain->prot);
 		if (ret)
 			break;
 	}
 
 	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE)
-		iommu_unmap(domain->domain, iova, PAGE_SIZE);
+		iommu_unmap_sync(domain->domain, iova, PAGE_SIZE);
 
 	return ret;
 }
@@ -897,8 +897,9 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 	int ret;
 
 	list_for_each_entry(d, &iommu->domain_list, next) {
-		ret = iommu_map(d->domain, iova, (phys_addr_t)pfn << PAGE_SHIFT,
-				npage << PAGE_SHIFT, prot | d->prot);
+		ret = iommu_map_sync(d->domain, iova,
+				     (phys_addr_t)pfn << PAGE_SHIFT,
+				     npage << PAGE_SHIFT, prot | d->prot);
 		if (ret) {
 			if (ret != -EBUSY ||
 			    map_try_harder(d, iova, pfn, npage, prot))
@@ -912,7 +913,7 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 
 unwind:
 	list_for_each_entry_continue_reverse(d, &iommu->domain_list, next)
-		iommu_unmap(d->domain, iova, npage << PAGE_SHIFT);
+		iommu_unmap_sync(d->domain, iova, npage << PAGE_SHIFT);
 
 	return ret;
 }
@@ -1102,8 +1103,8 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 				size = npage << PAGE_SHIFT;
 			}
 
-			ret = iommu_map(domain->domain, iova, phys,
-					size, dma->prot | domain->prot);
+			ret = iommu_map_sync(domain->domain, iova, phys,
+					     size, dma->prot | domain->prot);
 			if (ret)
 				return ret;
 
@@ -1133,13 +1134,14 @@ static void vfio_test_domain_fgsp(struct vfio_domain *domain)
 	if (!pages)
 		return;
 
-	ret = iommu_map(domain->domain, 0, page_to_phys(pages), PAGE_SIZE * 2,
-			IOMMU_READ | IOMMU_WRITE | domain->prot);
+	ret = iommu_map_sync(domain->domain, 0, page_to_phys(pages),
+			     PAGE_SIZE * 2,
+			     IOMMU_READ | IOMMU_WRITE | domain->prot);
 	if (!ret) {
-		size_t unmapped = iommu_unmap(domain->domain, 0, PAGE_SIZE);
+		size_t unmapped = iommu_unmap_sync(domain->domain, 0, PAGE_SIZE);
 
 		if (unmapped == PAGE_SIZE)
-			iommu_unmap(domain->domain, PAGE_SIZE, PAGE_SIZE);
+			iommu_unmap_sync(domain->domain, PAGE_SIZE, PAGE_SIZE);
 		else
 			domain->fgsp = true;
 	}
-- 
2.7.4
