From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v10 05/10] iommu, x86: Save the mode (posted or remapped) of an IRTE
Date: Tue,  9 Jun 2015 13:20:32 +0800
Message-ID: <1433827237-3382-6-git-send-email-feng.wu@intel.com>
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

Add a new field to struct irq_2_iommu, which captures whether the
associated IRTE is in posted mode or remapped mode. We update this
field when the IRTE is written into the table.

Suggested-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Acked-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index a643eec..68bce0a 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -18,6 +18,11 @@
 
 #include "irq_remapping.h"
 
+enum irq_mode {
+	IRQ_REMAPPING,
+	IRQ_POSTING,
+};
+
 struct ioapic_scope {
 	struct intel_iommu *iommu;
 	unsigned int id;
@@ -37,6 +42,7 @@ struct irq_2_iommu {
 	u16 irte_index;
 	u16 sub_handle;
 	u8  irte_mask;
+	enum irq_mode mode;
 };
 
 struct intel_ir_data {
@@ -104,6 +110,7 @@ static int alloc_irte(struct intel_iommu *iommu, int irq,
 		irq_iommu->irte_index =  index;
 		irq_iommu->sub_handle = 0;
 		irq_iommu->irte_mask = mask;
+		irq_iommu->mode = IRQ_REMAPPING;
 	}
 	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 
@@ -144,6 +151,9 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
 	__iommu_flush_cache(iommu, irte, sizeof(*irte));
 
 	rc = qi_flush_iec(iommu, index, 0);
+
+	/* Update iommu mode according to the IRTE mode */
+	irq_iommu->mode = irte->pst ? IRQ_POSTING : IRQ_REMAPPING;
 	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 
 	return rc;
-- 
2.1.0
