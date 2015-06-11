From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 3/4] arm64: Add IOMMU dma_ops
Date: Thu, 11 Jun 2015 16:54:23 +0100
Message-ID: <4e298538ccedbe6f593d8edc40eb3a08ad9e4df5.1434036796.git.robin.murphy@arm.com>
References: <cover.1434036796.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1434036796.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Taking some inspiration from the arch/arm code, implement the
arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.

Whilst proliferating per-device private IOMMU data via dev->archdata is
less than ideal, it will do the job for now, especially since we can't
easily handle the kind of problematic system topologies in the current
IOMMU API anyway.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm64/include/asm/device.h      |   3 +
 arch/arm64/include/asm/dma-mapping.h |  14 ++
 arch/arm64/mm/dma-mapping.c          | 342 +++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h            |   4 +-
 4 files changed, 361 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
index 243ef25..510cee1 100644
--- a/arch/arm64/include/asm/device.h
+++ b/arch/arm64/include/asm/device.h
@@ -20,6 +20,9 @@ struct dev_archdata {
 	struct dma_map_ops *dma_ops;
 #ifdef CONFIG_IOMMU_API
 	void *iommu;			/* private IOMMU data */
+#ifdef CONFIG_IOMMU_DMA
+	struct iommu_dma_domain *dma_domain;
+#endif
 #endif
 	bool dma_coherent;
 };
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 9437e3d..835a8d1 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -61,6 +61,20 @@ static inline bool is_device_dma_coherent(struct device *dev)
 }
 
 #include <asm-generic/dma-mapping-common.h>
+#include <linux/dma-iommu.h>
+
+#ifdef CONFIG_IOMMU_DMA
+static inline struct iommu_dma_domain *arch_get_dma_domain(struct device *dev)
+{
+	return dev->archdata.dma_domain;
+}
+
+static inline void arch_set_dma_domain(struct device *dev,
+				  struct iommu_dma_domain *dma_domain)
+{
+	dev->archdata.dma_domain = dma_domain;
+}
+#endif
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index b0bd4e5..51b7ae5 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -434,3 +434,345 @@ static int __init dma_debug_do_init(void)
 	return 0;
 }
 fs_initcall(dma_debug_do_init);
+
+
+#ifdef CONFIG_IOMMU_DMA
+#include <linux/iommu.h>
+#include <linux/platform_device.h>
+#include <linux/amba/bus.h>
+
+/* Thankfully, all cache ops are by VA so we can ignore phys here */
+static void flush_page(const void *virt, phys_addr_t phys)
+{
+	__dma_flush_range(virt, virt + PAGE_SIZE);
+}
+
+static void *__iommu_alloc_attrs(struct device *dev, size_t size,
+				 dma_addr_t *handle, gfp_t gfp,
+				 struct dma_attrs *attrs)
+{
+	bool coherent = is_device_dma_coherent(dev);
+	pgprot_t pgprot = coherent ? __pgprot(PROT_NORMAL) :
+				     __pgprot(PROT_NORMAL_NC);
+	int ioprot;
+	void *addr;
+
+	if (WARN(!dev, "cannot create IOMMU mapping for unknown device\n"))
+		return NULL;
+
+	if (!(gfp & __GFP_WAIT)) {
+		struct page *page;
+
+		addr = __alloc_from_pool(size, &page, gfp);
+		if (!addr)
+			return NULL;
+
+		ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, false);
+		*handle = iommu_dma_map_page(dev, page, 0, size, ioprot, coherent);
+		if (iommu_dma_mapping_error(dev, *handle)) {
+			__free_from_pool(addr, size);
+			addr = NULL;
+		}
+	} else {
+		struct page **pages;
+
+		ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
+		pages = iommu_dma_alloc(dev, size, gfp, ioprot,	coherent,
+					handle, coherent ? NULL : flush_page);
+		if (!pages)
+			return NULL;
+
+		addr = dma_common_pages_remap(pages, size, VM_USERMAP,
+				__get_dma_pgprot(attrs, pgprot, coherent),
+				__builtin_return_address(0));
+		if (!addr)
+			iommu_dma_free(dev, pages, size, handle);
+	}
+	return addr;
+}
+
+static void __iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
+			       dma_addr_t handle, struct dma_attrs *attrs)
+{
+	if (__free_from_pool(cpu_addr, size)) {
+		iommu_dma_unmap_page(dev, handle, size, 0, NULL);
+	} else {
+		struct vm_struct *area = find_vm_area(cpu_addr);
+
+		if (WARN_ON(!area || !area->pages))
+			return;
+		iommu_dma_free(dev, area->pages, size, &handle);
+		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
+	}
+}
+
+static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
+			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
+			      struct dma_attrs *attrs)
+{
+	struct vm_struct *area;
+	int ret;
+
+	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
+					     is_device_dma_coherent(dev));
+
+	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	area = find_vm_area(cpu_addr);
+	if (WARN_ON(!area || area->pages))
+		return -ENXIO;
+
+	return iommu_dma_mmap(area->pages, size, vma);
+}
+
+static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
+			       void *cpu_addr, dma_addr_t dma_addr,
+			       size_t size, struct dma_attrs *attrs)
+{
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	struct vm_struct *area = find_vm_area(cpu_addr);
+
+	if (WARN_ON(!area || !area->pages))
+		return -ENXIO;
+
+	return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,
+					 GFP_KERNEL);
+}
+
+static void __iommu_sync_single_for_cpu(struct device *dev,
+					dma_addr_t dev_addr, size_t size,
+					enum dma_data_direction dir)
+{
+	struct iommu_dma_domain *dma_domain = arch_get_dma_domain(dev);
+	phys_addr_t phys;
+
+	if (is_device_dma_coherent(dev))
+		return;
+
+	phys = iommu_iova_to_phys(iommu_dma_raw_domain(dma_domain), dev_addr);
+	__dma_unmap_area(phys_to_virt(phys), size, dir);
+}
+
+static void __iommu_sync_single_for_device(struct device *dev,
+					   dma_addr_t dev_addr, size_t size,
+					   enum dma_data_direction dir)
+{
+	struct iommu_dma_domain *dma_domain = arch_get_dma_domain(dev);
+	phys_addr_t phys;
+
+	if (is_device_dma_coherent(dev))
+		return;
+
+	phys = iommu_iova_to_phys(iommu_dma_raw_domain(dma_domain), dev_addr);
+	__dma_map_area(phys_to_virt(phys), size, dir);
+}
+
+static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
+				   unsigned long offset, size_t size,
+				   enum dma_data_direction dir,
+				   struct dma_attrs *attrs)
+{
+	bool coherent = is_device_dma_coherent(dev);
+	int prot = dma_direction_to_prot(dir, coherent);
+	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size,
+						 prot, coherent);
+
+	if (!iommu_dma_mapping_error(dev, dev_addr) &&
+	    !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		__iommu_sync_single_for_device(dev, dev_addr, size, dir);
+
+	return dev_addr;
+}
+
+static void __iommu_unmap_page(struct device *dev, dma_addr_t dev_addr,
+			       size_t size, enum dma_data_direction dir,
+			       struct dma_attrs *attrs)
+{
+	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		__iommu_sync_single_for_cpu(dev, dev_addr, size, dir);
+
+	iommu_dma_unmap_page(dev, dev_addr, size, dir, attrs);
+}
+
+static void __iommu_sync_sg_for_cpu(struct device *dev,
+				    struct scatterlist *sgl, int nelems,
+				    enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (is_device_dma_coherent(dev))
+		return;
+
+	for_each_sg(sgl, sg, nelems, i)
+		__dma_unmap_area(sg_virt(sg), sg->length, dir);
+}
+
+static void __iommu_sync_sg_for_device(struct device *dev,
+				       struct scatterlist *sgl, int nelems,
+				       enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (is_device_dma_coherent(dev))
+		return;
+
+	for_each_sg(sgl, sg, nelems, i)
+		__dma_map_area(sg_virt(sg), sg->length, dir);
+}
+
+static int __iommu_map_sg_attrs(struct device *dev, struct scatterlist *sgl,
+				int nelems, enum dma_data_direction dir,
+				struct dma_attrs *attrs)
+{
+	bool coherent = is_device_dma_coherent(dev);
+
+	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		__iommu_sync_sg_for_device(dev, sgl, nelems, dir);
+
+	return iommu_dma_map_sg(dev, sgl, nelems,
+			dma_direction_to_prot(dir, coherent),
+			coherent);
+}
+
+static void __iommu_unmap_sg_attrs(struct device *dev,
+				   struct scatterlist *sgl, int nelems,
+				   enum dma_data_direction dir,
+				   struct dma_attrs *attrs)
+{
+	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
+		__iommu_sync_sg_for_cpu(dev, sgl, nelems, dir);
+
+	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);
+}
+
+static struct dma_map_ops iommu_dma_ops = {
+	.alloc = __iommu_alloc_attrs,
+	.free = __iommu_free_attrs,
+	.mmap = __iommu_mmap_attrs,
+	.get_sgtable = __iommu_get_sgtable,
+	.map_page = __iommu_map_page,
+	.unmap_page = __iommu_unmap_page,
+	.map_sg = __iommu_map_sg_attrs,
+	.unmap_sg = __iommu_unmap_sg_attrs,
+	.sync_single_for_cpu = __iommu_sync_single_for_cpu,
+	.sync_single_for_device = __iommu_sync_single_for_device,
+	.sync_sg_for_cpu = __iommu_sync_sg_for_cpu,
+	.sync_sg_for_device = __iommu_sync_sg_for_device,
+	.dma_supported = iommu_dma_supported,
+	.mapping_error = iommu_dma_mapping_error,
+};
+
+struct iommu_dma_notifier_data {
+	struct list_head list;
+	struct device *dev;
+	struct iommu_dma_domain *dma_domain;
+};
+static LIST_HEAD(iommu_dma_masters);
+static DEFINE_MUTEX(iommu_dma_notifier_lock);
+
+static int __iommu_attach_notifier(struct notifier_block *nb,
+				   unsigned long action, void *data)
+{
+	struct iommu_dma_notifier_data *master, *tmp;
+
+	if (action != BUS_NOTIFY_ADD_DEVICE)
+		return 0;
+	/*
+	 * We expect the list to only contain the most recent addition,
+	 * which *should* be the same device as @data, so just process the
+	 * whole thing blindly. If any previous attachments did happen to
+	 * fail, they get a free retry since the domains are still live.
+	 */
+	mutex_lock(&iommu_dma_notifier_lock);
+	list_for_each_entry_safe(master, tmp, &iommu_dma_masters, list) {
+		if (iommu_dma_attach_device(master->dev, master->dma_domain)) {
+			pr_warn("Failed to attach device %s to IOMMU mapping; retaining platform DMA ops\n",
+				dev_name(master->dev));
+		} else {
+			master->dev->archdata.dma_ops = &iommu_dma_ops;
+			/* it's safe to drop the initial refcount now */
+			iommu_dma_release_domain(master->dma_domain);
+			list_del(&master->list);
+			kfree(master);
+		}
+	}
+	mutex_unlock(&iommu_dma_notifier_lock);
+	return 0;
+}
+
+static int register_iommu_dma_ops_notifier(struct bus_type *bus)
+{
+	int ret;
+	struct notifier_block *nb = kzalloc(sizeof(*nb), GFP_KERNEL);
+
+	/*
+	 * The device must be attached to a domain before its driver probe,
+	 * in case the driver allocates DMA buffers immediately. However, most
+	 * IOMMU drivers are currently configuring groups in their add_device
+	 * callback, so the attach should happen after that. Since the IOMMU
+	 * core uses a bus notifier for add_device, do the same but with a
+	 * lower priority to ensure the appropriate ordering.
+	 *
+	 * This can hopefully all go away once we have default domains in the
+	 * IOMMU core.
+	 */
+	nb->notifier_call = __iommu_attach_notifier;
+	nb->priority = -100;
+
+	ret = bus_register_notifier(bus, nb);
+	if (ret) {
+		pr_warn("Failed to register DMA domain notifier; IOMMU DMA ops unavailable on bus '%s'\n",
+			bus->name);
+		kfree(nb);
+	}
+	return ret;
+}
+
+static int __init arm64_iommu_dma_init(void)
+{
+	int ret;
+
+	ret = iommu_dma_init();
+	if (!ret)
+		ret = register_iommu_dma_ops_notifier(&platform_bus_type);
+	if (!ret)
+		ret = register_iommu_dma_ops_notifier(&amba_bustype);
+	return ret;
+}
+arch_initcall(arm64_iommu_dma_init);
+
+static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+				  const struct iommu_ops *ops)
+{
+	struct iommu_dma_notifier_data *iommudata;
+
+	if (!ops)
+		return;
+
+	iommudata = kzalloc(sizeof(*iommudata), GFP_KERNEL);
+	if (!iommudata)
+		return;
+
+	iommudata->dev = dev;
+	iommudata->dma_domain = iommu_dma_create_domain(ops, dma_base, size);
+	if (!iommudata->dma_domain) {
+		pr_warn("Failed to create %llu-byte IOMMU mapping for device %s\n",
+				size, dev_name(dev));
+		kfree(iommudata);
+		return;
+	}
+	mutex_lock(&iommu_dma_notifier_lock);
+	list_add(&iommudata->list, &iommu_dma_masters);
+	mutex_unlock(&iommu_dma_notifier_lock);
+}
+
+#else
+
+static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+				  struct iommu_ops *iommu)
+{ }
+
+#endif  /* CONFIG_IOMMU_DMA */
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 6708a8a..8062ed7 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -79,8 +79,6 @@ static inline int iommu_dma_init(void)
 	return 0;
 }
 
-#endif  /* CONFIG_IOMMU_DMA */
-
 static inline struct iommu_dma_domain *arch_get_dma_domain(struct device *dev)
 {
 	return NULL;
@@ -90,5 +88,7 @@ static inline void arch_set_dma_domain(struct device *dev,
 		struct iommu_dma_domain *dma_domain)
 { }
 
+#endif	/* CONFIG_IOMMU_DMA */
+
 #endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
1.9.1
