From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v13 04/15] genirq/msi: Introduce the MSI doorbell API
Date: Thu,  6 Oct 2016 08:45:20 +0000
Message-ID: <1475743531-4780-5-git-send-email-eric.auger@redhat.com>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1475743531-4780-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We introduce a new msi-doorbell API that allows msi controllers
to allocate and register their doorbells. This is useful when
those doorbells are likely to be iommu mapped (typically on ARM).
The VFIO layer will need to gather information about those doorbells:
whether they are safe (ie. they implement irq remapping) and how
many IOMMU pages are requested to map all of them.

This patch first introduces the dedicated msi_doorbell_info struct
and the registration/unregistration functions.

A doorbell region is characterized by its physical address base, size,
and whether it its safe (ie. it implements IRQ remapping). A doorbell
can be per-cpu of global. We currently only care about global doorbells.

A function returns whether all doorbells are safe.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v12 -> v13:
- directly select MSI_DOORBELL in ARM_SMMU and ARM_SMMU_V3 configs
- remove prot attribute
- move msi_doorbell_info struct definition in msi-doorbell.c
- change the commit title
- change proto of the registration function
- msi_doorbell_safe now in this patch

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

Conflicts:
	kernel/irq/Makefile

Conflicts:
	drivers/iommu/Kconfig
---
 drivers/iommu/Kconfig        |  2 +
 include/linux/msi-doorbell.h | 77 ++++++++++++++++++++++++++++++++++
 kernel/irq/Kconfig           |  4 ++
 kernel/irq/Makefile          |  1 +
 kernel/irq/msi-doorbell.c    | 98 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 182 insertions(+)
 create mode 100644 include/linux/msi-doorbell.h
 create mode 100644 kernel/irq/msi-doorbell.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 8ee54d7..0cc7fac 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -297,6 +297,7 @@ config SPAPR_TCE_IOMMU
 config ARM_SMMU
 	bool "ARM Ltd. System MMU (SMMU) Support"
 	depends on (ARM64 || ARM) && MMU
+	select MSI_DOORBELL
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU if ARM
@@ -310,6 +311,7 @@ config ARM_SMMU
 config ARM_SMMU_V3
 	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
+	select MSI_DOORBELL
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select GENERIC_MSI_IRQ_DOMAIN
diff --git a/include/linux/msi-doorbell.h b/include/linux/msi-doorbell.h
new file mode 100644
index 0000000..c18a382
--- /dev/null
+++ b/include/linux/msi-doorbell.h
@@ -0,0 +1,77 @@
+/*
+ * API to register/query MSI doorbells likely to be IOMMU mapped
+ *
+ * Copyright (C) 2016 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _LINUX_MSI_DOORBELL_H
+#define _LINUX_MSI_DOORBELL_H
+
+struct msi_doorbell_info;
+
+#ifdef CONFIG_MSI_DOORBELL
+
+/**
+ * msi_doorbell_register - allocate and register a global doorbell
+ * @base: physical base address of the global doorbell
+ * @size: size of the global doorbell
+ * @prot: protection/memory attributes
+ * @safe: true is irq_remapping implemented for this doorbell
+ * @dbinfo: returned doorbell info
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure
+ */
+int msi_doorbell_register_global(phys_addr_t base, size_t size,
+				 bool safe,
+				 struct msi_doorbell_info **dbinfo);
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
+/**
+ * msi_doorbell_safe - return whether all registered doorbells are safe
+ *
+ * Safe doorbells are those which implement irq remapping
+ * Return: true if all doorbells are safe, false otherwise
+ */
+bool msi_doorbell_safe(void);
+
+#else
+
+static inline int
+msi_doorbell_register_global(phys_addr_t base, size_t size,
+			     int prot, bool safe,
+			     struct msi_doorbell_info **dbinfo)
+{
+	*dbinfo = NULL;
+	return 0;
+}
+
+static inline void
+msi_doorbell_unregister_global(struct msi_doorbell_info *db) {}
+
+static inline bool msi_doorbell_safe(void)
+{
+	return true;
+}
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
index 1d3ee31..5b04dd1 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_PM_SLEEP) += pm.o
 obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
 obj-$(CONFIG_GENERIC_IRQ_IPI) += ipi.o
 obj-$(CONFIG_SMP) += affinity.o
+obj-$(CONFIG_MSI_DOORBELL) += msi-doorbell.o
diff --git a/kernel/irq/msi-doorbell.c b/kernel/irq/msi-doorbell.c
new file mode 100644
index 0000000..60a262a
--- /dev/null
+++ b/kernel/irq/msi-doorbell.c
@@ -0,0 +1,98 @@
+/*
+ * API to register/query MSI doorbells likely to be IOMMU mapped
+ *
+ * Copyright (C) 2016 Red Hat, Inc.
+ * Author: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/msi-doorbell.h>
+
+/**
+ * struct msi_doorbell_info - MSI doorbell region descriptor
+ * @percpu_doorbells: per cpu doorbell base address
+ * @global_doorbell: base address of the doorbell
+ * @doorbell_is_percpu: is the doorbell per cpu or global?
+ * @safe: true if irq remapping is implemented
+ * @size: size of the doorbell
+ */
+struct msi_doorbell_info {
+	union {
+		phys_addr_t __percpu    *percpu_doorbells;
+		phys_addr_t             global_doorbell;
+	};
+	bool    doorbell_is_percpu;
+	bool    safe;
+	size_t  size;
+};
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
+int msi_doorbell_register_global(phys_addr_t base, size_t size, bool safe,
+				 struct msi_doorbell_info **dbinfo)
+{
+	struct msi_doorbell *db;
+
+	db = kzalloc(sizeof(*db), GFP_KERNEL);
+	if (!db)
+		return -ENOMEM;
+
+	db->info.global_doorbell = base;
+	db->info.size = size;
+	db->info.safe = safe;
+
+	mutex_lock(&msi_doorbell_mutex);
+	list_add(&db->next, &msi_doorbell_list);
+	if (!db->info.safe)
+		nb_unsafe_doorbells++;
+	mutex_unlock(&msi_doorbell_mutex);
+	*dbinfo = &db->info;
+	return 0;
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
+	if (!db->info.safe)
+		nb_unsafe_doorbells--;
+	mutex_unlock(&msi_doorbell_mutex);
+	kfree(db);
+}
+EXPORT_SYMBOL_GPL(msi_doorbell_unregister_global);
+
+bool msi_doorbell_safe(void)
+{
+	return !nb_unsafe_doorbells;
+}
+EXPORT_SYMBOL_GPL(msi_doorbell_safe);
-- 
1.9.1
