From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4] iommu/arm-smmu-v3: Poll for CMD_SYNC outside cmdq lock
Date: Thu, 26 Jul 2018 18:03:05 +0100
Message-ID: <836061e0a114270be92da2e4d16a70859c2c840e.1532622539.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Even without the MSI trick, we can still do a lot better than hogging
the entire queue while it drains. All we actually need to do for the
necessary guarantee of completion is wait for our particular command to
have been consumed - as long as we keep track of where we inserted it,
there is no need to block other CPUs from adding further commands in the
meantime. There is one theoretical (but incredibly unlikely) edge case
to avoid, where cons has wrapped twice to still appear 'behind' the sync
position - this is easily disambiguated by adding a generation count to
the queue to indicate when prod wraps, since cons cannot wrap twice
without prod having wrapped at least once.

This also makes it reasonable to separate the two conceptually different
modes of polling such that command insertion - which really wants to be
fair and have minimal latency - is not subject to exponential backoff,
and returns to its original implementation.

Tested-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v4: rebase to 4.18-rc3, add tested-by

Fairly sure this isn't actually the fourth version of this particular
patch, but the previous posting[1] was part of a v3 series...

Robin.

[1] https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg20576.html

 drivers/iommu/arm-smmu-v3.c | 137 +++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1d647104bccc..09abf3da2d62 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -474,6 +474,7 @@ struct arm_smmu_queue {
 struct arm_smmu_cmdq {
 	struct arm_smmu_queue		q;
 	spinlock_t			lock;
+	int				generation;
 };
 
 struct arm_smmu_evtq {
@@ -673,6 +674,17 @@ static bool queue_empty(struct arm_smmu_queue *q)
 	       Q_WRP(q, q->prod) == Q_WRP(q, q->cons);
 }
 
+static bool queue_behind(struct arm_smmu_queue *q, u32 idx)
+{
+	return Q_IDX(q, q->cons) < Q_IDX(q, idx);
+}
+
+static bool queue_ahead_not_wrapped(struct arm_smmu_queue *q, u32 idx)
+{
+	return Q_IDX(q, q->cons) >= Q_IDX(q, idx) &&
+	       Q_WRP(q, q->cons) == Q_WRP(q, idx);
+}
+
 static void queue_sync_cons(struct arm_smmu_queue *q)
 {
 	q->cons = readl_relaxed(q->cons_reg);
@@ -706,33 +718,19 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
 	writel(q->prod, q->prod_reg);
 }
 
-/*
- * Wait for the SMMU to consume items. If drain is true, wait until the queue
- * is empty. Otherwise, wait until there is at least one free slot.
- */
-static int queue_poll_cons(struct arm_smmu_queue *q, bool sync, bool wfe)
+static int queue_poll_cons(struct arm_smmu_queue *q, bool wfe)
 {
-	ktime_t timeout;
-	unsigned int delay = 1, spin_cnt = 0;
+	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
 
-	/* Wait longer if it's a CMD_SYNC */
-	timeout = ktime_add_us(ktime_get(), sync ?
-					    ARM_SMMU_CMDQ_SYNC_TIMEOUT_US :
-					    ARM_SMMU_POLL_TIMEOUT_US);
-
-	while (queue_sync_cons(q), (sync ? !queue_empty(q) : queue_full(q))) {
+	while (queue_sync_cons(q), queue_full(q)) {
 		if (ktime_compare(ktime_get(), timeout) > 0)
 			return -ETIMEDOUT;
 
 		if (wfe) {
 			wfe();
-		} else if (++spin_cnt < ARM_SMMU_CMDQ_SYNC_SPIN_COUNT) {
-			cpu_relax();
-			continue;
 		} else {
-			udelay(delay);
-			delay *= 2;
-			spin_cnt = 0;
+			cpu_relax();
+			udelay(1);
 		}
 	}
 
@@ -895,15 +893,20 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
 
-static void arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd)
+static u32 arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd)
 {
 	struct arm_smmu_queue *q = &smmu->cmdq.q;
 	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
 
+	if (Q_IDX(q, q->prod + 1) == 0)
+		WRITE_ONCE(smmu->cmdq.generation, smmu->cmdq.generation + 1);
+
 	while (queue_insert_raw(q, cmd) == -ENOSPC) {
-		if (queue_poll_cons(q, false, wfe))
+		if (queue_poll_cons(q, wfe))
 			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 	}
+
+	return q->prod;
 }
 
 static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
@@ -927,7 +930,7 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
  * The difference between val and sync_idx is bounded by the maximum size of
  * a queue at 2^20 entries, so 32 bits is plenty for wrap-safe arithmetic.
  */
-static int __arm_smmu_sync_poll_msi(struct arm_smmu_device *smmu, u32 sync_idx)
+static int arm_smmu_sync_poll_msi(struct arm_smmu_device *smmu, u32 sync_idx)
 {
 	ktime_t timeout;
 	u32 val;
@@ -940,53 +943,73 @@ static int __arm_smmu_sync_poll_msi(struct arm_smmu_device *smmu, u32 sync_idx)
 	return (int)(val - sync_idx) < 0 ? -ETIMEDOUT : 0;
 }
 
-static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
+static int arm_smmu_sync_poll_cons(struct arm_smmu_device *smmu, u32 sync_idx,
+				   int sync_gen)
 {
-	u64 cmd[CMDQ_ENT_DWORDS];
-	unsigned long flags;
-	struct arm_smmu_cmdq_ent ent = {
-		.opcode = CMDQ_OP_CMD_SYNC,
-		.sync	= {
-			.msidata = atomic_inc_return_relaxed(&smmu->sync_nr),
-			.msiaddr = virt_to_phys(&smmu->sync_count),
-		},
-	};
-
-	arm_smmu_cmdq_build_cmd(cmd, &ent);
-
-	spin_lock_irqsave(&smmu->cmdq.lock, flags);
-	arm_smmu_cmdq_insert_cmd(smmu, cmd);
-	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
-
-	return __arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
-}
-
-static int __arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
-{
-	u64 cmd[CMDQ_ENT_DWORDS];
-	unsigned long flags;
+	struct arm_smmu_queue *q = &smmu->cmdq.q;
 	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
-	struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
-	int ret;
+	unsigned int delay = 1, spin_cnt = 0;
+	ktime_t timeout;
 
-	arm_smmu_cmdq_build_cmd(cmd, &ent);
+	timeout = ktime_add_us(ktime_get(), ARM_SMMU_CMDQ_SYNC_TIMEOUT_US);
+	do {
+		queue_sync_cons(q);
+		/*
+		 * If we see updates quickly enough, cons has passed sync_idx,
+		 * but not yet wrapped. At worst, cons might have actually
+		 * wrapped an even number of times, but that still guarantees
+		 * the original sync must have been consumed.
+		 */
+		if (queue_ahead_not_wrapped(q, sync_idx))
+			return 0;
+		/*
+		 * Otherwise, cons may have passed sync_idx and wrapped one or
+		 * more times to appear behind it again, but in that case prod
+		 * must also be one or more generations ahead.
+		 */
+		if (queue_behind(q, sync_idx) &&
+		    READ_ONCE(smmu->cmdq.generation) != sync_gen)
+			return 0;
 
-	spin_lock_irqsave(&smmu->cmdq.lock, flags);
-	arm_smmu_cmdq_insert_cmd(smmu, cmd);
-	ret = queue_poll_cons(&smmu->cmdq.q, true, wfe);
-	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
+		if (wfe) {
+			wfe();
+		} else if (++spin_cnt < ARM_SMMU_CMDQ_SYNC_SPIN_COUNT) {
+			cpu_relax();
+			continue;
+		} else {
+			udelay(delay);
+			delay *= 2;
+			spin_cnt = 0;
+		}
+	} while (ktime_before(ktime_get(), timeout));
 
-	return ret;
+	return -ETIMEDOUT;
 }
 
 static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 {
-	int ret;
+	u64 cmd[CMDQ_ENT_DWORDS];
+	unsigned long flags;
 	bool msi = (smmu->features & ARM_SMMU_FEAT_MSI) &&
 		   (smmu->features & ARM_SMMU_FEAT_COHERENCY);
+	struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
+	int ret, sync_idx, sync_gen;
 
-	ret = msi ? __arm_smmu_cmdq_issue_sync_msi(smmu)
-		  : __arm_smmu_cmdq_issue_sync(smmu);
+	if (msi) {
+		ent.sync.msidata = atomic_inc_return_relaxed(&smmu->sync_nr);
+		ent.sync.msiaddr = virt_to_phys(&smmu->sync_count);
+	}
+	arm_smmu_cmdq_build_cmd(cmd, &ent);
+
+	spin_lock_irqsave(&smmu->cmdq.lock, flags);
+	sync_idx = arm_smmu_cmdq_insert_cmd(smmu, cmd);
+	sync_gen = READ_ONCE(smmu->cmdq.generation);
+	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
+
+	if (msi)
+		ret = arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
+	else
+		ret = arm_smmu_sync_poll_cons(smmu, sync_idx, sync_gen);
 	if (ret)
 		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout\n");
 }
-- 
2.17.1.dirty
