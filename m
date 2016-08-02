From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v12 04/11] genirq/msi: Allow MSI doorbell (un)registration
Date: Tue,  2 Aug 2016 17:23:30 +0000
Message-ID: <1470158617-7022-5-git-send-email-eric.auger@redhat.com>
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

This new API aims at allowing irqchips to allocate & register
the MSI doorbells likely to be iommu mapped.

Later on, other services will be added allowing the VFIO layer
to query information based on all registered doorbells.

We count the number of doorbells that do not implement IRQ
remapping. They will be considered as unsafe with respect to MSI
assignment.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v11 -> v12:
- rename irqchip_doorbell into msi_doorbell, irqchip_doorbell_list
  into msi_doorbell_list and irqchip_doorbell_mutex into
  msi_doorbell_mutex
- fix style issues: align msi_doorbell struct members, kernel-doc comments
- use kzalloc
- use container_of in msi_doorbell_unregister_global
- compute nb_unsafe_doorbells on registration/unregistration
- registration simply returns NULL if allocation failed

v10 -> v11:
- remove void *chip_data argument from register/unregister function
- remove lookup funtions since we restored the struct irq_chip
  msi_doorbell_info ops to realize this function
- reword commit message and title
---
 drivers/iommu/Kconfig        |  1 +
 include/linux/msi-doorbell.h | 55 +++++++++++++++++++++++++++++++++++
 kernel/irq/Kconfig           |  4 +++
 kernel/irq/Makefile          |  1 +
 kernel/irq/msi-doorbell.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+)
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
index 0000000..a2a033b
--- /dev/null
+++ b/include/linux/msi-doorbell.h
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2016 Eric Auger
+ *
+ * Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
+#ifdef CONFIG_MSI_DOORBELL
+
+/**
+ * msi_doorbell_register_global - allocate and register a global doorbell
+ * @base: physical base address of the global doorbell
+ * @size: size of the global doorbell
+ * @prot: protection/memory attributes
+ * @irq_remapping: is irq_remapping implemented for this doorbell
+ *
+ * Return: the newly allocated doorbell info handle or NULL if allocation
+ * failed
+ */
+struct msi_doorbell_info *
+msi_doorbell_register_global(phys_addr_t base, size_t size,
+			     int prot, bool irq_remapping);
+
+/**
+ * msi_doorbell_unregister_global - unregister a global doorbell
+ * @db: doorbell info to unregister
+ *
+ * remove the doorbell descriptor from the list of registered doorbells
+ * and deallocates it
+ */
+void msi_doorbell_unregister_global(struct msi_doorbell_info *db);
+
+#else
+
+static inline struct msi_doorbell_info *
+msi_doorbell_register_global(phys_addr_t base, size_t size,
+			     int prot, bool irq_remapping)
+{
+	return NULL;
+}
+
+static inline void
+msi_doorbell_unregister_global(struct msi_doorbell_info *db) {}
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
index 0000000..e3e0d95
--- /dev/null
+++ b/kernel/irq/msi-doorbell.c
@@ -0,0 +1,68 @@
+/*
+ * linux/kernel/irq/msi-doorbell.c
+ *
+ * Copyright (C) 2016 Linaro
+ * Author: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
+struct msi_doorbell {
+	struct msi_doorbell_info	info;
+	struct list_head		next;
+};
+
+/* list of registered MSI doorbells */
+static LIST_HEAD(msi_doorbell_list);
+
+/* counts the number of unsafe registered doorbells */
+static uint nb_unsafe_doorbells;
+
+/* protects the list and nb__unsafe_doorbells */
+static DEFINE_MUTEX(msi_doorbell_mutex);
+
+struct msi_doorbell_info *
+msi_doorbell_register_global(phys_addr_t base, size_t size,
+			     int prot, bool irq_remapping)
+{
+	struct msi_doorbell *db;
+
+	db = kzalloc(sizeof(*db), GFP_KERNEL);
+	if (!db)
+		return NULL;
+
+	db->info.global_doorbell = base;
+	db->info.size = size;
+	db->info.prot = prot;
+	db->info.irq_remapping = irq_remapping;
+
+	mutex_lock(&msi_doorbell_mutex);
+	list_add(&db->next, &msi_doorbell_list);
+	if (!db->info.irq_remapping)
+		nb_unsafe_doorbells++;
+	mutex_unlock(&msi_doorbell_mutex);
+	return &db->info;
+}
+EXPORT_SYMBOL_GPL(msi_doorbell_register_global);
+
+void msi_doorbell_unregister_global(struct msi_doorbell_info *dbinfo)
+{
+	struct msi_doorbell *db;
+
+	db = container_of(dbinfo, struct msi_doorbell, info);
+
+	mutex_lock(&msi_doorbell_mutex);
+	list_del(&db->next);
+	if (!db->info.irq_remapping)
+		nb_unsafe_doorbells--;
+	mutex_unlock(&msi_doorbell_mutex);
+	kfree(db);
+}
+EXPORT_SYMBOL_GPL(msi_doorbell_unregister_global);
-- 
1.9.1
