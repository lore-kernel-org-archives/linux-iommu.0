From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/5] iommu, x86, apic: Remove irq_remapping_supported()
Date: Mon, 15 Dec 2014 16:13:24 +0100
Message-ID: <1418656404-28575-6-git-send-email-joro@8bytes.org>
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

The functionality has been moved to irq_remapping_prepare,
so remove this function and all its call-backs.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 arch/x86/kernel/apic/apic.c         |  5 -----
 drivers/iommu/amd_iommu.c           |  1 -
 drivers/iommu/amd_iommu_init.c      |  5 -----
 drivers/iommu/amd_iommu_proto.h     |  1 -
 drivers/iommu/intel_irq_remapping.c |  6 ------
 drivers/iommu/irq_remapping.c       | 11 -----------
 drivers/iommu/irq_remapping.h       |  3 ---
 7 files changed, 32 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 141f103..4484483 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1575,11 +1575,6 @@ void enable_x2apic(void)
 int __init enable_IR(void)
 {
 #ifdef CONFIG_IRQ_REMAP
-	if (!irq_remapping_supported()) {
-		pr_debug("intr-remapping not supported\n");
-		return -1;
-	}
-
 	if (!x2apic_preenabled && skip_ioapic_setup) {
 		pr_info("Skipped enabling intr-remap because of skipping "
 			"io-apic setup\n");
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a5c59b4..05ffb7c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4114,7 +4114,6 @@ static struct irq_domain *get_irq_domain(struct irq_alloc_info *info)
 }
 
 struct irq_remap_ops amd_iommu_irq_ops = {
-	.supported		= amd_iommu_supported,
 	.prepare		= amd_iommu_prepare,
 	.enable			= amd_iommu_enable,
 	.disable		= amd_iommu_disable,
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index fa63016..b9ce87e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2133,11 +2133,6 @@ int __init amd_iommu_prepare(void)
 	return iommu_go_to_state(IOMMU_ACPI_FINISHED);
 }
 
-int __init amd_iommu_supported(void)
-{
-	return amd_iommu_irq_remap ? 1 : 0;
-}
-
 int __init amd_iommu_enable(void)
 {
 	int ret;
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 612a221..fcf61ca 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -33,7 +33,6 @@ extern void amd_iommu_init_notifier(void);
 extern void amd_iommu_init_api(void);
 
 /* Needed for interrupt remapping */
-extern int amd_iommu_supported(void);
 extern int amd_iommu_prepare(void);
 extern int amd_iommu_enable(void);
 extern void amd_iommu_disable(void);
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 0c9226f..8918f47 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -510,11 +510,6 @@ static int __init dmar_x2apic_optout(void)
 	return dmar->flags & DMAR_X2APIC_OPT_OUT;
 }
 
-static int __init intel_irq_remapping_supported(void)
-{
-	return 1;
-}
-
 static void __init intel_cleanup_irq_remapping(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -970,7 +965,6 @@ static struct irq_domain *intel_get_irq_domain(struct irq_alloc_info *info)
 }
 
 struct irq_remap_ops intel_irq_remap_ops = {
-	.supported		= intel_irq_remapping_supported,
 	.prepare		= intel_prepare_irq_remapping,
 	.enable			= intel_enable_irq_remapping,
 	.disable		= disable_irq_remapping,
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 66517e7..6e7acd1 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -80,17 +80,6 @@ void set_irq_remapping_broken(void)
 	irq_remap_broken = 1;
 }
 
-int irq_remapping_supported(void)
-{
-	if (disable_irq_remap)
-		return 0;
-
-	if (!remap_ops || !remap_ops->supported)
-		return 0;
-
-	return remap_ops->supported();
-}
-
 int __init irq_remapping_prepare(void)
 {
 	remap_ops = &intel_irq_remap_ops;
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 4bd791d..961dc49 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -36,9 +36,6 @@ extern int no_x2apic_optout;
 extern int irq_remapping_enabled;
 
 struct irq_remap_ops {
-	/* Check whether Interrupt Remapping is supported */
-	int (*supported)(void);
-
 	/* Initializes hardware and makes it ready for remapping interrupts */
 	int  (*prepare)(void);
 
-- 
1.9.1
