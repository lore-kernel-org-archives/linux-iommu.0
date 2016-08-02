From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v12 7/8] iommu/msi-iommu: iommu_msi_msg_pa_to_va
Date: Tue,  2 Aug 2016 17:15:36 +0000
Message-ID: <1470158137-6931-8-git-send-email-eric.auger@redhat.com>
References: <1470158137-6931-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470158137-6931-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dennis.chen-5wv7dgnIgG8@public.gmane.org, robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Introduce iommu_msi_msg_pa_to_va whose role consists in
detecting whether the device's MSIs must to be mapped into an IOMMU.
It case it must, the function overrides the MSI msg originally composed
and replaces the doorbell's PA by a pre-allocated and pre-mapped reserved
IOVA. In case the corresponding PA region is not found, the function
returns an error.

This function is likely to be called in some code that cannot sleep. This
is the reason why the allocation/mapping is done separately.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v7 -> v8:
- renamed from iommu_msi_mapping_translate_msg to iommu_msi_msg_pa_to_va
  and now takes a struct device * as parameter

v7: creation
---
 drivers/iommu/msi-iommu.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/msi-iommu.h | 25 +++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/iommu/msi-iommu.c b/drivers/iommu/msi-iommu.c
index 58912ae..4ca6f584 100644
--- a/drivers/iommu/msi-iommu.c
+++ b/drivers/iommu/msi-iommu.c
@@ -20,6 +20,14 @@
 #include <linux/msi-iommu.h>
 #include <linux/spinlock.h>
 #include <linux/iova.h>
+#include <linux/msi.h>
+
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+#define msg_to_phys_addr(msg) \
+	(((phys_addr_t)((msg)->address_hi) << 32) | (msg)->address_lo)
+#else
+#define msg_to_phys_addr(msg)	((msg)->address_lo)
+#endif
 
 struct doorbell_mapping {
 	struct kref		kref;
@@ -269,3 +277,50 @@ struct iommu_domain *iommu_msi_domain(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_msi_domain);
 
+static dma_addr_t iommu_msi_find_iova(struct iommu_domain *domain,
+				      phys_addr_t addr, size_t size)
+{
+	struct doorbell_mapping_info *dmi = domain->msi_cookie;
+	struct iova_domain *iovad = domain->iova_cookie;
+	struct doorbell_mapping *mapping;
+	dma_addr_t iova = DMA_ERROR_CODE;
+	phys_addr_t aligned_base, offset;
+	size_t binding_size;
+
+	if (!iovad || !dmi)
+		return iova;
+
+	offset = iova_offset(iovad, addr);
+	aligned_base = addr - offset;
+	binding_size = iova_align(iovad, size + offset);
+
+	spin_lock(&dmi->lock);
+
+	mapping = search_msi_doorbell_mapping(dmi, addr, size);
+	if (mapping)
+		iova = mapping->iova + offset + aligned_base - mapping->addr;
+
+	spin_unlock(&dmi->lock);
+	return iova;
+}
+
+int iommu_msi_msg_pa_to_va(struct device *dev, struct msi_msg *msg)
+{
+	struct iommu_domain *d = iommu_msi_domain(dev);
+	dma_addr_t iova;
+
+	if (!d)
+		return 0;
+
+	iova = iommu_msi_find_iova(d, msg_to_phys_addr(msg),
+				   sizeof(phys_addr_t));
+
+	if (iova == DMA_ERROR_CODE)
+		return -EINVAL;
+
+	msg->address_lo = lower_32_bits(iova);
+	msg->address_hi = upper_32_bits(iova);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_msi_msg_pa_to_va);
+
diff --git a/include/linux/msi-iommu.h b/include/linux/msi-iommu.h
index 44a696d..b80487e 100644
--- a/include/linux/msi-iommu.h
+++ b/include/linux/msi-iommu.h
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 
 struct iommu_domain;
+struct msi_msg;
 
 #ifdef CONFIG_IOMMU_MSI
 
@@ -90,6 +91,24 @@ void iommu_msi_put_doorbell_iova(struct iommu_domain *domain, phys_addr_t addr);
  */
 struct iommu_domain *iommu_msi_domain(struct device *dev);
 
+/**
+ * iommu_msi_msg_pa_to_va - in case a device's MSI transaction is translated
+ * by an IOMMU, the msg address must be an IOVA instead of a physical address.
+ * This function overwrites the original MSI message containing the doorbell's
+ * physical address with the doorbell's pre-allocated IOVA, if any.
+ * @dev: device emitting the MSI
+ * @msg: original MSI message containing the PA to be overwritten with the IOVA
+ *
+ * The doorbell physical address must be bound previously to an IOVA using
+ * iommu_msi_get_doorbell_iova
+ *
+ * Return: 0 if the MSI does not need to be mapped or when the PA/IOVA
+ * were successfully swapped; return -EINVAL if the addresses need
+ * to be swapped but not IOMMU binding is found
+ */
+int iommu_msi_msg_pa_to_va(struct device *dev, struct msi_msg *msg);
+
+
 #else
 
 static inline int
@@ -114,5 +133,11 @@ static inline struct iommu_domain *iommu_msi_domain(struct device *dev)
 	return NULL;
 }
 
+static inline int iommu_msi_msg_pa_to_va(struct device *dev,
+					 struct msi_msg *msg)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_IOMMU_MSI */
 #endif	/* __MSI_IOMMU_H */
-- 
1.9.1
