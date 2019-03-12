From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 4/9] iommu/vt-d: Add bounce buffer API for domain map/unmap
Date: Tue, 12 Mar 2019 14:00:00 +0800
Message-ID: <20190312060005.12189-5-baolu.lu@linux.intel.com>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190312060005.12189-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This adds the APIs for bounce buffer specified domain
map() and unmap(). The start and end partial pages will
be mapped with bounce buffered pages instead. This will
enhance the security of DMA buffer by isolating the DMA
attacks from malicious devices.

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Tested-by: Xu Pengfei <pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Tested-by: Mika Westerberg <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c   |   3 +
 drivers/iommu/intel-pgtable.c | 305 +++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h   |   7 +
 3 files changed, 311 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 791261afb4a9..305731ec142e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1724,6 +1724,7 @@ static struct dmar_domain *alloc_domain(int flags)
 	domain->flags = flags;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
+	idr_init(&domain->bounce_idr);
 
 	return domain;
 }
@@ -1919,6 +1920,8 @@ static void domain_exit(struct dmar_domain *domain)
 
 	dma_free_pagelist(freelist);
 
+	idr_destroy(&domain->bounce_idr);
+
 	free_domain_mem(domain);
 }
 
diff --git a/drivers/iommu/intel-pgtable.c b/drivers/iommu/intel-pgtable.c
index ad3347d7ac1d..e8317982c5ab 100644
--- a/drivers/iommu/intel-pgtable.c
+++ b/drivers/iommu/intel-pgtable.c
@@ -15,6 +15,8 @@
 #include <linux/iommu.h>
 #include <trace/events/intel_iommu.h>
 
+#define	MAX_BOUNCE_LIST_ENTRIES		32
+
 struct addr_walk {
 	int (*low)(struct dmar_domain *domain, dma_addr_t addr,
 			phys_addr_t paddr, size_t size,
@@ -27,6 +29,13 @@ struct addr_walk {
 			struct bounce_param *param);
 };
 
+struct bounce_cookie {
+	struct page		*bounce_page;
+	phys_addr_t		original_phys;
+	phys_addr_t		bounce_phys;
+	struct list_head	list;
+};
+
 /*
  * Bounce buffer support for external devices:
  *
@@ -42,6 +51,14 @@ static inline unsigned long domain_page_size(struct dmar_domain *domain)
 	return 1UL << __ffs(domain->domain.pgsize_bitmap);
 }
 
+/*
+ * Bounce buffer cookie lazy allocation. A list to keep the unused
+ * bounce buffer cookies with a spin lock to protect the access.
+ */
+static LIST_HEAD(bounce_list);
+static DEFINE_SPINLOCK(bounce_lock);
+static int bounce_list_entries;
+
 /* Calculate how many pages does a range of [addr, addr + size) cross. */
 static inline unsigned long
 range_nrpages(dma_addr_t addr, size_t size, unsigned long page_size)
@@ -51,10 +68,274 @@ range_nrpages(dma_addr_t addr, size_t size, unsigned long page_size)
 	return ALIGN((addr & offset) + size, page_size) >> __ffs(page_size);
 }
 
-int domain_walk_addr_range(const struct addr_walk *walk,
-			   struct dmar_domain *domain,
-			   dma_addr_t addr, phys_addr_t paddr,
-			   size_t size, struct bounce_param *param)
+static int nobounce_map_middle(struct dmar_domain *domain, dma_addr_t addr,
+			       phys_addr_t paddr, size_t size,
+			       struct bounce_param *param)
+{
+	return domain_iomap_range(domain, addr, paddr, size, param->prot);
+}
+
+static int nobounce_unmap_middle(struct dmar_domain *domain, dma_addr_t addr,
+				 phys_addr_t paddr, size_t size,
+				 struct bounce_param *param)
+{
+	struct page **freelist = param->freelist, *new;
+
+	new = domain_iounmap_range(domain, addr, size);
+	if (new) {
+		new->freelist = *freelist;
+		*freelist = new;
+	}
+
+	return 0;
+}
+
+static inline void free_bounce_cookie(struct bounce_cookie *cookie)
+{
+	if (!cookie)
+		return;
+
+	free_page((unsigned long)page_address(cookie->bounce_page));
+	kfree(cookie);
+}
+
+static struct bounce_cookie *
+domain_get_bounce_buffer(struct dmar_domain *domain, unsigned long iova_pfn)
+{
+	struct bounce_cookie *cookie;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&bounce_lock, flags);
+	cookie = idr_find(&domain->bounce_idr, iova_pfn);
+	if (WARN_ON(cookie)) {
+		spin_unlock_irqrestore(&bounce_lock, flags);
+		pr_warn("bounce cookie for iova_pfn 0x%lx exists\n", iova_pfn);
+
+		return NULL;
+	}
+
+	/* Check the bounce list. */
+	cookie = list_first_entry_or_null(&bounce_list,
+					  struct bounce_cookie, list);
+	if (cookie) {
+		list_del_init(&cookie->list);
+		bounce_list_entries--;
+		spin_unlock_irqrestore(&bounce_lock, flags);
+		goto skip_alloc;
+	}
+	spin_unlock_irqrestore(&bounce_lock, flags);
+
+	/* We have to allocate a new cookie. */
+	cookie = kzalloc(sizeof(*cookie), GFP_ATOMIC);
+	if (!cookie)
+		return NULL;
+
+	cookie->bounce_page = alloc_pages_node(domain->nid,
+					       GFP_ATOMIC | __GFP_ZERO, 0);
+	if (!cookie->bounce_page) {
+		kfree(cookie);
+		return NULL;
+	}
+
+skip_alloc:
+	/* Map the cookie with the iova pfn. */
+	spin_lock_irqsave(&bounce_lock, flags);
+	ret = idr_alloc(&domain->bounce_idr, cookie, iova_pfn,
+			iova_pfn + 1, GFP_ATOMIC);
+	spin_unlock_irqrestore(&bounce_lock, flags);
+	if (ret < 0) {
+		free_bounce_cookie(cookie);
+		pr_warn("failed to reserve idr for iova_pfn 0x%lx\n", iova_pfn);
+
+		return NULL;
+	}
+
+	return cookie;
+}
+
+static void
+domain_put_bounce_buffer(struct dmar_domain *domain, unsigned long iova_pfn)
+{
+	struct bounce_cookie *cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bounce_lock, flags);
+	cookie = idr_remove(&domain->bounce_idr, iova_pfn);
+	if (!cookie) {
+		spin_unlock_irqrestore(&bounce_lock, flags);
+		pr_warn("no idr for iova_pfn 0x%lx\n", iova_pfn);
+
+		return;
+	}
+
+	if (bounce_list_entries >= MAX_BOUNCE_LIST_ENTRIES) {
+		spin_unlock_irqrestore(&bounce_lock, flags);
+		free_bounce_cookie(cookie);
+
+		return;
+	}
+	list_add_tail(&cookie->list, &bounce_list);
+	bounce_list_entries++;
+	spin_unlock_irqrestore(&bounce_lock, flags);
+}
+
+static inline int
+bounce_sync(phys_addr_t orig_addr, phys_addr_t bounce_addr,
+	    size_t size, enum dma_data_direction dir)
+{
+	unsigned long pfn = PFN_DOWN(orig_addr);
+	unsigned char *vaddr = phys_to_virt(bounce_addr);
+
+	if (PageHighMem(pfn_to_page(pfn))) {
+		/* The buffer does not have a mapping. Map it in and copy */
+		unsigned int offset = offset_in_page(orig_addr);
+		unsigned int sz = 0;
+		unsigned long flags;
+		char *buffer;
+
+		while (size) {
+			sz = min_t(size_t, PAGE_SIZE - offset, size);
+
+			local_irq_save(flags);
+			buffer = kmap_atomic(pfn_to_page(pfn));
+			if (dir == DMA_TO_DEVICE)
+				memcpy(vaddr, buffer + offset, sz);
+			else
+				memcpy(buffer + offset, vaddr, sz);
+			kunmap_atomic(buffer);
+			local_irq_restore(flags);
+
+			size -= sz;
+			pfn++;
+			vaddr += sz;
+			offset = 0;
+		}
+	} else if (dir == DMA_TO_DEVICE) {
+		memcpy(vaddr, phys_to_virt(orig_addr), size);
+	} else {
+		memcpy(phys_to_virt(orig_addr), vaddr, size);
+	}
+
+	return 0;
+}
+
+static int
+bounce_sync_for_cpu(phys_addr_t orig_addr, phys_addr_t bounce_addr, size_t size)
+{
+	return bounce_sync(orig_addr, bounce_addr, size, DMA_FROM_DEVICE);
+}
+
+static int
+bounce_sync_for_dev(phys_addr_t orig_addr, phys_addr_t bounce_addr, size_t size)
+{
+	return bounce_sync(orig_addr, bounce_addr, size, DMA_TO_DEVICE);
+}
+
+static int bounce_map(struct dmar_domain *domain, dma_addr_t addr,
+		      phys_addr_t paddr, size_t size,
+		      struct bounce_param *param)
+{
+	unsigned long page_size = domain_page_size(domain);
+	enum dma_data_direction dir = param->dir;
+	struct bounce_cookie *cookie;
+	phys_addr_t bounce_addr;
+	int prot = param->prot;
+	unsigned long offset;
+	int ret = 0;
+
+	offset = addr & (page_size - 1);
+	cookie = domain_get_bounce_buffer(domain, addr >> PAGE_SHIFT);
+	if (!cookie)
+		return -ENOMEM;
+
+	bounce_addr = page_to_phys(cookie->bounce_page) + offset;
+	cookie->original_phys = paddr;
+	cookie->bounce_phys = bounce_addr;
+	if (dir == DMA_BIDIRECTIONAL || dir == DMA_TO_DEVICE) {
+		ret = bounce_sync_for_dev(paddr, bounce_addr, size);
+		if (ret)
+			return ret;
+	}
+
+	return domain_iomap_range(domain, addr, bounce_addr, size, prot);
+}
+
+static int bounce_map_low(struct dmar_domain *domain, dma_addr_t addr,
+			  phys_addr_t paddr, size_t size,
+			  struct bounce_param *param)
+{
+	return bounce_map(domain, addr, paddr, size, param);
+}
+
+static int bounce_map_high(struct dmar_domain *domain, dma_addr_t addr,
+			   phys_addr_t paddr, size_t size,
+			   struct bounce_param *param)
+{
+	return bounce_map(domain, addr, paddr, size, param);
+}
+
+static const struct addr_walk walk_bounce_map = {
+	.low = bounce_map_low,
+	.middle = nobounce_map_middle,
+	.high = bounce_map_high,
+};
+
+static int bounce_unmap(struct dmar_domain *domain, dma_addr_t addr,
+			phys_addr_t paddr, size_t size,
+			struct bounce_param *param)
+{
+	struct page **freelist = param->freelist, *new;
+	enum dma_data_direction dir = param->dir;
+	struct bounce_cookie *cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bounce_lock, flags);
+	cookie = idr_find(&domain->bounce_idr, addr >> PAGE_SHIFT);
+	spin_unlock_irqrestore(&bounce_lock, flags);
+	if (WARN_ON(!cookie))
+		return -ENODEV;
+
+	new = domain_iounmap_range(domain, addr, size);
+	if (new) {
+		new->freelist = *freelist;
+		*freelist = new;
+	}
+
+	if (dir == DMA_BIDIRECTIONAL || dir == DMA_FROM_DEVICE)
+		bounce_sync_for_cpu(cookie->original_phys,
+				    cookie->bounce_phys, size);
+
+	domain_put_bounce_buffer(domain, addr >> PAGE_SHIFT);
+
+	return 0;
+}
+
+static int bounce_unmap_low(struct dmar_domain *domain, dma_addr_t addr,
+			    phys_addr_t paddr, size_t size,
+			    struct bounce_param *param)
+{
+	return bounce_unmap(domain, addr, paddr, size, param);
+}
+
+static int bounce_unmap_high(struct dmar_domain *domain, dma_addr_t addr,
+			     phys_addr_t paddr, size_t size,
+			     struct bounce_param *param)
+{
+	return bounce_unmap(domain, addr, paddr, size, param);
+}
+
+static const struct addr_walk walk_bounce_unmap = {
+	.low = bounce_unmap_low,
+	.middle = nobounce_unmap_middle,
+	.high = bounce_unmap_high,
+};
+
+static int
+domain_walk_addr_range(const struct addr_walk *walk,
+		       struct dmar_domain *domain,
+		       dma_addr_t addr, phys_addr_t paddr,
+		       size_t size, struct bounce_param *param)
 {
 	u64 page_size = domain_page_size(domain);
 	u64 page_offset = page_size - 1;
@@ -107,3 +388,19 @@ int domain_walk_addr_range(const struct addr_walk *walk,
 
 	return 0;
 }
+
+int
+domain_bounce_map(struct dmar_domain *domain, dma_addr_t addr,
+		  phys_addr_t paddr, size_t size, struct bounce_param *param)
+{
+	return domain_walk_addr_range(&walk_bounce_map, domain,
+				      addr, paddr, size, param);
+}
+
+int
+domain_bounce_unmap(struct dmar_domain *domain, dma_addr_t addr,
+		    phys_addr_t paddr, size_t size, struct bounce_param *param)
+{
+	return domain_walk_addr_range(&walk_bounce_unmap, domain,
+				      addr, paddr, size, param);
+}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index f74aed6ecc33..8b5ba91ab606 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -498,6 +498,7 @@ struct dmar_domain {
 
 	struct dma_pte	*pgd;		/* virtual address */
 	int		gaw;		/* max guest address width */
+	struct idr	bounce_idr;	/* IDR for iova_pfn to bounce page */
 
 	/* adjusted guest address width, 0 is level 2 30-bit */
 	int		agaw;
@@ -674,6 +675,12 @@ struct bounce_param {
 	struct page		**freelist;
 };
 
+int domain_bounce_map(struct dmar_domain *domain, dma_addr_t addr,
+		      phys_addr_t paddr, size_t size,
+		      struct bounce_param *param);
+int domain_bounce_unmap(struct dmar_domain *domain, dma_addr_t addr,
+			phys_addr_t paddr, size_t size,
+			struct bounce_param *param);
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
-- 
2.17.1
