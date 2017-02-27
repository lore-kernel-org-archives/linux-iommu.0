From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 27/30] iommu/arm-smmu-v3: Handle PRI queue overflow
Date: Mon, 27 Feb 2017 19:54:38 +0000
Message-ID: <20170227195441.5170-28-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When the PRI queue is full, it enters overflow condition, which is sticky
and exited by the PRI thread once it has had time to free up some slots.
During that time, no new entry is added to the queue. The SMMU
automatically replies to PRI Page Requests (PPR) that have "last=1" with
"success", to let the device retry later. PPRs that have "last=0" and
PASID Stop Markers are silently ignored. Two related issues need to be
fixed:

* Any PPR in the PRI queue prior to the overflow condition might be in a
  Page Request Group (PRG) that has its last entry auto-responded while in
  overflow. Until we fix up the overflow, ignore any non-last PPR received
  by the PRI thread.

* In addition, any PRG of PPRs already committed to the fault queue is now
  potentially invalid, since their last PPR might have been lost. Wait
  until the overflow condition is fixed, and destroy *all* remaining PRG
  structures :( We do that by appending a PRG sweeper work to the fault
  queue, that will do some inefficient sweeping and lock up the fault
  queue for a while. Awful, but necessary.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b5d45c1e14d1..1a5e72752e6d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -723,6 +723,7 @@ struct arm_smmu_device {
 	struct list_head		tasks;
 
 	struct workqueue_struct		*fault_queue;
+	struct work_struct		flush_prgs;
 
 	struct list_head		domains;
 	struct mutex			domains_mutex;
@@ -1798,7 +1799,8 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 static void arm_smmu_handle_fault(struct work_struct *work);
 
-static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
+static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt,
+				bool overflowing)
 {
 	struct arm_smmu_fault *fault;
 	struct arm_smmu_fault params = {
@@ -1817,6 +1819,9 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 		.priv	= evt[0] & PRIQ_0_PERM_PRIV,
 	};
 
+	if (overflowing && !params.last)
+		return;
+
 	fault = kmem_cache_alloc(arm_smmu_fault_cache, GFP_KERNEL);
 	if (!fault) {
 		/* Out of memory, tell the device to retry later */
@@ -1834,6 +1839,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->priq.q;
 	size_t queue_size = 1 << q->max_n_shift;
+	bool overflowing = false;
 	u64 evt[PRIQ_ENT_DWORDS];
 	size_t i = 0;
 
@@ -1842,7 +1848,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			spin_unlock(&smmu->priq.wq.lock);
-			arm_smmu_handle_ppr(smmu, evt);
+			arm_smmu_handle_ppr(smmu, evt, overflowing);
 			spin_lock(&smmu->priq.wq.lock);
 			if (++i == queue_size) {
 				smmu->priq.batch++;
@@ -1851,8 +1857,10 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 			}
 		}
 
-		if (queue_sync_prod(q) == -EOVERFLOW)
+		if (queue_sync_prod(q) == -EOVERFLOW) {
 			dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
+			overflowing = true;
+		}
 	} while (!queue_empty(q));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
@@ -1863,6 +1871,9 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 	spin_unlock(&smmu->priq.wq.lock);
 
+	if (overflowing)
+		queue_work(smmu->fault_queue, &smmu->flush_prgs);
+
 	return IRQ_HANDLED;
 }
 
@@ -2820,6 +2831,24 @@ static void arm_smmu_handle_fault(struct work_struct *work)
 	kfree(fault);
 }
 
+static void arm_smmu_flush_prgs(struct work_struct *work)
+{
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_task *smmu_task;
+	struct arm_smmu_pri_group *prg, *next_prg;
+
+	smmu = container_of(work, struct arm_smmu_device, flush_prgs);
+
+	spin_lock(&smmu->contexts_lock);
+	list_for_each_entry(smmu_task, &smmu->tasks, smmu_head) {
+		list_for_each_entry_safe(prg, next_prg, &smmu_task->prgs, list) {
+			list_del(&prg->list);
+			kfree(prg);
+		}
+	}
+	spin_unlock(&smmu->contexts_lock);
+}
+
 static void arm_smmu_sweep_contexts(struct work_struct *work)
 {
 	u64 batch;
@@ -4269,6 +4298,8 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 		smmu->fault_queue = alloc_ordered_workqueue("smmu_fault_queue", 0);
 		if (!smmu->fault_queue)
 			return -ENOMEM;
+
+		INIT_WORK(&smmu->flush_prgs, arm_smmu_flush_prgs);
 	}
 
 	return arm_smmu_init_strtab(smmu);
-- 
2.11.0
