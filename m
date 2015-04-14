From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part2 v5 25/33] x86/irq: Move check of cfg->move_in_progress
	into send_cleanup_vector()
Date: Tue, 14 Apr 2015 10:30:02 +0800
Message-ID: <1428978610-28986-26-git-send-email-jiang.liu@linux.intel.com>
References: <1428978610-28986-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1428978610-28986-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Dimitri Sivanich <sivanich-sJ/iWh9BUns@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Sander Eikelenboom <linux-6SM94LqRVpn6gRhOQ7JHfg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Vrabel <david.vrabel-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Move check of cfg->move_in_progress into send_cleanup_vector() to
prepare for simplifying struct irq_cfg.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Link: http://lkml.kernel.org/r/1416901802-24211-34-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Tested-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 arch/x86/kernel/apic/vector.c       |   10 ++++++++--
 arch/x86/platform/uv/uv_irq.c       |    3 +--
 drivers/iommu/amd_iommu.c           |    3 +--
 drivers/iommu/intel_irq_remapping.c |    3 +--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 436a3400d9ac..a5ce2eef0528 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -495,7 +495,7 @@ static struct irq_chip lapic_controller = {
 };
 
 #ifdef CONFIG_SMP
-void send_cleanup_vector(struct irq_cfg *cfg)
+static void __send_cleanup_vector(struct irq_cfg *cfg)
 {
 	cpumask_var_t cleanup_mask;
 
@@ -513,6 +513,12 @@ void send_cleanup_vector(struct irq_cfg *cfg)
 	cfg->move_in_progress = 0;
 }
 
+void send_cleanup_vector(struct irq_cfg *cfg)
+{
+	if (cfg->move_in_progress)
+		__send_cleanup_vector(cfg);
+}
+
 asmlinkage __visible void smp_irq_move_cleanup_interrupt(void)
 {
 	unsigned vector, me;
@@ -583,7 +589,7 @@ static void __irq_complete_move(struct irq_cfg *cfg, unsigned vector)
 	me = smp_processor_id();
 
 	if (vector == cfg->vector && cpumask_test_cpu(me, cfg->domain))
-		send_cleanup_vector(cfg);
+		__send_cleanup_vector(cfg);
 }
 
 void irq_complete_move(struct irq_cfg *cfg)
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index 54af6e388a12..091b36ac44c4 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -63,8 +63,7 @@ uv_set_irq_affinity(struct irq_data *data, const struct cpumask *mask,
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret >= 0) {
 		uv_program_mmr(cfg, data->chip_data);
-		if (cfg->move_in_progress)
-			send_cleanup_vector(cfg);
+		send_cleanup_vector(cfg);
 	}
 
 	return ret;
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a5a17f50691c..a8901fbaee0e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4333,8 +4333,7 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	 * at the new destination. So, time to cleanup the previous
 	 * vector allocation.
 	 */
-	if (cfg->move_in_progress)
-		send_cleanup_vector(cfg);
+	send_cleanup_vector(cfg);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 8a71ef6af93c..55e72ce52fc4 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1003,8 +1003,7 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	 * at the new destination. So, time to cleanup the previous
 	 * vector allocation.
 	 */
-	if (cfg->move_in_progress)
-		send_cleanup_vector(cfg);
+	send_cleanup_vector(cfg);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
-- 
1.7.10.4
