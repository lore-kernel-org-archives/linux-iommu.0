From: Oded Gabbay <oded.gabbay@amd.com>
Subject: [PATCH] iommu/amd: Fix bug in put_pasid_state_wait
Date: Thu, 16 Apr 2015 17:08:44 +0300
Message-ID: <1429193324-20398-1-git-send-email-oded.gabbay@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This patch fixes a bug in put_pasid_state_wait that appeared in kernel 4.0
The bug is that pasid_state->count wasn't decremented before entering the
wait_event. Thus, the condition in wait_event will never be true.

The fix is to decrement (atomically) the pasid_state->count before the
wait_event.

Signed-off-by: Oded Gabbay <oded.gabbay@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/iommu/amd_iommu_v2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 6d5a5c4..173e70d 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -266,6 +266,7 @@ static void put_pasid_state(struct pasid_state *pasid_state)
 
 static void put_pasid_state_wait(struct pasid_state *pasid_state)
 {
+	atomic_dec(&pasid_state->count);
 	wait_event(pasid_state->wq, !atomic_read(&pasid_state->count));
 	free_pasid_state(pasid_state);
 }
-- 
1.9.1
