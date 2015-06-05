From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 13/17] iommu/vt-d: Split up iommu_set_irq_remapping
Date: Fri,  5 Jun 2015 16:10:59 +0200
Message-ID: <1433513463-19128-14-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Split out the part that enables irq remapping into the new
function iommu_enable_irq_remapping. This allows to program
the irq remapping table to the hardware without enabling irq
remapping.

Tested-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 35d73f6..c3d1e63 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -440,9 +440,9 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 
 static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
 {
+	unsigned long flags;
 	u64 addr;
 	u32 sts;
-	unsigned long flags;
 
 	addr = virt_to_phys((void *)iommu->ir_table->base);
 
@@ -463,6 +463,12 @@ static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
 	 * interrupt-remapping.
 	 */
 	qi_global_iec(iommu);
+}
+
+static void iommu_enable_irq_remapping(struct intel_iommu *iommu)
+{
+	unsigned long flags;
+	u32 sts;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 
@@ -700,8 +706,10 @@ static int __init intel_enable_irq_remapping(void)
 				iommu->ir_table->base_old_phys,
 				INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte));
 			__iommu_load_old_irte(iommu);
-		} else
+		} else {
 			iommu_set_irq_remapping(iommu, eim_mode);
+			iommu_enable_irq_remapping(iommu);
+		}
 
 		setup = true;
 	}
@@ -939,6 +947,7 @@ static int reenable_irq_remapping(int eim)
 
 		/* Set up interrupt remapping for iommu.*/
 		iommu_set_irq_remapping(iommu, eim);
+		iommu_enable_irq_remapping(iommu);
 		setup = true;
 	}
 
@@ -1257,6 +1266,7 @@ static int dmar_ir_add(struct dmar_drhd_unit *dmaru, struct intel_iommu *iommu)
 		ir_remove_ioapic_hpet_scope(iommu);
 	} else {
 		iommu_set_irq_remapping(iommu, eim);
+		iommu_enable_irq_remapping(iommu);
 	}
 
 	return ret;
-- 
1.9.1
