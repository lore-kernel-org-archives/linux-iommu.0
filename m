Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA1AC433E1
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 17:33:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09AD2075A
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 17:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09AD2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C3BE2887A6;
	Mon, 22 Jun 2020 17:33:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NFfntm5PzXh1; Mon, 22 Jun 2020 17:33:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 55B7D887BC;
	Mon, 22 Jun 2020 17:33:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 332A3C08A7;
	Mon, 22 Jun 2020 17:33:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32BFAC016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 17:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 21856887A6
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 17:33:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RVwrzSq1BjFA for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 17:33:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 099FB88677
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 17:32:59 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 89B9DE93CC20475B994A;
 Tue, 23 Jun 2020 01:32:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 23 Jun 2020 01:32:42 +0800
From: John Garry <john.garry@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH 2/4] iommu/arm-smmu-v3: Calculate bits for prod and owner
Date: Tue, 23 Jun 2020 01:28:38 +0800
Message-ID: <1592846920-45338-3-git-send-email-john.garry@huawei.com>
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

Since the arm_smmu_ll_queue.prod will be for counting the "owner" value
and also HW prod pointer, calculate how many bits are available for and
used by each.

This is based on the number of possible CPUs in the system. And we require
that each CPU can issue a minimum of 2 commands per batch - 1 x CMD_SYNC
and at least 1 x other.

Ignoring limits of HW max_n_shift and HW cmdq memory allocation, approx 32K
is the max supported CPUs. For this, max_n_shift would be 15.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 64 ++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a8e814c652fe..4e9677b066f1 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -532,6 +532,8 @@ struct arm_smmu_ll_queue {
 		u8			__pad[SMP_CACHE_BYTES];
 	} ____cacheline_aligned_in_smp;
 	u32				max_n_shift;
+	u32				max_cmd_per_batch;
+	u32				owner_count_shift;
 };
 
 struct arm_smmu_queue {
@@ -1515,7 +1517,10 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_batch *cmds,
 				    struct arm_smmu_cmdq_ent *cmd)
 {
-	if (cmds->num == CMDQ_BATCH_ENTRIES) {
+	struct arm_smmu_cmdq *q = &smmu->cmdq;
+	struct arm_smmu_ll_queue *llq = &q->q.llq;
+
+	if (cmds->num == llq->max_cmd_per_batch) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
 		cmds->num = 0;
 	}
@@ -3177,6 +3182,58 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
+static int arm_smmu_init_cmd_queue(struct arm_smmu_device *smmu,
+				   struct arm_smmu_queue *q,
+				   unsigned long prod_off,
+				   unsigned long cons_off,
+				   size_t dwords)
+{
+	u32 cpus = num_possible_cpus(), bits_for_cmdq_owner,
+		bits_available_for_prod, entries_for_prod;
+	int ret;
+
+	/*
+	 * We can get the number of bits required for owner counting by
+	 * log2(nr possible cpus) + 1
+	 */
+	bits_for_cmdq_owner = ilog2(cpus) + 1;
+
+	/*
+	 * Add an extra bit to ensure prod(+wrap) do not overflow into
+	 * owner count.
+	 */
+	bits_available_for_prod = 32 - 1 - bits_for_cmdq_owner;
+
+	if (bits_available_for_prod < 1) /* How many CPUs??? */
+		return -ENOMEM;
+
+	q->llq.max_n_shift = min(q->llq.max_n_shift, bits_available_for_prod);
+
+	ret = arm_smmu_init_one_queue(smmu, q, prod_off, cons_off, dwords,
+				      "cmdq");
+	if (ret)
+		return ret;
+
+	entries_for_prod = 1 << q->llq.max_n_shift;
+
+	/*
+	 * We need at least 2 commands in a batch (1 x CMD_SYNC and 1 x
+	 * whatever else).
+	 */
+	if (entries_for_prod < 2 * cpus)
+		return -ENOMEM;
+
+	/*
+	 * When finding max_cmd_per_batch, deduct 1 entry per batch to take
+	 * account of CMD_SYNC
+	 */
+	q->llq.max_cmd_per_batch = min((entries_for_prod / cpus) - 1,
+				       (u32)CMDQ_BATCH_ENTRIES);
+	q->llq.owner_count_shift = q->llq.max_n_shift + 2;
+
+	return 0;
+}
+
 static void arm_smmu_cmdq_free_bitmap(void *data)
 {
 	unsigned long *bitmap = data;
@@ -3210,9 +3267,8 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	int ret;
 
 	/* cmdq */
-	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
-				      ARM_SMMU_CMDQ_CONS, CMDQ_ENT_DWORDS,
-				      "cmdq");
+	ret = arm_smmu_init_cmd_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
+				      ARM_SMMU_CMDQ_CONS, CMDQ_ENT_DWORDS);
 	if (ret)
 		return ret;
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
