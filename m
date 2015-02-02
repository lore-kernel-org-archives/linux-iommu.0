From: Feng Wu <feng.wu@intel.com>
Subject: [v4 4/8] iommu, x86: No need to migrating irq for VT-d Posted-Interrupts
Date: Mon,  2 Feb 2015 16:01:50 +0800
Message-ID: <1422864114-19324-5-git-send-email-feng.wu@intel.com>
References: <1422864114-19324-1-git-send-email-feng.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422864114-19324-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dwmw2@infradead.org, joro@8bytes.or
Cc: jiang.liu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

We don't need to migrate the irqs for VT-d Posted-Interrupts here.
When 'pst' is set in IRTE, the associated irq will be posted to
guests instead of interrupt remapping. The destination of the
interrupt is set in Posted-Interrupts Descriptor, and the migration
happens during vCPU scheduling.

However, we still update the cached irte here, which can be used
when changing back to remapping mode.

Signed-off-by: Feng Wu <feng.wu@intel.com>
Reviewed-by: Jiang Liu <jiang.liu@linux.intel.com>
Acked-by: David Woodhouse <David.Woodhouse@intel.com>
---
 drivers/iommu/intel_irq_remapping.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 48c2051..ab9057a 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -977,6 +977,7 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
 {
 	struct intel_ir_data *ir_data = data->chip_data;
 	struct irte *irte = &ir_data->irte_entry;
+	struct irte_pi *irte_pi = (struct irte_pi *)irte;
 	struct irq_cfg *cfg = irqd_cfg(data);
 	struct irq_data *parent = data->parent_data;
 	int ret;
@@ -991,7 +992,10 @@ intel_ir_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	 */
 	irte->vector = cfg->vector;
 	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
-	modify_irte(&ir_data->irq_2_iommu, irte);
+
+	/* We don't need to modify irte if the interrupt is for posting. */
+	if (irte_pi->pst != 1)
+		modify_irte(&ir_data->irq_2_iommu, irte);
 
 	/*
 	 * After this point, all the interrupts will start arriving
-- 
1.7.1
