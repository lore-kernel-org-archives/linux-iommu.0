From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 16/19] iommu/vt-d: Set IRTA in intel_setup_irq_remapping
Date: Sat, 13 Jun 2015 08:47:24 +0200
Message-ID: <1434178047-17809-17-git-send-email-joro@8bytes.org>
References: <1434178047-17809-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434178047-17809-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, jroedel-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This way we can give the hardware the new IR table right
after it has been allocated and initialized.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index f1711836..8497028 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -428,9 +428,9 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 
 static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
 {
+	unsigned long flags;
 	u64 addr;
 	u32 sts;
-	unsigned long flags;
 
 	addr = virt_to_phys((void *)iommu->ir_table->base);
 
@@ -447,10 +447,16 @@ static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
 
 	/*
-	 * global invalidation of interrupt entry cache before enabling
-	 * interrupt-remapping.
+	 * Global invalidation of interrupt entry cache to make sure the
+	 * hardware uses the new irq remapping table.
 	 */
 	qi_global_iec(iommu);
+}
+
+static void iommu_enable_irq_remapping(struct intel_iommu *iommu)
+{
+	unsigned long flags;
+	u32 sts;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
@@ -525,6 +531,8 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 		}
 	}
 
+	iommu_set_irq_remapping(iommu, eim_mode);
+
 	return 0;
 
 out_free_bitmap:
@@ -689,7 +697,7 @@ static int __init intel_enable_irq_remapping(void)
 	 * Setup Interrupt-remapping for all the DRHD's now.
 	 */
 	for_each_iommu(iommu, drhd) {
-		iommu_set_irq_remapping(iommu, eim_mode);
+		iommu_enable_irq_remapping(iommu);
 		setup = true;
 	}
 
@@ -926,6 +934,7 @@ static int reenable_irq_remapping(int eim)
 
 		/* Set up interrupt remapping for iommu.*/
 		iommu_set_irq_remapping(iommu, eim);
+		iommu_enable_irq_remapping(iommu);
 		setup = true;
 	}
 
@@ -1241,7 +1250,7 @@ static int dmar_ir_add(struct dmar_drhd_unit *dmaru, struct intel_iommu *iommu)
 		intel_teardown_irq_remapping(iommu);
 		ir_remove_ioapic_hpet_scope(iommu);
 	} else {
-		iommu_set_irq_remapping(iommu, eim);
+		iommu_enable_irq_remapping(iommu);
 	}
 
 	return ret;
-- 
1.9.1
