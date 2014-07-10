From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/9] iommu/amd: Don't free pasid_state in mn_release path
Date: Thu, 10 Jul 2014 15:25:44 +0200
Message-ID: <1404998750-15536-4-git-send-email-joro@8bytes.org>
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

The mmu_notifier state is part of pasid_state so it can't be
freed in the mn_release path. Free the pasid_state after
mmu_notifer_unregister has completed.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Tested-by: Oded Gabbay <Oded.Gabbay-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 1fdd22c..a621552 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -312,8 +312,6 @@ static void __unbind_pasid(struct pasid_state *pasid_state)
 
 	/* Make sure no more pending faults are in the queue */
 	flush_workqueue(iommu_wq);
-
-	put_pasid_state(pasid_state); /* Reference taken in bind() function */
 }
 
 static void unbind_pasid(struct device_state *dev_state, int pasid)
@@ -325,7 +323,7 @@ static void unbind_pasid(struct device_state *dev_state, int pasid)
 		return;
 
 	__unbind_pasid(pasid_state);
-	put_pasid_state_wait(pasid_state); /* Reference taken in this function */
+	put_pasid_state(pasid_state); /* Reference taken in this function */
 }
 
 static void free_pasid_states_level1(struct pasid_state **tbl)
@@ -371,6 +369,9 @@ static void free_pasid_states(struct device_state *dev_state)
 		 * unbind the PASID
 		 */
 		mmu_notifier_unregister(&pasid_state->mn, pasid_state->mm);
+
+		put_pasid_state_wait(pasid_state); /* Reference taken in
+						      amd_iommu_pasid_bind */
 	}
 
 	if (dev_state->pasid_levels == 2)
@@ -690,6 +691,7 @@ out_unregister:
 	mmu_notifier_unregister(&pasid_state->mn, pasid_state->mm);
 
 out_free:
+	mmput(pasid_state->mm);
 	free_pasid_state(pasid_state);
 
 out:
@@ -730,6 +732,8 @@ void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
 	/* This will call the mn_release function and unbind the PASID */
 	mmu_notifier_unregister(&pasid_state->mn, pasid_state->mm);
 
+	put_pasid_state_wait(pasid_state); /* Reference taken in
+					      amd_iommu_pasid_bind */
 out:
 	put_device_state(dev_state);
 }
-- 
1.7.9.5
