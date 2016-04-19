From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v7 06/10] iommu/dma-reserved-iommu: iommu_get/put_reserved_iova
Date: Tue, 19 Apr 2016 16:56:30 +0000
Message-ID: <1461084994-2355-7-git-send-email-eric.auger@linaro.org>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1461084994-2355-1-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-qxv4g6HH51o@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch introduces iommu_get/put_reserved_iova.

iommu_get_reserved_iova allows to iommu map a contiguous physical region
onto a reserved contiguous IOVA region. The physical region base address
does not need to be iommu page size aligned. iova pages are allocated and
mapped so that they cover all the physical region. This mapping is
tracked as a whole (and cannot be split) in an RB tree indexed by PA.

In case a mapping already exists for the physical pages, the IOVA mapped
to the PA base is directly returned.

Each time the get succeeds a binding ref count is incremented.

iommu_put_reserved_iova decrements the ref count and when this latter
is null, the mapping is destroyed and the iovas are released.

Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

---
v7:
- change title and rework commit message with new name of the functions
  and size parameter
- fix locking
- rework header doc comments
- put now takes a phys_addr_t
- check prot argument against reserved_iova_domain prot flags

v5 -> v6:
- revisit locking with spin_lock instead of mutex
- do not kref_get on 1st get
- add size parameter to the get function following Marc's request
- use the iova domain shift instead of using the smallest supported page size

v3 -> v4:
- formerly in iommu: iommu_get/put_single_reserved &
  iommu/arm-smmu: implement iommu_get/put_single_reserved
- Attempted to address Marc's doubts about missing size/alignment
  at VFIO level (user-space knows the IOMMU page size and the number
  of IOVA pages to provision)

v2 -> v3:
- remove static implementation of iommu_get_single_reserved &
  iommu_put_single_reserved when CONFIG_IOMMU_API is not set

v1 -> v2:
- previously a VFIO API, named vfio_alloc_map/unmap_free_reserved_iova
---
 drivers/iommu/dma-reserved-iommu.c | 150 +++++++++++++++++++++++++++++++++++++
 include/linux/dma-reserved-iommu.h |  38 ++++++++++
 2 files changed, 188 insertions(+)

diff --git a/drivers/iommu/dma-reserved-iommu.c b/drivers/iommu/dma-reserved-iommu.c
index f6fa18e..426d339 100644
--- a/drivers/iommu/dma-reserved-iommu.c
+++ b/drivers/iommu/dma-reserved-iommu.c
@@ -135,6 +135,22 @@ unlock:
 }
 EXPORT_SYMBOL_GPL(iommu_alloc_reserved_iova_domain);
 
+/* called with domain's reserved_lock held */
+static void reserved_binding_release(struct kref *kref)
+{
+	struct iommu_reserved_binding *b =
+		container_of(kref, struct iommu_reserved_binding, kref);
+	struct iommu_domain *d = b->domain;
+	struct reserved_iova_domain *rid =
+		(struct reserved_iova_domain *)d->reserved_iova_cookie;
+	unsigned long order;
+
+	order = iova_shift(rid->iovad);
+	free_iova(rid->iovad, b->iova >> order);
+	unlink_reserved_binding(d, b);
+	kfree(b);
+}
+
 void iommu_free_reserved_iova_domain(struct iommu_domain *domain)
 {
 	struct reserved_iova_domain *rid;
@@ -160,3 +176,137 @@ unlock:
 	}
 }
 EXPORT_SYMBOL_GPL(iommu_free_reserved_iova_domain);
+
+int iommu_get_reserved_iova(struct iommu_domain *domain,
+			      phys_addr_t addr, size_t size, int prot,
+			      dma_addr_t *iova)
+{
+	unsigned long base_pfn, end_pfn, nb_iommu_pages, order, flags;
+	struct iommu_reserved_binding *b, *newb;
+	size_t iommu_page_size, binding_size;
+	phys_addr_t aligned_base, offset;
+	struct reserved_iova_domain *rid;
+	struct iova_domain *iovad;
+	struct iova *p_iova;
+	int ret = -EINVAL;
+
+	newb = kzalloc(sizeof(*newb), GFP_KERNEL);
+	if (!newb)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&domain->reserved_lock, flags);
+
+	rid = (struct reserved_iova_domain *)domain->reserved_iova_cookie;
+	if (!rid)
+		goto free_newb;
+
+	if ((prot & IOMMU_READ & !(rid->prot & IOMMU_READ)) ||
+	    (prot & IOMMU_WRITE & !(rid->prot & IOMMU_WRITE)))
+		goto free_newb;
+
+	iovad = rid->iovad;
+	order = iova_shift(iovad);
+	base_pfn = addr >> order;
+	end_pfn = (addr + size - 1) >> order;
+	aligned_base = base_pfn << order;
+	offset = addr - aligned_base;
+	nb_iommu_pages = end_pfn - base_pfn + 1;
+	iommu_page_size = 1 << order;
+	binding_size = nb_iommu_pages * iommu_page_size;
+
+	b = find_reserved_binding(domain, aligned_base, binding_size);
+	if (b) {
+		*iova = b->iova + offset + aligned_base - b->addr;
+		kref_get(&b->kref);
+		ret = 0;
+		goto free_newb;
+	}
+
+	p_iova = alloc_iova(iovad, nb_iommu_pages,
+			    iovad->dma_32bit_pfn, true);
+	if (!p_iova) {
+		ret = -ENOMEM;
+		goto free_newb;
+	}
+
+	*iova = iova_dma_addr(iovad, p_iova);
+
+	/* unlock to call iommu_map which is not guaranteed to be atomic */
+	spin_unlock_irqrestore(&domain->reserved_lock, flags);
+
+	ret = iommu_map(domain, *iova, aligned_base, binding_size, prot);
+
+	spin_lock_irqsave(&domain->reserved_lock, flags);
+
+	rid = (struct reserved_iova_domain *) domain->reserved_iova_cookie;
+	if (!rid || (rid->iovad != iovad)) {
+		/* reserved iova domain was destroyed in our back */
+		ret = -EBUSY;
+		goto free_newb; /* iova already released */
+	}
+
+	/* no change in iova reserved domain but iommu_map failed */
+	if (ret)
+		goto free_iova;
+
+	/* everything is fine, add in the new node in the rb tree */
+	kref_init(&newb->kref);
+	newb->domain = domain;
+	newb->addr = aligned_base;
+	newb->iova = *iova;
+	newb->size = binding_size;
+
+	link_reserved_binding(domain, newb);
+
+	*iova += offset;
+	goto unlock;
+
+free_iova:
+	free_iova(rid->iovad, p_iova->pfn_lo);
+free_newb:
+	kfree(newb);
+unlock:
+	spin_unlock_irqrestore(&domain->reserved_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_get_reserved_iova);
+
+void iommu_put_reserved_iova(struct iommu_domain *domain, phys_addr_t addr)
+{
+	phys_addr_t aligned_addr, page_size, mask;
+	struct iommu_reserved_binding *b;
+	struct reserved_iova_domain *rid;
+	unsigned long order, flags;
+	struct iommu_domain *d;
+	dma_addr_t iova;
+	size_t size;
+	int ret = 0;
+
+	spin_lock_irqsave(&domain->reserved_lock, flags);
+
+	rid = (struct reserved_iova_domain *)domain->reserved_iova_cookie;
+	if (!rid)
+		goto unlock;
+
+	order = iova_shift(rid->iovad);
+	page_size = (uint64_t)1 << order;
+	mask = page_size - 1;
+	aligned_addr = addr & ~mask;
+
+	b = find_reserved_binding(domain, aligned_addr, page_size);
+	if (!b)
+		goto unlock;
+
+	iova = b->iova;
+	size = b->size;
+	d = b->domain;
+
+	ret = kref_put(&b->kref, reserved_binding_release);
+
+unlock:
+	spin_unlock_irqrestore(&domain->reserved_lock, flags);
+	if (ret)
+		iommu_unmap(d, iova, size);
+}
+EXPORT_SYMBOL_GPL(iommu_put_reserved_iova);
+
diff --git a/include/linux/dma-reserved-iommu.h b/include/linux/dma-reserved-iommu.h
index 01ec385..8722131 100644
--- a/include/linux/dma-reserved-iommu.h
+++ b/include/linux/dma-reserved-iommu.h
@@ -42,6 +42,34 @@ int iommu_alloc_reserved_iova_domain(struct iommu_domain *domain,
  */
 void iommu_free_reserved_iova_domain(struct iommu_domain *domain);
 
+/**
+ * iommu_get_reserved_iova: allocate a contiguous set of iova pages and
+ * map them to the physical range defined by @addr and @size.
+ *
+ * @domain: iommu domain handle
+ * @addr: physical address to bind
+ * @size: size of the binding
+ * @prot: mapping protection attribute
+ * @iova: returned iova
+ *
+ * Mapped physical pfns are within [@addr >> order, (@addr + size -1) >> order]
+ * where order corresponds to the reserved iova domain order.
+ * This mapping is tracked and reference counted with the minimal granularity
+ * of @size.
+ */
+int iommu_get_reserved_iova(struct iommu_domain *domain,
+			    phys_addr_t addr, size_t size, int prot,
+			    dma_addr_t *iova);
+
+/**
+ * iommu_put_reserved_iova: decrement a ref count of the reserved mapping
+ *
+ * @domain: iommu domain handle
+ * @addr: physical address whose binding ref count is decremented
+ *
+ * if the binding ref count is null, destroy the reserved mapping
+ */
+void iommu_put_reserved_iova(struct iommu_domain *domain, phys_addr_t addr);
 #else
 
 static inline int
@@ -55,5 +83,15 @@ iommu_alloc_reserved_iova_domain(struct iommu_domain *domain,
 static inline void
 iommu_free_reserved_iova_domain(struct iommu_domain *domain) {}
 
+static inline int iommu_get_reserved_iova(struct iommu_domain *domain,
+					  phys_addr_t addr, size_t size,
+					  int prot, dma_addr_t *iova)
+{
+	return -ENOENT;
+}
+
+static inline void iommu_put_reserved_iova(struct iommu_domain *domain,
+					   phys_addr_t addr) {}
+
 #endif	/* CONFIG_IOMMU_DMA_RESERVED */
 #endif	/* __DMA_RESERVED_IOMMU_H */
-- 
1.9.1
