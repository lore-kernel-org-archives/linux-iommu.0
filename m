From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Ratelimit fault handler
Date: Tue, 15 Mar 2016 10:35:20 -0600
Message-ID: <20160315163503.2875.49980.stgit@gimli.home>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Fault rates can easily overwhelm the console and make the system
unresponsive.  Ratelimit to allow an opportunity for maintenance.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/dmar.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 8ffd756..628987e 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1579,19 +1579,20 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
 	if (fault_type == INTR_REMAP)
-		pr_err("INTR-REMAP: Request device [[%02x:%02x.%d] "
-		       "fault index %llx\n"
-			"INTR-REMAP:[fault reason %02d] %s\n",
-			(source_id >> 8), PCI_SLOT(source_id & 0xFF),
-			PCI_FUNC(source_id & 0xFF), addr >> 48,
-			fault_reason, reason);
+		pr_err_ratelimited("INTR-REMAP: Request device [[%02x:%02x.%d] "
+				   "fault index %llx\n"
+				   "INTR-REMAP:[fault reason %02d] %s\n",
+				   (source_id >> 8), PCI_SLOT(source_id & 0xFF),
+				   PCI_FUNC(source_id & 0xFF), addr >> 48,
+				   fault_reason, reason);
 	else
-		pr_err("DMAR:[%s] Request device [%02x:%02x.%d] "
-		       "fault addr %llx \n"
-		       "DMAR:[fault reason %02d] %s\n",
-		       (type ? "DMA Read" : "DMA Write"),
-		       (source_id >> 8), PCI_SLOT(source_id & 0xFF),
-		       PCI_FUNC(source_id & 0xFF), addr, fault_reason, reason);
+		pr_err_ratelimited("DMAR:[%s] Request device [%02x:%02x.%d] "
+				   "fault addr %llx \n"
+				   "DMAR:[fault reason %02d] %s\n",
+				   (type ? "DMA Read" : "DMA Write"),
+				   (source_id >> 8), PCI_SLOT(source_id & 0xFF),
+				   PCI_FUNC(source_id & 0xFF), addr,
+				   fault_reason, reason);
 	return 0;
 }
 
@@ -1606,7 +1607,8 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	fault_status = readl(iommu->reg + DMAR_FSTS_REG);
 	if (fault_status)
-		pr_err("DRHD: handling fault status reg %x\n", fault_status);
+		pr_err_ratelimited("DRHD: handling fault status reg %x\n",
+				   fault_status);
 
 	/* TBD: ignore advanced fault log currently */
 	if (!(fault_status & DMA_FSTS_PPF))
