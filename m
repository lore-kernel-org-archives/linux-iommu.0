From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/amd: Use wait_event in put_pasid_state_wait
Date: Wed,  4 Feb 2015 16:10:22 +0100
Message-ID: <1423062622-28257-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin LaHaise <bcrl@kvack.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-aio@kvack.org, linux-kernel@vger.kernel.org, Oded Gabbay <oded.gabbay@amd.com>, jroedel@suse.de, joro@8bytes.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Now that I learned about possible spurious wakeups this
place needs fixing too. Replace the self-coded sleep variant
with the generic wait_event() helper.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu_v2.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index b6398d7..5cc1409 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -266,14 +266,7 @@ static void put_pasid_state(struct pasid_state *pasid_state)
 
 static void put_pasid_state_wait(struct pasid_state *pasid_state)
 {
-	DEFINE_WAIT(wait);
-
-	prepare_to_wait(&pasid_state->wq, &wait, TASK_UNINTERRUPTIBLE);
-
-	if (!atomic_dec_and_test(&pasid_state->count))
-		schedule();
-
-	finish_wait(&pasid_state->wq, &wait);
+	wait_event(pasid_state->wq, !atomic_read(&pasid_state->count));
 	free_pasid_state(pasid_state);
 }
 
-- 
1.8.4.5
