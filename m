From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 01/19] x86,
	apic: Move irq_remapping_enabled checks into IRQ-remapping code
Date: Tue, 20 Nov 2012 14:12:38 +0100
Message-ID: <1353417176-18945-2-git-send-email-joro@8bytes.org>
References: <1353417176-18945-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1353417176-18945-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Move the three easy to move checks in the x86' apic.c file
into the IRQ-remapping code.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Acked-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
---
 arch/x86/kernel/apic/apic.c   |    9 +++------
 drivers/iommu/irq_remapping.c |   11 +++++++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b17416e..69cba83 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1444,8 +1444,7 @@ void __init bsp_end_local_APIC_setup(void)
 	 * Now that local APIC setup is completed for BP, configure the fault
 	 * handling for interrupt remapping.
 	 */
-	if (irq_remapping_enabled)
-		irq_remap_enable_fault_handling();
+	irq_remap_enable_fault_handling();
 
 }
 
@@ -2218,8 +2217,7 @@ static int lapic_suspend(void)
 	local_irq_save(flags);
 	disable_local_APIC();
 
-	if (irq_remapping_enabled)
-		irq_remapping_disable();
+	irq_remapping_disable();
 
 	local_irq_restore(flags);
 	return 0;
@@ -2287,8 +2285,7 @@ static void lapic_resume(void)
 	apic_write(APIC_ESR, 0);
 	apic_read(APIC_ESR);
 
-	if (irq_remapping_enabled)
-		irq_remapping_reenable(x2apic_mode);
+	irq_remapping_reenable(x2apic_mode);
 
 	local_irq_restore(flags);
 }
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index faf85d6..19381b9 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -87,7 +87,9 @@ int __init irq_remapping_enable(void)
 
 void irq_remapping_disable(void)
 {
-	if (!remap_ops || !remap_ops->disable)
+	if (!irq_remapping_enabled ||
+	    !remap_ops ||
+	    !remap_ops->disable)
 		return;
 
 	remap_ops->disable();
@@ -95,7 +97,9 @@ void irq_remapping_disable(void)
 
 int irq_remapping_reenable(int mode)
 {
-	if (!remap_ops || !remap_ops->reenable)
+	if (!irq_remapping_enabled ||
+	    !remap_ops ||
+	    !remap_ops->reenable)
 		return 0;
 
 	return remap_ops->reenable(mode);
@@ -103,6 +107,9 @@ int irq_remapping_reenable(int mode)
 
 int __init irq_remap_enable_fault_handling(void)
 {
+	if (!irq_remapping_enabled)
+		return 0;
+
 	if (!remap_ops || !remap_ops->enable_faulting)
 		return -ENODEV;
 
-- 
1.7.9.5
