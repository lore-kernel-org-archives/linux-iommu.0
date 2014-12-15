From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/5] iommu/vt-d: Move supported-checks to
	intel_prepare_irq_remapping()
Date: Mon, 15 Dec 2014 16:13:22 +0100
Message-ID: <1418656404-28575-4-git-send-email-joro@8bytes.org>
References: <1418656404-28575-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418656404-28575-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The checks for IRQ remapping support rely on ordering with
dmar_table_init(), which is called in
intel_prepare_irq_remapping(). Move the checks for IRQ
remapping support to this function to ensure the right
ordering.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 39 +++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 45223ea..0c9226f 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -512,23 +512,6 @@ static int __init dmar_x2apic_optout(void)
 
 static int __init intel_irq_remapping_supported(void)
 {
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
 	return 1;
 }
 
@@ -553,6 +536,24 @@ static int __init intel_prepare_irq_remapping(void)
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 
+	/* First check whether IRQ remapping should be enabled */
+	if (disable_irq_remap)
+		return -1;
+
+	/* Are we running on sane hardware? */
+	if (irq_remap_broken) {
+		printk(KERN_WARNING
+			"This system BIOS has enabled interrupt remapping\n"
+			"on a chipset that contains an erratum making that\n"
+			"feature unstable.  To maintain system stability\n"
+			"interrupt remapping is being disabled.  Please\n"
+			"contact your BIOS vendor for an update\n");
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+		disable_irq_remap = 1;
+		return -1;
+	}
+
+	/* Everthing seems fine so far, parse the DMAR table */
 	if (dmar_table_init() < 0)
 		return -1;
 
@@ -561,6 +562,10 @@ static int __init intel_prepare_irq_remapping(void)
 		goto error;
 	}
 
+	/* Is interrupt remapping supported by hardware? */
+	if (!dmar_ir_support())
+		return 0;
+
 	/* First make sure all IOMMUs support IRQ remapping */
 	for_each_iommu(iommu, drhd)
 		if (!ecap_ir_support(iommu->ecap))
-- 
1.9.1
