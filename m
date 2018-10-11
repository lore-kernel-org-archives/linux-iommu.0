From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2] iommu: Do physical merging in iommu_map_sg()
Date: Thu, 11 Oct 2018 16:56:42 +0100
Message-ID: <90d22e679e64e9830ebe993665e2c04a612fdaf9.1539018455.git.robin.murphy@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The original motivation for iommu_map_sg() was to give IOMMU drivers the
chance to map an IOVA-contiguous scatterlist as efficiently as they
could. It turns out that there isn't really much driver-specific
business involved there, so now that the default implementation is
mandatory let's just improve that - the main thing we're after is to use
larger pages wherever possible, and as long as domain->pgsize_bitmap
reflects reality, iommu_map() can already do that in a generic way. All
we need to do is detect physically-contiguous segments and batch them
into a single map operation, since whatever we do here is transparent to
our caller and not bound by any segment-length restrictions on the list
itself.

Speaking of efficiency, there's really very little point in duplicating
the checks that iommu_map() is going to do anyway, so those get cleared
up in the process.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

One final attempt at a clean-ish loop without descending into real
code-golf madness...

 drivers/iommu/iommu.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c15c5980299..ea8ce6322714 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1676,33 +1676,32 @@ EXPORT_SYMBOL_GPL(iommu_unmap_fast);
 size_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 		    struct scatterlist *sg, unsigned int nents, int prot)
 {
-	struct scatterlist *s;
-	size_t mapped = 0;
-	unsigned int i, min_pagesz;
+	size_t len = 0, mapped = 0;
+	phys_addr_t start;
+	unsigned int i = 0;
 	int ret;
 
-	if (unlikely(domain->pgsize_bitmap == 0UL))
-		return 0;
+	while (i <= nents) {
+		phys_addr_t s_phys = sg_phys(sg);
 
-	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
+		if (len && s_phys != start + len) {
+			ret = iommu_map(domain, iova + mapped, start, len, prot);
+			if (ret)
+				goto out_err;
 
-	for_each_sg(sg, s, nents, i) {
-		phys_addr_t phys = page_to_phys(sg_page(s)) + s->offset;
+			mapped += len;
+			len = 0;
+		}
 
-		/*
-		 * We are mapping on IOMMU page boundaries, so offset within
-		 * the page must be 0. However, the IOMMU may support pages
-		 * smaller than PAGE_SIZE, so s->offset may still represent
-		 * an offset of that boundary within the CPU page.
-		 */
-		if (!IS_ALIGNED(s->offset, min_pagesz))
-			goto out_err;
+		if (len) {
+			len += sg->length;
+		} else {
+			len = sg->length;
+			start = s_phys;
+		}
 
-		ret = iommu_map(domain, iova + mapped, phys, s->length, prot);
-		if (ret)
-			goto out_err;
-
-		mapped += s->length;
+		if (++i < nents)
+			sg = sg_next(sg);
 	}
 
 	return mapped;
-- 
2.19.0.dirty
