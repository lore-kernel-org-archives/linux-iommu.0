From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 8/9] iommu/vt-d: Apply per pci device pasid table in SVA
Date: Sat, 14 Jul 2018 15:47:01 +0800
Message-ID: <1531554422-6874-9-git-send-email-baolu.lu@linux.intel.com>
References: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch applies the per pci device pasid table in the Shared
Virtual Address (SVA) implementation.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c | 29 +++++++++--------------------
 drivers/iommu/intel-svm.c   | 22 ++++++++++------------
 2 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index baad27a..f8609b5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5208,22 +5208,16 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 #define MAX_NR_PASID_BITS (20)
-static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
+static inline unsigned long intel_iommu_get_pts(struct device *dev)
 {
-	/*
-	 * Convert ecap_pss to extend context entry pts encoding, also
-	 * respect the soft pasid_max value set by the iommu.
-	 * - number of PASID bits = ecap_pss + 1
-	 * - number of PASID table entries = 2^(pts + 5)
-	 * Therefore, pts = ecap_pss - 4
-	 * e.g. KBL ecap_pss = 0x13, PASID has 20 bits, pts = 15
-	 */
-	if (ecap_pss(iommu->ecap) < 5)
+	int pts, max_pasid;
+
+	max_pasid = intel_pasid_get_dev_max_id(dev);
+	pts = find_first_bit((unsigned long *)&max_pasid, MAX_NR_PASID_BITS);
+	if (pts < 5)
 		return 0;
 
-	/* pasid_max is encoded as actual number of entries not the bits */
-	return find_first_bit((unsigned long *)&iommu->pasid_max,
-			MAX_NR_PASID_BITS) - 5;
+	return pts - 5;
 }
 
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
@@ -5259,8 +5253,8 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	if (!(ctx_lo & CONTEXT_PASIDE)) {
 		if (iommu->pasid_state_table)
 			context[1].hi = (u64)virt_to_phys(iommu->pasid_state_table);
-		context[1].lo = (u64)virt_to_phys(iommu->pasid_table) |
-			intel_iommu_get_pts(iommu);
+		context[1].lo = (u64)virt_to_phys(info->pasid_table->table) |
+			intel_iommu_get_pts(sdev->dev);
 
 		wmb();
 		/* CONTEXT_TT_MULTI_LEVEL and CONTEXT_TT_DEV_IOTLB are both
@@ -5327,11 +5321,6 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 		return NULL;
 	}
 
-	if (!iommu->pasid_table) {
-		dev_err(dev, "PASID not enabled on IOMMU; cannot enable SVM\n");
-		return NULL;
-	}
-
 	return iommu;
 }
 #endif /* CONFIG_INTEL_IOMMU_SVM */
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 9b5dc72..a253cde 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -274,11 +274,9 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * page) so that we end up taking a fault that the hardware really
 	 * *has* to handle gracefully without affecting other processes.
 	 */
-	svm->iommu->pasid_table[svm->pasid].val = 0;
-	wmb();
-
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
+		intel_pasid_clear_entry(sdev->dev, svm->pasid);
 		intel_flush_pasid_dev(svm, sdev, svm->pasid);
 		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
 	}
@@ -299,6 +297,7 @@ static LIST_HEAD(global_svm_list);
 int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct pasid_entry *entry;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
 	struct mm_struct *mm = NULL;
@@ -306,7 +305,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	int pasid_max;
 	int ret;
 
-	if (!iommu || !iommu->pasid_table)
+	if (!iommu)
 		return -EINVAL;
 
 	if (dev_is_pci(dev)) {
@@ -384,8 +383,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		}
 		svm->iommu = iommu;
 
-		if (pasid_max > iommu->pasid_max)
-			pasid_max = iommu->pasid_max;
+		if (pasid_max > intel_pasid_max_id)
+			pasid_max = intel_pasid_max_id;
 
 		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
 		ret = intel_pasid_alloc_id(svm,
@@ -418,7 +417,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (cpu_feature_enabled(X86_FEATURE_LA57))
 			pasid_entry_val |= PASID_ENTRY_FLPM_5LP;
 
-		iommu->pasid_table[svm->pasid].val = pasid_entry_val;
+		entry = intel_pasid_get_entry(dev, svm->pasid);
+		entry->val = pasid_entry_val;
 
 		wmb();
 
@@ -453,7 +453,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 
 	mutex_lock(&pasid_mutex);
 	iommu = intel_svm_device_to_iommu(dev);
-	if (!iommu || !iommu->pasid_table)
+	if (!iommu)
 		goto out;
 
 	svm = intel_pasid_lookup_id(pasid);
@@ -476,11 +476,9 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 				intel_flush_pasid_dev(svm, sdev, svm->pasid);
 				intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
 				kfree_rcu(sdev, rcu);
+				intel_pasid_clear_entry(dev, svm->pasid);
 
 				if (list_empty(&svm->devs)) {
-					svm->iommu->pasid_table[svm->pasid].val = 0;
-					wmb();
-
 					intel_pasid_free_id(svm->pasid);
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
@@ -513,7 +511,7 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 
 	mutex_lock(&pasid_mutex);
 	iommu = intel_svm_device_to_iommu(dev);
-	if (!iommu || !iommu->pasid_table)
+	if (!iommu)
 		goto out;
 
 	svm = intel_pasid_lookup_id(pasid);
-- 
2.7.4
