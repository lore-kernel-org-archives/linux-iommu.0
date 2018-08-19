From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 2/2] iommu/arm-smmu-v3: avoid redundant CMD_SYNCs if possible
Date: Sun, 19 Aug 2018 15:51:11 +0800
Message-ID: <1534665071-7976-3-git-send-email-thunder.leizhen@huawei.com>
References: <1534665071-7976-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534665071-7976-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, John Garry <john.garry@huawei.com>
List-Id: iommu@lists.linux-foundation.org

More than two CMD_SYNCs maybe adjacent in the command queue, and the first
one has done what others want to do. Drop the redundant CMD_SYNCs can
improve IO performance especially under the pressure scene.

I did the statistics in my test environment, the number of CMD_SYNCs can
be reduced about 1/3. See below:
CMD_SYNCs reduced:	19542181
CMD_SYNCs total:	58098548	(include reduced)
CMDs total:		116197099	(TLBI:SYNC about 1:1)

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ac6d6df..f3a56e1 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -567,6 +567,7 @@ struct arm_smmu_device {
 	int				gerr_irq;
 	int				combined_irq;
 	u32				sync_nr;
+	u8				prev_cmd_opcode;

 	unsigned long			ias; /* IPA */
 	unsigned long			oas; /* PA */
@@ -786,6 +787,11 @@ void arm_smmu_cmdq_build_sync_msi_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	cmd[1]  = ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
 }

+static inline u8 arm_smmu_cmd_opcode_get(u64 *cmd)
+{
+	return cmd[0] & CMDQ_0_OP;
+}
+
 /* High-level queue accessors */
 static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 {
@@ -906,6 +912,8 @@ static void arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd)
 	struct arm_smmu_queue *q = &smmu->cmdq.q;
 	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);

+	smmu->prev_cmd_opcode = arm_smmu_cmd_opcode_get(cmd);
+
 	while (queue_insert_raw(q, cmd) == -ENOSPC) {
 		if (queue_poll_cons(q, false, wfe))
 			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
@@ -958,9 +966,17 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
 	};

 	spin_lock_irqsave(&smmu->cmdq.lock, flags);
-	ent.sync.msidata = ++smmu->sync_nr;
-	arm_smmu_cmdq_build_sync_msi_cmd(cmd, &ent);
-	arm_smmu_cmdq_insert_cmd(smmu, cmd);
+	if (smmu->prev_cmd_opcode == CMDQ_OP_CMD_SYNC) {
+		/*
+		 * Previous command is CMD_SYNC also, there is no need to add
+		 * one more. Just poll it.
+		 */
+		ent.sync.msidata = smmu->sync_nr;
+	} else {
+		ent.sync.msidata = ++smmu->sync_nr;
+		arm_smmu_cmdq_build_sync_msi_cmd(cmd, &ent);
+		arm_smmu_cmdq_insert_cmd(smmu, cmd);
+	}
 	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);

 	return __arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
--
1.8.3
