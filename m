From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 3/9] genirq/msi-doorbell: creation
Date: Tue,  7 Jun 2016 16:01:22 +0000
Message-ID: <1465315288-5931-4-git-send-email-eric.auger@redhat.com>
References: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465315288-5931-1-git-send-email-eric.auger@redhat.com>
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

This new API aims at managing MSI doorbells likely to be iommu
mapped. The API is bound to be used at least by irqchip drivers,
the MSI layer and the VFIO sub-system.

Irqchips likely to be downstream to IOMMUs (that do not bypass MSI
transactions) need to register their MSI doorbells so that the MSI
layer can look them up and iommu map then when needed.

We currently introduce the irq_chip_msi_doorbell_info struct that
contains all the info characterizing a doorbell plus 3 functions that
allows to (un)register, and lookup MSI doorbells stored in a global
list.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/Kconfig        |  1 +
 include/linux/msi-doorbell.h | 79 ++++++++++++++++++++++++++++++++++++++++++
 kernel/irq/Kconfig           |  4 +++
 kernel/irq/Makefile          |  1 +
 kernel/irq/msi-doorbell.c    | 82 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 167 insertions(+)
 create mode 100644 include/linux/msi-doorbell.h
 create mode 100644 kernel/irq/msi-doorbell.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 5ea1610..ba54146 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -78,6 +78,7 @@ config IOMMU_DMA
 config IOMMU_MSI
 	bool
 	select IOMMU_DMA
+	select MSI_DOORBELL
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/include/linux/msi-doorbell.h b/include/linux/msi-doorbell.h
new file mode 100644
index 0000000..bbc7321
--- /dev/null
+++ b/include/linux/msi-doorbell.h
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2016 Eric Auger
+ *
+ * Eric Auger <eric.auger@linaro.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _LINUX_MSI_DOORBELL_H
+#define _LINUX_MSI_DOORBELL_H
+
+#include <linux/irq.h>
+
+/* Describe all the MSI doorbell regions for an irqchip */
+struct irq_chip_msi_doorbell_info {
+	union {
+		phys_addr_t __percpu *percpu_doorbells;
+		phys_addr_t global_doorbell;
+	};
+	bool doorbell_is_percpu;
+	bool irq_remapping;	/* is irq_remapping implemented? */
+	size_t size;		/* size of a each doorbell */
+	int prot;		/* iommu protection flag */
+};
+
+#ifdef CONFIG_MSI_DOORBELL
+
+/**
+ * msi_doorbell_register_global: allocate and register a global doorbell
+ *
+ * @chip_data: chip_data pointer
+ * @addr: physical address of the global doorbell
+ * @size: size of the global doorbell
+ * @prot: protection/memory attributes
+ * @irq_remapping: is irq_remapping implemented for this doorbell
+ */
+int msi_doorbell_register_global(void *chip_data, phys_addr_t addr,
+				 size_t size, int prot, bool irq_remapping);
+
+/**
+ * msi_doorbell_unregister: remove a doorbell from the list of registered
+ * doorbells
+ * @chip_data: chip_data pointer
+ */
+void msi_doorbell_unregister(void *chip_data);
+
+/**
+ * msi_doorbell_lookup: return the doorbell info associated to @chip_data
+ * doorbell info
+ *
+ * @chip_data: chip_data pointer
+ * return NULL if no registered doorbell for that chip_data, or the actual
+ * doorbell info pointer upon success
+ */
+struct irq_chip_msi_doorbell_info *
+msi_doorbell_lookup(void *chip_data);
+
+#else
+
+static inline int
+msi_doorbell_register_global(void *chip_data, phys_addr_t addr,
+			     size_t size, int prot, bool irq_remapping)
+{
+	return -ENOENT;
+}
+
+static inline void msi_doorbell_unregister(void *chip_data);
+
+static inline struct irq_chip_msi_doorbell_info *
+msi_doorbell_lookup(void *chip_data)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_MSI_DOORBELL */
+
+#endif
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 3bbfd6a..d4faaaa 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -72,6 +72,10 @@ config GENERIC_IRQ_IPI
 config GENERIC_MSI_IRQ
 	bool
 
+# MSI doorbell support (for doorbell IOMMU mapping)
+config MSI_DOORBELL
+	bool
+
 # Generic MSI hierarchical interrupt domain support
 config GENERIC_MSI_IRQ_DOMAIN
 	bool
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index 2ee42e9..be02dfd 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
 obj-$(CONFIG_PM_SLEEP) += pm.o
 obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
 obj-$(CONFIG_GENERIC_IRQ_IPI) += ipi.o
+obj-$(CONFIG_MSI_DOORBELL) += msi-doorbell.o
diff --git a/kernel/irq/msi-doorbell.c b/kernel/irq/msi-doorbell.c
new file mode 100644
index 0000000..84ecca1
--- /dev/null
+++ b/kernel/irq/msi-doorbell.c
@@ -0,0 +1,82 @@
+/*
+ * linux/kernel/irq/msi-doorbell.c
+ *
+ * Copyright (C) 2016 Linaro
+ * Author: Eric Auger <eric.auger@linaro.org>
+ *
+ * This file is licensed under GPLv2.
+ *
+ * This file contains common code to manage MSI doorbells likely
+ * to be iommu mapped. Typically meaningful on ARM.
+ */
+
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/msi-doorbell.h>
+
+struct irqchip_doorbell {
+	struct irq_chip_msi_doorbell_info info;
+	void *chip_data;
+	struct list_head next;
+};
+
+static LIST_HEAD(irqchip_doorbell_list);
+static DEFINE_MUTEX(irqchip_doorbell_mutex);
+
+int msi_doorbell_register_global(void *chip_data, phys_addr_t addr,
+				 size_t size, int prot, bool irq_remapping)
+{
+	struct irqchip_doorbell *db;
+
+	db = kmalloc(sizeof(*db), GFP_KERNEL);
+	if (!db)
+		return -ENOMEM;
+
+	db->chip_data = chip_data;
+	db->info.doorbell_is_percpu = false;
+	db->info.global_doorbell = addr;
+	db->info.size = size;
+	db->info.prot = prot;
+	db->info.irq_remapping = irq_remapping;
+
+	mutex_lock(&irqchip_doorbell_mutex);
+	list_add(&db->next, &irqchip_doorbell_list);
+	mutex_unlock(&irqchip_doorbell_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(msi_doorbell_register_global);
+
+void msi_doorbell_unregister(void *chip_data)
+{
+	struct irqchip_doorbell *db, *tmp;
+
+	mutex_lock(&irqchip_doorbell_mutex);
+	list_for_each_entry_safe(db, tmp, &irqchip_doorbell_list, next) {
+		if (db->chip_data == chip_data) {
+			list_del(&db->next);
+			kfree(db);
+			break;
+		}
+	}
+	mutex_unlock(&irqchip_doorbell_mutex);
+}
+EXPORT_SYMBOL_GPL(msi_doorbell_unregister);
+
+struct irq_chip_msi_doorbell_info *
+msi_doorbell_lookup(void *chip_data)
+{
+	struct irqchip_doorbell *db;
+	struct irq_chip_msi_doorbell_info *dbinfo = NULL;
+
+	mutex_lock(&irqchip_doorbell_mutex);
+	list_for_each_entry(db, &irqchip_doorbell_list, next) {
+		if (db->chip_data == chip_data) {
+			dbinfo = &db->info;
+			break;
+		}
+	}
+	mutex_unlock(&irqchip_doorbell_mutex);
+	return dbinfo;
+}
+EXPORT_SYMBOL_GPL(msi_doorbell_lookup);
+
-- 
1.9.1
