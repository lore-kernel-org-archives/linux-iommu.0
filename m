From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] intel-iommu: Fix off-by-one in pagetable freeing
Date: Fri, 20 Dec 2013 12:33:43 -0700
Message-ID: <20131220193250.17903.48255.stgit@bling.home>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

dma_pte_free_level() has an off-by-one error when checking whether a
pte is completely covered by a range.  Take for example the case of
attempting to free pfn 0x0 - 0x1ff, ie. 512 entries covering the first
2M superpage.  The level_size() is 0x200 and we test:

static void dma_pte_free_level(...
	...

	if (!(0 > 0 || 0x1ff < 0 + 0x200)) {
		...
	}

Clearly the 2nd test is true, which means we fail to take the branch
to clear and free the pagetable entry.  As a result, we're leaking
pagetables and failing to install new pages over the range.

This was found with a PCI device assigned to a QEMU guest using
vfio-pci without a VGA device present.  The first 1M of guest
address space is mapped with various combinations of 4K pages, but
eventually the range is entirely freed and replaced with a 2M
contiguous mapping.  intel-iommu errors out with something like:

ERROR: DMA PTE for vPFN 0x0 already set (to 5c2b8003 not 849c00083)

In this case 5c2b8003 is the pointer to the previous leaf page that
was neither freed nor cleared and 849c00083 is the superpage entry
that we're trying to replace it with.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 43b9bfe..59779e1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -917,7 +917,7 @@ static void dma_pte_free_level(struct dmar_domain *domain, int level,
 
 		/* If range covers entire pagetable, free it */
 		if (!(start_pfn > level_pfn ||
-		      last_pfn < level_pfn + level_size(level))) {
+		      last_pfn < level_pfn + level_size(level) - 1)) {
 			dma_clear_pte(pte);
 			domain_flush_cache(domain, pte, sizeof(*pte));
 			free_pgtable_page(level_pte);
