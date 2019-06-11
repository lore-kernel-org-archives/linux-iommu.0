Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE859C4321A
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 13:46:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFA920896
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 13:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFA920896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 51E65D7D;
	Tue, 11 Jun 2019 13:46:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0DB27D7D
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 13:46:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 35541711
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 13:46:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9585EBD;
	Tue, 11 Jun 2019 06:46:16 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F0803F557; 
	Tue, 11 Jun 2019 06:46:15 -0700 (PDT)
From: Will Deacon <will.deacon@arm.com>
To: iommu@lists.linux-foundation.org
Subject: [RFC CFT 4/6] iommu/arm-smmu-v3: Move low-level queue fields out of
	arm_smmu_queue
Date: Tue, 11 Jun 2019 14:46:01 +0100
Message-Id: <20190611134603.4253-5-will.deacon@arm.com>
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
new algorithm, introduce a new arm_smmu_ll_queue structure which contains
only the information necessary to perform queue arithmetic for a queue
and will later be extended so that we can perform complex atomic
manipulation on some of the fields.

No functional change.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 88 ++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1b7e8fe26c41..d72da799bd0a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -181,8 +181,8 @@
 #define ARM_SMMU_MEMATTR_DEVICE_nGnRE	0x1
 #define ARM_SMMU_MEMATTR_OIWB		0xf
 
-#define Q_IDX(q, p)			((p) & ((1 << (q)->max_n_shift) - 1))
-#define Q_WRP(q, p)			((p) & (1 << (q)->max_n_shift))
+#define Q_IDX(q, p)			((p) & ((1 << (q)->llq.max_n_shift) - 1))
+#define Q_WRP(q, p)			((p) & (1 << (q)->llq.max_n_shift))
 #define Q_OVERFLOW_FLAG			(1 << 31)
 #define Q_OVF(p)			((p) & Q_OVERFLOW_FLAG)
 #define Q_ENT(q, p)			((q)->base +			\
@@ -472,7 +472,14 @@ struct arm_smmu_cmdq_ent {
 	};
 };
 
+struct arm_smmu_ll_queue {
+	u32				prod;
+	u32				cons;
+	u32				max_n_shift;
+};
+
 struct arm_smmu_queue {
+	struct arm_smmu_ll_queue	llq;
 	int				irq; /* Wired interrupt */
 
 	__le64				*base;
@@ -480,9 +487,6 @@ struct arm_smmu_queue {
 	u64				q_base;
 
 	size_t				ent_dwords;
-	u32				max_n_shift;
-	u32				prod;
-	u32				cons;
 
 	u32 __iomem			*prod_reg;
 	u32 __iomem			*cons_reg;
@@ -681,19 +685,19 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
 /* Low-level queue manipulation functions */
 static bool queue_full(struct arm_smmu_queue *q)
 {
-	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
-	       Q_WRP(q, q->prod) != Q_WRP(q, q->cons);
+	return Q_IDX(q, q->llq.prod) == Q_IDX(q, q->llq.cons) &&
+	       Q_WRP(q, q->llq.prod) != Q_WRP(q, q->llq.cons);
 }
 
 static bool queue_empty(struct arm_smmu_queue *q)
 {
-	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
-	       Q_WRP(q, q->prod) == Q_WRP(q, q->cons);
+	return Q_IDX(q, q->llq.prod) == Q_IDX(q, q->llq.cons) &&
+	       Q_WRP(q, q->llq.prod) == Q_WRP(q, q->llq.cons);
 }
 
 static void queue_sync_cons_in(struct arm_smmu_queue *q)
 {
-	q->cons = readl_relaxed(q->cons_reg);
+	q->llq.cons = readl_relaxed(q->cons_reg);
 }
 
 static void queue_sync_cons_out(struct arm_smmu_queue *q)
@@ -703,13 +707,13 @@ static void queue_sync_cons_out(struct arm_smmu_queue *q)
 	 * are complete before we update the cons pointer.
 	 */
 	mb();
-	writel_relaxed(q->cons, q->cons_reg);
+	writel_relaxed(q->llq.cons, q->cons_reg);
 }
 
 static void queue_inc_cons(struct arm_smmu_queue *q)
 {
-	u32 cons = (Q_WRP(q, q->cons) | Q_IDX(q, q->cons)) + 1;
-	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
+	u32 cons = (Q_WRP(q, q->llq.cons) | Q_IDX(q, q->llq.cons)) + 1;
+	q->llq.cons = Q_OVF(q->llq.cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
 }
 
 static int queue_sync_prod_in(struct arm_smmu_queue *q)
@@ -717,22 +721,22 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
 	int ret = 0;
 	u32 prod = readl_relaxed(q->prod_reg);
 
-	if (Q_OVF(prod) != Q_OVF(q->prod))
+	if (Q_OVF(prod) != Q_OVF(q->llq.prod))
 		ret = -EOVERFLOW;
 
-	q->prod = prod;
+	q->llq.prod = prod;
 	return ret;
 }
 
 static void queue_sync_prod_out(struct arm_smmu_queue *q)
 {
-	writel(q->prod, q->prod_reg);
+	writel(q->llq.prod, q->prod_reg);
 }
 
 static void queue_inc_prod(struct arm_smmu_queue *q)
 {
-	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + 1;
-	q->prod = Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
+	u32 prod = (Q_WRP(q, q->llq.prod) | Q_IDX(q, q->llq.prod)) + 1;
+	q->llq.prod = Q_OVF(q->llq.prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
 }
 
 /*
@@ -781,7 +785,7 @@ static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent)
 	if (queue_full(q))
 		return -ENOSPC;
 
-	queue_write(Q_ENT(q, q->prod), ent, q->ent_dwords);
+	queue_write(Q_ENT(q, q->llq.prod), ent, q->ent_dwords);
 	queue_inc_prod(q);
 	queue_sync_prod_out(q);
 	return 0;
@@ -800,7 +804,7 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
 	if (queue_empty(q))
 		return -EAGAIN;
 
-	queue_read(ent, Q_ENT(q, q->cons), q->ent_dwords);
+	queue_read(ent, Q_ENT(q, q->llq.cons), q->ent_dwords);
 	queue_inc_cons(q);
 	queue_sync_cons_out(q);
 	return 0;
@@ -1328,7 +1332,8 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	} while (!queue_empty(q));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	q->cons = Q_OVF(q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+	q->llq.cons = Q_OVF(q->llq.prod) | Q_WRP(q, q->llq.cons) |
+		      Q_IDX(q, q->llq.cons);
 	return IRQ_HANDLED;
 }
 
@@ -1385,8 +1390,9 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	} while (!queue_empty(q));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	q->cons = Q_OVF(q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
-	writel(q->cons, q->cons_reg);
+	q->llq.cons = Q_OVF(q->llq.prod) | Q_WRP(q, q->llq.cons) |
+		      Q_IDX(q, q->llq.cons);
+	writel(q->llq.cons, q->cons_reg);
 	return IRQ_HANDLED;
 }
 
@@ -2287,13 +2293,13 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	size_t qsz;
 
 	do {
-		qsz = ((1 << q->max_n_shift) * dwords) << 3;
+		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
 		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
 					      GFP_KERNEL);
 		if (q->base || qsz < PAGE_SIZE)
 			break;
 
-		q->max_n_shift--;
+		q->llq.max_n_shift--;
 	} while (1);
 
 	if (!q->base) {
@@ -2305,7 +2311,7 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 
 	if (!WARN_ON(q->base_dma & (qsz - 1))) {
 		dev_info(smmu->dev, "allocated %u entries for %s\n",
-			 1 << q->max_n_shift, name);
+			 1 << q->llq.max_n_shift, name);
 	}
 
 	q->prod_reg	= arm_smmu_page1_fixup(prod_off, smmu);
@@ -2314,9 +2320,9 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 
 	q->q_base  = Q_BASE_RWA;
 	q->q_base |= q->base_dma & Q_BASE_ADDR_MASK;
-	q->q_base |= FIELD_PREP(Q_BASE_LOG2SIZE, q->max_n_shift);
+	q->q_base |= FIELD_PREP(Q_BASE_LOG2SIZE, q->llq.max_n_shift);
 
-	q->prod = q->cons = 0;
+	q->llq.prod = q->llq.cons = 0;
 	return 0;
 }
 
@@ -2709,8 +2715,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 	/* Command queue */
 	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
-	writel_relaxed(smmu->cmdq.q.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
-	writel_relaxed(smmu->cmdq.q.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
+	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
+	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
 	enables = CR0_CMDQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -2737,9 +2743,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 	/* Event queue */
 	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-	writel_relaxed(smmu->evtq.q.prod,
+	writel_relaxed(smmu->evtq.q.llq.prod,
 		       arm_smmu_page1_fixup(ARM_SMMU_EVTQ_PROD, smmu));
-	writel_relaxed(smmu->evtq.q.cons,
+	writel_relaxed(smmu->evtq.q.llq.cons,
 		       arm_smmu_page1_fixup(ARM_SMMU_EVTQ_CONS, smmu));
 
 	enables |= CR0_EVTQEN;
@@ -2754,9 +2760,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	if (smmu->features & ARM_SMMU_FEAT_PRI) {
 		writeq_relaxed(smmu->priq.q.q_base,
 			       smmu->base + ARM_SMMU_PRIQ_BASE);
-		writel_relaxed(smmu->priq.q.prod,
+		writel_relaxed(smmu->priq.q.llq.prod,
 			       arm_smmu_page1_fixup(ARM_SMMU_PRIQ_PROD, smmu));
-		writel_relaxed(smmu->priq.q.cons,
+		writel_relaxed(smmu->priq.q.llq.cons,
 			       arm_smmu_page1_fixup(ARM_SMMU_PRIQ_CONS, smmu));
 
 		enables |= CR0_PRIQEN;
@@ -2910,18 +2916,18 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	}
 
 	/* Queue sizes, capped to ensure natural alignment */
-	smmu->cmdq.q.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
-					 FIELD_GET(IDR1_CMDQS, reg));
-	if (!smmu->cmdq.q.max_n_shift) {
+	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
+					     FIELD_GET(IDR1_CMDQS, reg));
+	if (!smmu->cmdq.q.llq.max_n_shift) {
 		/* Odd alignment restrictions on the base, so ignore for now */
 		dev_err(smmu->dev, "unit-length command queue not supported\n");
 		return -ENXIO;
 	}
 
-	smmu->evtq.q.max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT,
-					 FIELD_GET(IDR1_EVTQS, reg));
-	smmu->priq.q.max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT,
-					 FIELD_GET(IDR1_PRIQS, reg));
+	smmu->evtq.q.llq.max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT,
+					     FIELD_GET(IDR1_EVTQS, reg));
+	smmu->priq.q.llq.max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT,
+					     FIELD_GET(IDR1_PRIQS, reg));
 
 	/* SID/SSID sizes */
 	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
