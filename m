Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B730C4321A
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 13:46:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0993B20896
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 13:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0993B20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B744CED6;
	Tue, 11 Jun 2019 13:46:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 95B7CD6A
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 13:46:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id F1FAD6D6
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 13:46:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80B3F346;
	Tue, 11 Jun 2019 06:46:11 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9E553F557; 
	Tue, 11 Jun 2019 06:46:09 -0700 (PDT)
From: Will Deacon <will.deacon@arm.com>
To: iommu@lists.linux-foundation.org
Subject: [RFC CFT 1/6] iommu/arm-smmu-v3: Increase maximum size of queues
Date: Tue, 11 Jun 2019 14:45:58 +0100
Message-Id: <20190611134603.4253-2-will.deacon@arm.com>
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

We've been artificially limiting the size of our queues to 4k so that we
don't end up allocating huge amounts of physically-contiguous memory at
probe time. However, 4k is only enough for 256 commands in the command
queue, so instead let's try to allocate the largest queue that the SMMU
supports, retrying with a smaller size if the allocation fails.

The caveat here is that we have to limit our upper bound based on
CONFIG_CMA_ALIGNMENT to ensure that our queue allocations remain
natually aligned, which is required by the SMMU architecture.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 54 +++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4d5a694f02c2..65de2458999f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -191,6 +191,7 @@
 #define Q_BASE_RWA			(1UL << 62)
 #define Q_BASE_ADDR_MASK		GENMASK_ULL(51, 5)
 #define Q_BASE_LOG2SIZE			GENMASK(4, 0)
+#define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + CONFIG_CMA_ALIGNMENT)
 
 /*
  * Stream table.
@@ -289,8 +290,9 @@
 					FIELD_GET(ARM64_TCR_##fld, tcr))
 
 /* Command queue */
-#define CMDQ_ENT_DWORDS			2
-#define CMDQ_MAX_SZ_SHIFT		8
+#define CMDQ_ENT_SZ_SHIFT		4
+#define CMDQ_ENT_DWORDS			((1 << CMDQ_ENT_SZ_SHIFT) >> 3)
+#define CMDQ_MAX_SZ_SHIFT		(Q_MAX_SZ_SHIFT - CMDQ_ENT_SZ_SHIFT)
 
 #define CMDQ_CONS_ERR			GENMASK(30, 24)
 #define CMDQ_ERR_CERROR_NONE_IDX	0
@@ -336,14 +338,16 @@
 #define CMDQ_SYNC_1_MSIADDR_MASK	GENMASK_ULL(51, 2)
 
 /* Event queue */
-#define EVTQ_ENT_DWORDS			4
-#define EVTQ_MAX_SZ_SHIFT		7
+#define EVTQ_ENT_SZ_SHIFT		5
+#define EVTQ_ENT_DWORDS			((1 << EVTQ_ENT_SZ_SHIFT) >> 3)
+#define EVTQ_MAX_SZ_SHIFT		(Q_MAX_SZ_SHIFT - EVTQ_ENT_SZ_SHIFT)
 
 #define EVTQ_0_ID			GENMASK_ULL(7, 0)
 
 /* PRI queue */
-#define PRIQ_ENT_DWORDS			2
-#define PRIQ_MAX_SZ_SHIFT		8
+#define PRIQ_ENT_SZ_SHIFT		4
+#define PRIQ_ENT_DWORDS			((1 << PRIQ_ENT_SZ_SHIFT) >> 3)
+#define PRIQ_MAX_SZ_SHIFT		(Q_MAX_SZ_SHIFT - PRIQ_ENT_SZ_SHIFT)
 
 #define PRIQ_0_SID			GENMASK_ULL(31, 0)
 #define PRIQ_0_SSID			GENMASK_ULL(51, 32)
@@ -798,7 +802,7 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
 /* High-level queue accessors */
 static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 {
-	memset(cmd, 0, CMDQ_ENT_DWORDS << 3);
+	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
 	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
 
 	switch (ent->opcode) {
@@ -2270,17 +2274,32 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 				   struct arm_smmu_queue *q,
 				   unsigned long prod_off,
 				   unsigned long cons_off,
-				   size_t dwords)
+				   size_t dwords, const char *name)
 {
-	size_t qsz = ((1 << q->max_n_shift) * dwords) << 3;
+	size_t qsz;
+
+	do {
+		qsz = ((1 << q->max_n_shift) * dwords) << 3;
+		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
+					      GFP_KERNEL);
+		if (q->base || qsz < PAGE_SIZE)
+			break;
+
+		q->max_n_shift--;
+	} while (1);
 
-	q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma, GFP_KERNEL);
 	if (!q->base) {
-		dev_err(smmu->dev, "failed to allocate queue (0x%zx bytes)\n",
-			qsz);
+		dev_err(smmu->dev,
+			"failed to allocate queue (0x%zx bytes) for %s\n",
+			qsz, name);
 		return -ENOMEM;
 	}
 
+	if (!WARN_ON(q->base_dma & (qsz - 1))) {
+		dev_info(smmu->dev, "allocated %u entries for %s\n",
+			 1 << q->max_n_shift, name);
+	}
+
 	q->prod_reg	= arm_smmu_page1_fixup(prod_off, smmu);
 	q->cons_reg	= arm_smmu_page1_fixup(cons_off, smmu);
 	q->ent_dwords	= dwords;
@@ -2300,13 +2319,15 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	/* cmdq */
 	spin_lock_init(&smmu->cmdq.lock);
 	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
-				      ARM_SMMU_CMDQ_CONS, CMDQ_ENT_DWORDS);
+				      ARM_SMMU_CMDQ_CONS, CMDQ_ENT_DWORDS,
+				      "cmdq");
 	if (ret)
 		return ret;
 
 	/* evtq */
 	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_PROD,
-				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS);
+				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS,
+				      "evtq");
 	if (ret)
 		return ret;
 
@@ -2315,7 +2336,8 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 		return 0;
 
 	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
-				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS);
+				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS,
+				       "priq");
 }
 
 static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
@@ -2879,7 +2901,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		return -ENXIO;
 	}
 
-	/* Queue sizes, capped at 4k */
+	/* Queue sizes, capped to ensure natural alignment */
 	smmu->cmdq.q.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
 					 FIELD_GET(IDR1_CMDQS, reg));
 	if (!smmu->cmdq.q.max_n_shift) {
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
