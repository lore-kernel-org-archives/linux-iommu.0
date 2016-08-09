From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2] iommu/dma: Respect IOMMU aperture when allocating
Date: Tue,  9 Aug 2016 17:31:35 +0100
Message-ID: <3538fbec92fcbf2f0f4c98e28eaed89b9a0f1230.1470759552.git.robin.murphy@arm.com>
References: <3feb8016c2def4aabc5513b548e17bbf57c27959.1470755555.git.robin.murphy@arm.com>
	<6d73ab5fb671089057b31beb73667c09147a0f0e.1470755555.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6d73ab5fb671089057b31beb73667c09147a0f0e.1470755555.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Where a device driver has set a 64-bit DMA mask to indicate the absence
of addressing limitations, we still need to ensure that we don't
allocate IOVAs beyond the actual input size of the IOMMU. The reported
aperture is the most reliable way we have of inferring that input
address size, so use that to enforce a hard upper limit where available.

Fixes: 0db2e5d18f76 ("iommu: Implement common IOMMU ops for DMA mapping")
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Now with bonus "not being completely broken" as well as the min()
change - seems the necessary prototype changes somehow wound up rebased
into a different patch :/

 drivers/iommu/dma-iommu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7d991c81c4fa..00c8a08d56e7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -152,12 +152,15 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
 	}
 }
 
-static struct iova *__alloc_iova(struct iova_domain *iovad, size_t size,
+static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
 		dma_addr_t dma_limit)
 {
+	struct iova_domain *iovad = domain->iova_cookie;
 	unsigned long shift = iova_shift(iovad);
 	unsigned long length = iova_align(iovad, size) >> shift;
 
+	if (domain->geometry.force_aperture)
+		dma_limit = min(dma_limit, domain->geometry.aperture_end);
 	/*
 	 * Enforce size-alignment to be safe - there could perhaps be an
 	 * attribute to control this per-device, or at least per-domain...
@@ -315,7 +318,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	if (!pages)
 		return NULL;
 
-	iova = __alloc_iova(iovad, size, dev->coherent_dma_mask);
+	iova = __alloc_iova(domain, size, dev->coherent_dma_mask);
 	if (!iova)
 		goto out_free_pages;
 
@@ -387,7 +390,7 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	size_t iova_off = iova_offset(iovad, phys);
 	size_t len = iova_align(iovad, size + iova_off);
-	struct iova *iova = __alloc_iova(iovad, len, dma_get_mask(dev));
+	struct iova *iova = __alloc_iova(domain, len, dma_get_mask(dev));
 
 	if (!iova)
 		return DMA_ERROR_CODE;
@@ -539,7 +542,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
-	iova = __alloc_iova(iovad, iova_len, dma_get_mask(dev));
+	iova = __alloc_iova(domain, iova_len, dma_get_mask(dev));
 	if (!iova)
 		goto out_restore_sg;
 
-- 
2.8.1.dirty
