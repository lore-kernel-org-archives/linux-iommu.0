From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 2/7] dma-mapping: replace set_arch_dma_coherent_ops with
	arch_setup_dma_ops
Date: Fri, 29 Aug 2014 16:54:25 +0100
Message-ID: <1409327670-3495-3-git-send-email-will.deacon@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409327670-3495-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

set_arch_dma_coherent_ops is called from of_dma_configure in order to
swizzle the architectural dma-mapping functions over to a cache-coherent
implementation. This is currently implemented only for ARM.

In anticipation of re-using this mechanism for IOMMU-backed dma-mapping
ops too, this patch replaces the function with a broader
arch_setup_dma_ops callback which is also responsible for setting the
DMA mask and offset as well as selecting the correct mapping functions.

A further advantage of this split is that it nicely isolates the
of-specific code from the dma-mapping code, allowing potential reuse by
other buses (e.g. PCI) in the future.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm/include/asm/dma-mapping.h | 20 ++++++++++++++----
 drivers/of/platform.c              | 42 ++++++++++----------------------------
 include/linux/dma-mapping.h        |  8 +++-----
 3 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index c45b61a4b4a5..936125ef3f3f 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -121,12 +121,24 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 }
 #define dma_max_pfn(dev) dma_max_pfn(dev)
 
-static inline int set_arch_dma_coherent_ops(struct device *dev)
+static inline void arch_setup_dma_ops(struct device *dev, u64 mask,
+				      unsigned long offset, bool coherent)
 {
-	set_dma_ops(dev, &arm_coherent_dma_ops);
-	return 0;
+	dev->coherent_dma_mask = mask;
+
+	/*
+	 * Set dma_mask to coherent_dma_mask by default if the architecture
+	 * code has not set it.
+	 */
+	if (!dev->dma_mask)
+		dev->dma_mask = &dev->coherent_dma_mask;
+
+	dev->dma_pfn_offset = offset;
+
+	if (coherent)
+		set_dma_ops(dev, &arm_coherent_dma_ops);
 }
-#define set_arch_dma_coherent_ops(dev)	set_arch_dma_coherent_ops(dev)
+#define arch_setup_dma_ops arch_setup_dma_ops
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 0197725e033a..484c558c63a6 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -164,43 +164,23 @@ static void of_dma_configure(struct platform_device *pdev)
 {
 	u64 dma_addr, paddr, size;
 	int ret;
+	bool coherent;
+	unsigned long offset;
 	struct device *dev = &pdev->dev;
 
-	/*
-	 * Set default dma-mask to 32 bit. Drivers are expected to setup
-	 * the correct supported dma_mask.
-	 */
-	dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
-	/*
-	 * Set it to coherent_dma_mask by default if the architecture
-	 * code has not set it.
-	 */
-	if (!dev->dma_mask)
-		dev->dma_mask = &dev->coherent_dma_mask;
+	ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
+	offset = ret < 0 ? 0 : PFN_DOWN(paddr - dma_addr);
+	dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
 
-	/*
-	 * if dma-coherent property exist, call arch hook to setup
-	 * dma coherent operations.
-	 */
-	if (of_dma_is_coherent(dev->of_node)) {
-		set_arch_dma_coherent_ops(dev);
-		dev_dbg(dev, "device is dma coherent\n");
-	}
+	coherent = of_dma_is_coherent(dev->of_node);
+	dev_dbg(dev, "device is%sdma coherent\n",
+		coherent ? " " : " not ");
 
 	/*
-	 * if dma-ranges property doesn't exist - just return else
-	 * setup the dma offset
+	 * Set default dma-mask to 32 bit. Drivers are expected to setup
+	 * the correct supported dma_mask.
 	 */
-	ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
-	if (ret < 0) {
-		dev_dbg(dev, "no dma range information to setup\n");
-		return;
-	}
-
-	/* DMA ranges found. Calculate and set dma_pfn_offset */
-	dev->dma_pfn_offset = PFN_DOWN(paddr - dma_addr);
-	dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
+	arch_setup_dma_ops(dev, DMA_BIT_MASK(32), offset, coherent);
 }
 
 /**
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 931b70986272..0f7f7b68b0db 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -129,11 +129,9 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
 
 extern u64 dma_get_required_mask(struct device *dev);
 
-#ifndef set_arch_dma_coherent_ops
-static inline int set_arch_dma_coherent_ops(struct device *dev)
-{
-	return 0;
-}
+#ifndef arch_setup_dma_ops
+static inline void arch_setup_dma_ops(struct device *dev, u64 mask,
+				      unsigned long offset, bool coherent) { }
 #endif
 
 static inline unsigned int dma_get_max_seg_size(struct device *dev)
-- 
2.1.0
