Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00163C433DF
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 17:33:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3EC2075A
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 17:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3EC2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 924B6893B7;
	Mon, 22 Jun 2020 17:33:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KmcffkgyQrl1; Mon, 22 Jun 2020 17:33:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C83D88918B;
	Mon, 22 Jun 2020 17:33:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAAF0C0891;
	Mon, 22 Jun 2020 17:33:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D847DC016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 17:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C3A7C8919B
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 17:33:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V6eaCutTTDLi for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 17:32:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4C6098918B
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 17:32:58 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 9675D3F52B4B178862C3;
 Tue, 23 Jun 2020 01:32:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 23 Jun 2020 01:32:43 +0800
From: John Garry <john.garry@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH 3/4] iommu/arm-smmu-v3: Always issue a CMD_SYNC per batch
Date: Tue, 23 Jun 2020 01:28:39 +0800
Message-ID: <1592846920-45338-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: trivial@kernel.org, maz@kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

To ensure that a CPU does not send more than a permitted amount of commands
to the cmdq, ensure that each batch includes a CMD_SYNC. When issuing a
CMD_SYNC, we always wait for the consumption of its batch of commands - as
such, we guarantee that any CPU will not issue more than its permitted
amount.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 86 +++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4e9677b066f1..45a39ccaf455 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1373,11 +1373,15 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
  * - Command insertion is totally ordered, so if two CPUs each race to
  *   insert their own list of commands then all of the commands from one
  *   CPU will appear before any of the commands from the other CPU.
+ *
+ * - A CMD_SYNC is always inserted, ensuring that any CPU does not issue
+ *   more than the permitted amount commands at once.
  */
 static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
-				       u64 *cmds, int n, bool sync)
+				       u64 *cmds, int n)
 {
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
+	const int sync = 1;
 	u32 prod;
 	unsigned long flags;
 	bool owner;
@@ -1419,19 +1423,17 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	 * Dependency ordering from the cmpxchg() loop above.
 	 */
 	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
-	if (sync) {
-		prod = queue_inc_prod_n(&llq, n);
-		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
-		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
 
-		/*
-		 * In order to determine completion of our CMD_SYNC, we must
-		 * ensure that the queue can't wrap twice without us noticing.
-		 * We achieve that by taking the cmdq lock as shared before
-		 * marking our slot as valid.
-		 */
-		arm_smmu_cmdq_shared_lock(cmdq);
-	}
+	prod = queue_inc_prod_n(&llq, n);
+	arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
+	queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
+
+	/*
+	 * In order to determine completion of our CMD_SYNC, we must ensure
+	 * that the queue can't wrap twice without us noticing. We achieve that
+	 * by taking the cmdq lock as shared before marking our slot as valid.
+	 */
+	arm_smmu_cmdq_shared_lock(cmdq);
 
 	/* 3. Mark our slots as valid, ensuring commands are visible first */
 	dma_wmb();
@@ -1468,26 +1470,21 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		atomic_set_release(&cmdq->owner_prod, prod);
 	}
 
-	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
-	if (sync) {
-		llq.prod = queue_inc_prod_n(&llq, n);
-		ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
-		if (ret) {
-			dev_err_ratelimited(smmu->dev,
-					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
-					    llq.prod,
-					    readl_relaxed(cmdq->q.prod_reg),
-					    readl_relaxed(cmdq->q.cons_reg));
-		}
+	/* 5. Since we always insert a CMD_SYNC, we must wait for it to complete */
+	llq.prod = queue_inc_prod_n(&llq, n);
+	ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
+	if (ret)
+		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
+				    llq.prod, readl_relaxed(cmdq->q.prod_reg),
+				    readl_relaxed(cmdq->q.cons_reg));
 
-		/*
-		 * Try to unlock the cmdq lock. This will fail if we're the last
-		 * reader, in which case we can safely update cmdq->q.llq.cons
-		 */
-		if (!arm_smmu_cmdq_shared_tryunlock(cmdq)) {
-			WRITE_ONCE(cmdq->q.llq.cons, llq.cons);
-			arm_smmu_cmdq_shared_unlock(cmdq);
-		}
+	/*
+	 * Try to unlock the cmdq lock. This will fail if we're the last reader,
+	 * in which case we can safely update cmdq->q.llq.cons
+	 */
+	if (!arm_smmu_cmdq_shared_tryunlock(cmdq)) {
+		WRITE_ONCE(cmdq->q.llq.cons, llq.cons);
+		arm_smmu_cmdq_shared_unlock(cmdq);
 	}
 
 	local_irq_restore(flags);
@@ -1505,12 +1502,7 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 		return -EINVAL;
 	}
 
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, false);
-}
-
-static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
-{
-	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1);
 }
 
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
@@ -1521,7 +1513,7 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 	struct arm_smmu_ll_queue *llq = &q->q.llq;
 
 	if (cmds->num == llq->max_cmd_per_batch) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num);
 		cmds->num = 0;
 	}
 	arm_smmu_cmdq_build_cmd(&cmds->cmds[cmds->num * CMDQ_ENT_DWORDS], cmd);
@@ -1531,7 +1523,7 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 				      struct arm_smmu_cmdq_batch *cmds)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num);
 }
 
 /* Context descriptor manipulation functions */
@@ -1803,7 +1795,6 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	};
 
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
 }
 
 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
@@ -2197,17 +2188,21 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 
 static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 {
-	int i;
+	int i, ret = 0;
 	struct arm_smmu_cmdq_ent cmd;
 
 	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
 
 	for (i = 0; i < master->num_sids; i++) {
+		int rc;
+
 		cmd.atc.sid = master->sids[i];
-		arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
+		rc = arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
+		if (rc)
+			ret = rc;
 	}
 
-	return arm_smmu_cmdq_issue_sync(master->smmu);
+	return ret;
 }
 
 static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
@@ -2280,7 +2275,6 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * careful, 007.
 	 */
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
 }
 
@@ -3667,7 +3661,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	/* Invalidate any cached configuration */
 	cmd.opcode = CMDQ_OP_CFGI_ALL;
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
 
 	/* Invalidate any stale TLB entries */
 	if (smmu->features & ARM_SMMU_FEAT_HYP) {
@@ -3677,7 +3670,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 	cmd.opcode = CMDQ_OP_TLBI_NSNH_ALL;
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
 
 	/* Event queue */
 	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
