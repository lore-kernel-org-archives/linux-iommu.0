From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 19/20] powerpc/dma: use the generic dma-direct map_page and
	map_sg routines
Date: Mon, 30 Jul 2018 18:38:23 +0200
Message-ID: <20180730163824.10064-20-hch@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180730163824.10064-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

These are indentical except for additional error checking, so migrate
to the common code, and wire up the get_mapping_error method as well.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/powerpc/kernel/dma.c | 32 ++++----------------------------
 1 file changed, 4 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index b2e88075b2ea..08b12cbd7abf 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -82,21 +82,6 @@ int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 			       vma->vm_page_prot);
 }
 
-static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
-			     int nents, enum dma_data_direction direction,
-			     unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i) {
-		sg->dma_address = phys_to_dma(dev, sg_phys(sg));
-		sg->dma_length = sg->length;
-	}
-
-	return nents;
-}
-
 /* note: needs to be called arch_get_required_mask for dma-noncoherent.c */
 u64 arch_get_required_mask(struct device *dev)
 {
@@ -110,24 +95,15 @@ u64 arch_get_required_mask(struct device *dev)
 	return mask;
 }
 
-static inline dma_addr_t dma_nommu_map_page(struct device *dev,
-					     struct page *page,
-					     unsigned long offset,
-					     size_t size,
-					     enum dma_data_direction dir,
-					     unsigned long attrs)
-{
-	return phys_to_dma(dev, page_to_phys(page)) + offset;
-}
-
 const struct dma_map_ops dma_nommu_ops = {
 	.alloc				= dma_nommu_alloc_coherent,
 	.free				= dma_nommu_free_coherent,
 	.mmap				= dma_nommu_mmap_coherent,
-	.map_sg				= dma_nommu_map_sg,
-	.dma_supported			= dma_direct_supported,
-	.map_page			= dma_nommu_map_page,
+	.map_sg				= dma_direct_map_sg,
+	.map_page			= dma_direct_map_page,
 	.get_required_mask		= arch_get_required_mask,
+	.dma_supported			= dma_direct_supported,
+	.mapping_error			= dma_direct_mapping_error,
 };
 
 #ifndef CONFIG_NOT_COHERENT_CACHE
-- 
2.18.0
