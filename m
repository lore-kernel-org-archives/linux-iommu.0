From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 1/2] dma-mapping: Export arm_iommu_{alloc, free}_iova() functions
Date: Fri, 18 May 2012 09:10:26 +0300
Message-ID: <1337321427-27748-2-git-send-email-hdoyu@nvidia.com>
References: <1337321427-27748-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1337321427-27748-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Export __{alloc,free}_iova() as arm_iommu_{alloc,free}_iova().

There are some cases that IOVA allocation and mapping have to be done
seperately, especially for perf optimization reasons. This patch
allows client modules to {alloc,free} IOVA space by themselves without
backing up actual pages for that area.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/include/asm/dma-iommu.h |    4 ++++
 arch/arm/mm/dma-mapping.c        |   31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 799b094..2595928 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -30,5 +30,9 @@ void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
 int arm_iommu_attach_device(struct device *dev,
 					struct dma_iommu_mapping *mapping);
 
+dma_addr_t arm_iommu_alloc_iova(struct device *dev, size_t size);
+
+void arm_iommu_free_iova(struct device *dev, dma_addr_t addr, size_t size);
+
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index afb5e7a..bca1715 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1041,6 +1041,21 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 	return mapping->base + (start << (mapping->order + PAGE_SHIFT));
 }
 
+/**
+ * arm_iommu_alloc_iova
+ * @dev: valid struct device pointer
+ * @size: size of buffer to allocate
+ *
+ * Allocate IOVA address range
+ */
+dma_addr_t arm_iommu_alloc_iova(struct device *dev, size_t size)
+{
+	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+
+	return __alloc_iova(mapping, size);
+}
+EXPORT_SYMBOL_GPL(arm_iommu_alloc_iova);
+
 static inline void __free_iova(struct dma_iommu_mapping *mapping,
 			       dma_addr_t addr, size_t size)
 {
@@ -1055,6 +1070,22 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 	spin_unlock_irqrestore(&mapping->lock, flags);
 }
 
+/**
+ * arm_iommu_free_iova
+ * @dev: valid struct device pointer
+ * @iova: iova address being free'ed
+ * @size: size of buffer to allocate
+ *
+ * Free IOVA address range
+ */
+void arm_iommu_free_iova(struct device *dev, dma_addr_t addr, size_t size)
+{
+	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+
+	__free_iova(mapping, addr, size);
+}
+EXPORT_SYMBOL_GPL(arm_iommu_free_iova);
+
 static struct page **__iommu_alloc_buffer(struct device *dev, size_t size, gfp_t gfp)
 {
 	struct page **pages;
-- 
1.7.5.4
