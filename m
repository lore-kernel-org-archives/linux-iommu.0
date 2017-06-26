From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/5] iommu/arm-smmu-v3: put off the execution of TLBI* to reduce lock confliction
Date: Mon, 26 Jun 2017 21:38:46 +0800
Message-ID: <1498484330-10840-2-git-send-email-thunder.leizhen@huawei.com>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>, John Garry <john.garry@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Because all TLBI commands should be followed by a SYNC command, to make
sure that it has been completely finished. So we can just add the TLBI
commands into the queue, and put off the execution until meet SYNC or
other commands. To prevent the followed SYNC command waiting for a long
time because of too many commands have been delayed, restrict the max
delayed number.

According to my test, I got the same performance data as I replaced writel
with writel_relaxed in queue_inc_prod.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 291da5f..4481123 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -337,6 +337,7 @@
 /* Command queue */
 #define CMDQ_ENT_DWORDS			2
 #define CMDQ_MAX_SZ_SHIFT		8
+#define CMDQ_MAX_DELAYED		32
 
 #define CMDQ_ERR_SHIFT			24
 #define CMDQ_ERR_MASK			0x7f
@@ -472,6 +473,7 @@ struct arm_smmu_cmdq_ent {
 			};
 		} cfgi;
 
+		#define CMDQ_OP_TLBI_NH_ALL	0x10
 		#define CMDQ_OP_TLBI_NH_ASID	0x11
 		#define CMDQ_OP_TLBI_NH_VA	0x12
 		#define CMDQ_OP_TLBI_EL2_ALL	0x20
@@ -499,6 +501,7 @@ struct arm_smmu_cmdq_ent {
 
 struct arm_smmu_queue {
 	int				irq; /* Wired interrupt */
+	u32				nr_delay;
 
 	__le64				*base;
 	dma_addr_t			base_dma;
@@ -722,11 +725,16 @@ static int queue_sync_prod(struct arm_smmu_queue *q)
 	return ret;
 }
 
-static void queue_inc_prod(struct arm_smmu_queue *q)
+static void queue_inc_swprod(struct arm_smmu_queue *q)
 {
-	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + 1;
+	u32 prod = q->prod + 1;
 
 	q->prod = Q_OVF(q, q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
+}
+
+static void queue_inc_prod(struct arm_smmu_queue *q)
+{
+	queue_inc_swprod(q);
 	writel(q->prod, q->prod_reg);
 }
 
@@ -761,13 +769,24 @@ static void queue_write(__le64 *dst, u64 *src, size_t n_dwords)
 		*dst++ = cpu_to_le64(*src++);
 }
 
-static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent)
+static int queue_insert_raw(struct arm_smmu_queue *q, u64 *ent, int optimize)
 {
 	if (queue_full(q))
 		return -ENOSPC;
 
 	queue_write(Q_ENT(q, q->prod), ent, q->ent_dwords);
-	queue_inc_prod(q);
+
+	/*
+	 * We don't want too many commands to be delayed, this may lead the
+	 * followed sync command to wait for a long time.
+	 */
+	if (optimize && (++q->nr_delay < CMDQ_MAX_DELAYED)) {
+		queue_inc_swprod(q);
+	} else {
+		queue_inc_prod(q);
+		q->nr_delay = 0;
+	}
+
 	return 0;
 }
 
@@ -909,6 +928,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_ent *ent)
 {
+	int optimize = 0;
 	u64 cmd[CMDQ_ENT_DWORDS];
 	unsigned long flags;
 	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
@@ -920,8 +940,17 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 		return;
 	}
 
+	/*
+	 * All TLBI commands should be followed by a sync command later.
+	 * The CFGI commands is the same, but they are rarely executed.
+	 * So just optimize TLBI commands now, to reduce the "if" judgement.
+	 */
+	if ((ent->opcode >= CMDQ_OP_TLBI_NH_ALL) &&
+	    (ent->opcode <= CMDQ_OP_TLBI_NSNH_ALL))
+		optimize = 1;
+
 	spin_lock_irqsave(&smmu->cmdq.lock, flags);
-	while (queue_insert_raw(q, cmd) == -ENOSPC) {
+	while (queue_insert_raw(q, cmd, optimize) == -ENOSPC) {
 		if (queue_poll_cons(q, false, wfe))
 			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 	}
@@ -1953,6 +1982,8 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 		     << Q_BASE_LOG2SIZE_SHIFT;
 
 	q->prod = q->cons = 0;
+	q->nr_delay = 0;
+
 	return 0;
 }
 
@@ -2512,6 +2543,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		dev_err(smmu->dev, "unit-length command queue not supported\n");
 		return -ENXIO;
 	}
+	BUILD_BUG_ON(CMDQ_MAX_DELAYED >= (1 << CMDQ_MAX_SZ_SHIFT));
 
 	smmu->evtq.q.max_n_shift = min((u32)EVTQ_MAX_SZ_SHIFT,
 				       reg >> IDR1_EVTQ_SHIFT & IDR1_EVTQ_MASK);
-- 
2.5.0
