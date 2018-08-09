From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/2] iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
Date: Thu, 9 Aug 2018 19:48:52 +0800
Message-ID: <1533815333-17320-2-git-send-email-thunder.leizhen@huawei.com>
References: <1533815333-17320-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533815333-17320-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>
List-Id: iommu@lists.linux-foundation.org

The condition "(int)(VAL - sync_idx) >= 0" to break loop in function
__arm_smmu_sync_poll_msi requires that sync_idx must be increased
monotonously according to the sequence of the CMDs in the cmdq.

But ".msidata = atomic_inc_return_relaxed(&smmu->sync_nr)" is not protected
by spinlock, so the following scenarios may appear:
cpu0			cpu1
msidata=0
			msidata=1
			insert cmd1
insert cmd0
			smmu execute cmd1
smmu execute cmd0
			poll timeout, because msidata=1 is overridden by
			cmd0, that means VAL=0, sync_idx=1.

This is not a functional problem, just make the caller wait for a long
time until TIMEOUT. It's rare to happen, because any other CMD_SYNCs
during the waiting period will break it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1d64710..d17a9a7 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -566,7 +566,7 @@ struct arm_smmu_device {

 	int				gerr_irq;
 	int				combined_irq;
-	atomic_t			sync_nr;
+	u32				sync_nr;

 	unsigned long			ias; /* IPA */
 	unsigned long			oas; /* PA */
@@ -947,14 +947,13 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
 	struct arm_smmu_cmdq_ent ent = {
 		.opcode = CMDQ_OP_CMD_SYNC,
 		.sync	= {
-			.msidata = atomic_inc_return_relaxed(&smmu->sync_nr),
 			.msiaddr = virt_to_phys(&smmu->sync_count),
 		},
 	};

-	arm_smmu_cmdq_build_cmd(cmd, &ent);
-
 	spin_lock_irqsave(&smmu->cmdq.lock, flags);
+	ent.sync.msidata = ++smmu->sync_nr;
+	arm_smmu_cmdq_build_cmd(cmd, &ent);
 	arm_smmu_cmdq_insert_cmd(smmu, cmd);
 	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);

@@ -2179,7 +2178,6 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 {
 	int ret;

-	atomic_set(&smmu->sync_nr, 0);
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
 		return ret;
--
1.8.3
