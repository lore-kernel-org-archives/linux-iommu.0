Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9377EC433DF
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 17:33:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719AA2075A
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 17:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719AA2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 191022040E;
	Mon, 22 Jun 2020 17:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2T3H6b6Js3xH; Mon, 22 Jun 2020 17:33:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 295942034B;
	Mon, 22 Jun 2020 17:33:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECA88C08A2;
	Mon, 22 Jun 2020 17:33:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC4E9C0891
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 17:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CA23B20390
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 17:33:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yvIIt5Rj3v8c for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 17:32:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by silver.osuosl.org (Postfix) with ESMTPS id 7288120348
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 17:32:58 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C293EF80ACF35D700EFE;
 Tue, 23 Jun 2020 01:32:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 23 Jun 2020 01:32:43 +0800
From: John Garry <john.garry@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
Date: Tue, 23 Jun 2020 01:28:40 +0800
Message-ID: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
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

It has been shown that the cmpxchg() for finding space in the cmdq can
be a bottleneck:
- for more CPUs contending the cmdq, the cmpxchg() will fail more often
- since the software-maintained cons pointer is updated on the same 64b
  memory region, the chance of cmpxchg() failure increases again

The cmpxchg() is removed as part of 2 related changes:

- Update prod and cmdq owner in a single atomic add operation. For this, we
  count the prod and owner in separate regions in prod memory.

  As with simple binary counting, once the prod+wrap fields overflow, they
  will zero. They should never overflow into "owner" region, and we zero
  the non-owner, prod region for each owner. This maintains the prod
  pointer.

  As for the "owner", we now count this value, instead of setting a flag.
  Similar to before, once the owner has finished gathering, it will clear
  a mask. As such, a CPU declares itself as the "owner" when it reads zero
  for this region. This zeroing will also clear possible overflow in
  wrap+prod region, above.

  The owner is now responsible for all cmdq locking to avoid possible
  deadlock. The owner will lock the cmdq for all non-owers it has gathered
  when they have space in the queue and have written their entries.

- Check for space in the cmdq after the prod pointer has been assigned.

  We don't bother checking for space in the cmdq before assigning the prod
  pointer, as this would be racy.

  So since the prod pointer is updated unconditionally, it would be common
  for no space to be available in the cmdq when prod is assigned - that
  is, according the software-maintained prod and cons pointer. So now
  it must be ensured that the entries are not yet written and not until
  there is space.

  How the prod pointer is maintained also leads to a strange condition
  where the prod pointer can wrap past the cons pointer. We can detect this
  condition, and report no space here. However, a prod pointer progressed
  twice past the cons pointer cannot be detected. But it can be ensured that
  this that this scenario does not occur, as we limit the amount of
  commands any CPU can issue at any given time, such that we cannot
  progress prod pointer further.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 101 ++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 45a39ccaf455..54d056f10bea 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -772,10 +772,19 @@ static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
 	prod = Q_IDX(q, q->prod);
 	cons = Q_IDX(q, q->cons);
 
-	if (Q_WRP(q, q->prod) == Q_WRP(q, q->cons))
+	if (Q_WRP(q, q->prod) == Q_WRP(q, q->cons)) {
+		/* check if we have wrapped, meaning definitely no space */
+		if (cons > prod)
+			return false;
+
 		space = (1 << q->max_n_shift) - (prod - cons);
-	else
+	} else {
+		/* similar check to above */
+		if (prod > cons)
+			return false;
+
 		space = cons - prod;
+	}
 
 	return space >= n;
 }
@@ -1073,7 +1082,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
  *   fails if the caller appears to be the last lock holder (yes, this is
  *   racy). All successful UNLOCK routines have RELEASE semantics.
  */
-static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq)
+static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq, int count)
 {
 	int val;
 
@@ -1083,12 +1092,12 @@ static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq)
 	 * to INT_MIN so these increments won't hurt as the value will remain
 	 * negative.
 	 */
-	if (atomic_fetch_inc_relaxed(&cmdq->lock) >= 0)
+	if (atomic_fetch_add_relaxed(count, &cmdq->lock) >= 0)
 		return;
 
 	do {
 		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);
-	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1) != val);
+	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + count) != val);
 }
 
 static void arm_smmu_cmdq_shared_unlock(struct arm_smmu_cmdq *cmdq)
@@ -1374,8 +1383,10 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
  *   insert their own list of commands then all of the commands from one
  *   CPU will appear before any of the commands from the other CPU.
  *
- * - A CMD_SYNC is always inserted, ensuring that any CPU does not issue
- *   more than the permitted amount commands at once.
+ * - A CMD_SYNC is always inserted, which ensures we limit the prod pointer
+ *   for when the cmdq is full, such that we don't wrap more than twice.
+ *   It also makes it easy for the owner to know by how many to increment the
+ *   cmdq lock.
  */
 static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				       u64 *cmds, int n)
@@ -1388,39 +1399,38 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	struct arm_smmu_ll_queue llq = {
 		.max_n_shift = cmdq->q.llq.max_n_shift,
-	}, head = llq;
+	}, head = llq, space = llq;
+	u32 owner_val = 1 << cmdq->q.llq.owner_count_shift;
+	u32 prod_mask = GENMASK(cmdq->q.llq.max_n_shift, 0);
+	u32 owner_mask = GENMASK(30, cmdq->q.llq.owner_count_shift);
 	int ret = 0;
 
 	/* 1. Allocate some space in the queue */
 	local_irq_save(flags);
-	llq.val = READ_ONCE(cmdq->q.llq.val);
-	do {
-		u64 old;
 
-		while (!queue_has_space(&llq, n + sync)) {
-			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
-				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
-			local_irq_save(flags);
-		}
+	prod = atomic_fetch_add(n + sync + owner_val,
+				&cmdq->q.llq.atomic.prod);
 
-		head.cons = llq.cons;
-		head.prod = queue_inc_prod_n(&llq, n + sync) |
-					     CMDQ_PROD_OWNED_FLAG;
+	owner = !(prod & owner_mask);
+	llq.prod = prod_mask & prod;
+	head.prod = queue_inc_prod_n(&llq, n + sync);
 
-		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
-		if (old == llq.val)
-			break;
+	/*
+	 * Ensure it's safe to write the entries. For this, we need to ensure
+	 * that there is space in the queue from our prod pointer.
+	 */
+	space.cons = READ_ONCE(cmdq->q.llq.cons);
+	space.prod = llq.prod;
+	while (!queue_has_space(&space, n + sync)) {
+		if (arm_smmu_cmdq_poll_until_not_full(smmu, &space))
+			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 
-		llq.val = old;
-	} while (1);
-	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
-	head.prod &= ~CMDQ_PROD_OWNED_FLAG;
-	llq.prod &= ~CMDQ_PROD_OWNED_FLAG;
+		space.prod = llq.prod;
+	}
 
 	/*
 	 * 2. Write our commands into the queue
-	 * Dependency ordering from the cmpxchg() loop above.
+	 * Dependency ordering from the space-checking while loop, above.
 	 */
 	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
 
@@ -1428,26 +1438,24 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
 	queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
 
-	/*
-	 * In order to determine completion of our CMD_SYNC, we must ensure
-	 * that the queue can't wrap twice without us noticing. We achieve that
-	 * by taking the cmdq lock as shared before marking our slot as valid.
-	 */
-	arm_smmu_cmdq_shared_lock(cmdq);
-
 	/* 3. Mark our slots as valid, ensuring commands are visible first */
 	dma_wmb();
 	arm_smmu_cmdq_set_valid_map(cmdq, llq.prod, head.prod);
 
 	/* 4. If we are the owner, take control of the SMMU hardware */
 	if (owner) {
+		int owner_count;
+		u32 prod_tmp;
+
 		/* a. Wait for previous owner to finish */
 		atomic_cond_read_relaxed(&cmdq->owner_prod, VAL == llq.prod);
 
-		/* b. Stop gathering work by clearing the owned flag */
-		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
-						   &cmdq->q.llq.atomic.prod);
-		prod &= ~CMDQ_PROD_OWNED_FLAG;
+		/* b. Stop gathering work by clearing the owned mask */
+		prod_tmp = atomic_fetch_andnot_relaxed(~prod_mask,
+						       &cmdq->q.llq.atomic.prod);
+		prod = prod_tmp & prod_mask;
+		owner_count = prod_tmp & owner_mask;
+		owner_count >>= cmdq->q.llq.owner_count_shift;
 
 		/*
 		 * c. Wait for any gathered work to be written to the queue.
@@ -1456,6 +1464,19 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		 */
 		arm_smmu_cmdq_poll_valid_map(cmdq, llq.prod, prod);
 
+		/*
+		 * In order to determine completion of the CMD_SYNCs, we must
+		 * ensure that the queue can't wrap twice without us noticing.
+		 * We achieve that by taking the cmdq lock as shared before
+		 * progressing the prod pointer.
+		 * The owner does this for all the non-owners it has gathered.
+		 * Otherwise, some non-owner(s) may lock the cmdq, blocking
+		 * cons being updating. This could be when the cmdq has just
+		 * become full. In this case, other sibling non-owners could be
+		 * blocked from progressing, leading to deadlock.
+		 */
+		arm_smmu_cmdq_shared_lock(cmdq, owner_count);
+
 		/*
 		 * d. Advance the hardware prod pointer
 		 * Control dependency ordering from the entries becoming valid.
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
