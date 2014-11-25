From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu: Decouple iommu_map_sg from CPU page size
Date: Tue, 25 Nov 2014 17:50:55 +0000
Message-ID: <2d38d270a532b52f73a720572f8f085dfa08321e.1416936761.git.robin.murphy@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

If the IOMMU supports pages smaller than the CPU page size, segments
which lie at offsets within the CPU page may be mapped based on the
finer-grained IOMMU page boundaries. This minimises the amount of
non-buffer memory between the CPU page boundary and the start of the
segment which must be mapped and therefore exposed to the device, and
brings the default iommu_map_sg implementation in line with
iommu_map/unmap with respect to alignment.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Hi Joerg,

I noticed this whilst wiring up DMA mapping to this new API - on arm64
we anticipate running 4k IOMMU pages with 64k CPU pages, in which case
the alignment check ends up being unnecessarily strict.

Regards,
Robin.

 drivers/iommu/iommu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 08c53c5..5c4101a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1129,14 +1129,24 @@ size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 {
 	struct scatterlist *s;
 	size_t mapped = 0;
-	unsigned int i;
+	unsigned int i, min_pagesz;
 	int ret;
 
+	if (unlikely(domain->ops->pgsize_bitmap == 0UL))
+		return 0;
+
+	min_pagesz = 1 << __ffs(domain->ops->pgsize_bitmap);
+
 	for_each_sg(sg, s, nents, i) {
-		phys_addr_t phys = page_to_phys(sg_page(s));
+		phys_addr_t phys = page_to_phys(sg_page(s)) + s->offset;
 
-		/* We are mapping on page boundarys, so offset must be 0 */
-		if (s->offset)
+		/*
+		 * We are mapping on IOMMU page boundaries, so offset within
+		 * the page must be 0. However, the IOMMU may support pages
+		 * smaller than PAGE_SIZE, so s->offset may still represent
+		 * an offset of that boundary within the CPU page.
+		 */
+		if (!IS_ALIGNED(s->offset, min_pagesz))
 			goto out_err;
 
 		ret = iommu_map(domain, iova + mapped, phys, s->length, prot);
-- 
1.9.1
