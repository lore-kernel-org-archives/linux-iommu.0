From: Peter Xu <peterx@redhat.com>
Subject: [PATCH 2/2] iommu/amd: Remove clear_flush_young notifier
Date: Wed, 30 Jan 2019 13:57:58 +0800
Message-ID: <20190130055758.3994-3-peterx@redhat.com>
References: <20190130055758.3994-1-peterx@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130055758.3994-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, Jason Wang <jasowang@redhat.com>, peterx@redhat.com, Jerome Glisse <jglisse@redhat.com>
List-Id: iommu@lists.linux-foundation.org

AMD IOMMU driver is using the clear_flush_young() to do cache flushing
but that's actually already covered by invalidate_range().  Remove the
extra notifier and the chunks.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/iommu/amd_iommu_v2.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 23dae9348ace..5d7ef750e4a0 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -370,29 +370,6 @@ static struct pasid_state *mn_to_state(struct mmu_notifier *mn)
 	return container_of(mn, struct pasid_state, mn);
 }
 
-static void __mn_flush_page(struct mmu_notifier *mn,
-			    unsigned long address)
-{
-	struct pasid_state *pasid_state;
-	struct device_state *dev_state;
-
-	pasid_state = mn_to_state(mn);
-	dev_state   = pasid_state->device_state;
-
-	amd_iommu_flush_page(dev_state->domain, pasid_state->pasid, address);
-}
-
-static int mn_clear_flush_young(struct mmu_notifier *mn,
-				struct mm_struct *mm,
-				unsigned long start,
-				unsigned long end)
-{
-	for (; start < end; start += PAGE_SIZE)
-		__mn_flush_page(mn, start);
-
-	return 0;
-}
-
 static void mn_invalidate_range(struct mmu_notifier *mn,
 				struct mm_struct *mm,
 				unsigned long start, unsigned long end)
@@ -430,7 +407,6 @@ static void mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 static const struct mmu_notifier_ops iommu_mn = {
 	.release		= mn_release,
-	.clear_flush_young      = mn_clear_flush_young,
 	.invalidate_range       = mn_invalidate_range,
 };
 
-- 
2.17.1
