From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 13/19] iommu/vt-d: Move EIM detection to
	intel_prepare_irq_remapping
Date: Sat, 13 Jun 2015 08:47:21 +0200
Message-ID: <1434178047-17809-14-git-send-email-joro@8bytes.org>
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

We need this to be detected already when we program the irq
remapping table pointer to hardware.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 47 +++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 3fe3fc7..12250f7 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -589,6 +589,7 @@ static int __init intel_prepare_irq_remapping(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
+	int eim = 0;
 
 	if (irq_remap_broken) {
 		pr_warn("This system BIOS has enabled interrupt remapping\n"
@@ -616,6 +617,26 @@ static int __init intel_prepare_irq_remapping(void)
 		if (!ecap_ir_support(iommu->ecap))
 			goto error;
 
+	/* Detect remapping mode: lapic or x2apic */
+	if (x2apic_supported()) {
+		eim = !dmar_x2apic_optout();
+		if (!eim) {
+			pr_info("x2apic is disabled because BIOS sets x2apic opt out bit.");
+			pr_info("Use 'intremap=no_x2apic_optout' to override the BIOS setting.\n");
+		}
+	}
+
+	for_each_iommu(iommu, drhd) {
+		if (eim && !ecap_eim_support(iommu->ecap)) {
+			pr_info("%s does not support EIM\n", iommu->name);
+			eim = 0;
+		}
+	}
+
+	eim_mode = eim;
+	if (eim)
+		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
+
 	/* Do the allocations early */
 	for_each_iommu(iommu, drhd)
 		if (intel_setup_irq_remapping(iommu))
@@ -633,13 +654,6 @@ static int __init intel_enable_irq_remapping(void)
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
 		/*
@@ -664,19 +678,6 @@ static int __init intel_enable_irq_remapping(void)
 	}
 
 	/*
-	 * check for the Interrupt-remapping support
-	 */
-	for_each_iommu(iommu, drhd)
-		if (eim && !ecap_eim_support(iommu->ecap)) {
-			pr_info("DRHD %Lx: EIM not supported by DRHD, "
-				" ecap %Lx\n", drhd->reg_base_addr, iommu->ecap);
-			eim = 0;
-		}
-	eim_mode = eim;
-	if (eim)
-		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
-
-	/*
 	 * Enable queued invalidation for all the DRHD's.
 	 */
 	for_each_iommu(iommu, drhd) {
@@ -694,7 +695,7 @@ static int __init intel_enable_irq_remapping(void)
 	 * Setup Interrupt-remapping for all the DRHD's now.
 	 */
 	for_each_iommu(iommu, drhd) {
-		iommu_set_irq_remapping(iommu, eim);
+		iommu_set_irq_remapping(iommu, eim_mode);
 		setup = true;
 	}
 
@@ -710,9 +711,9 @@ static int __init intel_enable_irq_remapping(void)
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
