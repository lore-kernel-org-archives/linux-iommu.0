From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v3 03/45] alpha: dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:05 +0200
Message-ID: <1464881987-13203-4-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Richard Henderson <rth-hL46jP5Bxq7R7s880joybQ@public.gmane.org>, Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>, Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Aurelien Jacquiot <a-jacquiot-l0cyMroinI0@public.gmane.org>, Mikael Starvik <starvik-VrBV9hrLPhE@public.gmane.org>, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/alpha/include/asm/dma-mapping.h |  2 --
 arch/alpha/kernel/pci-noop.c         |  2 +-
 arch/alpha/kernel/pci_iommu.c        | 12 ++++++------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index 3c3451f58ff4..c63b6ac19ee5 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -1,8 +1,6 @@
 #ifndef _ALPHA_DMA_MAPPING_H
 #define _ALPHA_DMA_MAPPING_H
 
-#include <linux/dma-attrs.h>
-
 extern struct dma_map_ops *dma_ops;
 
 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
diff --git a/arch/alpha/kernel/pci-noop.c b/arch/alpha/kernel/pci-noop.c
index 8e735b5e56bd..bb152e21e5ae 100644
--- a/arch/alpha/kernel/pci-noop.c
+++ b/arch/alpha/kernel/pci-noop.c
@@ -109,7 +109,7 @@ sys_pciconfig_write(unsigned long bus, unsigned long dfn,
 
 static void *alpha_noop_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t gfp,
-				       struct dma_attrs *attrs)
+				       unsigned long attrs)
 {
 	void *ret;
 
diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 8969bf2dfe3a..451fc9cdd323 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -349,7 +349,7 @@ static struct pci_dev *alpha_gendev_to_pci(struct device *dev)
 static dma_addr_t alpha_pci_map_page(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction dir,
-				     struct dma_attrs *attrs)
+				     unsigned long attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	int dac_allowed;
@@ -369,7 +369,7 @@ static dma_addr_t alpha_pci_map_page(struct device *dev, struct page *page,
 
 static void alpha_pci_unmap_page(struct device *dev, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction dir,
-				 struct dma_attrs *attrs)
+				 unsigned long attrs)
 {
 	unsigned long flags;
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
@@ -433,7 +433,7 @@ static void alpha_pci_unmap_page(struct device *dev, dma_addr_t dma_addr,
 
 static void *alpha_pci_alloc_coherent(struct device *dev, size_t size,
 				      dma_addr_t *dma_addrp, gfp_t gfp,
-				      struct dma_attrs *attrs)
+				      unsigned long attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	void *cpu_addr;
@@ -478,7 +478,7 @@ try_again:
 
 static void alpha_pci_free_coherent(struct device *dev, size_t size,
 				    void *cpu_addr, dma_addr_t dma_addr,
-				    struct dma_attrs *attrs)
+				    unsigned long attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	pci_unmap_single(pdev, dma_addr, size, PCI_DMA_BIDIRECTIONAL);
@@ -651,7 +651,7 @@ sg_fill(struct device *dev, struct scatterlist *leader, struct scatterlist *end,
 
 static int alpha_pci_map_sg(struct device *dev, struct scatterlist *sg,
 			    int nents, enum dma_data_direction dir,
-			    struct dma_attrs *attrs)
+			    unsigned long attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	struct scatterlist *start, *end, *out;
@@ -729,7 +729,7 @@ static int alpha_pci_map_sg(struct device *dev, struct scatterlist *sg,
 
 static void alpha_pci_unmap_sg(struct device *dev, struct scatterlist *sg,
 			       int nents, enum dma_data_direction dir,
-			       struct dma_attrs *attrs)
+			       unsigned long attrs)
 {
 	struct pci_dev *pdev = alpha_gendev_to_pci(dev);
 	unsigned long flags;
-- 
1.9.1
