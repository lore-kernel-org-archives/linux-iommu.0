Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041E2C433E1
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 14:04:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4BC20739
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 14:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4BC20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B0868891A3;
	Tue, 16 Jun 2020 14:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s20bOnzxiB9h; Tue, 16 Jun 2020 14:04:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E570588CBB;
	Tue, 16 Jun 2020 14:04:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2FE1C0895;
	Tue, 16 Jun 2020 14:04:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F9F4C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 14:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8EF1C886B6
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 14:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CBPOU-poiXwt for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 14:04:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 18AD1886A9
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 14:04:00 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id BDC26A55E90A4815332F;
 Tue, 16 Jun 2020 22:03:57 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 22:03:51 +0800
From: John Garry <john.garry@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH RFC v2 2/4] iommu/arm-smmu-v3: Calculate bits for prod and
 owner
Date: Tue, 16 Jun 2020 21:59:51 +0800
Message-ID: <1592315993-164290-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1592315993-164290-1-git-send-email-john.garry@huawei.com>
References: <1592315993-164290-1-git-send-email-john.garry@huawei.com>
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

Ignoring limits of HW max_n_shift and HW cmdq memory allocation, approx 16K
is the max supported CPUs. For this, max_n_shift would be 14.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 41 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a8e814c652fe..c3562dc35d45 100644
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
@@ -3141,8 +3146,26 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 				   unsigned long cons_off,
 				   size_t dwords, const char *name)
 {
+	int cpus = num_possible_cpus();
 	size_t qsz;
 
+	/*
+	 * We can get the number of bits required for owner counting by
+	 * log2(nr possible cpus) + 1
+	 */
+	int bits_for_cmdq_owner = ilog2(cpus) + 1;
+	/*
+	 * 1-bit for overflow, 1-bit for wrap, 1-bit extra to ensure prod+wrap
+	 * does not overflow into CPU count.
+	 */
+	int bits_available_for_prod = 32 - 3 - bits_for_cmdq_owner;
+	int entries_for_prod;
+
+	if (bits_available_for_prod < 1) /* How many CPUs??? */
+		return -ENOMEM;
+
+	q->llq.max_n_shift = min_t(int, q->llq.max_n_shift,
+				   bits_available_for_prod);
 	do {
 		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
 		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
@@ -3152,6 +3175,22 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 
 		q->llq.max_n_shift--;
 	} while (1);
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
+	 * account CMD_SYNC
+	 */
+	q->llq.max_cmd_per_batch = min_t(u32, (entries_for_prod - cpus) / cpus,
+					 CMDQ_BATCH_ENTRIES);
+	q->llq.owner_count_shift = q->llq.max_n_shift + 2;
 
 	if (!q->base) {
 		dev_err(smmu->dev,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
