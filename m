From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu: Fix polling of command queue
Date: Mon,  5 Sep 2016 14:09:53 +0100
Message-ID: <20160905130953.1690-1-jean-philippe.brucker@arm.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When the SMMUv3 driver attempts to send a command, it adds an entry to the
command queue. This is a circular buffer, where both the producer and
consumer have a wrap bit. When producer.index == consumer.index and
producer.wrap == consumer.wrap, the list is empty. When producer.index ==
consumer.index and producer.wrap != consumer.wrap, the list is full.

If the list is full when the driver needs to add a command, it waits for
the SMMU to consume one command, and advance the consumer pointer. The
problem is that we currently rely on "X before Y" operation to know if
entries have been consumed, which is a bit fiddly since it only makes
sense when the distance between X and Y is less than or equal to the size
of the queue. At the moment when the list is full, we use "Consumer before
Producer + 1", which is out of range and returns a value opposite to what
we expect: when the queue transitions to not full, we stay in the polling
loop and time out, printing an error.

Given that the actual bug was difficult to determine, simplify the polling
logic by relying exclusively on queue_full and queue_empty, that don't
have this range constraint. Polling the queue is now straightforward:

* When we want to add a command and the list is full, wait until it isn't
  full and retry.
* After adding a sync, wait for the list to be empty before returning.

Suggested-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a60dea6..fc938008 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -868,19 +868,15 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
 	writel(q->prod, q->prod_reg);
 }
 
-static bool __queue_cons_before(struct arm_smmu_queue *q, u32 until)
-{
-	if (Q_WRP(q, q->cons) == Q_WRP(q, until))
-		return Q_IDX(q, q->cons) < Q_IDX(q, until);
-
-	return Q_IDX(q, q->cons) >= Q_IDX(q, until);
-}
-
-static int queue_poll_cons(struct arm_smmu_queue *q, u32 until, bool wfe)
+/*
+ * Wait for the SMMU to consume items. If drain is true, wait until the queue
+ * is empty. Otherwise, wait until there is at least one free slot.
+ */
+static int queue_poll_cons(struct arm_smmu_queue *q, bool drain, bool wfe)
 {
 	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
 
-	while (queue_sync_cons(q), __queue_cons_before(q, until)) {
+	while (queue_sync_cons(q), (drain ? !queue_empty(q) : queue_full(q))) {
 		if (ktime_compare(ktime_get(), timeout) > 0)
 			return -ETIMEDOUT;
 
@@ -1073,7 +1069,6 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_ent *ent)
 {
-	u32 until;
 	u64 cmd[CMDQ_ENT_DWORDS];
 	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
 	struct arm_smmu_queue *q = &smmu->cmdq.q;
@@ -1085,17 +1080,12 @@ static void arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	}
 
 	spin_lock(&smmu->cmdq.lock);
-	while (until = q->prod + 1, queue_insert_raw(q, cmd) == -ENOSPC) {
-		/*
-		 * Keep the queue locked, otherwise the producer could wrap
-		 * twice and we could see a future consumer pointer that looks
-		 * like it's behind us.
-		 */
-		if (queue_poll_cons(q, until, wfe))
+	while (queue_insert_raw(q, cmd) == -ENOSPC) {
+		if (queue_poll_cons(q, false, wfe))
 			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 	}
 
-	if (ent->opcode == CMDQ_OP_CMD_SYNC && queue_poll_cons(q, until, wfe))
+	if (ent->opcode == CMDQ_OP_CMD_SYNC && queue_poll_cons(q, true, wfe))
 		dev_err_ratelimited(smmu->dev, "CMD_SYNC timeout\n");
 	spin_unlock(&smmu->cmdq.lock);
 }
-- 
2.9.2
