From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v12 10/11] genirq/msi: Map/unmap the MSI doorbells on
	msi_domain_alloc/free_irqs
Date: Tue,  2 Aug 2016 17:23:36 +0000
Message-ID: <1470158617-7022-11-git-send-email-eric.auger@redhat.com>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470158617-7022-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

This patch handles the iommu mapping of MSI doorbells that require to
be mapped in an iommu domain. This happens on msi_domain_alloc/free_irqs
since this is called in code that can sleep (pci_enable/disable_msi):
iommu_map/unmap is not stated as atomic. On msi_domain_(de)activate and
msi_domain_set_affinity, which must be atomic, we just lookup for this
pre-allocated/mapped IOVA.

If we detect the device sending MSIs is in front of an IOMMU that do not
bypass MSIs but we can't find any doorbell to map we fail. This means we
currently do not support MSI controllers inbetween the device and the
IOMMU. In the future, those controllers, typically integrated into the
PCI host controller may also register a doorbell declared as not mappable.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v11 -> v12:
- introduce intermediate helpers:
  msi_get_doorbell_info, msi_map_global_doorbell, msi_map_percpu_doorbell
- add kernel-doc comments
- remove desc->irq reset and cleanup in case of failure and set
  MSI_DESC_FLAG_FUNCTION instead
- add comments

v10 -> v11:
- restore v9 version based on irq_chip msi_doorbell_info

v9 -> v10:
- use irqchip API to lookup for the chip_data's doorbell

v8 -> v9:
- decouple irq_data parsing from the actual mapping/unmapping

v7 -> v8:
- new percpu pointer type
- exit from the irq domain hierarchy parsing on first map/unmap success
- reset desc->irq to 0 on mapping failure

v7: creation
---
 kernel/irq/msi.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 148 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 9b93766..6a3cb14 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -14,6 +14,9 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
+#include <linux/msi-iommu.h>
+#include <linux/iommu.h>
+#include <linux/msi-doorbell.h>
 
 /* Temparory solution for building, will be removed later */
 #include <linux/pci.h>
@@ -322,6 +325,131 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 }
 
 /**
+ * msi_get_doorbell_info - return the MSI doorbell descriptor corresponding
+ * to an irq data
+ * @data: irq data handle
+ *
+ * Return: the doorbell descriptor pointer if any, NULL if none, an ERR_PTR
+ * otherwise
+ */
+static struct msi_doorbell_info *msi_get_doorbell_info(struct irq_data *data)
+{
+	struct irq_chip *chip;
+
+	while (data) {
+		chip = irq_data_get_irq_chip(data);
+		if (chip->irq_get_msi_doorbell_info)
+			break;
+		data = data->parent_data;
+	}
+
+	if (!data)
+		return NULL;
+
+	return chip->irq_get_msi_doorbell_info(data);
+}
+
+/**
+ * msi_map_global_doorbell - iommu map/unmap the global doorbell physical
+ * address
+ * @domain: iommu domain the mapping is associated to
+ * @dbi: doorbell descriptor
+ * @map: true if map operation, false if unmap operation
+ *
+ * Return: 0 on success or an error code
+ */
+static int msi_map_global_doorbell(struct iommu_domain *domain,
+			       const struct msi_doorbell_info *dbi, bool map)
+{
+	dma_addr_t iova;
+	int ret = 0;
+
+	if (map)
+		ret = iommu_msi_get_doorbell_iova(domain, dbi->global_doorbell,
+						  dbi->size, dbi->prot, &iova);
+	else
+		iommu_msi_put_doorbell_iova(domain, dbi->global_doorbell);
+	return ret;
+}
+
+/**
+ * msi_map_percpu_doorbell - iommu map/unmap the percpu doorbell physical
+ * addresses
+ * @domain: iommu domain the mapping is associated to
+ * @dbi: doorbell descriptor
+ * @map: true if map operation, false if unmap operation
+ *
+ * Return: 0 on success or an error code
+ */
+static int msi_map_percpu_doorbell(struct iommu_domain *domain,
+			       const struct msi_doorbell_info *dbi, bool map)
+{
+	int cpu, ret;
+
+	for_each_possible_cpu(cpu) {
+		phys_addr_t __percpu *db_addr;
+		dma_addr_t iova;
+
+		db_addr = per_cpu_ptr(dbi->percpu_doorbells, cpu);
+
+		if (map) {
+			ret = iommu_msi_get_doorbell_iova(domain, *db_addr,
+							  dbi->size, dbi->prot,
+							  &iova);
+			if (ret)
+				return ret;
+		} else {
+			iommu_msi_put_doorbell_iova(domain, *db_addr);
+		}
+	}
+	return 0;
+}
+
+/**
+ * msi_handle_doorbell_mappings - IOMMU map/unmap any MSI doorbell associated
+ * to the irq data handle
+ * @data: irq data handle
+ * @map: true if map operation, false if unmap operation
+ *
+ * In case the irq data corresponds to an MSI sent by a device in front of
+ * an IOMMU and this latter does not bypass MSI transactions,
+ * traverse the irq domain hierarchy to retrieve the MSI doorbells and
+ * iommu_map/unmap them according to @map boolean.
+ *
+ * Return 0 on success or if no action is required, or an error code
+ */
+static int msi_handle_doorbell_mappings(struct irq_data *data, bool map)
+{
+	const struct msi_doorbell_info *dbi;
+	struct iommu_domain *domain;
+	struct device *dev;
+
+	/* Is the MSI address translated by an IOMMU? */
+	dev = msi_desc_to_dev(irq_data_get_msi_desc(data));
+	domain = iommu_msi_domain(dev);
+	if (!domain)
+		return 0;
+
+	/**
+	 * Do we find a doorbell to IOMMU map?
+	 * If we don't either the doorbell registration failed, or
+	 * the actual MSI controller did not register its doorbell:
+	 * either the MSI controller is behind the IOMMU and the MSI
+	 * controller should have registered its doorbell; or the MSI
+	 * controller is inbetween the device and the IOMMU. We currently
+	 * do not support this case.
+	 */
+	dbi = msi_get_doorbell_info(data);
+	if (!dbi)
+		return -ENODEV;
+
+	if (dbi->doorbell_is_percpu)
+		return msi_map_percpu_doorbell(domain, dbi, map);
+	else
+		return msi_map_global_doorbell(domain, dbi, map);
+}
+
+/**
  * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
  * @domain:	The domain to allocate from
  * @dev:	Pointer to device struct of the device for which the interrupts
@@ -354,18 +482,23 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 					       dev_to_node(dev), &arg, false);
 		if (virq < 0) {
 			ret = -ENOSPC;
-			if (ops->handle_error)
-				ret = ops->handle_error(domain, desc, ret);
-			if (ops->msi_finish)
-				ops->msi_finish(&arg, ret);
-			return ret;
+			goto error;
 		}
 
 		desc->flags |= MSI_DESC_FLAG_ALLOCATED;
-		desc->flags |= MSI_DESC_FLAG_FUNCTIONAL;
 
 		for (i = 0; i < desc->nvec_used; i++)
 			irq_set_msi_desc_off(virq, i, desc);
+
+		for (i = 0; i < desc->nvec_used; i++) {
+			struct irq_data *d = irq_get_irq_data(virq + i);
+
+			ret = msi_handle_doorbell_mappings(d, true);
+			if (ret)
+				goto error;
+		}
+
+		desc->flags |= MSI_DESC_FLAG_FUNCTIONAL;
 	}
 
 	if (ops->msi_finish)
@@ -380,6 +513,12 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	}
 
 	return 0;
+error:
+	if (ops->handle_error)
+		ret = ops->handle_error(domain, desc, ret);
+	if (ops->msi_finish)
+		ops->msi_finish(&arg, ret);
+	return ret;
 }
 
 /**
@@ -399,6 +538,9 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 		 * entry. If that's the case, don't do anything.
 		 */
 		if (desc->flags & MSI_DESC_FLAG_ALLOCATED) {
+			struct irq_data *d = irq_get_irq_data(desc->irq);
+
+			msi_handle_doorbell_mappings(d, false);
 			irq_domain_free_irqs(desc->irq, desc->nvec_used);
 			desc->irq = 0;
 			desc->flags &= ~MSI_DESC_FLAG_ALLOCATED;
-- 
1.9.1
