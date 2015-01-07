From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v7 10/10] iommu/vt-d: Use old irte in kdump kernel
Date: Wed,  7 Jan 2015 12:04:34 +0800
Message-ID: <1420603474-4235-11-git-send-email-zhen-hual@hp.com>
References: <1420603474-4235-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1420603474-4235-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
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
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Fix the intr-remapping fault.

[1.594890] dmar: DRHD: handling fault status reg 2
[1.594894] dmar: INTR-REMAP: Request device [[41:00.0] fault index 4d
[1.594894] INTR-REMAP:[fault reason 34] Present field in the IRTE entry
is clear

Use old irte in kdump kernel, do not disable and re-enable interrupt
remapping.

Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 42 ++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index d37fd62..58356cb 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -198,6 +198,11 @@ static int modify_irte(int irq, struct irte *irte_modified)
 
 	set_64bit(&irte->low, irte_modified->low);
 	set_64bit(&irte->high, irte_modified->high);
+
+#ifdef CONFIG_CRASH_DUMP
+	if (is_kdump_kernel())
+		__iommu_update_old_irte(iommu, index);
+#endif
 	__iommu_flush_cache(iommu, irte, sizeof(*irte));
 
 	rc = qi_flush_iec(iommu, index, 0);
@@ -259,6 +264,11 @@ static int clear_entries(struct irq_2_iommu *irq_iommu)
 	bitmap_release_region(iommu->ir_table->bitmap, index,
 			      irq_iommu->irte_mask);
 
+#ifdef CONFIG_CRASH_DUMP
+	if (is_kdump_kernel())
+		__iommu_update_old_irte(iommu, -1);
+#endif
+
 	return qi_flush_iec(iommu, index, irq_iommu->irte_mask);
 }
 
@@ -640,11 +650,20 @@ static int __init intel_enable_irq_remapping(void)
 		 */
 		dmar_fault(-1, iommu);
 
-		/*
-		 * Disable intr remapping and queued invalidation, if already
-		 * enabled prior to OS handover.
-		 */
-		iommu_disable_irq_remapping(iommu);
+#ifdef CONFIG_CRASH_DUMP
+		if (is_kdump_kernel()) {
+			/* Do notdisable irq and then re-enable again. */
+		} else {
+#endif
+			/*
+			 * Disable intr remapping and queued invalidation,
+			 * if already enabled prior to OS handover.
+			 */
+			iommu_disable_irq_remapping(iommu);
+
+#ifdef CONFIG_CRASH_DUMP
+		}
+#endif
 
 		dmar_disable_qi(iommu);
 	}
@@ -687,7 +706,20 @@ static int __init intel_enable_irq_remapping(void)
 		if (intel_setup_irq_remapping(iommu))
 			goto error;
 
+#ifdef CONFIG_CRASH_DUMP
+	if (is_kdump_kernel()) {
+		unsigned long long q;
+
+		q = dmar_readq(iommu->reg + DMAR_IRTA_REG);
+		iommu->ir_table->base_old_phys = q & VTD_PAGE_MASK;
+		iommu->ir_table->base_old_virt = ioremap_cache(
+				iommu->ir_table->base_old_phys,
+				INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
+		__iommu_load_old_irte(iommu);
+	} else
+#endif
 		iommu_set_irq_remapping(iommu, eim);
+
 		setup = 1;
 	}
 
-- 
2.0.0-rc0
