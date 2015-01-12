From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 3/5] iommu: implement common IOMMU ops for DMA mapping
Date: Mon, 12 Jan 2015 20:48:55 +0000
Message-ID: <09e5515a9afcb3235f4c425520cd18a6032d31b4.1421086706.git.robin.murphy@arm.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1421086706.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Taking inspiration from the existing arch/arm code, break out some
generic functions to interface the DMA-API to the IOMMU-API. This will
do the bulk of the heavy lifting for IOMMU-backed dma-mapping.

Whilst the target is arm64, rather than introduce yet another private
implementation, place this in common code as the first step towards
consolidating the numerous versions spread around between architecture
code and IOMMU drivers.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 include/linux/dma-iommu.h |  78 ++++++++
 lib/Kconfig               |   8 +
 lib/Makefile              |   1 +
 lib/dma-iommu.c           | 455 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 542 insertions(+)
 create mode 100644 include/linux/dma-iommu.h
 create mode 100644 lib/dma-iommu.c

diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
new file mode 100644
index 0000000..4515407
--- /dev/null
+++ b/include/linux/dma-iommu.h
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2014 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __DMA_IOMMU_H
+#define __DMA_IOMMU_H
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/iommu.h>
+
+#ifdef CONFIG_IOMMU_DMA
+
+int iommu_dma_init(void);
+
+struct iommu_dma_mapping *iommu_dma_create_mapping(struct iommu_ops *ops,
+		dma_addr_t base, size_t size);
+void iommu_dma_release_mapping(struct iommu_dma_mapping *mapping);
+
+dma_addr_t iommu_dma_create_iova_mapping(struct device *dev,
+		struct page **pages, size_t size, bool coherent);
+int iommu_dma_release_iova_mapping(struct device *dev, dma_addr_t iova,
+		size_t size);
+
+struct page **iommu_dma_alloc_buffer(struct device *dev, size_t size,
+		gfp_t gfp, struct dma_attrs *attrs,
+		void (clear_buffer)(struct page *page, size_t size));
+int iommu_dma_free_buffer(struct device *dev, struct page **pages, size_t size,
+		struct dma_attrs *attrs);
+
+dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs);
+dma_addr_t iommu_dma_coherent_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs);
+void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
+		enum dma_data_direction dir, struct dma_attrs *attrs);
+
+int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		enum dma_data_direction dir, struct dma_attrs *attrs);
+int iommu_dma_coherent_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir,
+		struct dma_attrs *attrs);
+void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sgl, int nents,
+		enum dma_data_direction dir, struct dma_attrs *attrs);
+
+int iommu_dma_attach_device(struct device *dev, struct iommu_dma_mapping *mapping);
+void iommu_dma_detach_device(struct device *dev);
+
+int iommu_dma_supported(struct device *hwdev, u64 mask);
+int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
+
+phys_addr_t iova_to_phys(struct device *dev, dma_addr_t dev_addr);
+
+#else
+
+static inline phys_addr_t iova_to_phys(struct device *dev, dma_addr_t dev_addr)
+{
+	return 0;
+}
+
+#endif  /* CONFIG_IOMMU_DMA */
+
+#endif	/* __KERNEL__ */
+#endif	/* __DMA_IOMMU_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 54cf309..965d027 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -518,4 +518,12 @@ source "lib/fonts/Kconfig"
 config ARCH_HAS_SG_CHAIN
 	def_bool n
 
+#
+# IOMMU-agnostic DMA-mapping layer
+#
+config IOMMU_DMA
+	def_bool n
+	depends on IOMMU_SUPPORT && ARCH_HAS_SG_CHAIN && NEED_SG_DMA_LENGTH
+	select IOMMU_IOVA
+
 endmenu
diff --git a/lib/Makefile b/lib/Makefile
index 3c3b30b..e4b6134 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_AUDIT_COMPAT_GENERIC) += compat_audit.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
 obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o
+obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 obj-$(CONFIG_NOTIFIER_ERROR_INJECTION) += notifier-error-inject.o
 obj-$(CONFIG_CPU_NOTIFIER_ERROR_INJECT) += cpu-notifier-error-inject.o
diff --git a/lib/dma-iommu.c b/lib/dma-iommu.c
new file mode 100644
index 0000000..2fb77b3
--- /dev/null
+++ b/lib/dma-iommu.c
@@ -0,0 +1,455 @@
+/*
+ * A fairly generic DMA-API to IOMMU-API glue layer.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ *
+ * based in part on arch/arm/mm/dma-mapping.c:
+ * Copyright (C) 2000-2004 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define pr_fmt(fmt)	"%s: " fmt, __func__
+
+#include <linux/dma-contiguous.h>
+#include <linux/dma-iommu.h>
+#include <linux/iova.h>
+
+int iommu_dma_init(void)
+{
+	return iommu_iova_cache_init();
+}
+
+struct iommu_dma_mapping {
+	struct iommu_domain *domain;
+	struct iova_domain *iovad;
+	struct kref kref;
+};
+
+static inline struct iommu_domain *dev_domain(struct device *dev)
+{
+	return dev->archdata.mapping->domain;
+}
+
+static inline struct iova_domain *dev_iovad(struct device *dev)
+{
+	return dev->archdata.mapping->iovad;
+}
+
+phys_addr_t iova_to_phys(struct device *dev, dma_addr_t dev_addr)
+{
+	return iommu_iova_to_phys(dev_domain(dev), dev_addr);
+}
+
+static int __dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
+{
+	int prot = coherent ? IOMMU_CACHE : 0;
+
+	switch (dir) {
+	case DMA_BIDIRECTIONAL:
+		return prot | IOMMU_READ | IOMMU_WRITE;
+	case DMA_TO_DEVICE:
+		return prot | IOMMU_READ;
+	case DMA_FROM_DEVICE:
+		return prot | IOMMU_WRITE;
+	default:
+		return 0;
+	}
+}
+
+static struct iova *__alloc_iova(struct device *dev, size_t size, bool coherent)
+{
+	struct iova_domain *iovad = dev_iovad(dev);
+	unsigned long shift = iova_shift(iovad);
+	unsigned long length = iova_align(iovad, size) >> shift;
+	u64 dma_limit;
+
+	if (coherent)
+		dma_limit = dev->coherent_dma_mask;
+	else
+		dma_limit = *dev->dma_mask;
+	/* Alignment should probably come from a domain/device attribute... */
+	return alloc_iova(iovad, length, dma_limit >> shift, false);
+}
+
+/*
+ * Create a mapping in device IO address space for specified pages
+ */
+dma_addr_t iommu_dma_create_iova_mapping(struct device *dev,
+			struct page **pages, size_t size, bool coherent)
+{
+	struct iommu_domain *domain = dev_domain(dev);
+	struct iova_domain *iovad = dev_iovad(dev);
+	struct iova *iova;
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	dma_addr_t addr_lo, addr_hi;
+	int i, prot = __dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
+
+	iova = __alloc_iova(dev, size, coherent);
+	if (!iova)
+		return DMA_ERROR_CODE;
+
+	addr_hi = addr_lo = iova_dma_addr(iovad, iova);
+	for (i = 0; i < count; ) {
+		unsigned int next_pfn = page_to_pfn(pages[i]) + 1;
+		phys_addr_t phys = page_to_phys(pages[i]);
+		unsigned int len, j;
+
+		for (j = i+1; j < count; j++, next_pfn++)
+			if (page_to_pfn(pages[j]) != next_pfn)
+				break;
+
+		len = (j - i) << PAGE_SHIFT;
+		if (iommu_map(domain, addr_hi, phys, len, prot))
+			goto fail;
+		addr_hi += len;
+		i = j;
+	}
+	return addr_lo;
+fail:
+	iommu_unmap(domain, addr_lo, addr_hi - addr_lo);
+	__free_iova(iovad, iova);
+	return DMA_ERROR_CODE;
+}
+
+int iommu_dma_release_iova_mapping(struct device *dev, dma_addr_t iova,
+				   size_t size)
+{
+	struct iommu_domain *domain = dev_domain(dev);
+	struct iova_domain *iovad = dev_iovad(dev);
+	size_t offset = iova_offset(iovad, iova);
+
+	iommu_unmap(domain, iova - offset, iova_align(iovad, size + offset));
+	free_iova(iovad, iova_pfn(iovad, iova));
+	return 0;
+}
+
+struct page **iommu_dma_alloc_buffer(struct device *dev, size_t size,
+		gfp_t gfp, struct dma_attrs *attrs,
+		void (clear_buffer)(struct page *page, size_t size))
+{
+	struct page **pages;
+	int count = size >> PAGE_SHIFT;
+	int array_size = count * sizeof(struct page *);
+	int i = 0;
+
+	if (array_size <= PAGE_SIZE)
+		pages = kzalloc(array_size, GFP_KERNEL);
+	else
+		pages = vzalloc(array_size);
+	if (!pages)
+		return NULL;
+
+	if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs)) {
+		unsigned long order = get_order(size);
+		struct page *page;
+
+		page = dma_alloc_from_contiguous(dev, count, order);
+		if (!page)
+			goto error;
+
+		if (clear_buffer)
+			clear_buffer(page, size);
+
+		for (i = 0; i < count; i++)
+			pages[i] = page + i;
+
+		return pages;
+	}
+
+	/*
+	 * IOMMU can map any pages, so himem can also be used here
+	 */
+	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
+
+	while (count) {
+		int j, order = __fls(count);
+
+		pages[i] = alloc_pages(gfp, order);
+		while (!pages[i] && order)
+			pages[i] = alloc_pages(gfp, --order);
+		if (!pages[i])
+			goto error;
+
+		if (order) {
+			split_page(pages[i], order);
+			j = 1 << order;
+			while (--j)
+				pages[i + j] = pages[i] + j;
+		}
+
+		if (clear_buffer)
+			clear_buffer(pages[i], PAGE_SIZE << order);
+		i += 1 << order;
+		count -= 1 << order;
+	}
+
+	return pages;
+error:
+	while (i--)
+		if (pages[i])
+			__free_pages(pages[i], 0);
+	if (array_size <= PAGE_SIZE)
+		kfree(pages);
+	else
+		vfree(pages);
+	return NULL;
+}
+
+int iommu_dma_free_buffer(struct device *dev, struct page **pages, size_t size,
+		struct dma_attrs *attrs)
+{
+	int count = size >> PAGE_SHIFT;
+	int array_size = count * sizeof(struct page *);
+	int i;
+
+	if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs)) {
+		dma_release_from_contiguous(dev, pages[0], count);
+	} else {
+		for (i = 0; i < count; i++)
+			if (pages[i])
+				__free_pages(pages[i], 0);
+	}
+
+	if (array_size <= PAGE_SIZE)
+		kfree(pages);
+	else
+		vfree(pages);
+	return 0;
+}
+
+static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		bool coherent)
+{
+	dma_addr_t dma_addr;
+	struct iommu_domain *domain = dev_domain(dev);
+	struct iova_domain *iovad = dev_iovad(dev);
+	phys_addr_t phys = page_to_phys(page) + offset;
+	size_t iova_off = iova_offset(iovad, phys);
+	size_t len = iova_align(iovad, size + iova_off);
+	int prot = __dma_direction_to_prot(dir, coherent);
+	struct iova *iova = __alloc_iova(dev, len, coherent);
+
+	if (!iova)
+		return DMA_ERROR_CODE;
+
+	dma_addr = iova_dma_addr(iovad, iova);
+	if (iommu_map(domain, dma_addr, phys - iova_off, len, prot)) {
+		__free_iova(iovad, iova);
+		return DMA_ERROR_CODE;
+	}
+
+	return dma_addr + iova_off;
+}
+
+dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
+{
+	return __iommu_dma_map_page(dev, page, offset, size, dir, false);
+}
+
+dma_addr_t iommu_dma_coherent_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		struct dma_attrs *attrs)
+{
+	return __iommu_dma_map_page(dev, page, offset, size, dir, true);
+}
+
+void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
+		enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct iommu_domain *domain = dev_domain(dev);
+	struct iova_domain *iovad = dev_iovad(dev);
+	size_t offset = iova_offset(iovad, handle);
+	size_t len = iova_align(iovad, size + offset);
+	dma_addr_t iova = handle - offset;
+
+	if (!iova)
+		return;
+
+	iommu_unmap(domain, iova, len);
+	free_iova(iovad, iova_pfn(iovad, iova));
+}
+
+/*
+ * This little guy is filling in until iommu_map_sg lands and we can hook that
+ * up instead (which is going to be rather involved thanks to page alignment)
+ */
+static int __iommu_dma_map_sg_simple(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, struct dma_attrs *attrs,
+		bool coherent)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i) {
+		sg_dma_address(s) = __iommu_dma_map_page(dev, sg_page(s), s->offset,
+						s->length, dir, coherent);
+		sg_dma_len(s) = s->length;
+	}
+	return nents;
+}
+
+int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	return __iommu_dma_map_sg_simple(dev, sg, nents, dir, attrs, false);
+}
+
+int iommu_dma_coherent_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	return __iommu_dma_map_sg_simple(dev, sg, nents, dir, attrs, true);
+}
+
+void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+		enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i)
+		if (sg_dma_len(s))
+			iommu_dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir, attrs);
+}
+
+struct iommu_dma_mapping *iommu_dma_create_mapping(struct iommu_ops *ops,
+		dma_addr_t base, size_t size)
+{
+	struct iommu_dma_mapping *mapping;
+	struct iommu_domain *domain;
+	struct iova_domain *iovad;
+	struct iommu_domain_geometry *dg;
+	unsigned long order, base_pfn, end_pfn;
+
+	pr_debug("base=%pad\tsize=0x%zx\n", &base, size);
+	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
+	if (!mapping)
+		return NULL;
+
+	/*
+	 * HACK: We'd like to ask the relevant IOMMU in ops for a suitable
+	 * domain, but until that happens, bypass the bus nonsense and create
+	 * one directly for this specific device/IOMMU combination...
+	 */
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+
+	if (!domain)
+		goto out_free_mapping;
+	domain->ops = ops;
+
+	if (ops->domain_init(domain))
+		goto out_free_mapping;
+	/*
+	 * ...and do the bare minimum to sanity-check that the domain allows
+	 * at least some access to the device...
+	 */
+	dg = &domain->geometry;
+	if (!(base < dg->aperture_end && base + size > dg->aperture_start)) {
+		pr_warn("DMA range outside IOMMU capability; is DT correct?\n");
+		goto out_free_mapping;
+	}
+	/* ...then finally give it a kicking to make sure it fits */
+	dg->aperture_start = max(base, dg->aperture_start);
+	dg->aperture_end = min(base + size - 1, dg->aperture_end);
+	/*
+	 * Note that this specifically breaks the case where multiple devices
+	 * need to share a domain, but we don't have the necessary information
+	 * to handle that here anyway - "proper" group and domain allocation
+	 * needs to involve the IOMMU driver and a complete view of the bus.
+	 */
+
+	iovad = kzalloc(sizeof(*iovad), GFP_KERNEL);
+	if (!iovad)
+		goto out_free_domain;
+
+	/* Use the smallest supported page size for IOVA granularity */
+	order = __ffs(ops->pgsize_bitmap);
+	base_pfn = max(dg->aperture_start >> order, (dma_addr_t)1);
+	end_pfn = dg->aperture_end >> order;
+	init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
+
+	mapping->domain = domain;
+	mapping->iovad = iovad;
+	kref_init(&mapping->kref);
+	pr_debug("mapping %p created\n", mapping);
+	return mapping;
+
+out_free_domain:
+	iommu_domain_free(domain);
+out_free_mapping:
+	kfree(mapping);
+	return NULL;
+}
+
+static void iommu_dma_free_mapping(struct kref *kref)
+{
+	struct iommu_dma_mapping *mapping;
+
+	mapping = container_of(kref, struct iommu_dma_mapping, kref);
+	put_iova_domain(mapping->iovad);
+	iommu_domain_free(mapping->domain);
+	kfree(mapping);
+	pr_debug("mapping: %p freed\n", mapping);
+}
+
+void iommu_dma_release_mapping(struct iommu_dma_mapping *mapping)
+{
+	kref_put(&mapping->kref, iommu_dma_free_mapping);
+}
+
+void iommu_dma_detach_device(struct device *dev)
+{
+	struct iommu_dma_mapping *mapping = dev->archdata.mapping;
+
+	if (!mapping) {
+		dev_warn(dev, "Not attached\n");
+		return;
+	}
+	dev->archdata.mapping = NULL;
+	iommu_detach_device(mapping->domain, dev);
+	iommu_dma_release_mapping(mapping);
+	pr_debug("%s detached from mapping: %p\n", dev_name(dev), mapping);
+}
+
+int iommu_dma_attach_device(struct device *dev, struct iommu_dma_mapping *mapping)
+{
+	int ret;
+
+	kref_get(&mapping->kref);
+	ret = iommu_attach_device(mapping->domain, dev);
+	if (ret)
+		iommu_dma_release_mapping(mapping);
+	else
+		dev->archdata.mapping = mapping;
+	pr_debug("%s%s attached to mapping: %p\n", dev_name(dev),
+			ret?" *not*":"", mapping);
+	return ret;
+}
+
+int iommu_dma_supported(struct device *hwdev, u64 mask)
+{
+	/*
+	 * This looks awful, but really it's reasonable to assume that if an
+	 * IOMMU can't address everything that the CPU can, it probably isn't
+	 * generic enough to be using this implementation in the first place.
+	 */
+	return 1;
+}
+
+int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == DMA_ERROR_CODE;
+}
-- 
1.9.1
