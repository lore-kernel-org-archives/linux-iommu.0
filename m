From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/3] parisc: always use flush_kernel_dcache_range for DMA
	cache maintainance
Date: Tue, 19 Jun 2018 09:04:54 +0200
Message-ID: <20180619070455.26624-3-hch@lst.de>
References: <20180619070455.26624-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180619070455.26624-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Current the S/G list based DMA ops use flush_kernel_vmap_range which
contains a few UP optimizations, while the rest of the DMA operations
uses flush_kernel_dcache_range.  The single vs sg operations are supposed
to have the same effect, so they should use the same routines.  Use
the more conservation version for now, but if people more familiar with
parisc think the vmap version is generally fine for DMA we should switch
all interfaces over to it.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/parisc/kernel/pci-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index d34cd6d34717..1f85ca2c0c9e 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -537,7 +537,7 @@ static void pa11_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
 
 	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_vmap_range(sg_virt(sg), sg->length);
+		flush_kernel_dcache_range(sg_virt(sg), sg->length);
 }
 
 static void pa11_dma_sync_single_for_cpu(struct device *dev,
@@ -568,7 +568,7 @@ static void pa11_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl
 	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
 
 	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_vmap_range(sg_virt(sg), sg->length);
+		flush_kernel_dcache_range(sg_virt(sg), sg->length);
 }
 
 static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sglist, int nents, enum dma_data_direction direction)
@@ -579,7 +579,7 @@ static void pa11_dma_sync_sg_for_device(struct device *dev, struct scatterlist *
 	/* once we do combining we'll need to use phys_to_virt(sg_dma_address(sglist)) */
 
 	for_each_sg(sglist, sg, nents, i)
-		flush_kernel_vmap_range(sg_virt(sg), sg->length);
+		flush_kernel_dcache_range(sg_virt(sg), sg->length);
 }
 
 static void pa11_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-- 
2.17.1
