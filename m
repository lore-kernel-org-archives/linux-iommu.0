From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/9] iommu/amd: Add pasid_state->invalid flag
Date: Thu, 10 Jul 2014 15:25:47 +0200
Message-ID: <1404998750-15536-7-git-send-email-joro@8bytes.org>
References: <1404998750-15536-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404998750-15536-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This is used to signal the ppr_notifer function that no more
faults should be processes on this pasid_state. This way we
can keep the pasid_state safely in the state-table so that
it can be freed in the amd_iommu_unbind_pasid() function.

This allows us to not hold a reference to the mm_struct
during the whole pasid-binding-time.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Tested-by: Oded Gabbay <Oded.Gabbay-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 6ba707b..69a46f1 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -53,6 +53,7 @@ struct pasid_state {
 	struct pri_queue pri[PRI_QUEUE_SIZE];	/* PRI tag states */
 	struct device_state *device_state;	/* Link to our device_state */
 	int pasid;				/* PASID index */
+	bool invalid;				/* Used during teardown */
 	spinlock_t lock;			/* Protect pri_queues and
 						   mmu_notifer_count */
 	wait_queue_head_t wq;			/* To wait for count == 0 */
@@ -306,8 +307,17 @@ static void unbind_pasid(struct pasid_state *pasid_state)
 
 	domain = pasid_state->device_state->domain;
 
+	/*
+	 * Mark pasid_state as invalid, no more faults will we added to the
+	 * work queue after this is visible everywhere.
+	 */
+	pasid_state->invalid = true;
+
+	/* Make sure this is visible */
+	smp_wmb();
+
+	/* After this the device/pasid can't access the mm anymore */
 	amd_iommu_domain_clear_gcr3(domain, pasid_state->pasid);
-	clear_pasid_state(pasid_state->device_state, pasid_state->pasid);
 
 	/* Make sure no more pending faults are in the queue */
 	flush_workqueue(iommu_wq);
@@ -573,7 +583,7 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 		goto out;
 
 	pasid_state = get_pasid_state(dev_state, iommu_fault->pasid);
-	if (pasid_state == NULL) {
+	if (pasid_state == NULL || pasid_state->invalid) {
 		/* We know the device but not the PASID -> send INVALID */
 		amd_iommu_complete_ppr(dev_state->pdev, iommu_fault->pasid,
 				       PPR_INVALID, tag);
@@ -657,6 +667,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
 	pasid_state->mm           = get_task_mm(task);
 	pasid_state->device_state = dev_state;
 	pasid_state->pasid        = pasid;
+	pasid_state->invalid      = false;
 	pasid_state->mn.ops       = &iommu_mn;
 
 	if (pasid_state->mm == NULL)
@@ -720,6 +731,9 @@ void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
 	 */
 	put_pasid_state(pasid_state);
 
+	/* Clear the pasid state so that the pasid can be re-used */
+	clear_pasid_state(dev_state, pasid_state->pasid);
+
 	/* This will call the mn_release function and unbind the PASID */
 	mmu_notifier_unregister(&pasid_state->mn, pasid_state->mm);
 
-- 
1.7.9.5
