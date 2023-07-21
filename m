Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0407FB
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 06:36:22 +0000 (UTC)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L2PfHc010529;
	Thu, 20 Jul 2023 23:36:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=eiE0t1Y6hvHtNltoFN6UQCbnWTgRzOhbld9Wfvf5Ag8=;
 b=b8ExM3SsqvB5zftlu1jz7QlLDtsuroLK4ODpSyjD8mHNkYz34rzXeZb2y1jmGbNvdh+G
 oFApoOVm3giMUONpHXYy+SwOEE7FNHL+28j3jbIDK3Zi4WOa58fuWlUEtmNe8LJpYyeN
 m7T9gwCsFwgj0GG5cP7DRfbE1fCLhyt1HU0tjOFFTmfCdE2ph1Dphz3DiSm/kooibcE7
 UaAYDRGbwD5V71HlToC8np26bxTdp+yamctc4yZ8lgI0ZZE5P3Kzfg8HovLmFMYs401k
 ASI1LgoCEmIjC/mR716k/bSxEuKwlhLmuRK1xeOqRKgNoIEdJHsd/4YAyp3hCmgQ87sD Ug== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ryh7g8nme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 20 Jul 2023 23:36:06 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 20 Jul
 2023 23:36:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 20 Jul 2023 23:36:04 -0700
Received: from odyssey-031.marvell.com (unknown [10.75.48.92])
	by maili.marvell.com (Postfix) with ESMTP id BCBF13F7068;
	Thu, 20 Jul 2023 23:36:03 -0700 (PDT)
From: Tanmay Jagdale <tanmay@marvell.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <baolu.lu@linux.intel.com>, <thunder.leizhen@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <gcherian@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>
Subject: [RESEND PATCH 3/4] iommu/arm-smmu-v3: Add arm_smmu_ecmdq_issue_cmdlist() for non-shared ECMDQ
Date: Fri, 21 Jul 2023 02:35:12 -0400
Message-ID: <20230721063513.33431-4-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721063513.33431-1-tanmay@marvell.com>
References: <20230721063513.33431-1-tanmay@marvell.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _HYL2lVCotGiVS3tVEKCMo3a6KHKTKoJ
X-Proofpoint-GUID: _HYL2lVCotGiVS3tVEKCMo3a6KHKTKoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_03,2023-07-20_01,2023-05-22_02

From: Zhen Lei <thunder.leizhen@huawei.com>

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
index 1b3b37a1972e..dc3ff4796aaf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -777,6 +777,87 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
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
@@ -806,6 +887,9 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 	llq.max_n_shift = cmdq->q.llq.max_n_shift;
 
+	if (!cmdq->shared)
+		return arm_smmu_ecmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
 	/* 1. Allocate some space in the queue */
 	local_irq_save(flags);
 	llq.val = READ_ONCE(cmdq->q.llq.val);
@@ -3022,6 +3106,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
+	cmdq->shared = 1;
 	atomic_set(&cmdq->owner_prod, 0);
 	atomic_set(&cmdq->lock, 0);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1f8777817e31..a8988fcd605f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -574,6 +574,7 @@ struct arm_smmu_cmdq {
 	atomic_long_t			*valid_map;
 	atomic_t			owner_prod;
 	atomic_t			lock;
+	int				shared;
 };
 
 struct arm_smmu_ecmdq {
-- 
2.34.1

