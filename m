From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 v3 33/38] x86,
	irq: Move check of cfg->move_in_progress into send_cleanup_vector()
Date: Sun,  9 Nov 2014 02:13:33 +0800
Message-ID: <1415470418-10874-34-git-send-email-jiang.liu@linux.intel.com>
References: <1415470418-10874-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415470418-10874-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Move check of cfg->move_in_progress into send_cleanup_vector() to
prepare for simplifying struct irq_cfg.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 arch/x86/kernel/apic/vector.c       |   10 ++++++++--
 arch/x86/platform/uv/uv_irq.c       |    3 +--
 drivers/iommu/amd_iommu.c           |    3 +--
 drivers/iommu/intel_irq_remapping.c |    3 +--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index d56b4611c75a..76c82170f04f 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -495,7 +495,7 @@ static struct irq_chip vector_chip = {
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
index 854e610a085f..66d531e71c9a 100644
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
index 236cc7ee0b85..02cb3637eb43 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4331,8 +4331,7 @@ static int amd_ir_set_affinity(struct irq_data *data,
 	 * at the new destination. So, time to cleanup the previous
 	 * vector allocation.
 	 */
-	if (cfg->move_in_progress)
-		send_cleanup_vector(cfg);
+	send_cleanup_vector(cfg);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 5bd9e6570099..d3bfe3528504 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -947,8 +947,7 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
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
