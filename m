Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FFCC43218
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 13:46:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A2220896
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 13:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A2220896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 80242EDC;
	Tue, 11 Jun 2019 13:46:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A267CEDB
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 13:46:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id F217A711
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 13:46:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6A88ED1;
	Tue, 11 Jun 2019 06:46:18 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1AAE13F557; 
	Tue, 11 Jun 2019 06:46:16 -0700 (PDT)
From: Will Deacon <will.deacon@arm.com>
To: iommu@lists.linux-foundation.org
Subject: [RFC CFT 5/6] iommu/arm-smmu-v3: Operate directly on low-level queue
	where possible
Date: Tue, 11 Jun 2019 14:46:02 +0100
Message-Id: <20190611134603.4253-6-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190611134603.4253-1-will.deacon@arm.com>
References: <20190611134603.4253-1-will.deacon@arm.com>
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Will Deacon <will.deacon@arm.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
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
new algorithm, rework many of our queue macro accessors and manipulation
functions so that they operate on the arm_smmu_ll_queue structure where
possible. This will allow us to call these helpers on local variables
without having to construct a full-blown arm_smmu_queue on the stack.

No functional change.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 58 ++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d72da799bd0a..85535400a365 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -181,12 +181,13 @@
 #define ARM_SMMU_MEMATTR_DEVICE_nGnRE	0x1
 #define ARM_SMMU_MEMATTR_OIWB		0xf
 
-#define Q_IDX(q, p)			((p) & ((1 << (q)->llq.max_n_shift) - 1))
-#define Q_WRP(q, p)			((p) & (1 << (q)->llq.max_n_shift))
+#define Q_IDX(llq, p)			((p) & ((1 << (llq)->max_n_shift) - 1))
+#define Q_WRP(llq, p)			((p) & (1 << (llq)->max_n_shift))
 #define Q_OVERFLOW_FLAG			(1 << 31)
 #define Q_OVF(p)			((p) & Q_OVERFLOW_FLAG)
 #define Q_ENT(q, p)			((q)->base +			\
-					 Q_IDX(q, p) * (q)->ent_dwords)
+					 Q_IDX(&((q)->llq), p) *	\
+					 (q)->ent_dwords)
 
 #define Q_BASE_RWA			(1UL << 62)
 #define Q_BASE_ADDR_MASK		GENMASK_ULL(51, 5)
@@ -683,16 +684,16 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
 }
 
 /* Low-level queue manipulation functions */
-static bool queue_full(struct arm_smmu_queue *q)
+static bool queue_full(struct arm_smmu_ll_queue *q)
 {
-	return Q_IDX(q, q->llq.prod) == Q_IDX(q, q->llq.cons) &&
-	       Q_WRP(q, q->llq.prod) != Q_WRP(q, q->llq.cons);
+	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
+	       Q_WRP(q, q->prod) != Q_WRP(q, q->cons);
 }
 
-static bool queue_empty(struct arm_smmu_queue *q)
+static bool queue_empty(struct arm_smmu_ll_queue *q)
 {
-	return Q_IDX(q, q->llq.prod) == Q_IDX(q, q->llq.cons) &&
-	       Q_WRP(q, q->llq.prod) == Q_WRP(q, q->llq.cons);
+	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
+	       Q_WRP(q, q->prod) == Q_WRP(q, q->cons);
 }
 
 static void queue_sync_cons_in(struct arm_smmu_queue *q)
@@ -710,10 +711,10 @@ static void queue_sync_cons_out(struct arm_smmu_queue *q)
 	writel_relaxed(q->llq.cons, q->cons_reg);
 }
 
-static void queue_inc_cons(struct arm_smmu_queue *q)
+static void queue_inc_cons(struct arm_smmu_ll_queue *q)
 {
-	u32 cons = (Q_WRP(q, q->llq.cons) | Q_IDX(q, q->llq.cons)) + 1;
-	q->llq.cons = Q_OVF(q->llq.cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
+	u32 cons = (Q_WRP(q, q->cons) | Q_IDX(q, q->cons)) + 1;
+	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
 }
 
 static int queue_sync_prod_in(struct arm_smmu_queue *q)
@@ -733,10 +734,10 @@ static void queue_sync_prod_out(struct arm_smmu_queue *q)
 	writel(q->llq.prod, q->prod_reg);
 }
 
-static void queue_inc_prod(struct arm_smmu_queue *q)
+static void queue_inc_prod(struct arm_smmu_ll_queue *q)
 {
-	u32 prod = (Q_WRP(q, q->llq.prod) | Q_IDX(q, q->llq.prod)) + 1;
-	q->llq.prod = Q_OVF(q->llq.prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
+	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + 1;
+	q->prod = Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
 }
 
 /*
@@ -753,7 +754,8 @@ static int queue_poll_cons(struct arm_smmu_queue *q, bool sync, bool wfe)
 					    ARM_SMMU_CMDQ_SYNC_TIMEOUT_US :
 					    ARM_SMMU_POLL_TIMEOUT_US);
 
-	while (queue_sync_cons_in(q), (sync ? !queue_empty(q) : queue_full(q))) {
+	while (queue_sync_cons_in(q),
+	      (sync ? !queue_empty(&q->llq) : queue_full(&q->llq))) {
 		if (ktime_compare(ktime_get(), timeout) > 0)
 			return -ETIMEDOUT;
 
@@ -782,11 +784,11 @@ static void queue_write(__le64 *dst, u64 *src, size_t n_dwords)
 
 static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent)
 {
-	if (queue_full(q))
+	if (queue_full(&q->llq))
 		return -ENOSPC;
 
 	queue_write(Q_ENT(q, q->llq.prod), ent, q->ent_dwords);
-	queue_inc_prod(q);
+	queue_inc_prod(&q->llq);
 	queue_sync_prod_out(q);
 	return 0;
 }
@@ -801,11 +803,11 @@ static void queue_read(__le64 *dst, u64 *src, size_t n_dwords)
 
 static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
 {
-	if (queue_empty(q))
+	if (queue_empty(&q->llq))
 		return -EAGAIN;
 
 	queue_read(ent, Q_ENT(q, q->llq.cons), q->ent_dwords);
-	queue_inc_cons(q);
+	queue_inc_cons(&q->llq);
 	queue_sync_cons_out(q);
 	return 0;
 }
@@ -1310,6 +1312,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	int i;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
+	struct arm_smmu_ll_queue *llq = &q->llq;
 	u64 evt[EVTQ_ENT_DWORDS];
 
 	do {
@@ -1329,11 +1332,11 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 		 */
 		if (queue_sync_prod_in(q) == -EOVERFLOW)
 			dev_err(smmu->dev, "EVTQ overflow detected -- events lost\n");
-	} while (!queue_empty(q));
+	} while (!queue_empty(llq));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	q->llq.cons = Q_OVF(q->llq.prod) | Q_WRP(q, q->llq.cons) |
-		      Q_IDX(q, q->llq.cons);
+	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
+		    Q_IDX(llq, llq->cons);
 	return IRQ_HANDLED;
 }
 
@@ -1379,6 +1382,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->priq.q;
+	struct arm_smmu_ll_queue *llq = &q->llq;
 	u64 evt[PRIQ_ENT_DWORDS];
 
 	do {
@@ -1387,12 +1391,12 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 		if (queue_sync_prod_in(q) == -EOVERFLOW)
 			dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
-	} while (!queue_empty(q));
+	} while (!queue_empty(llq));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	q->llq.cons = Q_OVF(q->llq.prod) | Q_WRP(q, q->llq.cons) |
-		      Q_IDX(q, q->llq.cons);
-	writel(q->llq.cons, q->cons_reg);
+	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
+		      Q_IDX(llq, llq->cons);
+	queue_sync_cons_out(q);
 	return IRQ_HANDLED;
 }
 
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
