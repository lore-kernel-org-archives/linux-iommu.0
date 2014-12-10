From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC Patch V1 4/9] iommu/vt-d: Prepare for killing function
	irq_remapping_supported()
Date: Wed, 10 Dec 2014 14:47:46 +0800
Message-ID: <1418194071-13785-5-git-send-email-jiang.liu@linux.intel.com>
References: <1418194071-13785-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418194071-13785-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Prepare for killing function irq_remapping_supported() by moving code
from intel_irq_remapping_supported() into intel_prepare_irq_remapping().

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c |   54 ++++++++++++++---------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index ff35b0336d2b..9e102168d8ae 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -512,30 +512,6 @@ static int __init dmar_x2apic_optout(void)
 
 static int __init intel_irq_remapping_supported(void)
 {
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-
-	if (disable_irq_remap)
-		return 0;
-	if (irq_remap_broken) {
-		printk(KERN_WARNING
-			"This system BIOS has enabled interrupt remapping\n"
-			"on a chipset that contains an erratum making that\n"
-			"feature unstable.  To maintain system stability\n"
-			"interrupt remapping is being disabled.  Please\n"
-			"contact your BIOS vendor for an update\n");
-		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
-		disable_irq_remap = 1;
-		return 0;
-	}
-
-	if (!dmar_ir_support())
-		return 0;
-
-	for_each_iommu(iommu, drhd)
-		if (!ecap_ir_support(iommu->ecap))
-			return 0;
-
 	return 1;
 }
 
@@ -560,26 +536,38 @@ static int __init intel_prepare_irq_remapping(void)
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 
+	if (irq_remap_broken) {
+		printk(KERN_WARNING
+			"This system BIOS has enabled interrupt remapping\n"
+			"on a chipset that contains an erratum making that\n"
+			"feature unstable.  To maintain system stability\n"
+			"interrupt remapping is being disabled.  Please\n"
+			"contact your BIOS vendor for an update\n");
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+		disable_irq_remap = 1;
+		return -ENODEV;
+	}
+
 	if (dmar_table_init() < 0)
-		return -1;
+		return -ENODEV;
+
+	if (!dmar_ir_support())
+		return -ENODEV;
 
 	if (parse_ioapics_under_ir() != 1) {
 		printk(KERN_INFO "Not enabling interrupt remapping\n");
 		goto error;
 	}
 
-	for_each_iommu(iommu, drhd) {
-		if (!ecap_ir_support(iommu->ecap))
-			continue;
-
-		/* Do the allocations early */
-		if (intel_setup_irq_remapping(iommu))
+	for_each_iommu(iommu, drhd)
+		if (!ecap_ir_support(iommu->ecap) ||
+		    intel_setup_irq_remapping(iommu))
 			goto error;
-	}
 	return 0;
+
 error:
 	intel_cleanup_irq_remapping();
-	return -1;
+	return -ENODEV;
 }
 
 static int __init intel_enable_irq_remapping(void)
-- 
1.7.10.4
