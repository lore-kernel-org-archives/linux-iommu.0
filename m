From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [patch 45/52] iommu/vt-d: Reevaluate vector configuration on
	activate()
Date: Wed, 13 Sep 2017 23:29:47 +0200
Message-ID: <20170913213155.853028808@linutronix.de>
References: <20170913212902.530704676@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline;
	filename=iommu-vt-d--Reevaluate-vector-configuration-on-activate--.patch
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Chen Yu <yu.c.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Alok Kataria <akataria-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rui Zhang <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "K. Y. Srinivasan" <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

With the upcoming reservation/management scheme, early activation will
assign a special vector. The final activation at request_irq() assigns a
real vector, which needs to be updated in the tables.

Split out the reconfiguration code in set_affinity and use it for
reactivation.

Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
---
 drivers/iommu/intel_irq_remapping.c |   38 +++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1121,6 +1121,24 @@ struct irq_remap_ops intel_irq_remap_ops
 	.get_irq_domain		= intel_get_irq_domain,
 };
 
+static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
+{
+	struct intel_ir_data *ir_data = irqd->chip_data;
+	struct irte *irte = &ir_data->irte_entry;
+	struct irq_cfg *cfg = irqd_cfg(irqd);
+
+	/*
+	 * Atomically updates the IRTE with the new destination, vector
+	 * and flushes the interrupt entry cache.
+	 */
+	irte->vector = cfg->vector;
+	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
+
+	/* Update the hardware only if the interrupt is in remapped mode. */
+	if (!force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
+		modify_irte(&ir_data->irq_2_iommu, irte);
+}
+
 /*
  * Migrate the IO-APIC irq in the presence of intr-remapping.
  *
@@ -1139,27 +1157,15 @@ static int
 intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
 		      bool force)
 {
-	struct intel_ir_data *ir_data = data->chip_data;
-	struct irte *irte = &ir_data->irte_entry;
-	struct irq_cfg *cfg = irqd_cfg(data);
 	struct irq_data *parent = data->parent_data;
+	struct irq_cfg *cfg = irqd_cfg(data);
 	int ret;
 
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
 		return ret;
 
-	/*
-	 * Atomically updates the IRTE with the new destination, vector
-	 * and flushes the interrupt entry cache.
-	 */
-	irte->vector = cfg->vector;
-	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
-
-	/* Update the hardware only if the interrupt is in remapped mode. */
-	if (ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
-		modify_irte(&ir_data->irq_2_iommu, irte);
-
+	intel_ir_reconfigure_irte(data, false);
 	/*
 	 * After this point, all the interrupts will start arriving
 	 * at the new destination. So, time to cleanup the previous
@@ -1392,9 +1398,7 @@ static void intel_irq_remapping_free(str
 static int intel_irq_remapping_activate(struct irq_domain *domain,
 					struct irq_data *irq_data, bool early)
 {
-	struct intel_ir_data *data = irq_data->chip_data;
-
-	modify_irte(&data->irq_2_iommu, &data->irte_entry);
+	intel_ir_reconfigure_irte(irq_data, true);
 	return 0;
 }
 
