From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 2/5] ARM: dma-mapping: New dma_map_ops->iova_{alloc,
	free}() functions
Date: Wed, 29 Aug 2012 09:55:32 +0300
Message-ID: <1346223335-31455-3-git-send-email-hdoyu@nvidia.com>
References: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1346223335-31455-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

There are some cases that IOVA allocation and mapping have to be done
seperately, especially for perf optimization reasons. This patch
allows client modules to {alloc,free} IOVA space without backing up
actual pages for that area.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/include/asm/dma-mapping.h |   17 +++++++++++++++++
 arch/arm/mm/dma-mapping.c          |   17 +++++++++++++++++
 include/linux/dma-mapping.h        |    2 ++
 3 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 1cbd279..5b86600 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -170,6 +170,23 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 	ops->free(dev, size, cpu_addr, dma_handle, attrs);
 }
 
+static inline dma_addr_t dma_iova_alloc(struct device *dev, size_t size)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	BUG_ON(!ops);
+
+	return ops->iova_alloc(dev, size);
+}
+
+static inline void dma_iova_free(struct device *dev, dma_addr_t addr,
+				 size_t size)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	BUG_ON(!ops);
+
+	ops->iova_free(dev, addr, size);
+}
+
 static inline size_t dma_iova_get_free_total(struct device *dev)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index db17338..c18522a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1080,6 +1080,13 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 	return mapping->base + (start << (mapping->order + PAGE_SHIFT));
 }
 
+static dma_addr_t arm_iommu_iova_alloc(struct device *dev, size_t size)
+{
+	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+
+	return __alloc_iova(mapping, size);
+}
+
 static inline void __free_iova(struct dma_iommu_mapping *mapping,
 			       dma_addr_t addr, size_t size)
 {
@@ -1094,6 +1101,14 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 	spin_unlock_irqrestore(&mapping->lock, flags);
 }
 
+static void arm_iommu_iova_free(struct device *dev, dma_addr_t addr,
+				size_t size)
+{
+	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+
+	__free_iova(mapping, addr, size);
+}
+
 static struct page **__iommu_alloc_buffer(struct device *dev, size_t size, gfp_t gfp)
 {
 	struct page **pages;
@@ -1773,6 +1788,8 @@ struct dma_map_ops iommu_ops = {
 	.sync_sg_for_cpu	= arm_iommu_sync_sg_for_cpu,
 	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
 
+	.iova_alloc		= arm_iommu_iova_alloc,
+	.iova_free		= arm_iommu_iova_free,
 	.iova_get_free_total	= arm_iommu_iova_get_free_total,
 	.iova_get_free_max	= arm_iommu_iova_get_free_max,
 };
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 0337182..e85aa04 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -53,6 +53,8 @@ struct dma_map_ops {
 #ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
 	u64 (*get_required_mask)(struct device *dev);
 #endif
+	dma_addr_t (*iova_alloc)(struct device *dev, size_t size);
+	void (*iova_free)(struct device *dev, dma_addr_t addr, size_t size);
 	size_t (*iova_get_free_total)(struct device *dev);
 	size_t (*iova_get_free_max)(struct device *dev);
 
-- 
1.7.5.4
