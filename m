From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/5] iommu/amd: Remove IOMMUv2 pasid_state_list
Date: Tue, 20 May 2014 23:18:25 +0200
Message-ID: <1400620706-21031-5-git-send-email-joro@8bytes.org>
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

This list was only used for the task_exit notifier function.
Now that it is gone we can remove it.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Tested-by: Jay Cornwall <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c |   26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index c06a29a..d9309a0 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -86,10 +86,6 @@ struct fault {
 static LIST_HEAD(state_list);
 static spinlock_t state_lock;
 
-/* List and lock for all pasid_states */
-static LIST_HEAD(pasid_state_list);
-static DEFINE_SPINLOCK(ps_lock);
-
 static struct workqueue_struct *iommu_wq;
 
 /*
@@ -171,25 +167,6 @@ static void put_device_state_wait(struct device_state *dev_state)
 	free_device_state(dev_state);
 }
 
-static void link_pasid_state(struct pasid_state *pasid_state)
-{
-	spin_lock(&ps_lock);
-	list_add_tail(&pasid_state->list, &pasid_state_list);
-	spin_unlock(&ps_lock);
-}
-
-static void __unlink_pasid_state(struct pasid_state *pasid_state)
-{
-	list_del(&pasid_state->list);
-}
-
-static void unlink_pasid_state(struct pasid_state *pasid_state)
-{
-	spin_lock(&ps_lock);
-	__unlink_pasid_state(pasid_state);
-	spin_unlock(&ps_lock);
-}
-
 /* Must be called under dev_state->lock */
 static struct pasid_state **__get_pasid_state_ptr(struct device_state *dev_state,
 						  int pasid, bool alloc)
@@ -346,7 +323,6 @@ static void unbind_pasid(struct device_state *dev_state, int pasid)
 	if (pasid_state == NULL)
 		return;
 
-	unlink_pasid_state(pasid_state);
 	__unbind_pasid(pasid_state);
 	put_pasid_state_wait(pasid_state); /* Reference taken in this function */
 }
@@ -687,8 +663,6 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
 	if (ret)
 		goto out_clear_state;
 
-	link_pasid_state(pasid_state);
-
 	return 0;
 
 out_clear_state:
-- 
1.7.9.5
