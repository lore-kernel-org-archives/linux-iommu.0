From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 5/8] iommu/msi-iommu: iommu_msi_[get,put]_doorbell_iova
Date: Tue,  7 Jun 2016 15:59:19 +0000
Message-ID: <1465315162-5888-6-git-send-email-eric.auger@redhat.com>
References: <1465315162-5888-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465315162-5888-1-git-send-email-eric.auger@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: julien.grall@arm.com, Jean-Philippe.Brucker@arm.com, p.fedin@samsung.com, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

iommu_msi_get_doorbell_iova allows to iommu map an MSI doorbell contiguous
physical region onto a reserved contiguous IOVA region. The physical
region base address does not need to be iommu page size aligned. iova
pages are allocated and mapped so that they cover all the physical region.
This mapping is tracked as a whole (and cannot be split).

In case a mapping already exists for the physical pages, the IOVA mapped
to the PA base is directly returned.

Each time the get succeeds a binding ref count is incremented.

iommu_put_reserved_iova decrements the ref count and when this latter
is null, the mapping is destroyed and the IOVAs are released.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v9:
- use iommu_domain_msi_aperture_valid

v8:
- function renaming
- new design based on the assumption the iova domain cannot disappear
- free_iova outside of doorbell_mapping_release (iommu_domain * was
  removed from doorbell_mapping)

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
- use the iova domain shift instead of using the smallest supported page siz

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
 drivers/iommu/msi-iommu.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/msi-iommu.h |  39 ++++++++++++
 2 files changed, 189 insertions(+)

diff --git a/drivers/iommu/msi-iommu.c b/drivers/iommu/msi-iommu.c
index de02ede..57017cb 100644
--- a/drivers/iommu/msi-iommu.c
+++ b/drivers/iommu/msi-iommu.c
@@ -98,3 +98,153 @@ int iommu_msi_set_aperture(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_msi_set_aperture);
 
+/* called with info->lock held */
+static struct doorbell_mapping *
+search_msi_doorbell_mapping(struct doorbell_mapping_info *info,
+			    phys_addr_t addr, size_t size)
+{
+	struct doorbell_mapping *mapping;
+
+	list_for_each_entry(mapping, &info->list, next) {
+		if ((addr >= mapping->addr) &&
+		    (addr + size <= mapping->addr + mapping->size))
+			return mapping;
+	}
+	return NULL;
+}
+
+int iommu_msi_get_doorbell_iova(struct iommu_domain *domain,
+				phys_addr_t addr, size_t size, int prot,
+				dma_addr_t *iova)
+{
+	struct doorbell_mapping_info *dmi = domain->msi_cookie;
+	struct iova_domain *iovad = domain->iova_cookie;
+	struct doorbell_mapping *new_mapping, *mapping;
+	phys_addr_t aligned_base, offset;
+	size_t binding_size;
+	struct iova *p_iova;
+	dma_addr_t new_iova;
+	int ret = -EINVAL;
+	bool unmap = false;
+
+	if (!dmi)
+		return -ENODEV;
+
+	if (!iommu_domain_msi_aperture_valid(domain))
+		return -EINVAL;
+
+	offset = iova_offset(iovad, addr);
+	aligned_base = addr - offset;
+	binding_size = iova_align(iovad, size + offset);
+
+	spin_lock(&dmi->lock);
+
+	mapping = search_msi_doorbell_mapping(dmi, aligned_base, binding_size);
+	if (mapping) {
+		*iova = mapping->iova + offset + aligned_base - mapping->addr;
+		kref_get(&mapping->kref);
+		ret = 0;
+		goto unlock;
+	}
+
+	spin_unlock(&dmi->lock);
+
+	new_mapping = kzalloc(sizeof(*new_mapping), GFP_KERNEL);
+	if (!new_mapping)
+		return -ENOMEM;
+
+	p_iova = alloc_iova(iovad, binding_size >> iova_shift(iovad),
+			    iovad->dma_32bit_pfn, true);
+	if (!p_iova) {
+		kfree(new_mapping);
+		return -ENOMEM;
+	}
+
+	new_iova = iova_dma_addr(iovad, p_iova);
+	*iova = new_iova;
+
+	/* iommu_map is not supposed to be atomic */
+	ret = iommu_map(domain, *iova, aligned_base, binding_size, prot);
+
+	spin_lock(&dmi->lock);
+
+	if (ret)
+		goto free_iova;
+	/*
+	 * check again the doorbell mapping was not added while the lock
+	 * was released
+	 */
+	mapping = search_msi_doorbell_mapping(dmi, aligned_base, binding_size);
+	if (mapping) {
+		*iova = mapping->iova + offset + aligned_base - mapping->addr;
+		kref_get(&mapping->kref);
+		ret = 0;
+		unmap = true;
+		goto free_iova;
+	}
+
+	kref_init(&new_mapping->kref);
+	new_mapping->addr = aligned_base;
+	new_mapping->iova = *iova;
+	new_mapping->size = binding_size;
+
+	list_add(&new_mapping->next, &dmi->list);
+
+	*iova += offset;
+	goto unlock;
+free_iova:
+	free_iova(iovad, p_iova->pfn_lo);
+	kfree(new_mapping);
+unlock:
+	spin_unlock(&dmi->lock);
+	if (unmap)
+		iommu_unmap(domain, new_iova, binding_size);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_msi_get_doorbell_iova);
+
+static void doorbell_mapping_release(struct kref *kref)
+{
+	struct doorbell_mapping *mapping =
+		container_of(kref, struct doorbell_mapping, kref);
+
+	list_del(&mapping->next);
+	kfree(mapping);
+}
+
+void iommu_msi_put_doorbell_iova(struct iommu_domain *domain, phys_addr_t addr)
+{
+	struct doorbell_mapping_info *dmi = domain->msi_cookie;
+	struct iova_domain *iovad = domain->iova_cookie;
+	phys_addr_t aligned_addr, page_size, offset;
+	struct doorbell_mapping *mapping;
+	dma_addr_t iova;
+	size_t size;
+	int ret = 0;
+
+	if (!dmi)
+		return;
+
+	page_size = (uint64_t)1 << iova_shift(iovad);
+	offset = iova_offset(iovad, addr);
+	aligned_addr = addr - offset;
+
+	spin_lock(&dmi->lock);
+
+	mapping = search_msi_doorbell_mapping(dmi, aligned_addr, page_size);
+	if (!mapping)
+		goto unlock;
+
+	iova = mapping->iova;
+	size = mapping->size;
+
+	ret = kref_put(&mapping->kref, doorbell_mapping_release);
+
+unlock:
+	spin_unlock(&dmi->lock);
+	if (ret) {
+		iommu_unmap(domain, iova, size);
+		free_iova(iovad, iova_pfn(iovad, iova));
+	}
+}
+EXPORT_SYMBOL_GPL(iommu_msi_put_doorbell_iova);
diff --git a/include/linux/msi-iommu.h b/include/linux/msi-iommu.h
index 392aa6f..1cd115f 100644
--- a/include/linux/msi-iommu.h
+++ b/include/linux/msi-iommu.h
@@ -52,6 +52,35 @@ void iommu_put_msi_cookie(struct iommu_domain *domain);
 int iommu_msi_set_aperture(struct iommu_domain *domain,
 			   dma_addr_t start, dma_addr_t end);
 
+/**
+ * iommu_msi_get_doorbell_iova: allocate a contiguous set of iova pages and
+ * map them to the MSI doorbell's physical range defined by @addr and @size.
+ *
+ * @domain: iommu domain handle
+ * @addr: physical address to bind
+ * @size: size of the binding
+ * @prot: mapping protection attribute
+ * @iova: returned iova
+ *
+ * Mapped physical pfns are within [@addr >> order, (@addr + size -1) >> order]
+ * where order corresponds to the iova domain order.
+ * This mapping is tracked and reference counted with the minimal granularity
+ * of @size.
+ */
+int iommu_msi_get_doorbell_iova(struct iommu_domain *domain,
+				phys_addr_t addr, size_t size, int prot,
+				dma_addr_t *iova);
+
+/**
+ * iommu_msi_put_doorbell_iova: decrement a ref count of the doorbell's mapping
+ *
+ * @domain: iommu domain handle
+ * @addr: physical address whose binding ref count is decremented
+ *
+ * if the binding ref count is null, destroy the MSI doorbell's mapping
+ */
+void iommu_msi_put_doorbell_iova(struct iommu_domain *domain, phys_addr_t addr);
+
 #else
 
 static inline int
@@ -61,5 +90,15 @@ iommu_msi_set_aperture(struct iommu_domain *domain,
 	return -ENOENT;
 }
 
+static inline int iommu_msi_get_doorbell_iova(struct iommu_domain *domain,
+					      phys_addr_t addr, size_t size,
+					      int prot, dma_addr_t *iova)
+{
+	return -ENOENT;
+}
+
+static inline void iommu_msi_put_doorbell_iova(struct iommu_domain *domain,
+					       phys_addr_t addr) {}
+
 #endif	/* CONFIG_IOMMU_MSI */
 #endif	/* __MSI_IOMMU_H */
-- 
1.9.1
