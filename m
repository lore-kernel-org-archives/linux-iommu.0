Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE10C433E2
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 11:54:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E34220738
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 11:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E34220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8067C86470;
	Mon,  1 Jun 2020 11:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OwBVZNc_ocEz; Mon,  1 Jun 2020 11:54:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B7C5986444;
	Mon,  1 Jun 2020 11:54:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6076C0178;
	Mon,  1 Jun 2020 11:54:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2EC2C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 11:54:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C260E87D55
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 11:54:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AlR76PcxgNDV for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 11:54:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5E4D187D45
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 11:54:52 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 54D2BCBCB725E06F887B;
 Mon,  1 Jun 2020 19:54:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 1 Jun 2020 19:54:38 +0800
From: John Garry <john.garry@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH RFC 2/2] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
Date: Mon, 1 Jun 2020 19:50:48 +0800
Message-ID: <1591012248-37956-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1591012248-37956-1-git-send-email-john.garry@huawei.com>
References: <1591012248-37956-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: maz@kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

It has been shown that the cmpxchg() for finding space in the cmdq can
be a bottleneck:
- For more CPUs contenting the cmdq, cmpxchg() will fail more often.
- Since the software-maintained cons pointer is updated on the same 64b
  memory region, the chance of cmpxchg() failure increases again.

The cmpxchg() is removed as part of 2 related changes:
- If a CMD_SYNC is always issued for a batch, the cmdq can - in theory -
  never fill, since we always wait for a CMD_SYNC to be consumed. We must
  issue the CMD_SYNC so that a CPU will be always limited to issuing
  max_cmd_per_batch commands. Generally for DMA unmap ops, a CMD_SYNC
  is always issued anyway.
  As such, the cmdq locking is removed, and we only longer maintain cons
  in software (this needs to be revised for !MSI support).
- Update prod and cmdq owner in a single operation. For this, we count the
  prod and owner in separate regions in arm_smmu_ll_queue.prod.
  As with simple binary counting, once the prod+wrap fields overflow, they
  will zero. They will overflow into "owner" region, but this is ok as we
  have accounted for the extra value.
  As for the "owner", we now count this value, instead of setting a flag.
  Similar to before, once the owner has finished gathering, it will clear
  this mask. As such, a CPU declares itself as the "owner" when it reads
  zero for this field. This zeroing will also clear possible overflow in
  wrap+prod region.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 58 +++++++++++----------------------------------
 1 file changed, 14 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e607ab5a4cbd..d6c7d82f9cf8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1375,7 +1375,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				       u64 *cmds, int n, bool sync)
 {
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
-	u32 prod;
+	u32 prod, prodx;
 	unsigned long flags;
 	bool owner;
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
@@ -1383,33 +1383,21 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		.max_n_shift = cmdq->q.llq.max_n_shift,
 	}, head = llq;
 	int ret = 0;
+	u32 owner_val = 1 << cmdq->q.llq.owner_count_shift;
+	u32 prod_mask = GENMASK(cmdq->q.llq.max_n_shift, 0);
+	u32 owner_mask = GENMASK(30, cmdq->q.llq.owner_count_shift);
+
+	/* always issue a CMD_SYNC TODO: fixup callers for this */
+	sync = true;
 
 	/* 1. Allocate some space in the queue */
 	local_irq_save(flags);
-	llq.val = READ_ONCE(cmdq->q.llq.val);
-	do {
-		u64 old;
-
-		while (!queue_has_space(&llq, n + sync)) {
-			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
-				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
-			local_irq_save(flags);
-		}
 
-		head.cons = llq.cons;
-		head.prod = queue_inc_prod_n(&llq, n + sync) |
-					     CMDQ_PROD_OWNED_FLAG;
+	prodx = atomic_fetch_add(n + sync + owner_val, &cmdq->q.llq.atomic.prod);
 
-		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
-		if (old == llq.val)
-			break;
-
-		llq.val = old;
-	} while (1);
-	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
-	head.prod &= ~CMDQ_PROD_OWNED_FLAG;
-	llq.prod &= ~CMDQ_PROD_OWNED_FLAG;
+	owner = !(prodx & owner_mask);
+	llq.prod = prod_mask & prodx;
+	head.prod = queue_inc_prod_n(&llq, n + sync);
 
 	/*
 	 * 2. Write our commands into the queue As with simple binary counting, once the prod+wrap fields overflow, they
  will zero. They will overflow into "owner" region, but this is ok as we
  have accounted for the extra value.
@@ -1420,14 +1408,6 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		prod = queue_inc_prod_n(&llq, n);
 		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
 		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
-
-		/*
-		 * In order to determine completion of our CMD_SYNC, we must
-		 * ensure that the queue can't wrap twice without us noticing.
-		 * We achieve that by taking the cmdq lock as shared before
-		 * marking our slot as valid.
-		 */
-		arm_smmu_cmdq_shared_lock(cmdq);
 	}
 
 	/* 3. Mark our slots as valid, ensuring commands are visible first */
@@ -1439,11 +1419,10 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		/* a. Wait for previous owner to finish */
 		atomic_cond_read_relaxed(&cmdq->owner_prod, VAL == llq.prod);
 
-		/* b. Stop gathering work by clearing the owned flag */
-		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
+		/* b. Stop gathering work by clearing the owned mask */
+		prod = atomic_fetch_andnot_relaxed(owner_mask,
 						   &cmdq->q.llq.atomic.prod);
-		prod &= ~CMDQ_PROD_OWNED_FLAG;
-
+		prod &= prod_mask;
 		/*
 		 * c. Wait for any gathered work to be written to the queue.
 		 * Note that we read our own entries so that we have the control
@@ -1476,15 +1455,6 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 					    readl_relaxed(cmdq->q.prod_reg),
 					    readl_relaxed(cmdq->q.cons_reg));
 		}
-
-		/*
-		 * Try to unlock the cmq lock. This will fail if we're the last
-		 * reader, in which case we can safely update cmdq->q.llq.cons
-		 */
-		if (!arm_smmu_cmdq_shared_tryunlock(cmdq)) {
-			WRITE_ONCE(cmdq->q.llq.cons, llq.cons);
-			arm_smmu_cmdq_shared_unlock(cmdq);
-		}
 	}
 
 	local_irq_restore(flags);
-- 
2.16.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
