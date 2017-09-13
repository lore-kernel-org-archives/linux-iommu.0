From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [patch 46/52] iommu/amd: Reevaluate vector configuration on activate()
Date: Wed, 13 Sep 2017 23:29:48 +0200
Message-ID: <20170913213155.944883733@linutronix.de>
References: <20170913212902.530704676@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline;
	filename=iommu-amd--Reevaluate-vector-configuration-on-activate--.patch
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
 drivers/iommu/amd_iommu.c |   39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4170,16 +4170,25 @@ static void irq_remapping_free(struct ir
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 }
 
+static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
+			       struct amd_ir_data *ir_data,
+			       struct irq_2_irte *irte_info,
+			       struct irq_cfg *cfg);
+
 static int irq_remapping_activate(struct irq_domain *domain,
 				  struct irq_data *irq_data, bool early)
 {
 	struct amd_ir_data *data = irq_data->chip_data;
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
 	struct amd_iommu *iommu = amd_iommu_rlookup_table[irte_info->devid];
+	struct irq_cfg *cfg = irqd_cfg(irq_data);
 
-	if (iommu)
-		iommu->irte_ops->activate(data->entry, irte_info->devid,
-					  irte_info->index);
+	if (!iommu)
+		return 0;
+
+	iommu->irte_ops->activate(data->entry, irte_info->devid,
+				  irte_info->index);
+	amd_ir_update_irte(irq_data, iommu, data, irte_info, cfg);
 	return 0;
 }
 
@@ -4267,6 +4276,22 @@ static int amd_ir_set_vcpu_affinity(stru
 	return modify_irte_ga(irte_info->devid, irte_info->index, irte, ir_data);
 }
 
+
+static void amd_ir_update_irte(struct irq_data *irqd, struct amd_iommu *iommu,
+			       struct amd_ir_data *ir_data,
+			       struct irq_2_irte *irte_info,
+			       struct irq_cfg *cfg)
+{
+
+	/*
+	 * Atomically updates the IRTE with the new destination, vector
+	 * and flushes the interrupt entry cache.
+	 */
+	iommu->irte_ops->set_affinity(ir_data->entry, irte_info->devid,
+				      irte_info->index, cfg->vector,
+				      cfg->dest_apicid);
+}
+
 static int amd_ir_set_affinity(struct irq_data *data,
 			       const struct cpumask *mask, bool force)
 {
@@ -4284,13 +4309,7 @@ static int amd_ir_set_affinity(struct ir
 	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
 		return ret;
 
-	/*
-	 * Atomically updates the IRTE with the new destination, vector
-	 * and flushes the interrupt entry cache.
-	 */
-	iommu->irte_ops->set_affinity(ir_data->entry, irte_info->devid,
-			    irte_info->index, cfg->vector, cfg->dest_apicid);
-
+	amd_ir_update_irte(data, iommu, ir_data, irte_info, cfg);
 	/*
 	 * After this point, all the interrupts will start arriving
 	 * at the new destination. So, time to cleanup the previous
