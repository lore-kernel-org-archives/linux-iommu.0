From: Peter Xu <peterx@redhat.com>
Subject: [PATCH 1/2] iommu/vt-d: Remove change_pte notifier
Date: Wed, 30 Jan 2019 13:57:57 +0800
Message-ID: <20190130055758.3994-2-peterx@redhat.com>
References: <20190130055758.3994-1-peterx@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130055758.3994-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, Jason Wang <jasowang@redhat.com>, peterx@redhat.com, Jerome Glisse <jglisse@redhat.com>
List-Id: iommu@lists.linux-foundation.org

The change_pte() interface is tailored for PFN updates, while the
other notifier invalidate_range() should be enough for Intel IOMMU
cache flushing.  Actually we've done similar thing for AMD IOMMU
already in 8301da53fbc1 ("iommu/amd: Remove change_pte mmu_notifier
call-back", 2014-07-30) but the Intel IOMMU driver still have it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/iommu/intel-svm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index a2a2aa4439aa..e9fd3ca057ac 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -180,14 +180,6 @@ static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
 	rcu_read_unlock();
 }
 
-static void intel_change_pte(struct mmu_notifier *mn, struct mm_struct *mm,
-			     unsigned long address, pte_t pte)
-{
-	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
-
-	intel_flush_svm_range(svm, address, 1, 1, 0);
-}
-
 /* Pages have been freed at this point */
 static void intel_invalidate_range(struct mmu_notifier *mn,
 				   struct mm_struct *mm,
@@ -227,7 +219,6 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 static const struct mmu_notifier_ops intel_mmuops = {
 	.release = intel_mm_release,
-	.change_pte = intel_change_pte,
 	.invalidate_range = intel_invalidate_range,
 };
 
-- 
2.17.1
