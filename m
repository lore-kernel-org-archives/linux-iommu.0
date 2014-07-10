From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 9/9] iommu/amd: Don't call the inv_ctx_cb when pasid is not
	set up
Date: Thu, 10 Jul 2014 15:25:50 +0200
Message-ID: <1404998750-15536-10-git-send-email-joro@8bytes.org>
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

On the error path of amd_iommu_bind_pasid() we call
mmu_notifier_unregister() for cleanup. This calls
mn_release() which calls the users inv_ctx_cb function if
one is available. Since the pasid is not set up yet there is
nothing the user can to tear down in this call-back. So
don't call inv_ctx_cb on the error path of
amd_iommu_unbind_pasid() and make life of the users simpler.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Tested-by: Oded Gabbay <Oded.Gabbay-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index f7ca009..a195c78 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -52,7 +52,8 @@ struct pasid_state {
 	struct pri_queue pri[PRI_QUEUE_SIZE];	/* PRI tag states */
 	struct device_state *device_state;	/* Link to our device_state */
 	int pasid;				/* PASID index */
-	bool invalid;				/* Used during teardown */
+	bool invalid;				/* Used during setup and
+						   teardown of the pasid */
 	spinlock_t lock;			/* Protect pri_queues and
 						   mmu_notifer_count */
 	wait_queue_head_t wq;			/* To wait for count == 0 */
@@ -473,13 +474,15 @@ static void mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct pasid_state *pasid_state;
 	struct device_state *dev_state;
+	bool run_inv_ctx_cb;
 
 	might_sleep();
 
-	pasid_state = mn_to_state(mn);
-	dev_state   = pasid_state->device_state;
+	pasid_state    = mn_to_state(mn);
+	dev_state      = pasid_state->device_state;
+	run_inv_ctx_cb = !pasid_state->invalid;
 
-	if (pasid_state->device_state->inv_ctx_cb)
+	if (run_inv_ctx_cb && pasid_state->device_state->inv_ctx_cb)
 		dev_state->inv_ctx_cb(dev_state->pdev, pasid_state->pasid);
 
 	unbind_pasid(pasid_state);
@@ -674,7 +677,8 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
 	pasid_state->mm           = mm;
 	pasid_state->device_state = dev_state;
 	pasid_state->pasid        = pasid;
-	pasid_state->invalid      = false;
+	pasid_state->invalid      = true; /* Mark as valid only if we are
+					     done with setting up the pasid */
 	pasid_state->mn.ops       = &iommu_mn;
 
 	if (pasid_state->mm == NULL)
@@ -691,6 +695,9 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
 	if (ret)
 		goto out_clear_state;
 
+	/* Now we are ready to handle faults */
+	pasid_state->invalid = false;
+
 	/*
 	 * Drop the reference to the mm_struct here. We rely on the
 	 * mmu_notifier release call-back to inform us when the mm
-- 
1.7.9.5
