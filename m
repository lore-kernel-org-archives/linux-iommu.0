From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] dma-coherent: Clarify dma_mmap_from_dev_coherent documentation
Date: Mon,  9 Apr 2018 18:59:14 +0100
Message-ID: <900c26f7cc33792c685fd3390c06e60ac81885de.1523296733.git.robin.murphy@arm.com>
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
To: hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The use of "correctly mapped" here is misleading, since it can give the
wrong expectation in the case that the memory *should* have been mapped
from the per-device pool, but doing so failed for other reasons.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/base/dma-coherent.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 1e6396bb807b..597d40893862 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -312,8 +312,9 @@ static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
  * This checks whether the memory was allocated from the per-device
  * coherent memory pool and if so, maps that memory to the provided vma.
  *
- * Returns 1 if we correctly mapped the memory, or 0 if the caller should
- * proceed with mapping memory from generic pools.
+ * Returns 1 if @vaddr belongs to the device coherent pool and the caller
+ * should return @ret, or 0 if they should proceed with mapping memory from
+ * generic areas.
  */
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 			   void *vaddr, size_t size, int *ret)
-- 
2.16.1.dirty
