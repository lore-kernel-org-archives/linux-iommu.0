From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 12/17] iommu/vt-d: Move EIM detection to
	intel_prepare_irq_remapping
Date: Fri,  5 Jun 2015 16:10:58 +0200
Message-ID: <1433513463-19128-13-git-send-email-joro@8bytes.org>
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

This needs to be set up before the ir-table can be
programmed to the iommu hardware register. This programming
will be moved to intel_setup_irq_remapping, so EIM needs to
be set up earlier too.

Tested-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 44 +++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 70e4955..35d73f6 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -637,10 +637,26 @@ static int __init intel_prepare_irq_remapping(void)
 		goto error;
 	}
 
+	if (x2apic_supported()) {
+		eim_mode = !dmar_x2apic_optout();
+		if (!eim_mode)
+			pr_info("BIOS set x2apic opt out bit. Use "
+				"'intremap=no_x2apic_optout' to enable x2apic\n");
+	}
+
 	/* First make sure all IOMMUs support IRQ remapping */
-	for_each_iommu(iommu, drhd)
+	for_each_iommu(iommu, drhd) {
 		if (!ecap_ir_support(iommu->ecap))
 			goto error;
+		if (eim_mode && !ecap_eim_support(iommu->ecap)) {
+			printk(KERN_INFO "DRHD %Lx: EIM not supported by DRHD, "
+			       " ecap %Lx\n", drhd->reg_base_addr, iommu->ecap);
+			eim_mode = 0;
+		}
+	}
+
+	if (eim_mode)
+		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
 
 	/* Do the allocations early */
 	for_each_iommu(iommu, drhd)
@@ -659,13 +675,6 @@ static int __init intel_enable_irq_remapping(void)
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	bool setup = false;
-	int eim = 0;
-
-	if (x2apic_supported()) {
-		eim = !dmar_x2apic_optout();
-		if (!eim)
-			pr_info("x2apic is disabled because BIOS sets x2apic opt out bit. You can use 'intremap=no_x2apic_optout' to override the BIOS setting.\n");
-	}
 
 	for_each_iommu(iommu, drhd) {
 		iommu_check_pre_ir_status(iommu);
@@ -679,19 +688,6 @@ static int __init intel_enable_irq_remapping(void)
 	}
 
 	/*
-	 * check for the Interrupt-remapping support
-	 */
-	for_each_iommu(iommu, drhd)
-		if (eim && !ecap_eim_support(iommu->ecap)) {
-			printk(KERN_INFO "DRHD %Lx: EIM not supported by DRHD, "
-			       " ecap %Lx\n", drhd->reg_base_addr, iommu->ecap);
-			eim = 0;
-		}
-	eim_mode = eim;
-	if (eim)
-		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
-
-	/*
 	 * Setup Interrupt-remapping for all the DRHD's now.
 	 */
 	for_each_iommu(iommu, drhd) {
@@ -705,7 +701,7 @@ static int __init intel_enable_irq_remapping(void)
 				INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
 			__iommu_load_old_irte(iommu);
 		} else
-			iommu_set_irq_remapping(iommu, eim);
+			iommu_set_irq_remapping(iommu, eim_mode);
 
 		setup = true;
 	}
@@ -722,9 +718,9 @@ static int __init intel_enable_irq_remapping(void)
 	 */
 	x86_io_apic_ops.print_entries = intel_ir_io_apic_print_entries;
 
-	pr_info("Enabled IRQ remapping in %s mode\n", eim ? "x2apic" : "xapic");
+	pr_info("Enabled IRQ remapping in %s mode\n", eim_mode ? "x2apic" : "xapic");
 
-	return eim ? IRQ_REMAP_X2APIC_MODE : IRQ_REMAP_XAPIC_MODE;
+	return eim_mode ? IRQ_REMAP_X2APIC_MODE : IRQ_REMAP_XAPIC_MODE;
 
 error:
 	intel_cleanup_irq_remapping();
-- 
1.9.1
