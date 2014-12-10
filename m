From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC Patch V1 3/9] x86,
	apic: Refine enable_IR_x2apic() and related functions
Date: Wed, 10 Dec 2014 14:47:45 +0800
Message-ID: <1418194071-13785-4-git-send-email-jiang.liu@linux.intel.com>
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
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, HATAYAMA Daisuke <d.hatayama-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, Jan Beulich <JBeulich-IBi9RG/b67k@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Oren Twaig <oren-Yzr3oMT/Kq5BDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "H. Peter Anvin" <hpa-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Refine enable_IR_x2apic() and related functions for better maintenence.
It also changes the way to treat IR in XAPIC mode as the same as IR is
disabled when enabling X2APIC.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 arch/x86/kernel/apic/apic.c |   78 ++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b6c473b97c5c..2a9bac837be4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1572,7 +1572,7 @@ void enable_x2apic(void)
 }
 #endif /* CONFIG_X86_X2APIC */
 
-int __init enable_IR(void)
+static int __init try_to_enable_IR(void)
 {
 #ifdef CONFIG_IRQ_REMAP
 	if (!irq_remapping_supported()) {
@@ -1585,44 +1585,18 @@ int __init enable_IR(void)
 			"io-apic setup\n");
 		return -1;
 	}
+#endif
 
 	return irq_remapping_enable();
-#endif
-	return -1;
 }
 
-void __init enable_IR_x2apic(void)
+static __init void try_to_enable_x2apic(int ir_stat)
 {
-	unsigned long flags;
-	int ret;
-	int hardware_init_ret;
-
-	hardware_init_ret = irq_remapping_prepare();
-	if (hardware_init_ret && !x2apic_supported())
-		return;
-
-	ret = save_ioapic_entries();
-	if (ret) {
-		pr_info("Saving IO-APIC state failed: %d\n", ret);
-		return;
-	}
-
-	local_irq_save(flags);
-	legacy_pic->mask_all();
-	mask_ioapic_entries();
-
-	if (x2apic_preenabled && nox2apic)
-		disable_x2apic();
-
-	if (hardware_init_ret)
-		ret = -1;
-	else
-		ret = enable_IR();
-
+#ifdef CONFIG_X86_X2APIC
 	if (!x2apic_supported())
-		goto skip_x2apic;
+		return;
 
-	if (ret < 0) {
+	if (ir_stat != IRQ_REMAP_X2APIC_MODE) {
 		/* IR is required if there is APIC ID > 255 even when running
 		 * under KVM
 		 */
@@ -1630,8 +1604,9 @@ void __init enable_IR_x2apic(void)
 		    !hypervisor_x2apic_available()) {
 			if (x2apic_preenabled)
 				disable_x2apic();
-			goto skip_x2apic;
+			return;
 		}
+
 		/*
 		 * without IR all CPUs can be addressed by IOAPIC/MSI
 		 * only in physical mode
@@ -1639,19 +1614,40 @@ void __init enable_IR_x2apic(void)
 		x2apic_force_phys();
 	}
 
-	if (ret == IRQ_REMAP_XAPIC_MODE) {
-		pr_info("x2apic not enabled, IRQ remapping is in xapic mode\n");
-		goto skip_x2apic;
-	}
-
-	if (x2apic_supported() && !x2apic_mode) {
+	if (!x2apic_mode) {
 		x2apic_mode = 1;
 		enable_x2apic();
 		pr_info("Enabled x2apic\n");
 	}
+#endif
+}
+
+void __init enable_IR_x2apic(void)
+{
+	unsigned long flags;
+	int ret, ir_stat;
+
+	ir_stat = irq_remapping_prepare();
+	if (ir_stat < 0 && !x2apic_supported())
+		return;
+
+	ret = save_ioapic_entries();
+	if (ret) {
+		pr_info("Saving IO-APIC state failed: %d\n", ret);
+		return;
+	}
+
+	local_irq_save(flags);
+	legacy_pic->mask_all();
+	mask_ioapic_entries();
+
+	if (x2apic_preenabled && nox2apic)
+		disable_x2apic();
+	if (ir_stat >= 0)
+		ir_stat = try_to_enable_IR();
+	try_to_enable_x2apic(ir_stat);
 
-skip_x2apic:
-	if (ret < 0) /* IR enabling failed */
+	if (ir_stat < 0) /* IR enabling failed */
 		restore_ioapic_entries();
 	legacy_pic->restore_mask();
 	local_irq_restore(flags);
-- 
1.7.10.4
