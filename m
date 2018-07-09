From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 3/9] iommu/vt-d: Apply global PASID in SVA
Date: Mon,  9 Jul 2018 13:22:52 +0800
Message-ID: <1531113778-28238-4-git-send-email-baolu.lu@linux.intel.com>
References: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531113778-28238-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch applies the global pasid name space in the shared
virtual address (SVA) implementation.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-svm.c   | 22 +++++++++++-----------
 include/linux/intel-iommu.h |  1 -
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 36cc1d1..56e65d0 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -26,6 +26,8 @@
 #include <linux/interrupt.h>
 #include <asm/page.h>
 
+#include "intel-pasid.h"
+
 #define PASID_ENTRY_P		BIT_ULL(0)
 #define PASID_ENTRY_FLPM_5LP	BIT_ULL(9)
 #define PASID_ENTRY_SRE		BIT_ULL(11)
@@ -85,8 +87,6 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 				iommu->name);
 	}
 
-	idr_init(&iommu->pasid_idr);
-
 	return 0;
 }
 
@@ -102,7 +102,7 @@ int intel_svm_free_pasid_tables(struct intel_iommu *iommu)
 		free_pages((unsigned long)iommu->pasid_state_table, order);
 		iommu->pasid_state_table = NULL;
 	}
-	idr_destroy(&iommu->pasid_idr);
+
 	return 0;
 }
 
@@ -392,9 +392,9 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 			pasid_max = iommu->pasid_max;
 
 		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
-		ret = idr_alloc(&iommu->pasid_idr, svm,
-				!!cap_caching_mode(iommu->cap),
-				pasid_max - 1, GFP_KERNEL);
+		ret = intel_pasid_alloc_id(svm,
+					   !!cap_caching_mode(iommu->cap),
+					   pasid_max - 1, GFP_KERNEL);
 		if (ret < 0) {
 			kfree(svm);
 			kfree(sdev);
@@ -410,7 +410,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				idr_remove(&svm->iommu->pasid_idr, svm->pasid);
+				intel_pasid_free_id(svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -460,7 +460,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!iommu || !iommu->pasid_table)
 		goto out;
 
-	svm = idr_find(&iommu->pasid_idr, pasid);
+	svm = intel_pasid_lookup_id(pasid);
 	if (!svm)
 		goto out;
 
@@ -485,7 +485,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 					svm->iommu->pasid_table[svm->pasid].val = 0;
 					wmb();
 
-					idr_remove(&svm->iommu->pasid_idr, svm->pasid);
+					intel_pasid_free_id(svm->pasid);
 					if (svm->mm)
 						mmu_notifier_unregister(&svm->notifier, svm->mm);
 
@@ -520,7 +520,7 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 	if (!iommu || !iommu->pasid_table)
 		goto out;
 
-	svm = idr_find(&iommu->pasid_idr, pasid);
+	svm = intel_pasid_lookup_id(pasid);
 	if (!svm)
 		goto out;
 
@@ -618,7 +618,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 
 		if (!svm || svm->pasid != req->pasid) {
 			rcu_read_lock();
-			svm = idr_find(&iommu->pasid_idr, req->pasid);
+			svm = intel_pasid_lookup_id(req->pasid);
 			/* It *can't* go away, because the driver is not permitted
 			 * to unbind the mm while any page faults are outstanding.
 			 * So we only need RCU to protect the internal idr code. */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index e1e1938..2ff1519 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -420,7 +420,6 @@ struct intel_iommu {
 	struct pasid_state_entry *pasid_state_table;
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
-	struct idr pasid_idr;
 	u32 pasid_max;
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
-- 
2.7.4
