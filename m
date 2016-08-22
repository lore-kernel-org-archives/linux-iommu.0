From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu: Fix event queues synchronization
Date: Mon, 22 Aug 2016 14:42:24 +0100
Message-ID: <20160822134224.18574-1-jean-philippe.brucker@arm.com>
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

SMMUv3 only sends interrupts for event queues (EVTQ and PRIQ) when they
transition from empty to non-empty. At the moment, if the SMMU adds new
items to a queue before the event thread finished consuming a previous
batch, the driver ignores any new item. The queue is then stuck in
non-empty state and all subsequent events will be lost.

As an example, consider the following flow, where (P, C) is the SMMU view
of producer/consumer indices, and (p, c) the driver view.

						P C | p c
  1. SMMU appends a PPR to the PRI queue,	1 0 | 0 0
          sends an MSI
  2. PRIQ handler is called.			1 0 | 1 0
  3. SMMU appends a PPR to the PRI queue.	2 0 | 1 0
  4. PRIQ thread removes the first element.	2 1 | 1 1

  5. PRIQ thread believes that the queue is empty, goes into idle
     indefinitely.

To avoid this, always synchronize the producer index and drain the queue
once before leaving an event handler. In order to prevent races on the
local producer index, move all event queue handling into the threads.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 150 +++++++++++++++++++-------------------------
 1 file changed, 66 insertions(+), 84 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1cd526d..a9219e6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1164,36 +1164,66 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	struct arm_smmu_queue *q = &smmu->evtq.q;
 	u64 evt[EVTQ_ENT_DWORDS];
 
-	while (!queue_remove_raw(q, evt)) {
-		u8 id = evt[0] >> EVTQ_0_ID_SHIFT & EVTQ_0_ID_MASK;
+	do {
+		while (!queue_remove_raw(q, evt)) {
+			u8 id = evt[0] >> EVTQ_0_ID_SHIFT & EVTQ_0_ID_MASK;
 
-		dev_info(smmu->dev, "event 0x%02x received:\n", id);
-		for (i = 0; i < ARRAY_SIZE(evt); ++i)
-			dev_info(smmu->dev, "\t0x%016llx\n",
-				 (unsigned long long)evt[i]);
-	}
+			dev_info(smmu->dev, "event 0x%02x received:\n", id);
+			for (i = 0; i < ARRAY_SIZE(evt); ++i)
+				dev_info(smmu->dev, "\t0x%016llx\n",
+					 (unsigned long long)evt[i]);
+
+		}
+
+		/*
+		 * Not much we can do on overflow, so scream and pretend we're
+		 * trying harder.
+		 */
+		if (queue_sync_prod(q) == -EOVERFLOW)
+			dev_err(smmu->dev, "EVTQ overflow detected -- events lost\n");
+	} while (!queue_empty(q));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t arm_smmu_evtq_handler(int irq, void *dev)
-{
-	irqreturn_t ret = IRQ_WAKE_THREAD;
-	struct arm_smmu_device *smmu = dev;
-	struct arm_smmu_queue *q = &smmu->evtq.q;
-
-	/*
-	 * Not much we can do on overflow, so scream and pretend we're
-	 * trying harder.
-	 */
-	if (queue_sync_prod(q) == -EOVERFLOW)
-		dev_err(smmu->dev, "EVTQ overflow detected -- events lost\n");
-	else if (queue_empty(q))
-		ret = IRQ_NONE;
+static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
+{
+	u32 sid, ssid;
+	u16 grpid;
+	bool ssv, last;
+
+	sid = evt[0] >> PRIQ_0_SID_SHIFT & PRIQ_0_SID_MASK;
+	ssv = evt[0] & PRIQ_0_SSID_V;
+	ssid = ssv ? evt[0] >> PRIQ_0_SSID_SHIFT & PRIQ_0_SSID_MASK : 0;
+	last = evt[0] & PRIQ_0_PRG_LAST;
+	grpid = evt[1] >> PRIQ_1_PRG_IDX_SHIFT & PRIQ_1_PRG_IDX_MASK;
+
+	dev_info(smmu->dev, "unexpected PRI request received:\n");
+	dev_info(smmu->dev,
+		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
+		 sid, ssid, grpid, last ? "L" : "",
+		 evt[0] & PRIQ_0_PERM_PRIV ? "" : "un",
+		 evt[0] & PRIQ_0_PERM_READ ? "R" : "",
+		 evt[0] & PRIQ_0_PERM_WRITE ? "W" : "",
+		 evt[0] & PRIQ_0_PERM_EXEC ? "X" : "",
+		 evt[1] & PRIQ_1_ADDR_MASK << PRIQ_1_ADDR_SHIFT);
+
+	if (last) {
+		struct arm_smmu_cmdq_ent cmd = {
+			.opcode			= CMDQ_OP_PRI_RESP,
+			.substream_valid	= ssv,
+			.pri			= {
+				.sid	= sid,
+				.ssid	= ssid,
+				.grpid	= grpid,
+				.resp	= PRI_RESP_DENY,
+			},
+		};
 
-	return ret;
+		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	}
 }
 
 static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
@@ -1202,63 +1232,19 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	struct arm_smmu_queue *q = &smmu->priq.q;
 	u64 evt[PRIQ_ENT_DWORDS];
 
-	while (!queue_remove_raw(q, evt)) {
-		u32 sid, ssid;
-		u16 grpid;
-		bool ssv, last;
-
-		sid = evt[0] >> PRIQ_0_SID_SHIFT & PRIQ_0_SID_MASK;
-		ssv = evt[0] & PRIQ_0_SSID_V;
-		ssid = ssv ? evt[0] >> PRIQ_0_SSID_SHIFT & PRIQ_0_SSID_MASK : 0;
-		last = evt[0] & PRIQ_0_PRG_LAST;
-		grpid = evt[1] >> PRIQ_1_PRG_IDX_SHIFT & PRIQ_1_PRG_IDX_MASK;
-
-		dev_info(smmu->dev, "unexpected PRI request received:\n");
-		dev_info(smmu->dev,
-			 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
-			 sid, ssid, grpid, last ? "L" : "",
-			 evt[0] & PRIQ_0_PERM_PRIV ? "" : "un",
-			 evt[0] & PRIQ_0_PERM_READ ? "R" : "",
-			 evt[0] & PRIQ_0_PERM_WRITE ? "W" : "",
-			 evt[0] & PRIQ_0_PERM_EXEC ? "X" : "",
-			 evt[1] & PRIQ_1_ADDR_MASK << PRIQ_1_ADDR_SHIFT);
-
-		if (last) {
-			struct arm_smmu_cmdq_ent cmd = {
-				.opcode			= CMDQ_OP_PRI_RESP,
-				.substream_valid	= ssv,
-				.pri			= {
-					.sid	= sid,
-					.ssid	= ssid,
-					.grpid	= grpid,
-					.resp	= PRI_RESP_DENY,
-				},
-			};
+	do {
+		while (!queue_remove_raw(q, evt))
+			arm_smmu_handle_ppr(smmu, evt);
 
-			arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-		}
-	}
+		if (queue_sync_prod(q) == -EOVERFLOW)
+			dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
+	} while (!queue_empty(q));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t arm_smmu_priq_handler(int irq, void *dev)
-{
-	irqreturn_t ret = IRQ_WAKE_THREAD;
-	struct arm_smmu_device *smmu = dev;
-	struct arm_smmu_queue *q = &smmu->priq.q;
-
-	/* PRIQ overflow indicates a programming error */
-	if (queue_sync_prod(q) == -EOVERFLOW)
-		dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
-	else if (queue_empty(q))
-		ret = IRQ_NONE;
-
-	return ret;
-}
-
 static irqreturn_t arm_smmu_cmdq_sync_handler(int irq, void *dev)
 {
 	/* We don't actually use CMD_SYNC interrupts for anything */
@@ -1291,15 +1277,11 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	if (active & GERROR_MSI_GERROR_ABT_ERR)
 		dev_warn(smmu->dev, "GERROR MSI write aborted\n");
 
-	if (active & GERROR_MSI_PRIQ_ABT_ERR) {
+	if (active & GERROR_MSI_PRIQ_ABT_ERR)
 		dev_warn(smmu->dev, "PRIQ MSI write aborted\n");
-		arm_smmu_priq_handler(irq, smmu->dev);
-	}
 
-	if (active & GERROR_MSI_EVTQ_ABT_ERR) {
+	if (active & GERROR_MSI_EVTQ_ABT_ERR)
 		dev_warn(smmu->dev, "EVTQ MSI write aborted\n");
-		arm_smmu_evtq_handler(irq, smmu->dev);
-	}
 
 	if (active & GERROR_MSI_CMDQ_ABT_ERR) {
 		dev_warn(smmu->dev, "CMDQ MSI write aborted\n");
@@ -2207,10 +2189,10 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	/* Request interrupt lines */
 	irq = smmu->evtq.q.irq;
 	if (irq) {
-		ret = devm_request_threaded_irq(smmu->dev, irq,
-						arm_smmu_evtq_handler,
+		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
 						arm_smmu_evtq_thread,
-						0, "arm-smmu-v3-evtq", smmu);
+						IRQF_ONESHOT,
+						"arm-smmu-v3-evtq", smmu);
 		if (ret < 0)
 			dev_warn(smmu->dev, "failed to enable evtq irq\n");
 	}
@@ -2235,10 +2217,10 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	if (smmu->features & ARM_SMMU_FEAT_PRI) {
 		irq = smmu->priq.q.irq;
 		if (irq) {
-			ret = devm_request_threaded_irq(smmu->dev, irq,
-							arm_smmu_priq_handler,
+			ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
 							arm_smmu_priq_thread,
-							0, "arm-smmu-v3-priq",
+							IRQF_ONESHOT,
+							"arm-smmu-v3-priq",
 							smmu);
 			if (ret < 0)
 				dev_warn(smmu->dev,
-- 
2.9.2
