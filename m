From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 14/19] iommu/vt-d: Move QI initializationt to
	intel_setup_irq_remapping
Date: Sat, 13 Jun 2015 08:47:22 +0200
Message-ID: <1434178047-17809-15-git-send-email-joro@8bytes.org>
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

QI needs to be enabled when we program the irq remapping
table to hardware in the prepare phase later.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 92 ++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 12250f7..46d17e1 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -507,12 +507,35 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 	ir_table->base = page_address(pages);
 	ir_table->bitmap = bitmap;
 	iommu->ir_table = ir_table;
+
+	/*
+	 * If the queued invalidation is already initialized,
+	 * shouldn't disable it.
+	 */
+	if (!iommu->qi) {
+		/*
+		 * Clear previous faults.
+		 */
+		dmar_fault(-1, iommu);
+		dmar_disable_qi(iommu);
+
+		if (dmar_enable_qi(iommu)) {
+			pr_err("Failed to enable queued invalidation\n");
+			goto out_free_bitmap;
+		}
+	}
+
 	return 0;
 
+out_free_bitmap:
+	kfree(bitmap);
 out_free_pages:
 	__free_pages(pages, INTR_REMAP_PAGE_ORDER);
 out_free_table:
 	kfree(ir_table);
+
+	iommu->ir_table  = NULL;
+
 	return -ENOMEM;
 }
 
@@ -637,10 +660,14 @@ static int __init intel_prepare_irq_remapping(void)
 	if (eim)
 		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
 
-	/* Do the allocations early */
-	for_each_iommu(iommu, drhd)
-		if (intel_setup_irq_remapping(iommu))
+	/* Do the initializations early */
+	for_each_iommu(iommu, drhd) {
+		if (intel_setup_irq_remapping(iommu)) {
+			pr_err("Failed to setup irq remapping for %s\n",
+			       iommu->name);
 			goto error;
+		}
+	}
 
 	return 0;
 
@@ -655,42 +682,9 @@ static int __init intel_enable_irq_remapping(void)
 	struct intel_iommu *iommu;
 	bool setup = false;
 
-	for_each_iommu(iommu, drhd) {
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
-		/*
-		 * Disable intr remapping and queued invalidation, if already
-		 * enabled prior to OS handover.
-		 */
+	for_each_iommu(iommu, drhd)
 		iommu_disable_irq_remapping(iommu);
 
-		dmar_disable_qi(iommu);
-	}
-
-	/*
-	 * Enable queued invalidation for all the DRHD's.
-	 */
-	for_each_iommu(iommu, drhd) {
-		int ret = dmar_enable_qi(iommu);
-
-		if (ret) {
-			pr_err("DRHD %Lx: failed to enable queued, "
-			       " invalidation, ecap %Lx, ret %d\n",
-			       drhd->reg_base_addr, iommu->ecap, ret);
-			goto error;
-		}
-	}
-
 	/*
 	 * Setup Interrupt-remapping for all the DRHD's now.
 	 */
@@ -1242,28 +1236,12 @@ static int dmar_ir_add(struct dmar_drhd_unit *dmaru, struct intel_iommu *iommu)
 	/* Setup Interrupt-remapping now. */
 	ret = intel_setup_irq_remapping(iommu);
 	if (ret) {
-		pr_err("DRHD %Lx: failed to allocate resource\n",
-		       iommu->reg_phys);
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
+		pr_err("Failed to setup irq remapping for %s\n",
+		       iommu->name);
 		intel_teardown_irq_remapping(iommu);
 		ir_remove_ioapic_hpet_scope(iommu);
+	} else {
+		iommu_set_irq_remapping(iommu, eim);
 	}
 
 	return ret;
-- 
1.9.1
