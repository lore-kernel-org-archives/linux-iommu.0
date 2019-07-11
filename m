Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30259C74A5B
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:30:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0580320863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYe+bYiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0580320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6098A54A1;
	Thu, 11 Jul 2019 17:28:57 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 121341E09
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:20:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id 170FB1DCF0
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 87C1C2166E;
	Thu, 11 Jul 2019 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562865622;
	bh=TZzf83GJ/JHbdPvTGVlTbAFE7yftsALQf/DxNuUU+8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYe+bYiEsvFSeWnh5R8X/Zf7x2icC+ajJ9LUPWoe4Y2YcBLRbLrRGkPxZgiIkDHb/
	R+oY8BUhsRNYOlroOeou3vSKQZG00dl4/phUj6no5YXE/X13P1D9bivzSXgqzfhoY+
	AYFuS2Q0z8PUx/k0XpwGtBM1e97ipro/gYCIZYVE=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 14/19] iommu/arm-smmu-v3: Separate s/w and h/w views of
	prod and cons indexes
Date: Thu, 11 Jul 2019 18:19:22 +0100
Message-Id: <20190711171927.28803-15-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190711171927.28803-1-will@kernel.org>
References: <20190711171927.28803-1-will@kernel.org>
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Will Deacon <will@kernel.org>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

In preparation for rewriting the command queue insertion code to use a
new algorithm, separate the software and hardware views of the prod and
cons indexes so that manipulating the software state doesn't
automatically update the hardware state at the same time.

No functional change.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c91131ce2a70..2ffdf4b3ecf0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -691,17 +691,13 @@ static bool queue_empty(struct arm_smmu_queue *q)
 	       Q_WRP(q, q->prod) == Q_WRP(q, q->cons);
 }
 
-static void queue_sync_cons(struct arm_smmu_queue *q)
+static void queue_sync_cons_in(struct arm_smmu_queue *q)
 {
 	q->cons = readl_relaxed(q->cons_reg);
 }
 
-static void queue_inc_cons(struct arm_smmu_queue *q)
+static void queue_sync_cons_out(struct arm_smmu_queue *q)
 {
-	u32 cons = (Q_WRP(q, q->cons) | Q_IDX(q, q->cons)) + 1;
-
-	q->cons = Q_OVF(q, q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
-
 	/*
 	 * Ensure that all CPU accesses (reads and writes) to the queue
 	 * are complete before we update the cons pointer.
@@ -710,7 +706,13 @@ static void queue_inc_cons(struct arm_smmu_queue *q)
 	writel_relaxed(q->cons, q->cons_reg);
 }
 
-static int queue_sync_prod(struct arm_smmu_queue *q)
+static void queue_inc_cons(struct arm_smmu_queue *q)
+{
+	u32 cons = (Q_WRP(q, q->cons) | Q_IDX(q, q->cons)) + 1;
+	q->cons = Q_OVF(q, q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
+}
+
+static int queue_sync_prod_in(struct arm_smmu_queue *q)
 {
 	int ret = 0;
 	u32 prod = readl_relaxed(q->prod_reg);
@@ -722,12 +724,15 @@ static int queue_sync_prod(struct arm_smmu_queue *q)
 	return ret;
 }
 
+static void queue_sync_prod_out(struct arm_smmu_queue *q)
+{
+	writel(q->prod, q->prod_reg);
+}
+
 static void queue_inc_prod(struct arm_smmu_queue *q)
 {
 	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + 1;
-
 	q->prod = Q_OVF(q, q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
-	writel(q->prod, q->prod_reg);
 }
 
 /*
@@ -744,7 +749,7 @@ static int queue_poll_cons(struct arm_smmu_queue *q, bool sync, bool wfe)
 					    ARM_SMMU_CMDQ_SYNC_TIMEOUT_US :
 					    ARM_SMMU_POLL_TIMEOUT_US);
 
-	while (queue_sync_cons(q), (sync ? !queue_empty(q) : queue_full(q))) {
+	while (queue_sync_cons_in(q), (sync ? !queue_empty(q) : queue_full(q))) {
 		if (ktime_compare(ktime_get(), timeout) > 0)
 			return -ETIMEDOUT;
 
@@ -778,6 +783,7 @@ static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent)
 
 	queue_write(Q_ENT(q, q->prod), ent, q->ent_dwords);
 	queue_inc_prod(q);
+	queue_sync_prod_out(q);
 	return 0;
 }
 
@@ -796,6 +802,7 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
 
 	queue_read(ent, Q_ENT(q, q->cons), q->ent_dwords);
 	queue_inc_cons(q);
+	queue_sync_cons_out(q);
 	return 0;
 }
 
@@ -1316,7 +1323,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 		 * Not much we can do on overflow, so scream and pretend we're
 		 * trying harder.
 		 */
-		if (queue_sync_prod(q) == -EOVERFLOW)
+		if (queue_sync_prod_in(q) == -EOVERFLOW)
 			dev_err(smmu->dev, "EVTQ overflow detected -- events lost\n");
 	} while (!queue_empty(q));
 
@@ -1373,7 +1380,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 		while (!queue_remove_raw(q, evt))
 			arm_smmu_handle_ppr(smmu, evt);
 
-		if (queue_sync_prod(q) == -EOVERFLOW)
+		if (queue_sync_prod_in(q) == -EOVERFLOW)
 			dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
 	} while (!queue_empty(q));
 
@@ -1557,8 +1564,9 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	/*
 	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
 	 * PTEs previously cleared by unmaps on the current CPU not yet visible
-	 * to the SMMU. We are relying on the DSB implicit in queue_inc_prod()
-	 * to guarantee those are observed before the TLBI. Do be careful, 007.
+	 * to the SMMU. We are relying on the DSB implicit in
+	 * queue_sync_prod_out() to guarantee those are observed before the
+	 * TLBI. Do be careful, 007.
 	 */
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
 	arm_smmu_cmdq_issue_sync(smmu);
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
