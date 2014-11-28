From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 8/8] arm: dma-mapping: plumb our iommu mapping ops into
	arch_setup_dma_ops
Date: Fri, 28 Nov 2014 13:29:46 +0000
Message-ID: <1417181386-18142-9-git-send-email-will.deacon@arm.com>
References: <1417181386-18142-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417181386-18142-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch plumbs the existing ARM IOMMU DMA infrastructure (which isn't
actually called outside of a few drivers) into arch_setup_dma_ops, so
that we can use IOMMUs for DMA transfers in a more generic fashion.

Since this significantly complicates the arch_setup_dma_ops function,
it is moved out of line into dma-mapping.c. If CONFIG_ARM_DMA_USE_IOMMU
is not set, the iommu parameter is ignored and the normal ops are used
instead.

Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm/include/asm/dma-mapping.h | 12 +++---
 arch/arm/mm/dma-mapping.c          | 83 ++++++++++++++++++++++++++++++++++----
 2 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index f3c0d953f6a2..9410b7e548fc 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -121,14 +121,12 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 }
 #define dma_max_pfn(dev) dma_max_pfn(dev)
 
-static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
-				      u64 size, struct iommu_ops *iommu,
-				      bool coherent)
-{
-	if (coherent)
-		set_dma_ops(dev, &arm_coherent_dma_ops);
-}
 #define arch_setup_dma_ops arch_setup_dma_ops
+extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			       struct iommu_ops *iommu, bool coherent);
+
+#define arch_teardown_dma_ops arch_teardown_dma_ops
+extern void arch_teardown_dma_ops(struct device *dev);
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e8907117861e..09645f00bd17 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1947,9 +1947,8 @@ EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
  *	arm_iommu_create_mapping)
  *
  * Attaches specified io address space mapping to the provided device,
- * this replaces the dma operations (dma_map_ops pointer) with the
- * IOMMU aware version. More than one client might be attached to
- * the same io address space mapping.
+ * More than one client might be attached to the same io address space
+ * mapping.
  */
 int arm_iommu_attach_device(struct device *dev,
 			    struct dma_iommu_mapping *mapping)
@@ -1962,7 +1961,6 @@ int arm_iommu_attach_device(struct device *dev,
 
 	kref_get(&mapping->kref);
 	dev->archdata.mapping = mapping;
-	set_dma_ops(dev, &iommu_ops);
 
 	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
 	return 0;
@@ -1974,7 +1972,6 @@ EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
  * @dev: valid struct device pointer
  *
  * Detaches the provided device from a previously attached map.
- * This voids the dma operations (dma_map_ops pointer)
  */
 void arm_iommu_detach_device(struct device *dev)
 {
@@ -1989,10 +1986,82 @@ void arm_iommu_detach_device(struct device *dev)
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	dev->archdata.mapping = NULL;
-	set_dma_ops(dev, NULL);
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
-#endif
+static struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
+{
+	return coherent ? &iommu_coherent_ops : &iommu_ops;
+}
+
+static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
+				    struct iommu_ops *iommu)
+{
+	struct dma_iommu_mapping *mapping;
+
+	if (!iommu)
+		return false;
+
+	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
+	if (IS_ERR(mapping)) {
+		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
+				size, dev_name(dev));
+		return false;
+	}
+
+	if (arm_iommu_attach_device(dev, mapping)) {
+		pr_warn("Failed to attached device %s to IOMMU_mapping\n",
+				dev_name(dev));
+		arm_iommu_release_mapping(mapping);
+		return false;
+	}
+
+	return true;
+}
+
+static void arm_teardown_iommu_dma_ops(struct device *dev)
+{
+	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+
+	arm_iommu_detach_device(dev);
+	arm_iommu_release_mapping(mapping);
+}
+
+#else
+
+static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
+				    struct iommu_ops *iommu)
+{
+	return false;
+}
+
+static void arm_teardown_iommu_dma_ops(struct device *dev) { }
+
+#define arm_get_iommu_dma_map_ops arm_get_dma_map_ops
+
+#endif	/* CONFIG_ARM_DMA_USE_IOMMU */
+
+static struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
+{
+	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
+}
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			struct iommu_ops *iommu, bool coherent)
+{
+	struct dma_map_ops *dma_ops;
+
+	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
+		dma_ops = arm_get_iommu_dma_map_ops(coherent);
+	else
+		dma_ops = arm_get_dma_map_ops(coherent);
+
+	set_dma_ops(dev, dma_ops);
+}
+
+void arch_teardown_dma_ops(struct device *dev)
+{
+	arm_teardown_iommu_dma_ops(dev);
+}
-- 
2.1.1
