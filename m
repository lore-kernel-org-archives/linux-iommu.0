From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch v2 02/16] iommu/vt-d: Move iommu preparatory allocations to
	irq_remap_ops.prepare
Date: Wed,  7 Jan 2015 15:31:29 +0800
Message-ID: <1420615903-28253-3-git-send-email-jiang.liu@linux.intel.com>
References: <1420615903-28253-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1420615903-28253-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

The whole iommu setup for irq remapping is a convoluted mess. The
iommu detect function gets called from mem_init() and the prepare
callback gets called from enable_IR_x2apic() for unknown reasons.

Of course AMD and Intel setup differs in nonsensical ways. Intels
prepare callback is explicit while AMDs prepare callback is implicit
in setup_irq_remapping_ops() just to be called in the prepare call
again.

Because all of this gets called from enable_IR_x2apic() and the dmar
prepare function merily parses the ACPI tables, but does not allocate
memory we end up with memory allocation from irq disabled context
later on.

AMDs iommu code at least allocates the required memory from the
prepare function. That has issues as well, but thats not scope of this
patch.

The goal of this change is to distangle the allocation from the actual
enablement. There is no point to allocate memory from irq disabled
regions with GFP_ATOMIC just because it does not matter at that point
in the boot stage. It matters with physical hotplug later on.

There is another issue with the current setup. Due to the conversion
to stacked irqdomains we end up with a call into the irqdomain
allocation code from irq disabled context, but that code does
GFP_KERNEL allocations rightfully as there is no reason to do
preperatory allocations with GFP_ATOMIC.

That change caused the allocator code to complain about GFP_KERNEL
allocations invoked in atomic context. Boris provided a temporary
hackaround which changed the GFP flags if irq_domain_add() got called
from atomic context. Not pretty and we really dont want to get this
into a mainline release for obvious reasons.

Move the ACPI table parsing and the resulting memory allocations from
the enable to the prepare function. That allows to get rid of the
horrible hackaround in irq_domain_add() later.

[Jiang] Rebased onto v3.19

Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Tested-by: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Acked-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Link: http://lkml.kernel.org/r/20141205084147.313026156-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c |   64 ++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index a55b207b9425..2360cb6a8896 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -595,22 +595,57 @@ static int __init intel_irq_remapping_supported(void)
 	return 1;
 }
 
-static int __init intel_enable_irq_remapping(void)
+static void __init intel_cleanup_irq_remapping(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+
+	for_each_iommu(iommu, drhd) {
+		if (ecap_ir_support(iommu->ecap)) {
+			iommu_disable_irq_remapping(iommu);
+			intel_teardown_irq_remapping(iommu);
+		}
+	}
+
+	if (x2apic_supported())
+		pr_warn("Failed to enable irq remapping.  You are vulnerable to irq-injection attacks.\n");
+}
+
+static int __init intel_prepare_irq_remapping(void)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
-	bool x2apic_present;
-	int setup = 0;
-	int eim = 0;
 
-	x2apic_present = x2apic_supported();
+	if (dmar_table_init() < 0)
+		return -1;
 
 	if (parse_ioapics_under_ir() != 1) {
-		printk(KERN_INFO "Not enable interrupt remapping\n");
+		printk(KERN_INFO "Not enabling interrupt remapping\n");
 		goto error;
 	}
 
-	if (x2apic_present) {
+	for_each_iommu(iommu, drhd) {
+		if (!ecap_ir_support(iommu->ecap))
+			continue;
+
+		/* Do the allocations early */
+		if (intel_setup_irq_remapping(iommu))
+			goto error;
+	}
+	return 0;
+error:
+	intel_cleanup_irq_remapping();
+	return -1;
+}
+
+static int __init intel_enable_irq_remapping(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	int setup = 0;
+	int eim = 0;
+
+	if (x2apic_supported()) {
 		pr_info("Queued invalidation will be enabled to support x2apic and Intr-remapping.\n");
 
 		eim = !dmar_x2apic_optout();
@@ -678,9 +713,6 @@ static int __init intel_enable_irq_remapping(void)
 		if (!ecap_ir_support(iommu->ecap))
 			continue;
 
-		if (intel_setup_irq_remapping(iommu))
-			goto error;
-
 		iommu_set_irq_remapping(iommu, eim);
 		setup = 1;
 	}
@@ -702,15 +734,7 @@ static int __init intel_enable_irq_remapping(void)
 	return eim ? IRQ_REMAP_X2APIC_MODE : IRQ_REMAP_XAPIC_MODE;
 
 error:
-	for_each_iommu(iommu, drhd)
-		if (ecap_ir_support(iommu->ecap)) {
-			iommu_disable_irq_remapping(iommu);
-			intel_teardown_irq_remapping(iommu);
-		}
-
-	if (x2apic_present)
-		pr_warn("Failed to enable irq remapping.  You are vulnerable to irq-injection attacks.\n");
-
+	intel_cleanup_irq_remapping();
 	return -1;
 }
 
@@ -1200,7 +1224,7 @@ static int intel_alloc_hpet_msi(unsigned int irq, unsigned int id)
 
 struct irq_remap_ops intel_irq_remap_ops = {
 	.supported		= intel_irq_remapping_supported,
-	.prepare		= dmar_table_init,
+	.prepare		= intel_prepare_irq_remapping,
 	.enable			= intel_enable_irq_remapping,
 	.disable		= disable_irq_remapping,
 	.reenable		= reenable_irq_remapping,
-- 
1.7.10.4
