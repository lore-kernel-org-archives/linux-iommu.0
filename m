From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch v1 10/17] iommu/vt-d: Allocate IRQ remapping data structures
	only for all IOMMUs
Date: Wed, 17 Dec 2014 12:35:41 +0800
Message-ID: <1418790948-22804-11-git-send-email-jiang.liu@linux.intel.com>
References: <1418790948-22804-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418790948-22804-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

IRQ remapping is only supported when all IOMMUs in the
system support it. So check if all IOMMUs in the system
support IRQ remapping before doing the allocations.

[Jiang]
1) Rebased onto v3.19.
2) Remove redundant check of ecap_ir_support(iommu->ecap) in function
   intel_enable_irq_remapping().

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index b7ce4f458b29..a47cb31f198e 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -619,10 +619,16 @@ static int __init intel_prepare_irq_remapping(void)
 		goto error;
 	}
 
+	/* First make sure all IOMMUs support IRQ remapping */
 	for_each_iommu(iommu, drhd)
-		if (!ecap_ir_support(iommu->ecap) ||
-		    intel_setup_irq_remapping(iommu))
+		if (!ecap_ir_support(iommu->ecap))
+			goto error;
+
+	/* Do the allocations early */
+	for_each_iommu(iommu, drhd)
+		if (intel_setup_irq_remapping(iommu))
 			goto error;
+
 	return 0;
 
 error:
@@ -673,16 +679,12 @@ static int __init intel_enable_irq_remapping(void)
 	/*
 	 * check for the Interrupt-remapping support
 	 */
-	for_each_iommu(iommu, drhd) {
-		if (!ecap_ir_support(iommu->ecap))
-			continue;
-
+	for_each_iommu(iommu, drhd)
 		if (eim && !ecap_eim_support(iommu->ecap)) {
 			printk(KERN_INFO "DRHD %Lx: EIM not supported by DRHD, "
 			       " ecap %Lx\n", drhd->reg_base_addr, iommu->ecap);
 			goto error;
 		}
-	}
 
 	/*
 	 * Enable queued invalidation for all the DRHD's.
@@ -702,9 +704,6 @@ static int __init intel_enable_irq_remapping(void)
 	 * Setup Interrupt-remapping for all the DRHD's now.
 	 */
 	for_each_iommu(iommu, drhd) {
-		if (!ecap_ir_support(iommu->ecap))
-			continue;
-
 		iommu_set_irq_remapping(iommu, eim);
 		setup = 1;
 	}
-- 
1.7.10.4
