From: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Don't store SIRTP request
Date: Mon, 11 Aug 2014 13:13:25 +0200
Message-ID: <53E8A555.5010905@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Don't store the SIRTP request bit in the register state. It will
otherwise become sticky and could request an Interrupt Remap Table
Pointer update on each command register write.

Found while starting to emulate IR in QEMU, not by observing problems on
real hardware.

Signed-off-by: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/intel_irq_remapping.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 0df41f6..a872874 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -438,8 +438,7 @@ static void iommu_set_irq_remapping(struct intel_iommu *iommu, int mode)
 		    (addr) | IR_X2APIC_MODE(mode) | INTR_REMAP_TABLE_REG_SIZE);
 
 	/* Set interrupt-remapping table pointer */
-	iommu->gcmd |= DMA_GCMD_SIRTP;
-	writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
+	writel(iommu->gcmd | DMA_GCMD_SIRTP, iommu->reg + DMAR_GCMD_REG);
 
 	IOMMU_WAIT_OP(iommu, DMAR_GSTS_REG,
 		      readl, (sts & DMA_GSTS_IRTPS), sts);
-- 
1.8.1.1.298.ge7eed54
