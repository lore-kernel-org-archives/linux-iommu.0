From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 8/8] iommu/arm-smmu: suppress fault information about
	CMD_PREFETCH_CONFIG execution
Date: Fri, 26 Jun 2015 16:33:04 +0800
Message-ID: <1435307584-9812-9-git-send-email-thunder.leizhen@huawei.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1435307584-9812-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Some broken SMMUv3 devices treat CMD_PREFETCH_CONFIG as illegal command,
it's ugly to print error information. CMD_PREFETCH_CONFIG is just used to
prefetch the configuration for a specified StreamID, without this command
will not impact SMMUv3 function.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d799feb..3971aef 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -813,6 +813,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	};

 	int i;
+	u32 opcode;
 	u64 cmd[CMDQ_ENT_DWORDS];
 	struct arm_smmu_queue *q = &smmu->cmdq.q;
 	u32 cons = readl_relaxed(q->cons_reg);
@@ -821,15 +822,14 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 		.opcode = CMDQ_OP_CMD_SYNC,
 	};

-	dev_err(smmu->dev, "CMDQ error (cons 0x%08x): %s\n", cons,
-		cerror_str[idx]);
-
 	switch (idx) {
 	case CMDQ_ERR_CERROR_ILL_IDX:
 		break;
 	case CMDQ_ERR_CERROR_ABT_IDX:
-		dev_err(smmu->dev, "retrying command fetch\n");
 	case CMDQ_ERR_CERROR_NONE_IDX:
+		dev_err(smmu->dev, "CMDQ error (cons 0x%08x): %s\n", cons,
+			cerror_str[idx]);
+		dev_err(smmu->dev, "retrying command execution\n");
 		return;
 	}

@@ -838,10 +838,20 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	 * not to touch any of the shadow cmdq state.
 	 */
 	queue_read(cmd, Q_ENT(q, idx), q->ent_dwords);
+
+	/*
+	 * Some broken SMMUv3 devices treat CMD_PREFETCH_CONFIG as illegal
+	 * command, it's ugly to print error information.
+	 */
+	opcode = (cmd[0] >> CMDQ_0_OP_SHIFT) & CMDQ_0_OP_MASK;
+	if (opcode == CMDQ_OP_PREFETCH_CFG)
+		goto skip_error_command;
+
 	dev_err(smmu->dev, "skipping command in error state:\n");
 	for (i = 0; i < ARRAY_SIZE(cmd); ++i)
 		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);

+skip_error_command:
 	/* Convert the erroneous command into a CMD_SYNC */
 	if (arm_smmu_cmdq_build_cmd(cmd, &cmd_sync)) {
 		dev_err(smmu->dev, "failed to convert to CMD_SYNC\n");
--
1.8.0
