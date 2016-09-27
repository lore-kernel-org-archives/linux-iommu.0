From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 09/11] vfio/type1: Reserve IOVAs for IOMMU_DOMAIN_MIXED domains
Date: Tue, 27 Sep 2016 20:48:36 +0000
Message-ID: <1475009318-2617-10-git-send-email-eric.auger@redhat.com>
References: <1475009318-2617-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1475009318-2617-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

For IOMMU_DOMAIN_MIXED domain types, the user space defines most
of the IOVA regions (UNMANAGED) and map them. Since we want to allow
the kernel to allocate spare IOVAs within the holes we need to reserve
the user space defined IOVA regions.

in vfio_test_domain_fgsp, we keep the original iommu_(un)map since
the purpose just is to try map/unmap and not to keep it.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/vfio/vfio_iommu_type1.c | 42 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index ad08fd0..2d1eede 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -37,6 +37,7 @@
 #include <linux/vfio.h>
 #include <linux/workqueue.h>
 #include <linux/dma-iommu.h>
+#include <linux/iova.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>"
@@ -255,6 +256,32 @@ static int vaddr_get_pfn(unsigned long vaddr, int prot, unsigned long *pfn)
 	return ret;
 }
 
+static int iommu_dma_map(struct iommu_domain *domain, unsigned long iova,
+			 phys_addr_t paddr, size_t size, int prot)
+{
+	switch (domain->type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		return iommu_map(domain, iova, paddr, size, prot);
+	case IOMMU_DOMAIN_MIXED:
+		return iommu_dma_map_mixed(domain, iova, paddr, size, prot);
+	default:
+		return -ENOENT;
+	}
+}
+
+static size_t iommu_dma_unmap(struct iommu_domain *domain, unsigned long iova,
+			      size_t size)
+{
+	switch (domain->type) {
+	case IOMMU_DOMAIN_UNMANAGED:
+		return iommu_unmap(domain, iova, size);
+	case IOMMU_DOMAIN_MIXED:
+		return iommu_dma_unmap_mixed(domain, iova, size);
+	default:
+		return -ENOENT;
+	}
+}
+
 /*
  * Attempt to pin pages.  We really don't want to track all the pfns and
  * the iommu can only map chunks of consecutive pfns anyway, so get the
@@ -353,7 +380,7 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
 				      struct vfio_domain, next);
 
 	list_for_each_entry_continue(d, &iommu->domain_list, next) {
-		iommu_unmap(d->domain, dma->iova, dma->size);
+		iommu_dma_unmap(d->domain, dma->iova, dma->size);
 		cond_resched();
 	}
 
@@ -379,7 +406,7 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
 				break;
 		}
 
-		unmapped = iommu_unmap(domain->domain, iova, len);
+		unmapped = iommu_dma_unmap(domain->domain, iova, len);
 		if (WARN_ON(!unmapped))
 			break;
 
@@ -519,7 +546,7 @@ static int map_try_harder(struct vfio_domain *domain, dma_addr_t iova,
 	int ret = 0;
 
 	for (i = 0; i < npage; i++, pfn++, iova += PAGE_SIZE) {
-		ret = iommu_map(domain->domain, iova,
+		ret = iommu_dma_map(domain->domain, iova,
 				(phys_addr_t)pfn << PAGE_SHIFT,
 				PAGE_SIZE, prot | domain->prot);
 		if (ret)
@@ -527,7 +554,7 @@ static int map_try_harder(struct vfio_domain *domain, dma_addr_t iova,
 	}
 
 	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE)
-		iommu_unmap(domain->domain, iova, PAGE_SIZE);
+		iommu_dma_unmap(domain->domain, iova, PAGE_SIZE);
 
 	return ret;
 }
@@ -539,7 +566,8 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 	int ret;
 
 	list_for_each_entry(d, &iommu->domain_list, next) {
-		ret = iommu_map(d->domain, iova, (phys_addr_t)pfn << PAGE_SHIFT,
+		ret = iommu_dma_map(d->domain, iova,
+				(phys_addr_t)pfn << PAGE_SHIFT,
 				npage << PAGE_SHIFT, prot | d->prot);
 		if (ret) {
 			if (ret != -EBUSY ||
@@ -554,7 +582,7 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 
 unwind:
 	list_for_each_entry_continue_reverse(d, &iommu->domain_list, next)
-		iommu_unmap(d->domain, iova, npage << PAGE_SHIFT);
+		iommu_dma_unmap(d->domain, iova, npage << PAGE_SHIFT);
 
 	return ret;
 }
@@ -690,7 +718,7 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 								 iova + size))
 				size += PAGE_SIZE;
 
-			ret = iommu_map(domain->domain, iova, phys,
+			ret = iommu_dma_map(domain->domain, iova, phys,
 					size, dma->prot | domain->prot);
 			if (ret)
 				return ret;
-- 
1.9.1
