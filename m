From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu: Disable interrupts whilst holding the cmdq
	lock
Date: Fri,  9 Sep 2016 14:50:14 +0100
Message-ID: <1473429014-17926-1-git-send-email-will.deacon@arm.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The cmdq lock is taken whenever we issue comments into the command queue,
which can occur in IRQ context (as a result if unmap) or in process
context (as a result of a threaded IRQ handler or device probe).

This can lead to a theoretical deadlock if the interrupt handler
performing the unmap hits whilst the lock is taken, so explicitly use
the {irqsave,irqrestore} spin_lock accessors for the cmdq lock.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c040e246bc59..5db6931c715c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -893,6 +893,7 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_ent *ent)
 {
 	u64 cmd[CMDQ_ENT_DWORDS];
+	unsigned long flags;
 	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
 	struct arm_smmu_queue *q = &smmu->cmdq.q;
 
@@ -902,7 +903,7 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 		return;
 	}
 
-	spin_lock(&smmu->cmdq.lock);
+	spin_lock_irqsave(&smmu->cmdq.lock, flags);
 	while (queue_insert_raw(q, cmd) == -ENOSPC) {
 		if (queue_poll_cons(q, false, wfe))
 			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
@@ -910,7 +911,7 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 
 	if (ent->opcode == CMDQ_OP_CMD_SYNC && queue_poll_cons(q, true, wfe))
 		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout\n");
-	spin_unlock(&smmu->cmdq.lock);
+	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
 }
 
 /* Context descriptor manipulation functions */
-- 
2.1.4
