From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/9] iommu/amd: Don't call mmu_notifer_unregister in __unbind_pasid
Date: Thu, 10 Jul 2014 15:25:43 +0200
Message-ID: <1404998750-15536-3-git-send-email-joro@8bytes.org>
References: <1404998750-15536-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404998750-15536-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Oded.Gabbay@amd.com, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

This function is called only in the mn_release() path, so
there is no need to unregister the mmu_notifer here.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Tested-by: Oded Gabbay <Oded.Gabbay@amd.com>
---
 drivers/iommu/amd_iommu_v2.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 0e29f6f..1fdd22c 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -313,8 +313,6 @@ static void __unbind_pasid(struct pasid_state *pasid_state)
 	/* Make sure no more pending faults are in the queue */
 	flush_workqueue(iommu_wq);
 
-	mmu_notifier_unregister(&pasid_state->mn, pasid_state->mm);
-
 	put_pasid_state(pasid_state); /* Reference taken in bind() function */
 }
 
-- 
1.7.9.5
