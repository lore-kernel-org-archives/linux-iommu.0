From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 17/19] iommu/vt-d: Copy IR table from old kernel when in kdump
	mode
Date: Sat, 13 Jun 2015 08:47:25 +0200
Message-ID: <1434178047-17809-18-git-send-email-joro@8bytes.org>
References: <1434178047-17809-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434178047-17809-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, jroedel-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

When we are booting into a kdump kernel and find IR enabled,
copy over the contents of the previous IR table so that
spurious interrupts will not be target aborted.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 70 +++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h         |  1 +
 2 files changed, 71 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 8497028..2a90121 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -11,6 +11,7 @@
 #include <linux/irq.h>
 #include <linux/intel-iommu.h>
 #include <linux/acpi.h>
+#include <linux/crash_dump.h>
 #include <asm/io_apic.h>
 #include <asm/smp.h>
 #include <asm/cpu.h>
@@ -54,8 +55,28 @@ static struct hpet_scope ir_hpet[MAX_HPET_TBS];
  */
 static DEFINE_RAW_SPINLOCK(irq_2_ir_lock);
 
+static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
 static int __init parse_ioapics_under_ir(void);
 
+static bool ir_pre_enabled(struct intel_iommu *iommu)
+{
+	return (iommu->flags & VTD_FLAG_IRQ_REMAP_PRE_ENABLED);
+}
+
+static void clear_ir_pre_enabled(struct intel_iommu *iommu)
+{
+	iommu->flags &= ~VTD_FLAG_IRQ_REMAP_PRE_ENABLED;
+}
+
+static void init_ir_status(struct intel_iommu *iommu)
+{
+	u32 gsts;
+
+	gsts = readl(iommu->reg + DMAR_GSTS_REG);
+	if (gsts & DMA_GSTS_IRES)
+		iommu->flags |= VTD_FLAG_IRQ_REMAP_PRE_ENABLED;
+}
+
 static struct irq_2_iommu *irq_2_iommu(unsigned int irq)
 {
 	struct irq_cfg *cfg = irq_cfg(irq);
@@ -426,6 +447,44 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 	return 0;
 }
 
+static int iommu_load_old_irte(struct intel_iommu *iommu)
+{
+	struct irte *old_ir_table;
+	phys_addr_t irt_phys;
+	size_t size;
+	u64 irta;
+
+	if (!is_kdump_kernel()) {
+		pr_warn("IRQ remapping was enabled on %s but we are not in kdump mode\n",
+			iommu->name);
+		clear_ir_pre_enabled(iommu);
+		iommu_disable_irq_remapping(iommu);
+		return -EINVAL;
+	}
+
+	/* Check whether the old ir-table has the same size as ours */
+	irta = dmar_readq(iommu->reg + DMAR_IRTA_REG);
+	if ((irta & INTR_REMAP_TABLE_REG_SIZE_MASK)
+	     != INTR_REMAP_TABLE_REG_SIZE)
+		return -EINVAL;
+
+	irt_phys = irta & VTD_PAGE_MASK;
+	size     = INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte);
+
+	/* Map the old IR table */
+	old_ir_table = ioremap_cache(irt_phys, size);
+	if (!old_ir_table)
+		return -ENOMEM;
+
+	/* Copy data over */
+	memcpy(iommu->ir_table->base, old_ir_table, size);
+
+	__iommu_flush_cache(iommu, iommu->ir_table->base, size);
+
+	return 0;
+}
+
+
 static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
 {
 	unsigned long flags;
@@ -531,6 +590,17 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 		}
 	}
 
+	init_ir_status(iommu);
+
+	if (ir_pre_enabled(iommu)) {
+		if (iommu_load_old_irte(iommu))
+			pr_err("Failed to copy IR table for %s from previous kernel\n",
+			       iommu->name);
+		else
+			pr_info("Copied IR table for %s from previous kernel\n",
+				iommu->name);
+	}
+
 	iommu_set_irq_remapping(iommu, eim_mode);
 
 	return 0;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fff87f1..9aedf21 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -295,6 +295,7 @@ struct q_inval {
 /* 1MB - maximum possible interrupt remapping table size */
 #define INTR_REMAP_PAGE_ORDER	8
 #define INTR_REMAP_TABLE_REG_SIZE	0xf
+#define INTR_REMAP_TABLE_REG_SIZE_MASK  0xf
 
 #define INTR_REMAP_TABLE_ENTRIES	65536
 
-- 
1.9.1
