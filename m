From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/3] iommu/arm-smmu-v3: Specialise CMD_SYNC handling
Date: Fri, 18 Aug 2017 18:33:02 +0100
Message-ID: <321d82b499b6002df2d614a0754dfe32d6c55f1f.1503075486.git.robin.murphy@arm.com>
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

CMD_SYNC already has a bit of special treatment here and there, but as
we're about to extend it with more functionality for completing outside
the CMDQ lock, things are going to get rather messy if we keep trying to
cram everything into a single generic command interface. Instead, let's
break out the issuing of CMD_SYNC into its own specific helper where
upcoming changes will have room to breathe.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 46 +++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e67ba6c40faf..bbcb33e8f55c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -936,13 +936,23 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
 
+static void arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd,
+				     bool wfe)
+{
+	struct arm_smmu_queue *q = &smmu->cmdq.q;
+
+	while (queue_insert_raw(q, cmd) == -ENOSPC) {
+		if (queue_poll_cons(q, false, wfe))
+			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
+	}
+}
+
 static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_ent *ent)
 {
 	u64 cmd[CMDQ_ENT_DWORDS];
 	unsigned long flags;
 	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
-	struct arm_smmu_queue *q = &smmu->cmdq.q;
 
 	if (arm_smmu_cmdq_build_cmd(cmd, ent)) {
 		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
@@ -951,12 +961,22 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	}
 
 	spin_lock_irqsave(&smmu->cmdq.lock, flags);
-	while (queue_insert_raw(q, cmd) == -ENOSPC) {
-		if (queue_poll_cons(q, false, wfe))
-			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
-	}
+	arm_smmu_cmdq_insert_cmd(smmu, cmd, wfe);
+	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
+}
 
-	if (ent->opcode == CMDQ_OP_CMD_SYNC && queue_poll_cons(q, true, wfe))
+static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
+{
+	u64 cmd[CMDQ_ENT_DWORDS];
+	unsigned long flags;
+	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
+	struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
+
+	arm_smmu_cmdq_build_cmd(cmd, ent);
+
+	spin_lock_irqsave(&smmu->cmdq.lock, flags);
+	arm_smmu_cmdq_insert_cmd(smmu, cmd, wfe);
+	if (queue_poll_cons(&smmu->cmdq.q, true, wfe))
 		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout\n");
 	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
 }
@@ -1029,8 +1049,7 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	};
 
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	cmd.opcode = CMDQ_OP_CMD_SYNC;
-	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	arm_smmu_cmdq_issue_sync(smmu);
 }
 
 static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
@@ -1352,10 +1371,7 @@ static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 /* IO_PGTABLE API */
 static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 {
-	struct arm_smmu_cmdq_ent cmd;
-
-	cmd.opcode = CMDQ_OP_CMD_SYNC;
-	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	arm_smmu_cmdq_issue_sync(smmu);
 }
 
 static void arm_smmu_tlb_sync(void *cookie)
@@ -2399,8 +2415,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	/* Invalidate any cached configuration */
 	cmd.opcode = CMDQ_OP_CFGI_ALL;
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	cmd.opcode = CMDQ_OP_CMD_SYNC;
-	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	arm_smmu_cmdq_issue_sync(smmu);
 
 	/* Invalidate any stale TLB entries */
 	if (smmu->features & ARM_SMMU_FEAT_HYP) {
@@ -2410,8 +2425,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 	cmd.opcode = CMDQ_OP_TLBI_NSNH_ALL;
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	cmd.opcode = CMDQ_OP_CMD_SYNC;
-	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	arm_smmu_cmdq_issue_sync(smmu);
 
 	/* Event queue */
 	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-- 
2.13.4.dirty
