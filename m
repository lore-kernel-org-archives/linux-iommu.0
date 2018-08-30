From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 12/12] iommu/vt-d: Remove deferred invalidation
Date: Thu, 30 Aug 2018 09:35:24 +0800
Message-ID: <20180830013524.28743-13-baolu.lu@linux.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830013524.28743-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Deferred invalidation is an ECS specific feature. It will not be
supported when IOMMU works in scalable mode. As we deprecated the
ECS support, remove deferred invalidation and cleanup the code.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c |  1 -
 drivers/iommu/intel-svm.c   | 45 -------------------------------------
 include/linux/intel-iommu.h |  8 -------
 3 files changed, 54 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e378a383d4f4..3e49d4029058 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1722,7 +1722,6 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	if (pasid_supported(iommu)) {
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
-		intel_svm_exit(iommu);
 	}
 #endif
 }
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index fa5a19d83795..3f5ed33c56f0 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -31,15 +31,8 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-struct pasid_state_entry {
-	u64 val;
-};
-
 int intel_svm_init(struct intel_iommu *iommu)
 {
-	struct page *pages;
-	int order;
-
 	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
 			!cap_fl1gp_support(iommu->cap))
 		return -EINVAL;
@@ -48,39 +41,6 @@ int intel_svm_init(struct intel_iommu *iommu)
 			!cap_5lp_support(iommu->cap))
 		return -EINVAL;
 
-	/* Start at 2 because it's defined as 2^(1+PSS) */
-	iommu->pasid_max = 2 << ecap_pss(iommu->ecap);
-
-	/* Eventually I'm promised we will get a multi-level PASID table
-	 * and it won't have to be physically contiguous. Until then,
-	 * limit the size because 8MiB contiguous allocations can be hard
-	 * to come by. The limit of 0x20000, which is 1MiB for each of
-	 * the PASID and PASID-state tables, is somewhat arbitrary. */
-	if (iommu->pasid_max > 0x20000)
-		iommu->pasid_max = 0x20000;
-
-	order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
-	if (ecap_dis(iommu->ecap)) {
-		pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
-		if (pages)
-			iommu->pasid_state_table = page_address(pages);
-		else
-			pr_warn("IOMMU: %s: Failed to allocate PASID state table\n",
-				iommu->name);
-	}
-
-	return 0;
-}
-
-int intel_svm_exit(struct intel_iommu *iommu)
-{
-	int order = get_order(sizeof(struct pasid_entry) * iommu->pasid_max);
-
-	if (iommu->pasid_state_table) {
-		free_pages((unsigned long)iommu->pasid_state_table, order);
-		iommu->pasid_state_table = NULL;
-	}
-
 	return 0;
 }
 
@@ -214,11 +174,6 @@ static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
 {
 	struct intel_svm_dev *sdev;
 
-	/* Try deferred invalidate if available */
-	if (svm->iommu->pasid_state_table &&
-	    !cmpxchg64(&svm->iommu->pasid_state_table[svm->pasid].val, 0, 1ULL << 63))
-		return;
-
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list)
 		intel_flush_svm_range_dev(svm, sdev, address, pages, ih, gl);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 30e2bbfbbd50..b34cf8b887a0 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -457,15 +457,8 @@ struct intel_iommu {
 	struct iommu_flush flush;
 #endif
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	/* These are large and need to be contiguous, so we allocate just
-	 * one for now. We'll maybe want to rethink that if we truly give
-	 * devices away to userspace processes (e.g. for DPDK) and don't
-	 * want to trust that userspace will use *only* the PASID it was
-	 * told to. But while it's all driver-arbitrated, we're fine. */
-	struct pasid_state_entry *pasid_state_table;
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
-	u32 pasid_max;
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
@@ -579,7 +572,6 @@ void iommu_flush_write_buffer(struct intel_iommu *iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
-int intel_svm_exit(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
 
-- 
2.17.1
