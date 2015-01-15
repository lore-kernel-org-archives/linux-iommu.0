From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] vfio/type1: DMA unmap chunking
Date: Thu, 15 Jan 2015 10:35:14 -0700
Message-ID: <20150115173513.29162.94145.stgit@gimli.home>
References: <20150115171023.29162.90105.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150115171023.29162.90105.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When unmapping DMA entries we try to rely on the IOMMU API behavior
that allows the IOMMU to unmap a larger area than requested, up to
the size of the original mapping.  This works great when the IOMMU
supports superpages *and* they're in use.  Otherwise, each PAGE_SIZE
increment is unmapped separately, resulting in poor performance.

Instead we can use the IOVA-to-physical-address translation provided
by the IOMMU API and unmap using the largest contiguous physical
memory chunk available, which is also how vfio/type1 would have
mapped the region.  For a synthetic 1TB guest VM mapping and shutdown
test on Intel VT-d (2M IOMMU pagesize support), this achieves about
a 30% overall improvement mapping standard 4K pages, regardless of
IOMMU superpage enabling, and about a 40% improvement mapping 2M
hugetlbfs pages when IOMMU superpages are not available.  Hugetlbfs
with IOMMU superpages enabled is effectively unchanged.

Unfortunately the same algorithm does not work well on IOMMUs with
fine-grained superpages, like AMD-Vi, costing about 25% extra since
the IOMMU will automatically unmap any power-of-two contiguous
mapping we've provided it.  We add a routine and a domain flag to
detect this feature, leaving AMD-Vi unaffected by this unmap
optimization.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/vfio/vfio_iommu_type1.c |   54 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 4a9d666..e6e7f15 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -66,6 +66,7 @@ struct vfio_domain {
 	struct list_head	next;
 	struct list_head	group_list;
 	int			prot;		/* IOMMU_CACHE */
+	bool			fgsp;		/* Fine-grained super pages */
 };
 
 struct vfio_dma {
@@ -350,8 +351,8 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
 		iommu_unmap(d->domain, dma->iova, dma->size);
 
 	while (iova < end) {
-		size_t unmapped;
-		phys_addr_t phys;
+		size_t unmapped, len;
+		phys_addr_t phys, next;
 
 		phys = iommu_iova_to_phys(domain->domain, iova);
 		if (WARN_ON(!phys)) {
@@ -359,7 +360,19 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
 			continue;
 		}
 
-		unmapped = iommu_unmap(domain->domain, iova, PAGE_SIZE);
+		/*
+		 * To optimize for fewer iommu_unmap() calls, each of which
+		 * may require hardware cache flushing, try to find the
+		 * largest contiguous physical memory chunk to unmap.
+		 */
+		for (len = PAGE_SIZE;
+		     !domain->fgsp && iova + len < end; len += PAGE_SIZE) {
+			next = iommu_iova_to_phys(domain->domain, iova + len);
+			if (next != phys + len)
+				break;
+		}
+
+		unmapped = iommu_unmap(domain->domain, iova, len);
 		if (WARN_ON(!unmapped))
 			break;
 
@@ -665,6 +678,39 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 	return 0;
 }
 
+/*
+ * We change our unmap behavior slightly depending on whether the IOMMU
+ * supports fine-grained superpages.  IOMMUs like AMD-Vi will use a superpage
+ * for practically any contiguous power-of-two mapping we give it.  This means
+ * we don't need to look for contiguous chunks ourselves to make unmapping
+ * more efficient.  On IOMMUs with coarse-grained super pages, like Intel VT-d
+ * with discrete 2M/1G/512G/1T superpages, identifying contiguous chunks
+ * significantly boosts non-hugetlbfs mappings and doesn't seem to hurt when
+ * hugetlbfs is in use.
+ */
+static void vfio_test_domain_fgsp(struct vfio_domain *domain)
+{
+	struct page *pages;
+	int ret, order = get_order(PAGE_SIZE * 2);
+
+	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
+	if (!pages)
+		return;
+
+	ret = iommu_map(domain->domain, 0, page_to_phys(pages), PAGE_SIZE * 2,
+			IOMMU_READ | IOMMU_WRITE | domain->prot);
+	if (!ret) {
+		size_t unmapped = iommu_unmap(domain->domain, 0, PAGE_SIZE);
+
+		if (unmapped == PAGE_SIZE)
+			iommu_unmap(domain->domain, PAGE_SIZE, PAGE_SIZE);
+		else
+			domain->fgsp = true;
+	}
+
+	__free_pages(pages, order);
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -758,6 +804,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		}
 	}
 
+	vfio_test_domain_fgsp(domain);
+
 	/* replay mappings on new domains */
 	ret = vfio_iommu_replay(iommu, domain);
 	if (ret)
