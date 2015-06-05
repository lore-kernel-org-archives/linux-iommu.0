From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 11/17] iommu/vt-d: Move QI initialization to
	intel_setup_irq_remapping
Date: Fri,  5 Jun 2015 16:10:57 +0200
Message-ID: <1433513463-19128-12-git-send-email-joro@8bytes.org>
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

This function needs a working QI later when kdump recovery
is moved to this function.

Tested-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 63 ++++++++++---------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index d22518d..70e4955 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -519,6 +519,19 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 	ir_table->base = page_address(pages);
 	ir_table->bitmap = bitmap;
 	iommu->ir_table = ir_table;
+
+	if (!iommu->qi) {
+		/*
+		 * Clear previous faults.
+		 */
+		dmar_fault(-1, iommu);
+		dmar_disable_qi(iommu);
+		if (dmar_enable_qi(iommu)) {
+			pr_err("Failed to enable queued invalidation\n");
+			goto out_free_pages;
+		}
+	}
+
 	return 0;
 
 out_free_pages:
@@ -655,18 +668,6 @@ static int __init intel_enable_irq_remapping(void)
 	}
 
 	for_each_iommu(iommu, drhd) {
-		/*
-		 * If the queued invalidation is already initialized,
-		 * shouldn't disable it.
-		 */
-		if (iommu->qi)
-			continue;
-
-		/*
-		 * Clear previous faults.
-		 */
-		dmar_fault(-1, iommu);
-
 		iommu_check_pre_ir_status(iommu);
 
 		if (!is_kdump_kernel() && iommu->pre_enabled_ir) {
@@ -675,8 +676,6 @@ static int __init intel_enable_irq_remapping(void)
 			pr_warn("IRQ remapping was enabled on %s but we are not in kdump mode\n",
 				iommu->name);
 		}
-
-		dmar_disable_qi(iommu);
 	}
 
 	/*
@@ -693,20 +692,6 @@ static int __init intel_enable_irq_remapping(void)
 		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
 
 	/*
-	 * Enable queued invalidation for all the DRHD's.
-	 */
-	for_each_iommu(iommu, drhd) {
-		int ret = dmar_enable_qi(iommu);
-
-		if (ret) {
-			printk(KERN_ERR "DRHD %Lx: failed to enable queued, "
-			       " invalidation, ecap %Lx, ret %d\n",
-			       drhd->reg_base_addr, iommu->ecap, ret);
-			goto error;
-		}
-	}
-
-	/*
 	 * Setup Interrupt-remapping for all the DRHD's now.
 	 */
 	for_each_iommu(iommu, drhd) {
@@ -1270,28 +1255,12 @@ static int dmar_ir_add(struct dmar_drhd_unit *dmaru, struct intel_iommu *iommu)
 	/* Setup Interrupt-remapping now. */
 	ret = intel_setup_irq_remapping(iommu);
 	if (ret) {
-		pr_err("DRHD %Lx: failed to allocate resource\n",
+		pr_err("DRHD %Lx: failed to setup IRQ remapping\n",
 		       iommu->reg_phys);
-		ir_remove_ioapic_hpet_scope(iommu);
-		return ret;
-	}
-
-	if (!iommu->qi) {
-		/* Clear previous faults. */
-		dmar_fault(-1, iommu);
-		iommu_disable_irq_remapping(iommu);
-		dmar_disable_qi(iommu);
-	}
-
-	/* Enable queued invalidation */
-	ret = dmar_enable_qi(iommu);
-	if (!ret) {
-		iommu_set_irq_remapping(iommu, eim);
-	} else {
-		pr_err("DRHD %Lx: failed to enable queued invalidation, ecap %Lx, ret %d\n",
-		       iommu->reg_phys, iommu->ecap, ret);
 		intel_teardown_irq_remapping(iommu);
 		ir_remove_ioapic_hpet_scope(iommu);
+	} else {
+		iommu_set_irq_remapping(iommu, eim);
 	}
 
 	return ret;
-- 
1.9.1
