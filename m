From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 14/17] iommu/vt-d: Move kdump pointer intialization to
	__iommu_load_old_irte
Date: Fri,  5 Jun 2015 16:11:00 +0200
Message-ID: <1433513463-19128-15-git-send-email-joro@8bytes.org>
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

We initialize the base_old_phys and base_old_virt in this
function. This cleans up the caller and makes the code more
readable. Also add a check for the size of the irq
remapping table of the old kernel, break out if it does not
match our size. Rename the function to iommu_load_old_irte
while at it.

Tested-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 50 +++++++++++++++++++++----------------
 include/linux/intel-iommu.h         |  1 +
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index c3d1e63..fd6c25b 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -21,7 +21,7 @@
 
 #include "irq_remapping.h"
 
-static int __iommu_load_old_irte(struct intel_iommu *iommu);
+static int iommu_load_old_irte(struct intel_iommu *iommu);
 static int __iommu_update_old_irte(struct intel_iommu *iommu, int index);
 static void iommu_check_pre_ir_status(struct intel_iommu *iommu);
 
@@ -698,14 +698,7 @@ static int __init intel_enable_irq_remapping(void)
 	 */
 	for_each_iommu(iommu, drhd) {
 		if (iommu->pre_enabled_ir) {
-			unsigned long long q;
-
-			q = dmar_readq(iommu->reg + DMAR_IRTA_REG);
-			iommu->ir_table->base_old_phys = q & VTD_PAGE_MASK;
-			iommu->ir_table->base_old_virt = ioremap_cache(
-				iommu->ir_table->base_old_phys,
-				INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
-			__iommu_load_old_irte(iommu);
+			iommu_load_old_irte(iommu);
 		} else {
 			iommu_set_irq_remapping(iommu, eim_mode);
 			iommu_enable_irq_remapping(iommu);
@@ -1303,21 +1296,34 @@ int dmar_ir_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 	return ret;
 }
 
-static int __iommu_load_old_irte(struct intel_iommu *iommu)
+static int iommu_load_old_irte(struct intel_iommu *iommu)
 {
-	if ((!iommu)
-		|| (!iommu->ir_table)
-		|| (!iommu->ir_table->base)
-		|| (!iommu->ir_table->base_old_phys)
-		|| (!iommu->ir_table->base_old_virt))
-		return -1;
+	struct irte *old_ir_table;
+	phys_addr_t irt_phys;
+	size_t size;
+	u64 irta;
+
+	/* Check whether the old ir-table has the same size as ours */
+	irta = dmar_readq(iommu->reg + DMAR_IRTA_REG);
+	if ((irta & INTR_REMAP_TABLE_REG_SIZE_MASK)
+		 != INTR_REMAP_TABLE_REG_SIZE)
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
 
-	memcpy(iommu->ir_table->base,
-		iommu->ir_table->base_old_virt,
-		INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
+	__iommu_flush_cache(iommu, iommu->ir_table->base, size);
 
-	__iommu_flush_cache(iommu, iommu->ir_table->base,
-		INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
+	iommu->ir_table->base_old_phys = irt_phys;
+	iommu->ir_table->base_old_virt = old_ir_table;
 
 	return 0;
 }
@@ -1327,7 +1333,7 @@ static int __iommu_update_old_irte(struct intel_iommu *iommu, int index)
 	int start;
 	unsigned long size;
 	void __iomem *to;
-	void *from;
+void *from;
 
 	if ((!iommu)
 		|| (!iommu->ir_table)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6c37de9..5aa8834 100644
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
