From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 1/2] iommu/arm-smmu-v3: Poll for CMD_SYNC outside cmdq lock
Date: Wed, 17 Oct 2018 14:56:06 +0100
Message-ID: <61b4c3e5f1322dfe96ca2062a7fe058298340996.1539782799.git.robin.murphy@arm.com>
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

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v5:
 - Rework to incorporate the back-to-back sync elision.
 - Refactor the generation count slightly to preemptively help with
   the HiSilicon MSI workaround.
 - Split the cleanup into a separate patch for ease of review (it could
   happily be squashed when applied).

The fundamental logic is copied directly from v4, but I've dropped the
previous tested-by since there are a fair few subtle changes in how it's
integrated. Patches are based on Will's iommu/devel branch plus my "Fix
big-endian CMD_SYNC writes" patch.

Robin.

 drivers/iommu/arm-smmu-v3.c | 94 +++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 867ba548c2cc..da8a91d116bf 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -588,6 +588,7 @@ struct arm_smmu_device {
 	struct arm_smmu_strtab_cfg	strtab_cfg;
 
 	u32				sync_count;
+	int				cmdq_generation;
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
@@ -676,6 +677,17 @@ static bool queue_empty(struct arm_smmu_queue *q)
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
@@ -709,33 +721,19 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
 	writel(q->prod, q->prod_reg);
 }
 
-/*
- * Wait for the SMMU to consume items. If sync is true, wait until the queue
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
 
@@ -905,8 +903,11 @@ static void arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd)
 
 	smmu->prev_cmd_opcode = FIELD_GET(CMDQ_0_OP, cmd[0]);
 
+	if (Q_IDX(q, q->prod + 1) == 0)
+		WRITE_ONCE(smmu->cmdq_generation, smmu->cmdq_generation + 1);
+
 	while (queue_insert_raw(q, cmd) == -ENOSPC) {
-		if (queue_poll_cons(q, false, wfe))
+		if (queue_poll_cons(q, wfe))
 			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 	}
 }
@@ -945,6 +946,48 @@ static int __arm_smmu_sync_poll_msi(struct arm_smmu_device *smmu, u32 sync_idx)
 	return (int)(val - sync_idx) < 0 ? -ETIMEDOUT : 0;
 }
 
+static int arm_smmu_sync_poll_cons(struct arm_smmu_device *smmu, u32 sync_idx,
+				   int sync_gen)
+{
+	struct arm_smmu_queue *q = &smmu->cmdq.q;
+	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
+	unsigned int delay = 1, spin_cnt = 0;
+	ktime_t timeout;
+
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
+		    READ_ONCE(smmu->cmdq_generation) != sync_gen)
+			return 0;
+
+		if (wfe) {
+			wfe();
+		} else if (++spin_cnt < ARM_SMMU_CMDQ_SYNC_SPIN_COUNT) {
+			cpu_relax();
+		} else {
+			udelay(delay);
+			delay *= 2;
+			spin_cnt = 0;
+		}
+	} while (ktime_before(ktime_get(), timeout));
+
+	return -ETIMEDOUT;
+}
+
 static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
 {
 	u64 cmd[CMDQ_ENT_DWORDS];
@@ -976,18 +1019,19 @@ static int __arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 {
 	u64 cmd[CMDQ_ENT_DWORDS];
 	unsigned long flags;
-	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
 	struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
-	int ret;
+	int sync_idx, sync_gen;
 
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
 
 	spin_lock_irqsave(&smmu->cmdq.lock, flags);
-	arm_smmu_cmdq_insert_cmd(smmu, cmd);
-	ret = queue_poll_cons(&smmu->cmdq.q, true, wfe);
+	if (smmu->prev_cmd_opcode != CMDQ_OP_CMD_SYNC)
+		arm_smmu_cmdq_insert_cmd(smmu, cmd);
+	sync_idx = smmu->cmdq.q.prod;
+	sync_gen = READ_ONCE(smmu->cmdq_generation);
 	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
 
-	return ret;
+	return arm_smmu_sync_poll_cons(smmu, sync_idx, sync_gen);
 }
 
 static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
-- 
2.19.1.dirty
