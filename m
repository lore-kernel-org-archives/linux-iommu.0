Return-Path: <SRS0=OQ2u=LU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5C4C49EA7
	for <iommu@archiver.kernel.org>; Sat, 26 Jun 2021 11:02:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4362E6145E
	for <iommu@archiver.kernel.org>; Sat, 26 Jun 2021 11:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4362E6145E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E2131404C9;
	Sat, 26 Jun 2021 11:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XbqZaFbkt2YJ; Sat, 26 Jun 2021 11:02:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9CA794036A;
	Sat, 26 Jun 2021 11:02:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3B25C0029;
	Sat, 26 Jun 2021 11:02:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F996C001A
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 11:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2325160615
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 11:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D_Y46PqSOUPR for <iommu@lists.linux-foundation.org>;
 Sat, 26 Jun 2021 11:02:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EAA3C6066D
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 11:02:14 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GBrTm6X88zZkCw;
 Sat, 26 Jun 2021 18:59:08 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:12 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:11 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 7/8] iommu/arm-smmu-v3: Add arm_smmu_ecmdq_issue_cmdlist()
 for non-shared ECMDQ
Date: Sat, 26 Jun 2021 19:01:29 +0800
Message-ID: <20210626110130.2416-8-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210626110130.2416-1-thunder.leizhen@huawei.com>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
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

When a core can exclusively own an ECMDQ, competition with other cores
does not need to be considered during command insertion. Therefore, we can
delete the part of arm_smmu_cmdq_issue_cmdlist() that deals with
multi-core contention and generate a more efficient ECMDQ-specific
function arm_smmu_ecmdq_issue_cmdlist().

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 85 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 86 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d5205030710bd1a..a088f2479fc6223 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -769,6 +769,87 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
 	}
 }
 
+/*
+ * The function is used when the current core exclusively occupies an ECMDQ.
+ * This is a reduced version of arm_smmu_cmdq_issue_cmdlist(), which eliminates
+ * a lot of unnecessary inter-core competition considerations.
+ */
+static int arm_smmu_ecmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+					struct arm_smmu_cmdq *cmdq,
+					u64 *cmds, int n, bool sync)
+{
+	u32 prod;
+	unsigned long flags;
+	struct arm_smmu_ll_queue llq = {
+		.max_n_shift = cmdq->q.llq.max_n_shift,
+	}, head;
+	int ret = 0;
+
+	/* 1. Allocate some space in the queue */
+	local_irq_save(flags);
+	llq.val = READ_ONCE(cmdq->q.llq.val);
+	do {
+		u64 old;
+
+		while (!queue_has_space(&llq, n + sync)) {
+			local_irq_restore(flags);
+			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
+				dev_err_ratelimited(smmu->dev, "ECMDQ timeout\n");
+			local_irq_save(flags);
+		}
+
+		head.cons = llq.cons;
+		head.prod = queue_inc_prod_n(&llq, n + sync);
+
+		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
+		if (old == llq.val)
+			break;
+
+		llq.val = old;
+	} while (1);
+
+	/* 2. Write our commands into the queue */
+	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
+	if (sync) {
+		u64 cmd_sync[CMDQ_ENT_DWORDS];
+
+		prod = queue_inc_prod_n(&llq, n);
+		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, &cmdq->q, prod);
+		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
+	}
+
+	/* 3. Ensuring commands are visible first */
+	dma_wmb();
+
+	/* 4. Advance the hardware prod pointer */
+	read_lock(&cmdq->q.ecmdq_lock);
+	writel_relaxed(head.prod | cmdq->q.ecmdq_prod, cmdq->q.prod_reg);
+	read_unlock(&cmdq->q.ecmdq_lock);
+
+	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
+	if (sync) {
+		llq.prod = queue_inc_prod_n(&llq, n);
+		ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
+		if (ret) {
+			dev_err_ratelimited(smmu->dev,
+					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
+					    llq.prod,
+					    readl_relaxed(cmdq->q.prod_reg),
+					    readl_relaxed(cmdq->q.cons_reg));
+		}
+
+		/*
+		 * Update cmdq->q.llq.cons, to improve the success rate of
+		 * queue_has_space() when some new commands are inserted next
+		 * time.
+		 */
+		WRITE_ONCE(cmdq->q.llq.cons, llq.cons);
+	}
+
+	local_irq_restore(flags);
+	return ret;
+}
+
 /*
  * This is the actual insertion function, and provides the following
  * ordering guarantees to callers:
@@ -798,6 +879,9 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	}, head = llq;
 	int ret = 0;
 
+	if (!cmdq->shared)
+		return arm_smmu_ecmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
 	/* 1. Allocate some space in the queue */
 	local_irq_save(flags);
 	llq.val = READ_ONCE(cmdq->q.llq.val);
@@ -3001,6 +3085,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 	atomic_long_t *bitmap;
 
+	cmdq->shared = 1;
 	atomic_set(&cmdq->owner_prod, 0);
 	atomic_set(&cmdq->lock, 0);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3f3a867a4626fcd..c6efbea3c0a1cda 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -569,6 +569,7 @@ struct arm_smmu_cmdq {
 	atomic_long_t			*valid_map;
 	atomic_t			owner_prod;
 	atomic_t			lock;
+	int				shared;
 };
 
 struct arm_smmu_ecmdq {
-- 
2.26.0.106.g9fadedd


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
