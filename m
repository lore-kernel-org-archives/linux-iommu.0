From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v7 09/10] iommu/dma-reserved-iommu:
	iommu_msi_mapping_translate_msg
Date: Tue, 19 Apr 2016 16:56:33 +0000
Message-ID: <1461084994-2355-10-git-send-email-eric.auger@linaro.org>
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

Introduce iommu_msi_mapping_translate_msg whose role consists in
detecting whether the device's MSIs must to be mapped into an IOMMU.
It case it must, the function overrides the MSI msg originally composed
and replaces the doorbell's PA by a pre-allocated and pre-mapped reserved
IOVA. In case the corresponding PA region is not found, the function
returns an error.

This function is likely to be called in some code that cannot sleep. This
is the reason why the allocation/mapping is done separately.

Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

---

v7: creation
---
 drivers/iommu/dma-reserved-iommu.c | 69 ++++++++++++++++++++++++++++++++++++++
 include/linux/dma-reserved-iommu.h | 27 +++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/iommu/dma-reserved-iommu.c b/drivers/iommu/dma-reserved-iommu.c
index 907a17f..603ee45 100644
--- a/drivers/iommu/dma-reserved-iommu.c
+++ b/drivers/iommu/dma-reserved-iommu.c
@@ -18,6 +18,14 @@
 #include <linux/iommu.h>
 #include <linux/iova.h>
 #include <linux/msi.h>
+#include <linux/irq.h>
+
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+#define msg_to_phys_addr(msg) \
+	(((phys_addr_t)((msg)->address_hi) << 32) | (msg)->address_lo)
+#else
+#define msg_to_phys_addr(msg)	((msg)->address_lo)
+#endif
 
 struct reserved_iova_domain {
 	struct iova_domain *iovad;
@@ -351,3 +359,64 @@ struct iommu_domain *iommu_msi_mapping_desc_to_domain(struct msi_desc *desc)
 	return d;
 }
 EXPORT_SYMBOL_GPL(iommu_msi_mapping_desc_to_domain);
+
+static dma_addr_t iommu_find_reserved_iova(struct iommu_domain *domain,
+				    phys_addr_t addr, size_t size)
+{
+	unsigned long  base_pfn, end_pfn, nb_iommu_pages, order, flags;
+	size_t iommu_page_size, binding_size;
+	struct iommu_reserved_binding *b;
+	phys_addr_t aligned_base, offset;
+	dma_addr_t iova = DMA_ERROR_CODE;
+	struct iova_domain *iovad;
+
+	spin_lock_irqsave(&domain->reserved_lock, flags);
+
+	iovad = (struct iova_domain *)domain->reserved_iova_cookie;
+
+	if (!iovad)
+		goto unlock;
+
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
+	if (b && (b->addr <= aligned_base) &&
+		(aligned_base + binding_size <=  b->addr + b->size))
+		iova = b->iova + offset + aligned_base - b->addr;
+unlock:
+	spin_unlock_irqrestore(&domain->reserved_lock, flags);
+	return iova;
+}
+
+int iommu_msi_mapping_translate_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct iommu_domain *d;
+	struct msi_desc *desc;
+	dma_addr_t iova;
+
+	desc = irq_data_get_msi_desc(data);
+	if (!desc)
+		return -EINVAL;
+
+	d = iommu_msi_mapping_desc_to_domain(desc);
+	if (!d)
+		return 0;
+
+	iova = iommu_find_reserved_iova(d, msg_to_phys_addr(msg),
+					sizeof(phys_addr_t));
+
+	if (iova == DMA_ERROR_CODE)
+		return -EINVAL;
+
+	msg->address_lo = lower_32_bits(iova);
+	msg->address_hi = upper_32_bits(iova);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_msi_mapping_translate_msg);
diff --git a/include/linux/dma-reserved-iommu.h b/include/linux/dma-reserved-iommu.h
index 8373929..04e1912f 100644
--- a/include/linux/dma-reserved-iommu.h
+++ b/include/linux/dma-reserved-iommu.h
@@ -20,6 +20,8 @@
 
 struct iommu_domain;
 struct msi_desc;
+struct irq_data;
+struct msi_msg;
 
 #ifdef CONFIG_IOMMU_DMA_RESERVED
 
@@ -82,6 +84,25 @@ void iommu_put_reserved_iova(struct iommu_domain *domain, phys_addr_t addr);
  */
 struct iommu_domain *iommu_msi_mapping_desc_to_domain(struct msi_desc *desc);
 
+/**
+ * iommu_msi_mapping_translate_msg: in case the MSI transaction is translated
+ * by an IOMMU, the msg address must be an IOVA instead of a physical address.
+ * This function overwrites the original MSI message containing the doorbell
+ * physical address, result of the primary composition, with the doorbell IOVA.
+ *
+ * The doorbell physical address must be bound previously to an IOVA using
+ * iommu_get_reserved_iova
+ *
+ * @data: irq data handle
+ * @msg: original msi message containing the PA to be overwritten with
+ * the IOVA
+ *
+ * return 0 if the MSI does not need to be mapped or when the PA/IOVA
+ * were successfully swapped; return -EINVAL if the addresses need
+ * to be swapped but not IOMMU binding is found
+ */
+int iommu_msi_mapping_translate_msg(struct irq_data *data, struct msi_msg *msg);
+
 #else
 
 static inline int
@@ -111,5 +132,11 @@ iommu_msi_mapping_desc_to_domain(struct msi_desc *desc)
 	return NULL;
 }
 
+static inline int iommu_msi_mapping_translate_msg(struct irq_data *data,
+						  struct msi_msg *msg)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_IOMMU_DMA_RESERVED */
 #endif	/* __DMA_RESERVED_IOMMU_H */
-- 
1.9.1
