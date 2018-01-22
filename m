From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v3] vfio/type1: Adopt fast IOTLB flush interface when unmap
	IOVAs
Date: Sun, 21 Jan 2018 23:29:37 -0500
Message-ID: <1516595377-4681-1-git-send-email-suravee.suthikulpanit@amd.com>
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
To: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

VFIO IOMMU type1 currently upmaps IOVA pages synchronously, which requires
IOTLB flushing for every unmapping. This results in large IOTLB flushing
overhead when handling pass-through devices has a large number of mapped
IOVAs (e.g. GPUs). This could also cause IOTLB invalidate time-out issue
on AMD IOMMU with certain dGPUs.

This can be avoided by using the new IOTLB flushing interface.

Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
Changes from V2: (https://lkml.org/lkml/2017/12/27/43)

  * In vfio_unmap_unpin(), fallback to use slow IOTLB flush
    when fast IOTLB flush fails (per Alex).

  * Do not adopt fast IOTLB flush in map_try_harder().

  * Submit VFIO and AMD IOMMU patches separately.

 drivers/vfio/vfio_iommu_type1.c | 98 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e30e29a..5c40b00 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -102,6 +102,13 @@ struct vfio_pfn {
 	atomic_t		ref_count;
 };
 
+struct vfio_regions {
+	struct list_head list;
+	dma_addr_t iova;
+	phys_addr_t phys;
+	size_t len;
+};
+
 #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
 					(!list_empty(&iommu->domain_list))
 
@@ -479,6 +486,36 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
 	return unlocked;
 }
 
+/*
+ * Generally, VFIO needs to unpin remote pages after each IOTLB flush.
+ * Therefore, when using IOTLB flush sync interface, VFIO need to keep track
+ * of these regions (currently using a list).
+ *
+ * This value specifies maximum number of regions for each IOTLB flush sync.
+ */
+#define VFIO_IOMMU_TLB_SYNC_MAX		512
+
+static long vfio_sync_unpin(struct vfio_dma *dma, struct vfio_domain *domain,
+				struct list_head *regions)
+{
+	long unlocked = 0;
+	struct vfio_regions *entry, *next;
+
+	iommu_tlb_sync(domain->domain);
+
+	list_for_each_entry_safe(entry, next, regions, list) {
+		unlocked += vfio_unpin_pages_remote(dma,
+						    entry->iova,
+						    entry->phys >> PAGE_SHIFT,
+						    entry->len >> PAGE_SHIFT,
+						    false);
+		list_del(&entry->list);
+		kfree(entry);
+	}
+	cond_resched();
+	return unlocked;
+}
+
 static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
 				  unsigned long *pfn_base, bool do_accounting)
 {
@@ -648,12 +685,40 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
 	return i > npage ? npage : (i > 0 ? i : -EINVAL);
 }
 
+static size_t try_unmap_unpin_fast(struct vfio_domain *domain, dma_addr_t iova,
+				   size_t len, phys_addr_t phys,
+				   struct list_head *unmapped_regions)
+{
+	struct vfio_regions *entry;
+	size_t unmapped;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	unmapped = iommu_unmap_fast(domain->domain, iova, len);
+	if (WARN_ON(!unmapped)) {
+		kfree(entry);
+		return -EINVAL;
+	}
+
+	iommu_tlb_range_add(domain->domain, iova, unmapped);
+	entry->iova = iova;
+	entry->phys = phys;
+	entry->len  = unmapped;
+	list_add_tail(&entry->list, unmapped_regions);
+	return unmapped;
+}
+
 static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 			     bool do_accounting)
 {
 	dma_addr_t iova = dma->iova, end = dma->iova + dma->size;
 	struct vfio_domain *domain, *d;
+	struct list_head unmapped_regions;
+	bool use_fastpath = true;
 	long unlocked = 0;
+	int cnt = 0;
 
 	if (!dma->size)
 		return 0;
@@ -661,6 +726,8 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
 		return 0;
 
+	INIT_LIST_HEAD(&unmapped_regions);
+
 	/*
 	 * We use the IOMMU to track the physical addresses, otherwise we'd
 	 * need a much more complicated tracking system.  Unfortunately that
@@ -698,6 +765,33 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 				break;
 		}
 
+		/*
+		 * First, try to use fast unmap/unpin. In case of failure,
+		 * sync upto the current point, and continue the slow
+		 * unmap/unpin path.
+		 */
+		if (use_fastpath) {
+			unmapped = try_unmap_unpin_fast(domain, iova,
+							len, phys,
+							&unmapped_regions);
+			if (unmapped > 0) {
+				iova += unmapped;
+				cnt++;
+			} else {
+				use_fastpath = false;
+			}
+
+			if (cnt >= VFIO_IOMMU_TLB_SYNC_MAX || !use_fastpath) {
+				unlocked += vfio_sync_unpin(dma, domain,
+							    &unmapped_regions);
+				cnt = 0;
+			}
+
+			if (use_fastpath)
+				continue;
+		}
+
+		/* Slow unmap/unpin path */
 		unmapped = iommu_unmap(domain->domain, iova, len);
 		if (WARN_ON(!unmapped))
 			break;
@@ -712,6 +806,10 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 	}
 
 	dma->iommu_mapped = false;
+
+	if (cnt)
+		unlocked += vfio_sync_unpin(dma, domain, &unmapped_regions);
+
 	if (do_accounting) {
 		vfio_lock_acct(dma->task, -unlocked, NULL);
 		return 0;
-- 
1.8.3.1
