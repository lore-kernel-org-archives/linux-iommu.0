From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu/amd: Handle integer overflow in dma_ops_area_alloc
Date: Wed, 27 May 2015 09:26:09 +0200
Message-ID: <1432711569-18890-1-git-send-email-joro@8bytes.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Handle this case to make sure boundary_size does not become
0 and trigger a BUG_ON later.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index e43d489..f2d12c0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1704,14 +1704,16 @@ static unsigned long dma_ops_area_alloc(struct device *dev,
 	unsigned long next_bit = dom->next_address % APERTURE_RANGE_SIZE;
 	int max_index = dom->aperture_size >> APERTURE_RANGE_SHIFT;
 	int i = start >> APERTURE_RANGE_SHIFT;
-	unsigned long boundary_size;
+	unsigned long boundary_size, mask;
 	unsigned long address = -1;
 	unsigned long limit;
 
 	next_bit >>= PAGE_SHIFT;
 
-	boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-			PAGE_SIZE) >> PAGE_SHIFT;
+	mask = dma_get_seg_boundary(dev);
+
+	boundary_size = mask + 1 ? ALIGN(mask + 1, PAGE_SIZE) >> PAGE_SHIFT :
+				   1UL << (BITS_PER_LONG - PAGE_SHIFT);
 
 	for (;i < max_index; ++i) {
 		unsigned long offset = dom->aperture[i]->offset >> PAGE_SHIFT;
-- 
1.9.1
