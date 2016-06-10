From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 17/44] iommu: dma-mapping: Use unsigned long for dma_attrs
Date: Fri, 10 Jun 2016 12:11:34 +0200
Message-ID: <1465553521-27303-18-git-send-email-k.kozlowski@samsung.com>
References: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1465553521-27303-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 12 ++++++------
 drivers/iommu/dma-iommu.c |  6 +++---
 include/linux/dma-iommu.h |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 634f636393d5..afbb0de6a7f5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2716,7 +2716,7 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
 static dma_addr_t map_page(struct device *dev, struct page *page,
 			   unsigned long offset, size_t size,
 			   enum dma_data_direction dir,
-			   struct dma_attrs *attrs)
+			   unsigned long attrs)
 {
 	phys_addr_t paddr = page_to_phys(page) + offset;
 	struct protection_domain *domain;
@@ -2738,7 +2738,7 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
  * The exported unmap_single function for dma_ops.
  */
 static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
-		       enum dma_data_direction dir, struct dma_attrs *attrs)
+		       enum dma_data_direction dir, unsigned long attrs)
 {
 	struct protection_domain *domain;
 
@@ -2755,7 +2755,7 @@ static void unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
  */
 static int map_sg(struct device *dev, struct scatterlist *sglist,
 		  int nelems, enum dma_data_direction dir,
-		  struct dma_attrs *attrs)
+		  unsigned long attrs)
 {
 	struct protection_domain *domain;
 	int i;
@@ -2803,7 +2803,7 @@ unmap:
  */
 static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 		     int nelems, enum dma_data_direction dir,
-		     struct dma_attrs *attrs)
+		     unsigned long attrs)
 {
 	struct protection_domain *domain;
 	struct scatterlist *s;
@@ -2825,7 +2825,7 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
  */
 static void *alloc_coherent(struct device *dev, size_t size,
 			    dma_addr_t *dma_addr, gfp_t flag,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	u64 dma_mask = dev->coherent_dma_mask;
 	struct protection_domain *domain;
@@ -2879,7 +2879,7 @@ out_free:
  */
 static void free_coherent(struct device *dev, size_t size,
 			  void *virt_addr, dma_addr_t dma_addr,
-			  struct dma_attrs *attrs)
+			  unsigned long attrs)
 {
 	struct protection_domain *domain;
 	struct page *page;
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea5a9ebf0f78..6c1bda504fb1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -286,7 +286,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
  *	   or NULL on failure.
  */
 struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		struct dma_attrs *attrs, int prot, dma_addr_t *handle,
+		unsigned long attrs, int prot, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t))
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
@@ -400,7 +400,7 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 }
 
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle);
 }
@@ -560,7 +560,7 @@ out_restore_sg:
 }
 
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs)
+		enum dma_data_direction dir, unsigned long attrs)
 {
 	/*
 	 * The scatterlist segments are mapped into a single
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 8443bbb5c071..81c5c8d167ad 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -39,7 +39,7 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
  * the arch code to take care of attributes and cache maintenance
  */
 struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
-		struct dma_attrs *attrs, int prot, dma_addr_t *handle,
+		unsigned long attrs, int prot, dma_addr_t *handle,
 		void (*flush_page)(struct device *, const void *, phys_addr_t));
 void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 		dma_addr_t *handle);
@@ -56,9 +56,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
  * directly as DMA mapping callbacks for simplicity
  */
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
-		enum dma_data_direction dir, struct dma_attrs *attrs);
+		enum dma_data_direction dir, unsigned long attrs);
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
-		enum dma_data_direction dir, struct dma_attrs *attrs);
+		enum dma_data_direction dir, unsigned long attrs);
 int iommu_dma_supported(struct device *dev, u64 mask);
 int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
-- 
1.9.1
