Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3018C433F5
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 12:19:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B36A60F4C
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 12:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B36A60F4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4661D814A1;
	Tue, 21 Sep 2021 12:19:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lid5UGLTWsEt; Tue, 21 Sep 2021 12:19:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E001381016;
	Tue, 21 Sep 2021 12:19:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA755C0011;
	Tue, 21 Sep 2021 12:19:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DA58C000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 11:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D55060AF1
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 11:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amazon.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1N8cjcMI98Qk for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 11:44:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2DFB3606A5
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1632224663; x=1663760663;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=L6/uiASrjWcY7OR+4ZxkhVbDc2ez+fKTbcMMZwXQK08=;
 b=bWuKXEE928EInvynG0y2w1OJ+m6gYLIFjGkr3bp84WczlsEv4tXG7Sgh
 qqkPF4b4RfC4L302wK/+TSn0lxsM0r0vGw5+OY7SLJPOZxn6TG7Kh2A6e
 mzQI8nMb7CT4nCZnaWt7v3E+W84rxbfaDL4xPolK/+3li+D9oWh3HfsNE o=;
X-IronPort-AV: E=Sophos;i="5.85,311,1624320000"; d="scan'208";a="143399945"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2a-ff3df2fe.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 21 Sep 2021 11:44:13 +0000
Received: from EX13D03EUA004.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
 by email-inbound-relay-pdx-2a-ff3df2fe.us-west-2.amazon.com (Postfix) with
 ESMTPS id 99211418E5; Tue, 21 Sep 2021 11:44:11 +0000 (UTC)
Received: from u898248c994d452.ant.amazon.com (10.43.162.248) by
 EX13D03EUA004.ant.amazon.com (10.43.165.93) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Tue, 21 Sep 2021 11:44:06 +0000
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH] iommu/arm-smmu-v3: poll cmdq until it has space
Date: Tue, 21 Sep 2021 13:43:38 +0200
Message-ID: <20210921114338.1144521-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.43.162.248]
X-ClientProxiedBy: EX13D13UWB003.ant.amazon.com (10.43.161.233) To
 EX13D03EUA004.ant.amazon.com (10.43.165.93)
X-Mailman-Approved-At: Tue, 21 Sep 2021 12:19:22 +0000
Cc: Fernand Sieber <sieberf@amazon.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
From: Fernand Sieber via iommu <iommu@lists.linux-foundation.org>
Reply-To: Fernand Sieber <sieberf@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When a thread sends commands to the SMMU, it needs to allocate some
space to write its commands in a ring buffer.

The allocation algorithms works as follows: until enough free spaced is
available in the queue, repeat the following outer loop. First, try to
acquire an exclusive lock to read the consumer index from the SMMU
register over MMIO. If that fails, it means that another thread holds
the lock (or multiple threads, in shared mode, for sync commands). The
current code guarantees that when a thread is holding the lock, the
consumer index will be updated from the SMMU register. So then when the
acquisition of the exclusive lock fails, we can safely assume that
another thread will eventually update the consumer index and enter an
inner waiting loop until that happens.

The problem that this patch fixes is that the waiting loop exits as soon
as any space is available in the queue, so it is possible that it exits
immediately if there's some space available but not enough to write the
thread's commands. That means the cmdq allocation queue will fail (outer
loop) and the thread will spin attempting to acquire the exclusive lock
to update the consumer index from the SMMU register.

If a lot of threads are failing to allocate commands, this can cause
heavy contention on the lock, to the point where the system slowdown or
livelocks. The livelock is possible if some other threads are attempting
to execute synchronous commands. These threads need to ensure that they
control updates to the consumer index so that they can correctly observe
when their command is executed, they enforce that by acquiring the lock
in shared mode. If there's too much contention, they never succeed to
acquire the lock via the read+cmpxchg mechanism, and their progress
stall. But because they already hold allocated space in the command
queue, their stall prevents progress from other threads attempting to
allocate space in the cmdq. This causes a livelock.

This patch makes the waiting loop exit as soon as enough space is
available, rather than as soon as any space is available. This means
that when two threads are competing for the exclusive lock when
allocating space in the queue, one of them will fail to acquiire the
lock in exclusive lock and be knocked to the waiting loop and stay there
until there's enough free space rather than exiting it immediately when
any space is available. Threads in the waiting loop do not compete for
the lock, reducing contention enough to enable synchronous threads to
make progress, when applicable.

Note that we cannot afford to have all threads parked in the waiting
loop unless there are synchronous threads executing concurrenty,
otherwise no thread is observing the SMMU register and updating the
consumer index. Thus if we succeed to acquire the lock in exclusive
mode, we cannot enter the waiting loop because we could be the last
thread observing the SMMU. Similarly, if the producer index is updated,
we need to exit the waiting loop because it could mean that the latest
thread to observe the SMMU has succeeded to allocate commands and thus
has moved on.

Signed-off-by: Fernand Sieber <sieberf@amazon.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 +++++++++++++++------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a388e318f86e..9ccda3bd5402 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -118,12 +118,6 @@ static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
 	return space >= n;
 }

-static bool queue_full(struct arm_smmu_ll_queue *q)
-{
-	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
-	       Q_WRP(q, q->prod) != Q_WRP(q, q->cons);
-}
-
 static bool queue_empty(struct arm_smmu_ll_queue *q)
 {
 	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
@@ -582,14 +576,16 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
 	__arm_smmu_cmdq_poll_set_valid_map(cmdq, sprod, eprod, false);
 }

-/* Wait for the command queue to become non-full */
-static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
-					     struct arm_smmu_ll_queue *llq)
+/* Wait for the command queue to have enough space */
+static int arm_smmu_cmdq_poll_until_has_space(struct arm_smmu_device *smmu,
+					      struct arm_smmu_ll_queue *llq,
+					      u32 n)
 {
 	unsigned long flags;
 	struct arm_smmu_queue_poll qp;
 	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	int ret = 0;
+	int prod;

 	/*
 	 * Try to update our copy of cons by grabbing exclusive cmdq access. If
@@ -599,15 +595,36 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
 		WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
 		arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
 		llq->val = READ_ONCE(cmdq->q.llq.val);
-		return 0;
+
+		/*
+		 * We must return here even if there's no space, because we could be
+		 * the last thread observing the SMMU progress. Thus, we cannot enter
+		 * the waiting loop below as it relies on another thread updating
+		 * llq->val.
+		 */
+		if (queue_has_space(llq, n))
+			return 0;
+		else
+			return -EAGAIN;
 	}

 	queue_poll_init(smmu, &qp);
+	prod = llq->prod;
 	do {
 		llq->val = READ_ONCE(cmdq->q.llq.val);
-		if (!queue_full(llq))
+		if (!queue_has_space(llq, n))
 			break;

+		/*
+		 * We must return here even if there's no space, because the producer
+		 * having moved forward could mean that the last thread observing the
+		 * SMMU progress has allocated space in the cmdq and moved on, leaving
+		 * us in this waiting loop with no other thread updating
+		 * llq->state->val.
+		 */
+		if (llq->prod != prod)
+			return -EAGAIN;
+
 		ret = queue_poll(&qp);
 	} while (!ret);

@@ -755,7 +772,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,

 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
+			if (arm_smmu_cmdq_poll_until_has_space(smmu, &llq, n + sync) == -ETIMEDOUT)
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
 		}
--
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
