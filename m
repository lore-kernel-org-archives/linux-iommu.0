From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 17/17] iommu/vt-d: Remove update code for old ir-table
Date: Fri,  5 Jun 2015 16:11:03 +0200
Message-ID: <1433513463-19128-18-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The code to update the irq remapping table of the old kernel
is not necessary anymore because we switch immidiatly to the
new table after we copied the data over.

Tested-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 44 -------------------------------------
 include/linux/intel-iommu.h         |  2 --
 2 files changed, 46 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 07a8e82..b49aa8c 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -22,7 +22,6 @@
 #include "irq_remapping.h"
 
 static int iommu_load_old_irte(struct intel_iommu *iommu);
-static int __iommu_update_old_irte(struct intel_iommu *iommu, int index);
 static void iommu_check_pre_ir_status(struct intel_iommu *iommu);
 static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
 
@@ -202,9 +201,6 @@ static int modify_irte(int irq, struct irte *irte_modified)
 	set_64bit(&irte->low, irte_modified->low);
 	set_64bit(&irte->high, irte_modified->high);
 
-	if (iommu->pre_enabled_ir)
-		__iommu_update_old_irte(iommu, index);
-
 	__iommu_flush_cache(iommu, irte, sizeof(*irte));
 
 	rc = qi_flush_iec(iommu, index, 0);
@@ -266,9 +262,6 @@ static int clear_entries(struct irq_2_iommu *irq_iommu)
 	bitmap_release_region(iommu->ir_table->bitmap, index,
 			      irq_iommu->irte_mask);
 
-	if (iommu->pre_enabled_ir)
-		__iommu_update_old_irte(iommu, -1);
-
 	return qi_flush_iec(iommu, index, irq_iommu->irte_mask);
 }
 
@@ -1327,9 +1320,6 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 
 	__iommu_flush_cache(iommu, iommu->ir_table->base, size);
 
-	iommu->ir_table->base_old_phys = irt_phys;
-	iommu->ir_table->base_old_virt = old_ir_table;
-
 	/*
 	 * Now check the table for used entries and mark those as
 	 * allocated in the bitmap
@@ -1342,40 +1332,6 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 	return 0;
 }
 
-static int __iommu_update_old_irte(struct intel_iommu *iommu, int index)
-{
-	int start;
-	unsigned long size;
-	void __iomem *to;
-void *from;
-
-	if ((!iommu)
-		|| (!iommu->ir_table)
-		|| (!iommu->ir_table->base)
-		|| (!iommu->ir_table->base_old_phys)
-		|| (!iommu->ir_table->base_old_virt))
-		return -1;
-
-	if (index < -1 || index >= INTR_REMAP_TABLE_ENTRIES)
-		return -1;
-
-	if (index == -1) {
-		start = 0;
-		size = INTR_REMAP_TABLE_ENTRIES * sizeof(struct irte);
-	} else {
-		start = index * sizeof(struct irte);
-		size = sizeof(struct irte);
-	}
-
-	to = iommu->ir_table->base_old_virt;
-	from = iommu->ir_table->base;
-	memcpy(to + start, from + start, size);
-
-	__iommu_flush_cache(iommu, to + start, size);
-
-	return 0;
-}
-
 static void iommu_check_pre_ir_status(struct intel_iommu *iommu)
 {
 	u32 sts;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 5aa8834..9fcdd9a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -302,8 +302,6 @@ struct q_inval {
 struct ir_table {
 	struct irte *base;
 	unsigned long *bitmap;
-	void __iomem *base_old_virt;
-	unsigned long base_old_phys;
 };
 #endif
 
-- 
1.9.1
