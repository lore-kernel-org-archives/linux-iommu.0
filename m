From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH RESEND] iommu/dma: Don't touch invalid iova_domain members
Date: Mon, 15 May 2017 16:01:30 +0100
Message-ID: <122f47aa5596dc8ef0a1ee76e4425c7b597479a4.1494859975.git.robin.murphy@arm.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When __iommu_dma_map() and iommu_dma_free_iova() are called from
iommu_dma_get_msi_page(), various iova_*() helpers are still invoked in
the process, whcih is unwise since they access a different member of the
union (the iova_domain) from that which was last written, and there's no
guarantee that sensible values will result anyway.

CLean up the code paths that are valid for an MSI cookie to ensure we
only do iova_domain-specific things when we're actually dealing with one.

Fixes: a44e6657585b ("iommu/dma: Clean up MSI IOVA allocation")
Reported-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Tested-by: Shanker Donthineni <shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Tested-by: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Resending rebased to 4.12-rc1 with fixes tag.

 drivers/iommu/dma-iommu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 8348f366ddd1..62618e77bedc 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -396,13 +396,13 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 		dma_addr_t iova, size_t size)
 {
 	struct iova_domain *iovad = &cookie->iovad;
-	unsigned long shift = iova_shift(iovad);
 
 	/* The MSI case is only ever cleaning up its most recent allocation */
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
 		cookie->msi_iova -= size;
 	else
-		free_iova_fast(iovad, iova >> shift, size >> shift);
+		free_iova_fast(iovad, iova_pfn(iovad, iova),
+				size >> iova_shift(iovad));
 }
 
 static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
@@ -617,11 +617,14 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	struct iova_domain *iovad = &cookie->iovad;
-	size_t iova_off = iova_offset(iovad, phys);
+	size_t iova_off = 0;
 	dma_addr_t iova;
 
-	size = iova_align(iovad, size + iova_off);
+	if (cookie->type == IOMMU_DMA_IOVA_COOKIE) {
+		iova_off = iova_offset(&cookie->iovad, phys);
+		size = iova_align(&cookie->iovad, size + iova_off);
+	}
+
 	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
 	if (!iova)
 		return DMA_ERROR_CODE;
-- 
2.12.2.dirty
