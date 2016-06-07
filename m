From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 8/9] genirq/msi: map/unmap the MSI doorbells on msi_domain_alloc/free_irqs
Date: Tue,  7 Jun 2016 16:01:27 +0000
Message-ID: <1465315288-5931-9-git-send-email-eric.auger@redhat.com>
References: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

This patch handles the iommu mapping of MSI doorbells that require to
be mapped in an iommu domain. This happens on msi_domain_alloc/free_irqs
since this is called in code that can sleep (pci_enable/disable_msi):
iommu_map/unmap is not stated as atomic. On msi_domain_(de)activate and
msi_domain_set_affinity, which must be atomic, we just lookup for this
pre-allocated/mapped IOVA.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
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
 kernel/irq/msi.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 72bf4d6..a78db5f 100644
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
@@ -322,6 +325,71 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
 }
 
 /**
+ * msi_handle_doorbell_mappings: in case the irq data corresponds to an
+ * MSI that requires iommu mapping, traverse the irq domain hierarchy
+ * to retrieve the doorbells to handle and iommu_map/unmap them according
+ * to @map boolean.
+ *
+ * @data: irq data handle
+ * @map: mapping if true, unmapping if false
+ */
+static int msi_handle_doorbell_mappings(struct irq_data *data, bool map)
+{
+	const struct irq_chip_msi_doorbell_info *dbinfo;
+	struct iommu_domain *domain;
+	struct device *dev;
+	dma_addr_t iova;
+	void *chip_data;
+	int ret = 0, cpu;
+
+	while (data) {
+		dev = msi_desc_to_dev(irq_data_get_msi_desc(data));
+		domain = iommu_msi_domain(dev);
+		if (domain) {
+			chip_data = irq_data_get_irq_chip_data(data);
+			dbinfo = msi_doorbell_lookup(chip_data);
+			if (dbinfo)
+				break;
+		}
+		data = data->parent_data;
+	}
+
+	if (!data)
+		return 0;
+
+	if (!dbinfo->doorbell_is_percpu) {
+		if (!map) {
+			iommu_msi_put_doorbell_iova(domain,
+						    dbinfo->global_doorbell);
+			return 0;
+		}
+		return iommu_msi_get_doorbell_iova(domain,
+						   dbinfo->global_doorbell,
+						   dbinfo->size, dbinfo->prot,
+						   &iova);
+	}
+
+	/* percpu doorbells */
+	for_each_possible_cpu(cpu) {
+		phys_addr_t __percpu *db_addr =
+			per_cpu_ptr(dbinfo->percpu_doorbells, cpu);
+
+		if (!map) {
+			iommu_msi_put_doorbell_iova(domain, *db_addr);
+		} else {
+
+			ret = iommu_msi_get_doorbell_iova(domain, *db_addr,
+							  dbinfo->size,
+							  dbinfo->prot, &iova);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
  * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
  * @domain:	The domain to allocate from
  * @dev:	Pointer to device struct of the device for which the interrupts
@@ -352,17 +420,29 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 
 		virq = __irq_domain_alloc_irqs(domain, virq, desc->nvec_used,
 					       dev_to_node(dev), &arg, false);
-		if (virq < 0) {
-			ret = -ENOSPC;
-			if (ops->handle_error)
-				ret = ops->handle_error(domain, desc, ret);
-			if (ops->msi_finish)
-				ops->msi_finish(&arg, ret);
-			return ret;
-		}
+		if (virq < 0)
+			goto error;
 
 		for (i = 0; i < desc->nvec_used; i++)
 			irq_set_msi_desc_off(virq, i, desc);
+
+		for (i = 0; i < desc->nvec_used; i++) {
+			struct irq_data *d = irq_get_irq_data(virq + i);
+
+			ret = msi_handle_doorbell_mappings(d, true);
+			if (ret)
+				break;
+		}
+		if (ret) {
+			for (; i >= 0; i--) {
+				struct irq_data *d = irq_get_irq_data(virq + i);
+
+				msi_handle_doorbell_mappings(d, false);
+			}
+			irq_domain_free_irqs(virq, desc->nvec_used);
+			desc->irq = 0;
+			goto error;
+		}
 	}
 
 	if (ops->msi_finish)
@@ -377,6 +457,13 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	}
 
 	return 0;
+error:
+	ret = -ENOSPC;
+	if (ops->handle_error)
+		ret = ops->handle_error(domain, desc, ret);
+	if (ops->msi_finish)
+		ops->msi_finish(&arg, ret);
+	return ret;
 }
 
 /**
@@ -396,6 +483,9 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 		 * entry. If that's the case, don't do anything.
 		 */
 		if (desc->irq) {
+			msi_handle_doorbell_mappings(
+				irq_get_irq_data(desc->irq),
+				false);
 			irq_domain_free_irqs(desc->irq, desc->nvec_used);
 			desc->irq = 0;
 		}
-- 
1.9.1
