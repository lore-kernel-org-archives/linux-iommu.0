From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 09/10] iommu/vt-d: Copy functions for irte
Date: Mon, 22 Dec 2014 17:15:28 +0800
Message-ID: <1419239729-26529-10-git-send-email-zhen-hual@hp.com>
References: <1419239729-26529-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1419239729-26529-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Functions to copy the irte data from the old kernel into the kdump kernel.

Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 57 +++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h         |  4 +++
 2 files changed, 61 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index a55b207..13f2034 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -8,6 +8,7 @@
 #include <linux/irq.h>
 #include <linux/intel-iommu.h>
 #include <linux/acpi.h>
+#include <linux/crash_dump.h>
 #include <asm/io_apic.h>
 #include <asm/smp.h>
 #include <asm/cpu.h>
@@ -17,6 +18,11 @@
 
 #include "irq_remapping.h"
 
+#ifdef CONFIG_CRASH_DUMP
+static int __iommu_load_old_irte(struct intel_iommu *iommu);
+static int __iommu_update_old_irte(struct intel_iommu *iommu, int index);
+#endif /* CONFIG_CRASH_DUMP */
+
 struct ioapic_scope {
 	struct intel_iommu *iommu;
 	unsigned int id;
@@ -1296,3 +1302,54 @@ int dmar_ir_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 
 	return ret;
 }
+
+#ifdef CONFIG_CRASH_DUMP
+
+static int __iommu_load_old_irte(struct intel_iommu *iommu)
+{
+	if ((!iommu)
+		|| (!iommu->ir_table)
+		|| (!iommu->ir_table->base)
+		|| (!iommu->ir_table->base_old_phys)
+		|| (!iommu->ir_table->base_old_virt))
+		return -1;
+
+	memcpy(iommu->ir_table->base,
+		iommu->ir_table->base_old_virt,
+		INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
+
+	return 0;
+}
+
+static int __iommu_update_old_irte(struct intel_iommu *iommu, int index)
+{
+	int start;
+	unsigned long size;
+	void __iomem *to;
+	void *from;
+
+	if ((!iommu)
+		|| (!iommu->ir_table)
+		|| (!iommu->ir_table->base)
+		|| (!iommu->ir_table->base_old_phys)
+		|| (!iommu->ir_table->base_old_virt))
+		return -1;
+
+	if (index < -1 || index >= INTR_REMAP_TABLE_ENTRIES)
+		return -1;
+
+	if (index == -1) {
+		start = 0;
+		size = INTR_REMAP_TABLE_ENTRIES * sizeof(struct irte);
+	} else {
+		start = index * sizeof(struct irte);
+		size = sizeof(struct irte);
+	}
+
+	to = iommu->ir_table->base_old_virt;
+	from = iommu->ir_table->base;
+	memcpy(to + start, from + start, size);
+
+	return 0;
+}
+#endif /* CONFIG_CRASH_DUMP */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8e29b97..76c6ea5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -290,6 +290,10 @@ struct q_inval {
 struct ir_table {
 	struct irte *base;
 	unsigned long *bitmap;
+#ifdef CONFIG_CRASH_DUMP
+	void __iomem *base_old_virt;
+	unsigned long base_old_phys;
+#endif
 };
 #endif
 
-- 
2.0.0-rc0
