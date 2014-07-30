From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/4] iommu/amd: Fix 2 typos in comments
Date: Wed, 30 Jul 2014 16:04:40 +0200
Message-ID: <1406729080-2486-4-git-send-email-joro@8bytes.org>
References: <1406729080-2486-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1406729080-2486-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

amd_iommu_pasid_bind -> amd_iommu_bind_pasid

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 2de13be..5f578e8 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -367,7 +367,7 @@ static void free_pasid_states(struct device_state *dev_state)
 		mmu_notifier_unregister(&pasid_state->mn, pasid_state->mm);
 
 		put_pasid_state_wait(pasid_state); /* Reference taken in
-						      amd_iommu_pasid_bind */
+						      amd_iommu_bind_pasid */
 
 		/* Drop reference taken in amd_iommu_bind_pasid */
 		put_device_state(dev_state);
@@ -749,7 +749,7 @@ void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
 	mmu_notifier_unregister(&pasid_state->mn, pasid_state->mm);
 
 	put_pasid_state_wait(pasid_state); /* Reference taken in
-					      amd_iommu_pasid_bind */
+					      amd_iommu_bind_pasid */
 out:
 	/* Drop reference taken in this function */
 	put_device_state(dev_state);
-- 
1.9.1
