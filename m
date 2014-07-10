From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/9] iommu/amd: Get rid of __unbind_pasid
Date: Thu, 10 Jul 2014 15:25:45 +0200
Message-ID: <1404998750-15536-5-git-send-email-joro@8bytes.org>
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

Unbind_pasid is only called from mn_release which already
has the pasid_state. Use this to simplify the unbind_pasid
path and get rid of __unbind_pasid.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Tested-by: Oded Gabbay <Oded.Gabbay-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index a621552..574c71b 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -99,7 +99,6 @@ static struct workqueue_struct *iommu_wq;
 static u64 *empty_page_table;
 
 static void free_pasid_states(struct device_state *dev_state);
-static void unbind_pasid(struct device_state *dev_state, int pasid);
 
 static u16 device_id(struct pci_dev *pdev)
 {
@@ -301,7 +300,7 @@ static void put_pasid_state_wait(struct pasid_state *pasid_state)
 	free_pasid_state(pasid_state);
 }
 
-static void __unbind_pasid(struct pasid_state *pasid_state)
+static void unbind_pasid(struct pasid_state *pasid_state)
 {
 	struct iommu_domain *domain;
 
@@ -314,18 +313,6 @@ static void __unbind_pasid(struct pasid_state *pasid_state)
 	flush_workqueue(iommu_wq);
 }
 
-static void unbind_pasid(struct device_state *dev_state, int pasid)
-{
-	struct pasid_state *pasid_state;
-
-	pasid_state = get_pasid_state(dev_state, pasid);
-	if (pasid_state == NULL)
-		return;
-
-	__unbind_pasid(pasid_state);
-	put_pasid_state(pasid_state); /* Reference taken in this function */
-}
-
 static void free_pasid_states_level1(struct pasid_state **tbl)
 {
 	int i;
@@ -480,7 +467,7 @@ static void mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	if (pasid_state->device_state->inv_ctx_cb)
 		dev_state->inv_ctx_cb(dev_state->pdev, pasid_state->pasid);
 
-	unbind_pasid(dev_state, pasid_state->pasid);
+	unbind_pasid(pasid_state);
 }
 
 static struct mmu_notifier_ops iommu_mn = {
-- 
1.7.9.5
