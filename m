From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/4] iommu/arm-smmu: Fix CMDQ error handling
Date: Thu, 18 Aug 2016 14:05:40 +0100
Message-ID: <1471525542-14969-3-git-send-email-will.deacon@arm.com>
References: <1471525542-14969-1-git-send-email-will.deacon@arm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1471525542-14969-1-git-send-email-will.deacon@arm.com>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com, joro@8bytes.org, Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

In the unlikely event of a global command queue error, the ARM SMMUv3
driver attempts to convert the problematic command into a CMD_SYNC and
resume the command queue. Unfortunately, this code is pretty badly
broken:

  1. It uses the index into the error string table as the CMDQ index,
     so we probably read the wrong entry out of the queue

  2. The arguments to queue_write are the wrong way round, so we end up
     writing from the queue onto the stack.

These happily cancel out, so the kernel is likely to stay alive, but
the command queue will probably fault again when we resume.

This patch fixes the error handling code to use the correct queue index
and write back the CMD_SYNC to the faulting entry.

Cc: <stable@vger.kernel.org>
Reported-by: Diwakar Subraveti <Diwakar.Subraveti@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ce801170d5f2..330623f8e344 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -879,7 +879,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	 * We may have concurrent producers, so we need to be careful
 	 * not to touch any of the shadow cmdq state.
 	 */
-	queue_read(cmd, Q_ENT(q, idx), q->ent_dwords);
+	queue_read(cmd, Q_ENT(q, cons), q->ent_dwords);
 	dev_err(smmu->dev, "skipping command in error state:\n");
 	for (i = 0; i < ARRAY_SIZE(cmd); ++i)
 		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
@@ -890,7 +890,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 		return;
 	}
 
-	queue_write(cmd, Q_ENT(q, idx), q->ent_dwords);
+	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
 
 static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
-- 
2.1.4
