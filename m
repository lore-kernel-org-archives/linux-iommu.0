From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v6 25/46] iommu: intel: dma-mapping: Use unsigned long for
	dma_attrs
Date: Wed, 13 Jul 2016 10:41:16 +0200
Message-ID: <1468399300-5399-25-git-send-email-k.kozlowski@samsung.com>
References: <1468399167-28083-1-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-1-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-2-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-3-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-4-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-5-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-6-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-7-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-8-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-9-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-10-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-11-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-12-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-13-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-14-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-15-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-16-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-17-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-18-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-19-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-20-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-21-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-22-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-23-git-send-email-k.kozlowski@samsung.com>
	<1468399300-5399-24-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1468399300-5399-24-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
[for iommu]
Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 69ea66dcc534..3431684ad848 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3552,7 +3552,7 @@ error:
 static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 unsigned long offset, size_t size,
 				 enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	return __intel_map_single(dev, page_to_phys(page) + offset, size,
 				  dir, *dev->dma_mask);
@@ -3711,14 +3711,14 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 
 static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
-			     struct dma_attrs *attrs)
+			     unsigned long attrs)
 {
 	intel_unmap(dev, dev_addr, size);
 }
 
 static void *intel_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
-				  struct dma_attrs *attrs)
+				  unsigned long attrs)
 {
 	struct page *page = NULL;
 	int order;
@@ -3764,7 +3764,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
-				dma_addr_t dma_handle, struct dma_attrs *attrs)
+				dma_addr_t dma_handle, unsigned long attrs)
 {
 	int order;
 	struct page *page = virt_to_page(vaddr);
@@ -3779,7 +3779,7 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 
 static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			   int nelems, enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	dma_addr_t startaddr = sg_dma_address(sglist) & PAGE_MASK;
 	unsigned long nrpages = 0;
@@ -3808,7 +3808,7 @@ static int intel_nontranslate_map_sg(struct device *hddev,
 }
 
 static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nelems,
-			enum dma_data_direction dir, struct dma_attrs *attrs)
+			enum dma_data_direction dir, unsigned long attrs)
 {
 	int i;
 	struct dmar_domain *domain;
-- 
1.9.1
