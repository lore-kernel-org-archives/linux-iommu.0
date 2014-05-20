From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/5] iommu/amd: Implement mmu_notifier_release call-back
Date: Tue, 20 May 2014 23:18:24 +0200
Message-ID: <1400620706-21031-4-git-send-email-joro@8bytes.org>
References: <1400620706-21031-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1400620706-21031-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Jay.Cornwall-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Since mmu_notifier call-backs can sleep (because they use
SRCU now) we can use them to tear down PASID mappings. This
allows us to finally remove the hack to use the task_exit
notifier from oprofile to get notified when a process dies.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Tested-by: Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c |   91 ++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 05e93f1..c06a29a 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -101,7 +101,6 @@ static u64 *empty_page_table;
 
 static void free_pasid_states(struct device_state *dev_state);
 static void unbind_pasid(struct device_state *dev_state, int pasid);
-static int task_exit(struct notifier_block *nb, unsigned long e, void *data);
 
 static u16 device_id(struct pci_dev *pdev)
 {
@@ -172,10 +171,6 @@ static void put_device_state_wait(struct device_state *dev_state)
 	free_device_state(dev_state);
 }
 
-static struct notifier_block profile_nb = {
-	.notifier_call = task_exit,
-};
-
 static void link_pasid_state(struct pasid_state *pasid_state)
 {
 	spin_lock(&ps_lock);
@@ -393,7 +388,12 @@ static void free_pasid_states(struct device_state *dev_state)
 			continue;
 
 		put_pasid_state(pasid_state);
-		unbind_pasid(dev_state, i);
+
+		/*
+		 * This will call the mn_release function and
+		 * unbind the PASID
+		 */
+		mmu_notifier_unregister(&pasid_state->mn, pasid_state->mm);
 	}
 
 	if (dev_state->pasid_levels == 2)
@@ -475,7 +475,24 @@ static void mn_invalidate_range_end(struct mmu_notifier *mn,
 				  __pa(pasid_state->mm->pgd));
 }
 
+static void mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct pasid_state *pasid_state;
+	struct device_state *dev_state;
+
+	might_sleep();
+
+	pasid_state = mn_to_state(mn);
+	dev_state   = pasid_state->device_state;
+
+	if (pasid_state->device_state->inv_ctx_cb)
+		dev_state->inv_ctx_cb(dev_state->pdev, pasid_state->pasid);
+
+	unbind_pasid(dev_state, pasid_state->pasid);
+}
+
 static struct mmu_notifier_ops iommu_mn = {
+	.release		= mn_release,
 	.clear_flush_young      = mn_clear_flush_young,
 	.change_pte             = mn_change_pte,
 	.invalidate_page        = mn_invalidate_page,
@@ -618,53 +635,6 @@ static struct notifier_block ppr_nb = {
 	.notifier_call = ppr_notifier,
 };
 
-static int task_exit(struct notifier_block *nb, unsigned long e, void *data)
-{
-	struct pasid_state *pasid_state;
-	struct task_struct *task;
-
-	task = data;
-
-	/*
-	 * Using this notifier is a hack - but there is no other choice
-	 * at the moment. What I really want is a sleeping notifier that
-	 * is called when an MM goes down. But such a notifier doesn't
-	 * exist yet. The notifier needs to sleep because it has to make
-	 * sure that the device does not use the PASID and the address
-	 * space anymore before it is destroyed. This includes waiting
-	 * for pending PRI requests to pass the workqueue. The
-	 * MMU-Notifiers would be a good fit, but they use RCU and so
-	 * they are not allowed to sleep. Lets see how we can solve this
-	 * in a more intelligent way in the future.
-	 */
-again:
-	spin_lock(&ps_lock);
-	list_for_each_entry(pasid_state, &pasid_state_list, list) {
-		struct device_state *dev_state;
-		int pasid;
-
-		if (pasid_state->task != task)
-			continue;
-
-		/* Drop Lock and unbind */
-		spin_unlock(&ps_lock);
-
-		dev_state = pasid_state->device_state;
-		pasid     = pasid_state->pasid;
-
-		if (pasid_state->device_state->inv_ctx_cb)
-			dev_state->inv_ctx_cb(dev_state->pdev, pasid);
-
-		unbind_pasid(dev_state, pasid);
-
-		/* Task may be in the list multiple times */
-		goto again;
-	}
-	spin_unlock(&ps_lock);
-
-	return NOTIFY_OK;
-}
-
 int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
 			 struct task_struct *task)
 {
@@ -739,6 +709,7 @@ EXPORT_SYMBOL(amd_iommu_bind_pasid);
 
 void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
 {
+	struct pasid_state *pasid_state;
 	struct device_state *dev_state;
 	u16 devid;
 
@@ -755,7 +726,17 @@ void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
 	if (pasid < 0 || pasid >= dev_state->max_pasids)
 		goto out;
 
-	unbind_pasid(dev_state, pasid);
+	pasid_state = get_pasid_state(dev_state, pasid);
+	if (pasid_state == NULL)
+		goto out;
+	/*
+	 * Drop reference taken here. We are safe because we still hold
+	 * the reference taken in the amd_iommu_bind_pasid function.
+	 */
+	put_pasid_state(pasid_state);
+
+	/* This will call the mn_release function and unbind the PASID */
+	mmu_notifier_unregister(&pasid_state->mn, pasid_state->mm);
 
 out:
 	put_device_state(dev_state);
@@ -961,7 +942,6 @@ static int __init amd_iommu_v2_init(void)
 		goto out_destroy_wq;
 
 	amd_iommu_register_ppr_notifier(&ppr_nb);
-	profile_event_register(PROFILE_TASK_EXIT, &profile_nb);
 
 	return 0;
 
@@ -980,7 +960,6 @@ static void __exit amd_iommu_v2_exit(void)
 	if (!amd_iommu_v2_supported())
 		return;
 
-	profile_event_unregister(PROFILE_TASK_EXIT, &profile_nb);
 	amd_iommu_unregister_ppr_notifier(&ppr_nb);
 
 	flush_workqueue(iommu_wq);
-- 
1.7.9.5
