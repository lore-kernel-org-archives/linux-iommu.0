From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 4/4] iommu/arm-smmu-v3: Poll for CMD_SYNC outside cmdq lock
Date: Thu, 31 Aug 2017 14:44:28 +0100
Message-ID: <ff239173e47dfa0fc76eaa2a25b3cbcfe8dce5e6.1504182142.git.robin.murphy@arm.com>
References: <cover.1504182142.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1504182142.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Even without the MSI trick, we can still do a lot better than hogging
the entire queue while it drains. All we actually need to do for the
necessary guarantee of completion is wait for our particular command to
have been consumed, and as long as we keep track of where it is there is
no need to block other CPUs from adding further commands in the
meantime. There is one theoretical (but incredibly unlikely) edge case
to avoid, where cons has wrapped twice to still appear 'behind' the sync
position - this is easily disambiguated by adding a generation count to
the queue to indicate when prod wraps, since cons cannot wrap twice
without prod having wrapped at least once.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: New

 drivers/iommu/arm-smmu-v3.c | 81 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 311f482b93d5..f5c5da553803 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -417,7 +417,6 @@
 
 /* High-level queue structures */
 #define ARM_SMMU_POLL_TIMEOUT_US	100
-#define ARM_SMMU_CMDQ_DRAIN_TIMEOUT_US	1000000 /* 1s! */
 #define ARM_SMMU_SYNC_TIMEOUT_US	1000000 /* 1s! */
 
 #define MSI_IOVA_BASE			0x8000000
@@ -540,6 +539,7 @@ struct arm_smmu_queue {
 struct arm_smmu_cmdq {
 	struct arm_smmu_queue		q;
 	spinlock_t			lock;
+	int				generation;
 };
 
 struct arm_smmu_evtq {
@@ -770,21 +770,12 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
 	writel(q->prod, q->prod_reg);
 }
 
-/*
- * Wait for the SMMU to consume items. If drain is true, wait until the queue
- * is empty. Otherwise, wait until there is at least one free slot.
- */
-static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
+/* Wait for the SMMU to consume items, until there is at least one free slot */
+static int queue_poll_cons(struct arm_smmu_queue *q, bool wfe)
 {
-	ktime_t timeout;
-	unsigned int delay = 1;
+	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
 
-	/* Wait longer if it's queue drain */
-	timeout = ktime_add_us(ktime_get(), drain ?
-					    ARM_SMMU_CMDQ_DRAIN_TIMEOUT_US :
-					    ARM_SMMU_POLL_TIMEOUT_US);
-
-	while (queue_sync_cons(q), (drain ? !queue_empty(q) : queue_full(q))) {
+	while (queue_sync_cons(q), queue_full(q)) {
 		if (ktime_compare(ktime_get(), timeout) > 0)
 			return -ETIMEDOUT;
 
@@ -792,8 +783,7 @@ static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
 			wfe();
 		} else {
 			cpu_relax();
-			udelay(delay);
-			delay *= 2;
+			udelay(1);
 		}
 	}
 
@@ -959,15 +949,20 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
 
-static void arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd)
+static u32 arm_smmu_cmdq_insert_cmd(struct arm_smmu_device *smmu, u64 *cmd)
 {
 	struct arm_smmu_queue *q = &smmu->cmdq.q;
 	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
 
 	while (queue_insert_raw(q, cmd) == -ENOSPC) {
-		if (queue_poll_cons(q, false, wfe))
+		if (queue_poll_cons(q, wfe))
 			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 	}
+
+	if (Q_IDX(q, q->prod) == 0)
+		smmu->cmdq.generation++;
+
+	return q->prod;
 }
 
 static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
@@ -997,15 +992,54 @@ static int arm_smmu_sync_poll_msi(struct arm_smmu_device *smmu, u32 sync_idx)
 	return (int)(val - sync_idx) < 0 ? -ETIMEDOUT : 0;
 }
 
+static int arm_smmu_sync_poll_cons(struct arm_smmu_device *smmu, u32 sync_idx,
+				   int sync_gen)
+{
+	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_SYNC_TIMEOUT_US);
+	struct arm_smmu_queue *q = &smmu->cmdq.q;
+	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
+	unsigned int delay = 1;
+
+	do {
+		queue_sync_cons(q);
+		/*
+		 * If we see updates quickly enough, cons has passed sync_idx,
+		 * but not yet wrapped. At worst, cons might have actually
+		 * wrapped an even number of times, but that still guarantees
+		 * the original sync must have been consumed.
+		 */
+		if (Q_IDX(q, q->cons) >= Q_IDX(q, sync_idx) &&
+		    Q_WRP(q, sync_idx) == Q_WRP(q, q->cons))
+			return 0;
+		/*
+		 * Otherwise, cons may have passed sync_idx and wrapped one or
+		 * more times to appear behind it again, but in that case prod
+		 * must also be one or more generations ahead.
+		 */
+		if (Q_IDX(q, q->cons) < Q_IDX(q, sync_idx) &&
+		    READ_ONCE(smmu->cmdq.generation) != sync_gen)
+			return 0;
+
+		if (wfe) {
+			wfe();
+		} else {
+			cpu_relax();
+			udelay(delay);
+			delay *= 2;
+		}
+	} while (ktime_before(ktime_get(), timeout));
+
+	return -ETIMEDOUT;
+}
+
 static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 {
 	u64 cmd[CMDQ_ENT_DWORDS];
 	unsigned long flags;
-	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
 	bool msi = (smmu->features & ARM_SMMU_FEAT_MSI) &&
 		   (smmu->features & ARM_SMMU_FEAT_COHERENCY);
 	struct arm_smmu_cmdq_ent ent = { .opcode = CMDQ_OP_CMD_SYNC };
-	int ret;
+	int ret, sync_idx, sync_gen;
 
 	if (msi) {
 		ent.sync.msidata = atomic_inc_return(&smmu->sync_nr);
@@ -1014,13 +1048,14 @@ static void arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
 
 	spin_lock_irqsave(&smmu->cmdq.lock, flags);
-	arm_smmu_cmdq_insert_cmd(smmu, cmd);
-	if (!msi)
-		ret = queue_poll_cons(&smmu->cmdq.q, true, wfe);
+	sync_idx = arm_smmu_cmdq_insert_cmd(smmu, cmd);
+	sync_gen = READ_ONCE(smmu->cmdq.generation);
 	spin_unlock_irqrestore(&smmu->cmdq.lock, flags);
 
 	if (msi)
 		ret = arm_smmu_sync_poll_msi(smmu, ent.sync.msidata);
+	else
+		ret = arm_smmu_sync_poll_cons(smmu, sync_idx, sync_gen);
 	if (ret)
 		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout\n");
 }
-- 
2.13.4.dirty
