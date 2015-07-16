From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4 2/4] iommu: Implement common IOMMU ops for DMA mapping
Date: Thu, 16 Jul 2015 19:40:13 +0100
Message-ID: <00fb13713dc8a69dc32b859f9311e70d78fb0c7a.1437070995.git.robin.murphy@arm.com>
References: <cover.1437070995.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1437070995.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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

Taking inspiration from the existing arch/arm code, break out some
generic functions to interface the DMA-API to the IOMMU-API. This will
do the bulk of the heavy lifting for IOMMU-backed dma-mapping.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/Kconfig     |   7 +
 drivers/iommu/Makefile    |   1 +
 drivers/iommu/dma-iommu.c | 538 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  84 ++++++++
 include/linux/iommu.h     |   1 +
 5 files changed, 631 insertions(+)
 create mode 100644 drivers/iommu/dma-iommu.c
 create mode 100644 include/linux/dma-iommu.h

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f1fb1d3..efb0e66 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -48,6 +48,13 @@ config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
 
+# IOMMU-agnostic DMA-mapping layer
+config IOMMU_DMA
+	bool
+	depends on NEED_SG_DMA_LENGTH
+	select IOMMU_API
+	select IOMMU_IOVA
+
 config FSL_PAMU
 	bool "Freescale IOMMU support"
 	depends on PPC32
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index c6dcc51..f465cfb 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
+obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
new file mode 100644
index 0000000..cab3289
--- /dev/null
+++ b/drivers/iommu/dma-iommu.c
@@ -0,0 +1,538 @@
+/*
+ * A fairly generic DMA-API to IOMMU-API glue layer.
+ *
+ * Copyright (C) 2014-2015 ARM Ltd.
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
+#include <linux/device.h>
+#include <linux/dma-iommu.h>
+#include <linux/huge_mm.h>
+#include <linux/iommu.h>
+#include <linux/iova.h>
+#include <linux/mm.h>
+
+int iommu_dma_init(void)
+{
+	return iommu_iova_cache_init();
+}
+
+/**
+ * iommu_get_dma_cookie - Acquire DMA-API resources for a domain
+ * @domain: IOMMU domain to prepare for DMA-API usage
+ *
+ * IOMMU drivers should normally call this from their domain_alloc
+ * callback when domain->type == IOMMU_DOMAIN_DMA.
+ */
+int iommu_get_dma_cookie(struct iommu_domain *domain)
+{
+	struct iova_domain *iovad;
+
+	if (domain->dma_api_cookie)
+		return -EEXIST;
+
+	iovad = kzalloc(sizeof(*iovad), GFP_KERNEL);
+	domain->dma_api_cookie = iovad;
+
+	return iovad ? 0 : -ENOMEM;
+}
+EXPORT_SYMBOL(iommu_get_dma_cookie);
+
+/**
+ * iommu_put_dma_cookie - Release a domain's DMA mapping resources
+ * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
+ *
+ * IOMMU drivers should normally call this from their domain_free callback.
+ */
+void iommu_put_dma_cookie(struct iommu_domain *domain)
+{
+	struct iova_domain *iovad = domain->dma_api_cookie;
+
+	if (!iovad)
+		return;
+
+	put_iova_domain(iovad);
+	kfree(iovad);
+	domain->dma_api_cookie = NULL;
+}
+EXPORT_SYMBOL(iommu_put_dma_cookie);
+
+/**
+ * iommu_dma_init_domain - Initialise a DMA mapping domain
+ * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
+ * @base: IOVA at which the mappable address space starts
+ * @size: Size of IOVA space
+ *
+ * @base and @size should be exact multiples of IOMMU page granularity to
+ * avoid rounding surprises. If necessary, we reserve the page at address 0
+ * to ensure it is an invalid IOVA.
+ */
+int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size)
+{
+	struct iova_domain *iovad = domain->dma_api_cookie;
+	unsigned long order, base_pfn, end_pfn;
+
+	if (!iovad)
+		return -ENODEV;
+
+	/* Use the smallest supported page size for IOVA granularity */
+	order = __ffs(domain->ops->pgsize_bitmap);
+	base_pfn = max_t(unsigned long, 1, base >> order);
+	end_pfn = (base + size - 1) >> order;
+
+	/* Check the domain allows at least some access to the device... */
+	if (domain->geometry.force_aperture) {
+		if (base > domain->geometry.aperture_end ||
+		    base + size <= domain->geometry.aperture_start) {
+			pr_warn("specified DMA range outside IOMMU capability\n");
+			return -EFAULT;
+		}
+		/* ...then finally give it a kicking to make sure it fits */
+		base_pfn = max_t(unsigned long, base_pfn,
+				domain->geometry.aperture_start >> order);
+		end_pfn = min_t(unsigned long, end_pfn,
+				domain->geometry.aperture_end >> order);
+	}
+
+	/* All we can safely do with an existing domain is enlarge it */
+	if (iovad->start_pfn) {
+		if (1UL << order == iovad->granule &&
+		    base_pfn == iovad->start_pfn &&
+		    end_pfn >= iovad->dma_32bit_pfn) {
+			pr_warn("Incompatible range for DMA domain\n");
+			return -EFAULT;
+		}
+		iovad->dma_32bit_pfn = end_pfn;
+	} else {
+		init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(iommu_dma_init_domain);
+
+/**
+ * dma_direction_to_prot - Translate DMA API directions to IOMMU API page flags
+ * @dir: Direction of DMA transfer
+ * @coherent: Is the DMA master cache-coherent?
+ *
+ * Return: corresponding IOMMU API page protection flags
+ */
+int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
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
+static struct iova *__alloc_iova(struct iova_domain *iovad, size_t size,
+		dma_addr_t dma_limit)
+{
+	unsigned long shift = iova_shift(iovad);
+	unsigned long length = iova_align(iovad, size) >> shift;
+
+	/*
+	 * Enforce size-alignment to be safe - there should probably be
+	 * an attribute to control this per-device, or at least per-domain...
+	 */
+	return alloc_iova(iovad, length, dma_limit >> shift, true);
+}
+
+/* The IOVA allocator knows what we mapped, so just unmap whatever that was */
+static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr)
+{
+	struct iova_domain *iovad = domain->dma_api_cookie;
+	unsigned long shift = iova_shift(iovad);
+	unsigned long pfn = dma_addr >> shift;
+	struct iova *iova = find_iova(iovad, pfn);
+	size_t size = iova_size(iova) << shift;
+
+	/* ...and if we can't, then something is horribly, horribly wrong */
+	BUG_ON(iommu_unmap(domain, pfn << shift, size) < size);
+	__free_iova(iovad, iova);
+}
+
+static void __iommu_dma_free_pages(struct page **pages, int count)
+{
+	while (count--)
+		__free_page(pages[count]);
+	kvfree(pages);
+}
+
+static struct page **__iommu_dma_alloc_pages(unsigned int count, gfp_t gfp)
+{
+	struct page **pages;
+	unsigned int i = 0, array_size = count * sizeof(*pages);
+
+	if (array_size <= PAGE_SIZE)
+		pages = kzalloc(array_size, GFP_KERNEL);
+	else
+		pages = vzalloc(array_size);
+	if (!pages)
+		return NULL;
+
+	/* IOMMU can map any pages, so himem can also be used here */
+	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
+
+	while (count) {
+		struct page *page = NULL;
+		int j, order = __fls(count);
+
+		/*
+		 * Higher-order allocations are a convenience rather
+		 * than a necessity, hence using __GFP_NORETRY until
+		 * falling back to single-page allocations.
+		 */
+		for (order = min(order, MAX_ORDER); order > 0; order--) {
+			page = alloc_pages(gfp | __GFP_NORETRY, order);
+			if (!page)
+				continue;
+			if (PageCompound(page)) {
+				if (!split_huge_page(page))
+					break;
+				__free_pages(page, order);
+			} else {
+				split_page(page, order);
+				break;
+			}
+		}
+		if (!page)
+			page = alloc_page(gfp);
+		if (!page) {
+			__iommu_dma_free_pages(pages, i);
+			return NULL;
+		}
+		j = 1 << order;
+		count -= j;
+		while (j--)
+			pages[i++] = page++;
+	}
+	return pages;
+}
+
+/**
+ * iommu_dma_free - Free a buffer allocated by iommu_dma_alloc()
+ * @dev: Device which owns this buffer
+ * @pages: Array of buffer pages as returned by iommu_dma_alloc()
+ * @size: Size of buffer in bytes
+ * @handle: DMA address of buffer
+ *
+ * Frees both the pages associated with the buffer, and the array
+ * describing them
+ */
+void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
+		dma_addr_t *handle)
+{
+	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), *handle);
+	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
+	*handle = DMA_ERROR_CODE;
+}
+
+/**
+ * iommu_dma_alloc - Allocate and map a buffer contiguous in IOVA space
+ * @dev: Device to allocate memory for. Must be a real device
+ *	 attached to an iommu_dma_domain
+ * @size: Size of buffer in bytes
+ * @gfp: Allocation flags
+ * @prot: IOMMU mapping flags
+ * @handle: Out argument for allocated DMA handle
+ * @flush_page: Arch callback to flush a single page from all caches to
+ *		ensure DMA visibility of __GFP_ZERO. May be NULL if not
+ *		required.
+ *
+ * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
+ * but an IOMMU which supports smaller pages might not map the whole thing.
+ *
+ * Return: Array of struct page pointers describing the buffer,
+ *	   or NULL on failure.
+ */
+struct page **iommu_dma_alloc(struct device *dev, size_t size,
+		gfp_t gfp, int prot, dma_addr_t *handle,
+		void (*flush_page)(const void *, phys_addr_t))
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iova_domain *iovad = domain->dma_api_cookie;
+	struct iova *iova;
+	struct page **pages;
+	struct sg_table sgt;
+	dma_addr_t dma_addr;
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	*handle = DMA_ERROR_CODE;
+
+	pages = __iommu_dma_alloc_pages(count, gfp);
+	if (!pages)
+		return NULL;
+
+	iova = __alloc_iova(iovad, size, dev->coherent_dma_mask);
+	if (!iova)
+		goto out_free_pages;
+
+	size = iova_align(iovad, size);
+	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
+		goto out_free_iova;
+
+	if (gfp & __GFP_ZERO) {
+		struct sg_mapping_iter miter;
+		/*
+		 * The flushing provided by the SG_MITER_TO_SG flag only
+		 * applies to highmem pages, so it won't do the job here.
+		 */
+		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
+		while (sg_miter_next(&miter)) {
+			memset(miter.addr, 0, PAGE_SIZE);
+			if (flush_page)
+				flush_page(miter.addr, page_to_phys(miter.page));
+		}
+		sg_miter_stop(&miter);
+	}
+
+	dma_addr = iova_dma_addr(iovad, iova);
+	if (iommu_map_sg(domain, dma_addr, sgt.sgl, sgt.orig_nents, prot)
+			< size)
+		goto out_free_sg;
+
+	*handle = dma_addr;
+	sg_free_table(&sgt);
+	return pages;
+
+out_free_sg:
+	sg_free_table(&sgt);
+out_free_iova:
+	__free_iova(iovad, iova);
+out_free_pages:
+	__iommu_dma_free_pages(pages, count);
+	return NULL;
+}
+
+/**
+ * iommu_dma_mmap - Map a buffer into provided user VMA
+ * @pages: Array representing buffer from iommu_dma_alloc()
+ * @size: Size of buffer in bytes
+ * @vma: VMA describing requested userspace mapping
+ *
+ * Maps the pages of the buffer in @pages into @vma. The caller is responsible
+ * for verifying the correct size and protection of @vma beforehand.
+ */
+
+int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
+{
+	unsigned long uaddr = vma->vm_start;
+	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	int ret = -ENXIO;
+
+	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
+		ret = vm_insert_page(vma, uaddr, pages[i]);
+		if (ret)
+			break;
+		uaddr += PAGE_SIZE;
+	}
+	return ret;
+}
+
+dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, int prot)
+{
+	dma_addr_t dma_addr;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iova_domain *iovad = domain->dma_api_cookie;
+	phys_addr_t phys = page_to_phys(page) + offset;
+	size_t iova_off = iova_offset(iovad, phys);
+	size_t len = iova_align(iovad, size + iova_off);
+	struct iova *iova = __alloc_iova(iovad, len, dma_get_mask(dev));
+
+	if (!iova)
+		return DMA_ERROR_CODE;
+
+	dma_addr = iova_dma_addr(iovad, iova);
+	if (iommu_map(domain, dma_addr, phys - iova_off, len, prot)) {
+		__free_iova(iovad, iova);
+		return DMA_ERROR_CODE;
+	}
+	return dma_addr + iova_off;
+}
+
+void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
+		enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle);
+}
+
+/*
+ * Go and look at iommu_dma_map_sg first; It's OK, I'll wait...
+ *
+ * ...right, now that the scatterlist pages are all contiguous from the
+ * device's viewpoint, we can collapse any buffer segments which run
+ * together (subject to the device's segment limitations), filling in
+ * the DMA fields at the same time as we run through the list.
+ */
+static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
+		dma_addr_t dma_addr)
+{
+	struct scatterlist *s, *seg = sg;
+	unsigned long seg_mask = dma_get_seg_boundary(dev);
+	unsigned int max_len = dma_get_max_seg_size(dev);
+	unsigned int seg_len = 0, seg_dma = 0;
+	int i, count = 1;
+
+	for_each_sg(sg, s, nents, i) {
+		/* Un-swizzling the fields here, hence the naming mismatch */
+		unsigned int s_offset = sg_dma_address(s);
+		unsigned int s_length = sg_dma_len(s);
+		unsigned int s_dma_len = s->length;
+
+		s->offset = s_offset;
+		s->length = s_length;
+		sg_dma_address(s) = DMA_ERROR_CODE;
+		sg_dma_len(s) = 0;
+
+		/*
+		 * This ensures any concatenation we do doesn't exceed the
+		 * dma_parms limits, but it also won't fail if any segments
+		 * were out of spec to begin with - they'll just stay as-is.
+		 */
+		if (seg_len && (seg_dma + seg_len == dma_addr + s_offset) &&
+		    (seg_len + s_dma_len <= max_len) &&
+		    ((seg_dma & seg_mask) <= seg_mask - (seg_len + s_length))
+		   ) {
+			sg_dma_len(seg) += s_dma_len;
+		} else {
+			if (seg_len) {
+				seg = sg_next(seg);
+				count++;
+			}
+			sg_dma_len(seg) = s_dma_len - s_offset;
+			sg_dma_address(seg) = dma_addr + s_offset;
+
+			seg_len = s_offset;
+			seg_dma = dma_addr + s_offset;
+		}
+		seg_len += s_length;
+		dma_addr += s_dma_len;
+	}
+	return count;
+}
+
+/*
+ * If mapping failed, then just restore the original list,
+ * but making sure the DMA fields are invalidated.
+ */
+static void __invalidate_sg(struct scatterlist *sg, int nents)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i) {
+		if (sg_dma_address(s) != DMA_ERROR_CODE)
+			s->offset = sg_dma_address(s);
+		if (sg_dma_len(s))
+			s->length = sg_dma_len(s);
+		sg_dma_address(s) = DMA_ERROR_CODE;
+		sg_dma_len(s) = 0;
+	}
+}
+
+/*
+ * The DMA API client is passing in a scatterlist which could describe
+ * any old buffer layout, but the IOMMU API requires everything to be
+ * aligned to IOMMU pages. Hence the need for this complicated bit of
+ * impedance-matching, to be able to hand off a suitably-aligned list,
+ * but still preserve the original offsets and sizes for the caller.
+ */
+int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, int prot)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iova_domain *iovad = domain->dma_api_cookie;
+	struct iova *iova;
+	struct scatterlist *s;
+	dma_addr_t dma_addr;
+	size_t iova_len = 0;
+	int i;
+
+	/*
+	 * Work out how much IOVA space we need, and align the segments to
+	 * IOVA granules for the IOMMU driver to handle. With some clever
+	 * trickery we can modify the list in-place, but reversibly, by
+	 * hiding the original data in the as-yet-unused DMA fields.
+	 */
+	for_each_sg(sg, s, nents, i) {
+		size_t s_offset = iova_offset(iovad, s->offset);
+		size_t s_length = s->length;
+
+		sg_dma_address(s) = s->offset;
+		sg_dma_len(s) = s_length;
+		s->offset -= s_offset;
+		s_length = iova_align(iovad, s_length + s_offset);
+		s->length = s_length;
+
+		iova_len += s_length;
+	}
+
+	iova = __alloc_iova(iovad, iova_len, dma_get_mask(dev));
+	if (!iova)
+		goto out_restore_sg;
+
+	/*
+	 * We'll leave any physical concatenation to the IOMMU driver's
+	 * implementation - it knows better than we do.
+	 */
+	dma_addr = iova_dma_addr(iovad, iova);
+	if (iommu_map_sg(domain, dma_addr, sg, nents, prot) < iova_len)
+		goto out_free_iova;
+
+	return __finalise_sg(dev, sg, nents, dma_addr);
+
+out_free_iova:
+	__free_iova(iovad, iova);
+out_restore_sg:
+	__invalidate_sg(sg, nents);
+	return 0;
+}
+
+void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+		enum dma_data_direction dir, struct dma_attrs *attrs)
+{
+	/*
+	 * The scatterlist segments are mapped contiguously
+	 * in IOVA space, so this is incredibly easy.
+	 */
+	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), sg_dma_address(sg));
+}
+
+int iommu_dma_supported(struct device *dev, u64 mask)
+{
+	/*
+	 * 'Special' IOMMUs which don't have the same addressing capability
+	 * as the CPU will have to wait until we have some way to query that
+	 * before they'll be able to use this framework.
+	 */
+	return 1;
+}
+
+int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
+{
+	return dma_addr == DMA_ERROR_CODE;
+}
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
new file mode 100644
index 0000000..6f08215
--- /dev/null
+++ b/include/linux/dma-iommu.h
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2014-2015 ARM Ltd.
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
+#include <linux/iommu.h>
+
+#ifdef CONFIG_IOMMU_DMA
+
+int iommu_dma_init(void);
+
+/* Domain management interface for IOMMU drivers */
+int iommu_get_dma_cookie(struct iommu_domain *domain);
+void iommu_put_dma_cookie(struct iommu_domain *domain);
+
+/* Setup call for arch DMA mapping code */
+int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size);
+
+/* General helpers for DMA-API <-> IOMMU-API interaction */
+int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
+
+/*
+ * These implement the bulk of the relevant DMA mapping callbacks, but require
+ * the arch code to take care of attributes and cache maintenance
+ */
+struct page **iommu_dma_alloc(struct device *dev, size_t size,
+		gfp_t gfp, int prot, dma_addr_t *handle,
+		void (*flush_page)(const void *, phys_addr_t));
+void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
+		dma_addr_t *handle);
+
+int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma);
+
+dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, int prot);
+int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, int prot);
+
+/*
+ * Arch code with no special attribute handling may use these
+ * directly as DMA mapping callbacks for simplicity
+ */
+void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
+		enum dma_data_direction dir, struct dma_attrs *attrs);
+void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+		enum dma_data_direction dir, struct dma_attrs *attrs);
+int iommu_dma_supported(struct device *dev, u64 mask);
+int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
+
+#else
+
+static inline int iommu_dma_init(void)
+{
+	return 0;
+}
+
+static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
+{
+}
+
+#endif	/* CONFIG_IOMMU_DMA */
+
+#endif	/* __KERNEL__ */
+#endif	/* __DMA_IOMMU_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index dc767f7..19eee27 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -81,6 +81,7 @@ struct iommu_domain {
 	iommu_fault_handler_t handler;
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
+	void *dma_api_cookie;
 };
 
 enum iommu_cap {
-- 
1.9.1
