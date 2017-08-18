From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/3] iommu/arm-smmu-v3: Forget about cmdq-sync interrupt
Date: Fri, 18 Aug 2017 18:33:03 +0100
Message-ID: <571d93ceaee419b56885fa7b41e4bf04b46c5891.1503075486.git.robin.murphy@arm.com>
References: <cover.1503075486.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1503075486.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The cmdq-sync interrupt is never going to be particularly useful, since
for stage 1 DMA at least we'll often need to wait for sync completion
within someone else's IRQ handler, thus have to implement polling
anyway. Beyond that, the overhead of taking an interrupt, then still
having to grovel around in the queue to figure out *which* sync command
completed, doesn't seem much more attractive than simple polling either.

Furthermore, if an implementation both has wired interrupts and supports
MSIs, then we don't want to be taking the IRQ unnecessarily if we're
using the MSI write to update memory. Let's just make life simpler by
not even bothering to claim it in the first place.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index bbcb33e8f55c..6fbc2e59f7c1 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1294,12 +1294,6 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t arm_smmu_cmdq_sync_handler(int irq, void *dev)
-{
-	/* We don't actually use CMD_SYNC interrupts for anything */
-	return IRQ_HANDLED;
-}
-
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
@@ -1332,10 +1326,8 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	if (active & GERROR_MSI_EVTQ_ABT_ERR)
 		dev_warn(smmu->dev, "EVTQ MSI write aborted\n");
 
-	if (active & GERROR_MSI_CMDQ_ABT_ERR) {
+	if (active & GERROR_MSI_CMDQ_ABT_ERR)
 		dev_warn(smmu->dev, "CMDQ MSI write aborted\n");
-		arm_smmu_cmdq_sync_handler(irq, smmu->dev);
-	}
 
 	if (active & GERROR_PRIQ_ABT_ERR)
 		dev_err(smmu->dev, "PRIQ write aborted -- events may have been lost\n");
@@ -1364,7 +1356,6 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 {
 	arm_smmu_gerror_handler(irq, dev);
-	arm_smmu_cmdq_sync_handler(irq, dev);
 	return IRQ_WAKE_THREAD;
 }
 
@@ -2281,15 +2272,6 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 			dev_warn(smmu->dev, "failed to enable evtq irq\n");
 	}
 
-	irq = smmu->cmdq.q.irq;
-	if (irq) {
-		ret = devm_request_irq(smmu->dev, irq,
-				       arm_smmu_cmdq_sync_handler, 0,
-				       "arm-smmu-v3-cmdq-sync", smmu);
-		if (ret < 0)
-			dev_warn(smmu->dev, "failed to enable cmdq-sync irq\n");
-	}
-
 	irq = smmu->gerr_irq;
 	if (irq) {
 		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
@@ -2797,10 +2779,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		if (irq > 0)
 			smmu->priq.q.irq = irq;
 
-		irq = platform_get_irq_byname(pdev, "cmdq-sync");
-		if (irq > 0)
-			smmu->cmdq.q.irq = irq;
-
 		irq = platform_get_irq_byname(pdev, "gerror");
 		if (irq > 0)
 			smmu->gerr_irq = irq;
-- 
2.13.4.dirty
