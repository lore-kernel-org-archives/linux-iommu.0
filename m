From: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH/RFC 1/4] dma-mapping: Make arch_setup_dma_ops return an error
	code
Date: Thu,  5 Feb 2015 16:31:59 -0800
Message-ID: <1423182722-16646-2-git-send-email-lauraa@codeaurora.org>
References: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1423182722-16646-1-git-send-email-lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Setting up the DMA operations may trigger a probe deferral.
Return a proper error code to let probe deferral do its thing.

Signed-off-by: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 arch/arm/include/asm/dma-mapping.h   |  2 +-
 arch/arm/mm/dma-mapping.c            |  4 +++-
 arch/arm64/include/asm/dma-mapping.h |  2 +-
 arch/arm64/mm/dma-mapping.c          | 16 ++++++++++------
 include/linux/dma-mapping.h          |  7 +++++--
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index b52101d..68bff4e 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -122,7 +122,7 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 #define dma_max_pfn(dev) dma_max_pfn(dev)
 
 #define arch_setup_dma_ops arch_setup_dma_ops
-extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+extern int arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			       struct iommu_ops *iommu, bool coherent);
 
 #define arch_teardown_dma_ops arch_teardown_dma_ops
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7864797..ba20196 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2048,7 +2048,7 @@ static struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
 }
 
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+int arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			struct iommu_ops *iommu, bool coherent)
 {
 	struct dma_map_ops *dma_ops;
@@ -2060,6 +2060,8 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		dma_ops = arm_get_dma_map_ops(coherent);
 
 	set_dma_ops(dev, dma_ops);
+
+	return 0;
 }
 
 void arch_teardown_dma_ops(struct device *dev)
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 0791a78..f7968af 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -45,7 +45,7 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 		return __generic_dma_ops(dev);
 }
 
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+int arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			struct iommu_ops *iommu, bool coherent);
 #define arch_setup_dma_ops	arch_setup_dma_ops
 
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index d52175d..1e3c8f9 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -704,22 +704,24 @@ static struct dma_map_ops iommu_dma_ops = {
 	.mapping_error = iommu_dma_mapping_error,
 };
 
-static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+static int __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 				  struct iommu_ops *ops)
 {
 	struct iommu_dma_mapping *mapping;
+	int ret;
 
 	if (!ops)
-		return;
+		return 0;
 
 	mapping = iommu_dma_create_mapping(ops, dma_base, size);
 	if (!mapping) {
 		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
 				size, dev_name(dev));
-		return;
+		return -EINVAL;
 	}
 
-	if (iommu_dma_attach_device(dev, mapping))
+	ret = iommu_dma_attach_device(dev, mapping);
+	if (ret)
 		pr_warn("Failed to attach device %s to IOMMU mapping\n",
 				dev_name(dev));
 	else
@@ -727,6 +729,8 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 	/* drop the initial mapping refcount */
 	iommu_dma_release_mapping(mapping);
+
+	return ret;
 }
 
 static void __iommu_teardown_dma_ops(struct device *dev)
@@ -747,11 +751,11 @@ static void __iommu_teardown_dma_ops(struct device *dev) { }
 
 #endif  /* CONFIG_IOMMU_DMA */
 
-void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+int arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			struct iommu_ops *iommu, bool coherent)
 {
 	dev->archdata.dma_coherent = coherent;
-	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
+	return __iommu_setup_dma_ops(dev, dma_base, size, iommu);
 }
 
 void arch_teardown_dma_ops(struct device *dev)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c3007cb..dfd8060 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -130,9 +130,12 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
 extern u64 dma_get_required_mask(struct device *dev);
 
 #ifndef arch_setup_dma_ops
-static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
+static inline int arch_setup_dma_ops(struct device *dev, u64 dma_base,
 				      u64 size, struct iommu_ops *iommu,
-				      bool coherent) { }
+				      bool coherent)
+{
+	return 0;
+}
 #endif
 
 #ifndef arch_teardown_dma_ops
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
