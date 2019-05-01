From: Julien Grall <julien.grall@arm.com>
Subject: [PATCH v3 1/7] genirq/msi: Add a new field in msi_desc to store an IOMMU cookie
Date: Wed,  1 May 2019 14:58:18 +0100
Message-ID: <20190501135824.25586-2-julien.grall@arm.com>
References: <20190501135824.25586-1-julien.grall@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501135824.25586-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: logang@deltatee.com, douliyangs@gmail.com, miquel.raynal@bootlin.com, marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org, robin.murphy@arm.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>, Eric Auger <eric.auger@redhat.com>
List-Id: iommu@lists.linux-foundation.org

When an MSI doorbell is located downstream of an IOMMU, it is required
to swizzle the physical address with an appropriately-mapped IOVA for any
device attached to one of our DMA ops domain.

At the moment, the allocation of the mapping may be done when composing
the message. However, the composing may be done in non-preemtible
context while the allocation requires to be called from preemptible
context.

A follow-up change will split the current logic in two functions
requiring to keep an IOMMU cookie per MSI.

A new field is introduced in msi_desc to store an IOMMU cookie. As the
cookie may not be required in some configuration, the field is protected
under a new config CONFIG_IRQ_MSI_IOMMU.

A pair of helpers has also been introduced to access the field.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

---
    Changes in v3:
        - Add Robin's and Eric's reviewed-by

    Changes in v2:
        - Update the commit message to use imperative mood
        - Protect the field with a new config that will be selected by
        IOMMU_DMA later on
        - Add a set of helpers to access the new field
---
 include/linux/msi.h | 26 ++++++++++++++++++++++++++
 kernel/irq/Kconfig  |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7e9b81c3b50d..82a308c19222 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -77,6 +77,9 @@ struct msi_desc {
 	struct device			*dev;
 	struct msi_msg			msg;
 	struct irq_affinity_desc	*affinity;
+#ifdef CONFIG_IRQ_MSI_IOMMU
+	const void			*iommu_cookie;
+#endif
 
 	union {
 		/* PCI MSI/X specific data */
@@ -119,6 +122,29 @@ struct msi_desc {
 #define for_each_msi_entry_safe(desc, tmp, dev)	\
 	list_for_each_entry_safe((desc), (tmp), dev_to_msi_list((dev)), list)
 
+#ifdef CONFIG_IRQ_MSI_IOMMU
+static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
+{
+	return desc->iommu_cookie;
+}
+
+static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
+					     const void *iommu_cookie)
+{
+	desc->iommu_cookie = iommu_cookie;
+}
+#else
+static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
+{
+	return NULL;
+}
+
+static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
+					     const void *iommu_cookie)
+{
+}
+#endif
+
 #ifdef CONFIG_PCI_MSI
 #define first_pci_msi_entry(pdev)	first_msi_entry(&(pdev)->dev)
 #define for_each_pci_msi_entry(desc, pdev)	\
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 5f3e2baefca9..8fee06625c37 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -91,6 +91,9 @@ config GENERIC_MSI_IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
 
+config IRQ_MSI_IOMMU
+	bool
+
 config HANDLE_DOMAIN_IRQ
 	bool
 
-- 
2.11.0
