From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v10 06/10] iommu, x86: Avoid migrating VT-d posted interrupts
Date: Tue,  9 Jun 2015 13:20:33 +0800
Message-ID: <1433827237-3382-7-git-send-email-feng.wu@intel.com>
References: <1433827237-3382-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1433827237-3382-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When the interrupt is configured in posted mode, the destination of
the interrupt is set in the Posted-Interrupts Descriptor and the
migration of these interrupts happens during vCPU scheduling.

We still update the cached irte, which will be used when changing back
to remapping mode, but we avoid writing the table entry.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Acked-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 68bce0a..3bcb459 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1003,7 +1003,10 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	 */
 	irte->vector = cfg->vector;
 	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
-	modify_irte(&ir_data->irq_2_iommu, irte);
+
+	/* Update the hardware only if the interrupt is in remapped mode. */
+	if (ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
+		modify_irte(&ir_data->irq_2_iommu, irte);
 
 	/*
 	 * After this point, all the interrupts will start arriving
-- 
2.1.0
